vs = vs or {}
vs.cfg = vs.cfg or {}

//////////////////////////////////////////////////////////////////////////////////

/////////////////////////////// Vectivus Shields V2 /////////////////////////////

// Developed by Vectivus:
// http://steamcommunity.com/profiles/76561198371018204

// Wish to contact me:
// vectivus099@gmail.com

//////////////////////////////////////////////////////////////////////////////////

vs.cfg = {

	-- true = workshopDL. false = fastDL.
	WorkshopDL = true,

	Npc = { -- NPC Configuration

		-- What model the NPC will use ( NOT playermodels )
		Model = "models/vinrax/player/Scp049_player.mdl",

		-- What colour the overhead text will use
		OverHead = Color( 87, 39, 210, 25 ),

	},

	Menu = { -- This is the Menu configurations

		-- What the title will show in the menu
		Title = "Bubble Shields",

		-- This will play an open sound each time someone interacts with the NPC
		Sounds = true,
	
		-- What colour the purchase button text uses r,g,b,a
		Purchase = Color( 142, 68, 173, 255 ),

		-- What colour is the money in the menu
		Money = Color( 46, 204, 113, 255 ),

	},

	Bubble = { -- This is what the bubble that protects the player looks like

		-- What colour will the bubble be using r,g,b,a
		-- Only certain material will work with alpha
		Colour = Color( 87, 39, 210, 155 ),

		-- What material should the prop be using, be careful some materials allow users to see through props
		Material = "models/wireframe",

		-- Should the bubble shield create a shadow on the ground
		Shadows = false,

		-- The sound the bubble makes when it's activated
		Active = "bubbles/b_active.mp3",

		-- The sound the bubble makes when each break
		Break = "bubbles/b_break.mp3",

	},

	Shield = { -- Settings on how the shield works

		-- How much each bubble shield costs
		Price = 25000,

		-- How many shields a player can hold at once ( suggest keeping this low )
		Max = 4,

		-- Notify the attacker how many shields the victim has left
		Notifications = true,

		-- Makes it to where fall damage doesn't break shields and removes fall damage
		FallDamage = true,

		-- How long each bubble shield lasts
		ShieldTime = 4,

	},

	Vip = { -- This will allow certain UserGroups And Certain SteamIDS to have their own max shield limit

		Steam = { -- Supports steamid and steamid64 https://steamid.io/

			-- Use this format to add users, feel free to remove me
			[ "76561198371018204" ] = 30, -- vectivus

		},

		Rank = { -- This will support any admin mod that uses 'GetUserGroup'	
			-- If the player also has a steamid limit that will overwrite the usergroup limit

			-- [ "RANK" ] = SHIELD AMOUNT ( NUMBER )

			[ "superadmin" ] = 10,
			[ "admin" ] = 8,
			[ "vip" ] = 6,

		},

	},

	-- Weapons that can break more than 1 shields
	-- "all" will make the weapons break all victims shields
	Weapons = {

		[ "weapon_rpg" ] = "all",
		[ "weapon_357" ] = 2,

	},

}

vs.cfg.Shop = { -- This is the NPC'S Store, add / change / remove anything you want!

	{
		-- Name of shield
		name = "Single Shield",
		
		-- How much the shield costs
		price = vs.cfg.Shield.Price,
		
		-- How many shields it will give the player after purchasing
		amount = 1,
	},

	{
		name = "Two Shields",
		price = vs.cfg.Shield.Price * 2,
		amount = 2,
	},

	{
		name = "Three Shields",
		price = vs.cfg.Shield.Price * 3,
		amount = 3,
	},

	{
		name = "Max Shields",
		price = vs.cfg.Shield.Price * vs.cfg.Shield.Max,
		amount = vs.cfg.Shield.Max,
	},

}

-- CONFIG ENDS HERE --
