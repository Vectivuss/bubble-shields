for i=16, 100 do
	surface.CreateFont( "ui."..i, { font = "Bebas Neue", size = i } ) 
end

function ScrWH() 
	return ScrW(), ScrH() 
end scrwh=ScrWH; Scrwh=ScrWH; SCRWH=ScrWH; 

function PlaySound( s )
	surface.PlaySound( "vgui/" .. s .. ".ogg" )
end

function addMaterial( m, t )
	surface.SetMaterial( Material( m, t ) )
end