
local p = LocalPlayer()

local main_menu
concommand.Add( "vs.shield.npc", function()
    if IsValid(main_menu) then main_menu:Remove() end
    main_menu = vgui.Create( "VSShields.DFrame" )
    main_menu:Center()
end )

local cols = {
    ["black01"] = Color(0,0,0,155),
    ["purple01"] = Color(87,39,210),
}

hook.Add( "HUDPaint", "VectivusShields.HUDPaint", function()
    if !IsValid(p) then p = LocalPlayer() end

    local w, h = ScrW(), ScrH()
    local W, H = VectivusLib:Scale(250), VectivusLib:Scale(70)
    local x, y = (w/2-W/2), (h-H)-h*.01

    local cur, max = VectivusShields.GetShields(p), VectivusShields.GetMaxShields(p)
    if cur < 1 then return end

    local text = "Active Shields: " .. cur .. "/" .. max
    surface.SetFont( "vs.shields.ui.40" )
    local tW, _ = surface.GetTextSize(text) + VectivusLib:Scale(25)

    draw.RoundedBox( 0, x, y, tW, H, cols["black01"] )
    surface.SetDrawColor( cols["purple01"] )
    local tall = VectivusLib:Scale(6)
    surface.DrawRect( x, y+H-tall, tW, tall )

    draw.SimpleText( text, "vs.shields.ui.40", x+VectivusLib:Scale(12), y+H/2 - VectivusLib:Scale(5), color_white, 0, 1 )
end )

net.Receive( "VectivusShields.Notify", function()
	local e, i = net.ReadString(), net.ReadUInt(8)
	notification.AddLegacy( e .. " has " .. tostring(i) .. " shields left", 0, 2 )
end )
