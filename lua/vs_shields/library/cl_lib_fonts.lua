
VectivusLib = VectivusLib or {}

local scaledFonts = scaledFonts or {}

function VectivusLib:Scale( i )
    return math.max( i*(ScrH()/1440), 1 )
end

function VectivusLib:RegisterFont( name, font, size, weight )
    surface.CreateFont( "vs." .. name, {
        font = font,
        size = size,
        weight = weight or 500,
    })
end

function VectivusLib:CreateFont( name, font, size, weight )
    scaledFonts[ name ] = {
        font = font,
        size = size,
        weight = weight,
    }
    self:RegisterFont( name, font, self:Scale( size ), weight )
end

hook.Add( "OnScreenSizeChanged", "VectivusLib:RegisterFont", function()
    timer.Simple( 1, function()
        for k, v in pairs( scaledFonts ) do
            print( "[   VectivusLib:Fonts - Updated:    ]", k )
            VectivusLib:CreateFont( k, v.font, v.size, v.weight )
        end
    end )
end )

do
    for i=27, 45 do
        VectivusLib:CreateFont( "shields.ui."..i, "Bebas Neue", i )
    end
    VectivusLib:RegisterFont( "shields.ui.50", "Bebas Neue", 50 ) -- world
end
