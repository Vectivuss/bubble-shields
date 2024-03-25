
VectivusShields = VectivusShields or {}

local function Print( addon, cat, msg, ... )
    local args = { ... }
    msg = string.format( msg, unpack(args) )
    MsgC( Color( 0, 225, 0 ), "[" .. addon .. "]:", Color( 255, 0, 0 ), "[" .. cat .. "]",  Color( 255, 255, 0 ), " »  ",  Color( 155, 155, 155 ), msg .. "\n" )
end

local Addon = "Shields"

local function LoadFile( path, name )
    path = path or ""
    local _typ = string.lower( string.Left( name, 3 ) )
    local s = path..name
    if SERVER and _typ == "sv_" then
        include(s)
        Print( "VectivusLib", Addon..":Initialize", "[ SV ][ FILE: %s ]", name )
    elseif _typ == "sh_" then
        if SERVER then timer.Simple(0,function() AddCSLuaFile(s) end) end
        include(s)
        Print( "VectivusLib", Addon..":Initialize", "[ SH ][ FILE: %s ]", name )
    elseif _typ == "cl_" then
        if SERVER then
            timer.Simple(0,function() AddCSLuaFile(s) end)
            Print( "VectivusLib", Addon..":Initialize", "[ CL ][ FILE: %s ]", name )
        else
            timer.Simple(0,function() include(s) end)
            Print( "VectivusLib", Addon..":Initialize", "[ CL ][ FILE: %s ]", name )
        end
    end
end
local function PreLoadFile(path,name)
    LoadFile(path,name)
end
local function PostLoadFile(path,name)
    timer.Simple( 1, function() LoadFile(path,name) end )
end

local function LoadDirectory( dir )
    dir = dir .. "/"
    local files, directory = file.Find( dir.."*", "LUA" )
    for _, v in ipairs( files ) do
        if string.EndsWith( v, ".lua" ) then
            LoadFile( dir, v )
        end
    end
	for _, dirs in ipairs( directory ) do
		LoadDirectory( dir..dirs )
	end
end

local function Initialize()
    LoadDirectory( "vs_shields" )
end

timer.Simple( 0, Initialize ) // we delay this due to certain gamemodes taking time to load -_-
