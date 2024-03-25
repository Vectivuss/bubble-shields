
local PANEL, colors = {}, {
    ["black01"] = Color(0,0,0,166),
    ["grey01"] = Color(22,22,22),
    ["grey02"] = Color(28,28,28),
    ["grey03"] = Color(30,30,30),
    ["grey04"] = Color(37,37,37),
    ["white01"] = Color(255,255,255,111),
    ["green01"] = Color(46,204,113),
    ["purple01"] = Color(89,39,210),
}

function PANEL:Init()
    local w, h = VectivusLib:Scale(900), VectivusLib:Scale(460)
    self:SetSize(0,0)
    self:Center()
    self:MakePopup()
    self:SizeTo( w, h, 1.8, 0, .1 )

    self.navbar = vgui.Create( "DPanel", self )
    self.navbar.Paint = function( s, w, h )
        draw.RoundedBox( 6, 0, 0, w, h, colors["grey02"] )
        draw.SimpleText( "BUBBLE SHIELDS", "vs.shields.ui.45", s:GetWide()*.01, h/2, color_white, 0, 1 )
    end

    self.close = vgui.Create( "DButton", self.navbar )
    self.close:SetText( "" )
    self.close.DoClick = function()
        surface.PlaySound("UI/buttonclick.wav")
        self:Close()
    end
    self.close.Paint = function( s, w, h )
		if s:IsHovered() then
            draw.RoundedBox( 6, 0, 0, w, h, Color( 255, 102, 102, 255 ) )
			draw.SimpleTextOutlined( "X", "vs.shields.ui.45", w/2, h/2, color_white, 1, 1, 1, color_black )
        else
			draw.RoundedBox( 6, 0, 0, w, h, Color( 197, 40, 40, 255 ) )
			draw.SimpleTextOutlined( "X", "vs.shields.ui.45", w/2, h/2, color_white, 1, 1, 1, color_black )
		end
    end

    self.populate = vgui.Create( "DPanel", self )
    self.populate:Dock(FILL)
    self.populate:DockMargin( VectivusLib:Scale(15), VectivusLib:Scale(15), VectivusLib:Scale(15), VectivusLib:Scale(15) )
    self.populate.Paint = function( s, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, colors["grey02"] )
    end

    self.scroll = vgui.Create( "VSShields.DScrollPanel", self.populate )
    self.scroll:Dock(FILL)
    self.scroll:SetColor( Color( 50, 50, 50 ) )

    self.buttons = {}
    for i=1, VectivusShields.Config.Shield_Max do
        if !IsValid(self.populate) then continue end
        local DPanel = vgui.Create( "DPanel", self.scroll )
        self.buttons[i] = DPanel

        local price = DarkRP.formatMoney( VectivusShields.Config.DarkRP_Price * i )
        DPanel.Paint = function( s, w, h )
            draw.RoundedBox( 6, 0, 0, w, h, colors["grey01"] )
            draw.SimpleText( i .. " Shields", "vs.shields.ui.27", h*.1, h*.1, colors["white01"], 0, TEXT_ALIGN_TOP )
            draw.SimpleText( price, "vs.shields.ui.27", h*.1, h-h*.1, colors["green01"], 0, TEXT_ALIGN_BOTTOM )
        end

        local size = VectivusLib:Scale(12)
        local button = vgui.Create( "DButton", DPanel )
        button:SetText("")
        button:Dock(RIGHT)
        button:DockMargin( size, size, size, size )
        button:SetWide( VectivusLib:Scale(120) )
        button.DoClick = function()
            RunConsoleCommand( "vs.shield.purchase", i )
        end
        button.Paint = function(s,w,h)
            draw.RoundedBox( 6, 0, 0, w, h, s:IsHovered() and colors["grey04"] or colors["grey03"] )
            draw.SimpleText( "Purchase", "vs.shields.ui.32", w/2, h/2, colors["purple01"], 1, 1 )
        end
    end
end

function PANEL:Close()
    self:AlphaTo( 0, .5, 0 )
    self:SizeTo( 0, 0, 1, 0, .1, function() self:Close() end )
    self:SetMouseInputEnabled( false )
    self:SetKeyboardInputEnabled( false )
end

function PANEL:Paint( w, h )
    draw.RoundedBox( 6, 0, 0, w, h, colors["grey01"] )
end

function PANEL:Think()
    self:Center()
end

function PANEL:OnKeyCodePressed( k )
    if k == KEY_TAB then self:Close() end
end

function PANEL:PerformLayout( w, h )
    self.navbar:Dock(TOP)
    self.navbar:SetTall( VectivusLib:Scale(60) )
    self.close:Dock(RIGHT)
    self.close:DockMargin(0,VectivusLib:Scale(6),VectivusLib:Scale(6),VectivusLib:Scale(6))
    self.close:SetWide( VectivusLib:Scale(50) )

    for i=1, #self.buttons do
        self.buttons[i]:Dock(TOP)
        self.buttons[i]:DockMargin( VectivusLib:Scale(10), VectivusLib:Scale(10), VectivusLib:Scale(10), 0 )
        self.buttons[i]:SetTall( VectivusLib:Scale(80) )
    end
end

vgui.Register( "VSShields.DFrame", PANEL, "EditablePanel" )
