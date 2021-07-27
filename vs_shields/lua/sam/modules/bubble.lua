if SAM_LOADED then return end
local sam, command, language = sam, sam.command, sam.language

command.set_category("Bubble")

--[[
	Give Player Shields
]]

command.new( "giveshields" )
	:SetPermission( "giveshields", "admin" )
	:AddArg( "player" )
	:AddArg( "number", { hint = "amount", min = 1, max = 100, round = true, optional = true, default = 1 } )
	:Help( "This will set the target(s) shields" )
	
	:OnExecute(function(ply, targets, amount)
		for i = 1, #targets do
			addShields( targets[i], amount )
		end
		if sam.is_command_silent then return end
		sam.player.send_message(nil, "{A} gave {T} {V} shields.", {
			A = ply, T = targets, V = amount
		})
	end)
:End()

--[[
	Remove Player Shields
]]

command.new( "removeshields" )
	:SetPermission( "removeshields", "admin" )
	:AddArg( "player" )
	:AddArg( "number", { hint = "amount", min = 1, max = 100, round = true, optional = true, default = 1 } )
	:Help( "This will remove the target(s) shields" )
	
	:OnExecute(function(ply, targets, amount)
		for i = 1, #targets do
			removeShields( targets[i], amount )
		end
		if sam.is_command_silent then return end
		sam.player.send_message(nil, "{A} took {V} shields from {T}.", {
			A = ply, T = targets, V = amount
		})
	end)
:End()