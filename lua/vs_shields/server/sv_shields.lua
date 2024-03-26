
resource.AddWorkshop( "2268032178" )
util.AddNetworkString( "VectivusShields.Notify" )

function VectivusShields.CreateShield( p )
    if !IsValid(p) or !p:IsPlayer() then return end
    if IsValid(p.vs_shield) then p.vs_shield:Remove() end
    p.vs_shield = ents.Create( "vs_shield_bubble" )
    p.vs_shield:SetPos( p:WorldSpaceCenter() )
    p.vs_shield:SetParent( p, 1 )
    p.vs_shield:Spawn()
    return p.vs_shield
end

function VectivusShields.SetShields( p, amount )
    if !IsValid(p) or !p:IsPlayer() then return end
    if !amount then return end
    amount = math.Clamp( amount, 0, VectivusShields.GetMaxShields(p) )
    p:SetNWInt( "VectivusShields.Amount", amount )
end

function VectivusShields.AddShields( p, amount )
    if !IsValid(p) or !p:IsPlayer() then return end
    amount = amount or 0
    local i = VectivusShields.GetShields(p)
    VectivusShields.SetShields( p, i+amount )
end

function VectivusShields.SetActiveShield( p, bool )
    if !IsValid(p) then return end
    p:SetNWBool( "VectivusShields.ActiveShield", bool )
end

hook.Add( "PlayerSpawn", "VectivusShields.Respawn", function( p )
    VectivusShields.SetShields( p, 0 )
    VectivusShields.SetActiveShield( p, false )
    SafeRemoveEntity(p.vs_shield)
end )

function VectivusShields.OnTakeDamage( e, t )
    local p = IsValid(e) and e:IsPlayer() and e
    if !p then return end
    if !VectivusShields.HasShields(p) then return end

    if hook.Run( "VectivusShields.CanTakeDamage", p, t ) == false then return end

    local att = IsValid(t:GetAttacker()) and t:GetAttacker()
    if !att then return end

    VectivusShields.SetActiveShield( p, true )
    VectivusShields.CreateShield( p )

    local wep = IsValid(att:GetActiveWeapon()) and att:GetActiveWeapon() or nil
    local total_shields = VectivusShields.GetShields(p)

    if wep then
        local class = wep:GetClass()
        local data = VectivusShields.Config.Weapons[class or ""] or nil
    end

    do // shield deduction
        if data and data == string.lower("all") then
            VectivusShields.SetShields( p, 0 )
        elseif data then
            total_shields = total_shields - data
            VectivusShields.AddShields( p, -data )
        else
            total_shields = total_shields - 1
            VectivusShields.AddShields( p, -1 )
        end
    end

    do // network notification
        if att:IsPlayer() and !att:IsBot() then
            net.Start( "VectivusShields.Notify" )
            net.WriteString( p:Name() )
            net.WriteUInt( total_shields, 8 )
            net.Send(att)
        end
    end

    hook.Run( "VectivusShields.ShieldStarted", p, att, t )

    timer.Simple( VectivusShields.Config.Shield_Duration, function()
        if !IsValid(p) then return end
        SafeRemoveEntity(p.vs_shield)
        VectivusShields.SetActiveShield( p, false )
        sound.Play( "Breakable.Glass", p:GetPos(), 128, 128 )
        hook.Run( "VectivusShields.ShieldEnded", p, att, t )
    end )
end
hook.Add( "EntityTakeDamage", "VectivusShields.OnTakeDamage", VectivusShields.OnTakeDamage )

hook.Add( "PlayerShouldTakeDamage", "VectivusShields.OnTakeDamage", function( p )
    if VectivusShields.HasActiveShield(p) then return false end
end )

hook.Add( "VectivusShields.CanTakeDamage", "a", function( p, t )
    do // active shield
        if VectivusShields.HasActiveShield(p) then return false end
    end
    do // Fall Damage
        if t:IsFallDamage() then t:SetDamage(0) return false end
    end
end )

function VectivusShields.PurchaseShield( p, amount )
    if !IsValid(p) or !amount then return end
    if !VectivusLib.GetMoney(p) then return end

    amount = math.Clamp( amount, 0, VectivusShields.GetMaxShields(p) )

    if hook.Run( "VectivusShields.CanPurchase", p, amount ) == false then return end

	local nearVendor = false
	for _, v in pairs( ents.FindByClass( "vs_shield_npc" ) ) do
		if p:GetPos():Distance( v:GetPos() ) < 140 then
			nearVendor = true
			break
		end
	end
	if !nearVendor then return end

    local access_amount = VectivusShields.GetMaxShields(p)
    local cur_amount = VectivusShields.GetShields(p)
    if cur_amount >= access_amount then 
        if DarkRP then
            DarkRP.notify( p, 0, 4, "You already have max shields!" )
        end
        return 
    end

    if amount + cur_amount > access_amount then
        local over = cur_amount + amount - access_amount
        amount = amount - over
    end

    do // Take money
        local price = VectivusShields.Config.DarkRP_Price * amount
        local canAfford = VectivusLib.HasMoney( p, price )
        if !canAfford then 
            if DarkRP then
                DarkRP.notify( p, 1, 4, "You cannot afford this!" )
            end
            return
        end

        VectivusLib.GiveMoney( p, -price )

        VectivusShields.AddShields( p, amount )
        if DarkRP then
            DarkRP.notify( p, 2, 4, "Purchased " .. amount .. " shield(s) for " .. DarkRP.formatMoney(price) )
        end
    end

    hook.Run( "VectivusShields.PurchasedShields", p, i )
end
concommand.Add( "vs.shield.purchase", function( p, _, t )
    local amount = tonumber( t[1] or 0 )
    VectivusShields.PurchaseShield( p, amount )
end )

hook.Add( "VectivusShields.CanPurchase", "a", function( p )
    do // anti-spam...
        if p.NextVShield and p.NextVShield > CurTime() then
            return false
        end
        p.NextVShield = CurTime()+.2
    end
end )
