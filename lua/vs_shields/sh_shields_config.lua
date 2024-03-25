
VectivusShields.Config = VectivusShields.Config or {}
//////////////////////////////////////////////////////////////////////////////////

// Version: 2.0.0

/////////////////////////////// Vectivus´s Shields /////////////////////////////

// Developed by Vectivus:
// http://steamcommunity.com/profiles/76561198371018204

//////////////////////////////////////////////////////////////////////////////////

// Total amount of shield(s) a player can hold
VectivusShields.Config.Shield_Max = 4

// How long the shield(s) stay active for in seconds
VectivusShields.Config.Shield_Duration = 2

// How much it costs per shield ( darkrp gamemode support )
VectivusShields.Config.DarkRP_Price = 5000

// What Weapons can break more than 1 shield
VectivusShields.Config.Weapons = {
    -- [ "weapon_rpg" ] = "all",
    [ "weapon_357" ] = "all",
}

VectivusShields.Config.Access = { -- This will allow certain UserGroups And Certain SteamIDS to have their OWN max shield(s) limit

    Steam = { -- Supports steamid and steamid64 https://steamid.io/
        -- Use this format to add users, feel free to remove me
        [ "76561198371018204" ] = 30,
    },

    UserGroup = { -- This will support any admin mod that uses 'GetUserGroup'
    -- If the player also has a steamid limit that will overwrite the usergroup limit
        [ "superadmin" ] = 10,
    }

}
