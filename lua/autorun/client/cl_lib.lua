for i=16, 100 do
	surface.CreateFont( "ui."..i, { font = "Bebas Neue", size = i } ) 
end

function ScrWH() 
	return ScrW(), ScrH() 
end scrwh=ScrWH; Scrwh=ScrWH; SCRWH=ScrWH; 

function PlaySound( s )
	surface.PlaySound( "vgui/" .. s .. ".ogg" )
end

local blur = Material( "pp/blurscreen" )

function draw.BlurPanel( panel, amount, color )
	local x, y = panel:LocalToScreen(0, 0)
	local w, h = ScrW(), ScrH()
	surface.SetDrawColor(255, 255, 255)
	surface.SetMaterial(blur)
	amount = amount or 4
	for i = 1, 5 do
		blur:SetFloat("$blur", (i / 3) * amount)
		blur:Recompute()
		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect( x*-1, y*-1, w, h )
	end
	if color then draw.RoundedBox( 0, 0, 0, w, h, color ) end
end

function addMaterial( m, t )
	surface.SetMaterial( Material( m, t ) )
end
