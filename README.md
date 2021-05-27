## *Bubble Shields*

[![MIT Licence](https://img.shields.io/github/license/vectivuss/bubble-shields?color=%235727d2&label=License)](https://github.com/Vectivuss/bubble-shields/blob/main/LICENSE)
[![Size](https://img.shields.io/github/repo-size/Vectivuss/bubble-shields?color=%23d227aa&label=Size&logo=lua)](https://github.com/Vectivuss/bubble-shields)

### *About*
Bubble shields protect the user from ALL incoming damage for a certain amount of time. The user is able to carry an amount of bubble shields at a time for example 5. When all shields do break the user will begin to take damage again. The addon was specifically made for DarkRP but can easily be support for other Gamemodes in the future

### *Includes*

| *Features* | *Description*
|  :--- | :--- |
| Addon Integration | Easy to integration other addons with bubble shields e.g voidcases
| Administration | Bubble shields currently supports ULX and SAM administration with cmds
| Logging | Allows addons such as BLogs to monitor purchases and shield breaks
| Lightweight | The addon is completely lightweight and easy to setup / configure

### *Requirements*
* [Workshop Content](https://steamcommunity.com/sharedfiles/filedetails/?id=2268032178)
* [DarkRP Gamemode](https://github.com/FPtje/DarkRP)

### *Configuration*
To configure the addon you must edit the config file which is located: `vs_shields/lua/autorun/sh_shields_cfg.lua` Make sure that you've read the file carefully and haven't made any mistakes, in doing so it will cause the entire addon to break.

### *Documentation*

| *Functions* | *Arguments* | *Description*
|  :--- | :--- | :--- |
| addShields | Player, Amount | Adds shields to Player/NPC ( Serverside )
| removeShields | Player, Amount | Removes shields from Player/NPC ( Serverside )
