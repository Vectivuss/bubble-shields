util.AddNetworkString( "vs.shield" )
util.AddNetworkString( "vs.notify" )

local function shield_Buy( p, id )

	local bData = table.Copy( vs.cfg.Shop[ id ] )
	if ( !DarkRP ) then return end
	if ( !bData ) then return end
	local canAfford = p:canAfford( bData.price )

	local nearVendor = false
	for _, v in pairs( ents.FindByClass( "bubble_npc" ) ) do
		if ( p:GetPos():Distance( v:GetPos() ) < 140 ) then
			nearVendor = true
			break
		end
	end
	if ( !nearVendor ) then return end

	do -- How many shields user can buy
		local bToAdd = id
		local maxBRank = ( vs.cfg.Vip.Steam[ p:SteamID64() ] or vs.cfg.Vip.Steam[ p:SteamID() ] ) or vs.cfg.Vip.Rank[ p:GetUserGroup() ] or vs.cfg.Shield.Max
		if bToAdd + p.sAmount > maxBRank then
			local overShield = ( p.sAmount + bData.amount ) - maxBRank
			bToAdd = bToAdd - overShield
			DarkRP.notify( p, 0, 4, "You already have max shields!" )
			shield_Buy( p, bToAdd )
			return
		end
	end

	do -- Gives user shields
		if ( !canAfford ) then
			DarkRP.notify( p, 1, 4, "You cannot afford this!" )
			return
		end
		p.sAmount = p.sAmount + bData.amount or p.sAmount + p.sAmount == vs.cfg.Shield.Max
		p:SetNWInt( "shields", p.sAmount )
		p:addMoney( -bData.price )
		print( tostring( p ) .. " bought " .. bData.name .. " for (" .. DarkRP.formatMoney( bData.price ) .. ")" ) -- for debugging
		if BDMG then
			BBUY:Log( "{1} purchased " .. bData.amount .. " shields for {2}", GAS.Logging:FormatPlayer( p ), GAS.Logging:FormatMoney( bData.price ) )
		end
	end

end

net.Receive( "vs.shield", function( _, p )
	shield_Buy( p, net.ReadInt( 32 ) )
end )