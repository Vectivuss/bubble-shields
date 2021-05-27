do end

hook.Add( "PlayerInitialSpawn", "p.reset.shields", function( p )
	if !vs.cfg.Bubble.ShieldBreak then
		p:SetNWInt( "shields", 0 )
		p.sAmount = 0
	else
		p:SetNWInt( "shields", p:GetNWInt( "shields" ) )
		p.sAmount = p:GetNWInt( "shields" )
	end
end )

hook.Add( "PlayerSpawn", "p.reset.shields", function( p )
	if ( !vs.cfg.Bubble.ShieldBreak ) then
		p:SetNWInt( "shields", 0 )
		p.sAmount = 0
	else
		p:SetNWInt( "shields", p:GetNWInt( "shields" ) )
		p.sAmount = p:GetNWInt( "shields" )
	end
end )

hook.Add( "EntityTakeDamage", "bubble.take.damage", function( p, d )
	if ( p:IsPlayer() and d:GetAttacker():IsPlayer() ) then
		if ( p.sAmount > 0 and !p.bubbleActive ) then
			p.bubbleActive = true

			for _, v in pairs( ents.FindByClass( "bubble" ) ) do
				if v:GetClass() then
					if ( v:GetOwner() == p ) then
						v:Remove()
					end
				end
			end

			local a = ents.Create( "bubble" )
			a:SetPos( p:GetPos() + Vector( 0, 0, 43 ) )
			a:SetOwner( p )
			a:SetParent( p, 1 )
			a:Spawn()

			sound.Play( vs.cfg.Bubble.Active, p:GetPos(), 64, 120 )

			local g = vs.cfg.Weapons[ d:GetAttacker():GetActiveWeapon():GetClass() ]

			if g == string.lower( "all" ) then
				p.sAmount = p.sAmount - p.sAmount
				if BDMG then
					BDMG:Log( "{1} broke ALL of {2} Shields", GAS.Logging:FormatPlayer( d:GetInflictor() ), GAS.Logging:FormatPlayer( p ) )
				end
			elseif g then
				p.sAmount = p.sAmount - g
				if BDMG then
					BDMG:Log( "{1} broke ".. g .." of {2} Shields", GAS.Logging:FormatPlayer( d:GetInflictor() ), GAS.Logging:FormatPlayer( p ) )
				end
			else
				p.sAmount = p.sAmount - 1
				if BDMG then
					BDMG:Log( "{1} broke 1 of {2} Shields", GAS.Logging:FormatPlayer( d:GetInflictor() ), GAS.Logging:FormatPlayer( p ) )
				end
			end

			if p.sAmount <= 0 then -- prevents going into negitives
				p.sAmount = 0
			end

			p:SetNWInt( "shields", p.sAmount )

			if ( vs.cfg.Shield.Notifications and !d:IsFallDamage() ) then
				net.Start( "vs.notify" )
				net.WriteString( p:Nick() )
				net.WriteInt( p.sAmount, 32 )
				net.Send( d:GetAttacker() )
			end

			timer.Simple( vs.cfg.Shield.ShieldTime, function()
				p.bubbleActive = false
				p:GodDisable()
				SafeRemoveEntity( a )
				sound.Play( vs.cfg.Bubble.Break, p:GetPos(), 128, 120 )
			end )
			p:GodEnable()
		end
	end
end )

hook.Add( "GetFallDamage", "p.can.take.falldamage", function( p )
	if ( vs.cfg.Shield.FallDamage and p.sAmount > 0 ) then -- Prevents fall damage when holding shields
		return false
	end
end )

hook.Add( "PlayerDeath", "remove.bubble", function( p )
	for _, v in ipairs( ents.FindByClass( "bubble" ) ) do
		if v:GetClass() then
			if ( v:GetOwner() == p ) then
				v:Remove()
			end
		end
	end
end )