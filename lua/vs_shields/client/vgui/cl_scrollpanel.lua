
--[[------------------------------------------
    [ DScrollPanel ]
--------------------------------------------]]

local PANEL = {}
PANEL.color = Color(255,255,255,188)

local col = Color(0,0,0,128)
function PANEL:Init()
    self.VBar:SetWide(8)
    self.VBar:SetHideButtons(true)
    self.VBar.Paint = function( s, w, h )
        draw.RoundedBox( 16, 0, 0, w, h, col )
    end
    self.VBar.btnGrip.Paint = function( s, w, h )
        local col = self.color
        draw.RoundedBox( 16, 0, 0, w, h, s:IsHovered() and Color(col.r,col.g,col.b,166) or Color(col.r,col.g,col.b,88))
    end
end

function PANEL:SetColor( col )
    if !col or !IsColor( col ) then return end
    self.color = col
end

vgui.Register( "VSShields.DScrollPanel", PANEL, "DScrollPanel" )
