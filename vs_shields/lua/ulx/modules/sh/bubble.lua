if ( !istable( ULib ) ) then return end

local CATEGORY_NAME = "Bubble"

--[[
	Check Bubble Shields
]]

function ulx.getbubbles( calling_ply, target_plys )
	local affected_plys = {}
	for i=1, #target_plys do
		local v = target_plys[ i ]
		if ulx.getExclusive( v, calling_ply ) then
			ULib.tsayError( calling_ply, ulx.getExclusive( v, calling_ply ), true )
		elseif not v:Alive() then
			ULib.tsayError( calling_ply, v:Nick() .. " is currently dead!", true )
		else
			ulx.fancyLogAdmin( calling_ply, "#T has " .. v:GetNWInt("shields", 0) .. " bubble shield(s)!", target_plys )
			table.insert( affected_plys, v )
		end
	end
end
local getbubbles = ulx.command( CATEGORY_NAME, "ulx getbubbles", ulx.getbubbles, "!getbubbles" )
getbubbles:addParam{ type=ULib.cmds.PlayersArg }
getbubbles:defaultAccess( ULib.ACCESS_ADMIN )
getbubbles:help( "Checks target(s) how many shields they have" )

--[[
	Give Bubble Shields
]]

function ulx.givebubbles( calling_ply, target_plys, amount )
	for i=1, #target_plys do
		local v = target_plys[ i ]
		addShields( v, amount )
	end
	ulx.fancyLogAdmin( calling_ply, "#A gave #T #i more shields", target_plys, amount )
end

local givebubbles = ulx.command( CATEGORY_NAME, "ulx givebubbles", ulx.givebubbles, "!givebubbles" )
givebubbles:addParam{ type=ULib.cmds.PlayersArg }
givebubbles:addParam{ type=ULib.cmds.NumArg, min=0, max=100, hint="Give target(s) shields amount", ULib.cmds.round }
givebubbles:defaultAccess( ULib.ACCESS_ADMIN )
givebubbles:help( "Gives target(s) an amount of shields" )

--[[
	Remove Bubble Shields
]]

function ulx.removebubbles( calling_ply, target_plys, amount )
	for i=1, #target_plys do
		local v = target_plys[ i ]
		if ulx.getExclusive( v, calling_ply ) then
			ULib.tsayError( calling_ply, ulx.getExclusive( v, calling_ply ), true )
		elseif v:GetNWInt("shields") <= 0 then
			ULib.tsayError( calling_ply, v:Nick() .. " doesn't have any shields", true )
		else
			removeShields( v, amount )
		end
	end
	ulx.fancyLogAdmin( calling_ply, "#A took #i shields from #T", amount, target_plys )
end

local removebubbles = ulx.command( CATEGORY_NAME, "ulx removebubbles", ulx.removebubbles, "!removebubbles" )
removebubbles:addParam{ type=ULib.cmds.PlayersArg }
removebubbles:addParam{ type=ULib.cmds.NumArg, min=0, max=100, hint="Remove target(s) shields amount", ULib.cmds.round }
removebubbles:defaultAccess( ULib.ACCESS_ADMIN )
removebubbles:help( "Remove target(s) an amount of shields" )