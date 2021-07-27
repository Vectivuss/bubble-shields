hook.Add( "HUDPaint", "active.shields", function()
	local p, w, h = LocalPlayer(), ScrWH()
	local max = ( vs.cfg.Vip.Steam[ p:SteamID64() ] or vs.cfg.Vip.Steam[ p:SteamID() ] ) or vs.cfg.Vip.Rank[ p:GetUserGroup() ] or vs.cfg.Shield.Max

	if ( p:GetNWInt( "shields" ) >= 1 ) then
		draw.RoundedBox( 0, w*.453, h*.953, w*.11, h*.04, Color(35,39,42,200) )
		draw.SimpleText( "Active Shields: " .. p:GetNWInt( "shields", 0 ) .. "/" .. max, "ui.27", w *.506, h*.970, Color( 180, 180, 180, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		draw.RoundedBox( 0, w *.453, h*.988, w*.11, h*.004, vs.cfg.Bubble.Colour )
	end
end )

net.Receive( "vs.notify", function() -- tells attacker how many shields victim has left
	local a = net.ReadString()
	local s = net.ReadInt( 32 )
	notification.AddLegacy( a .. " has " .. s .. " shields left", 0, 2 )
end )