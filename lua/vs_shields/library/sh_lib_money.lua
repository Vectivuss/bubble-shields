
// Supports: DarkRP, NutScript, BaseWars, Helix

VectivusLib = VectivusLib or {}

function VectivusLib.GetMoney( p )
    if !IsValid( p ) then return end
    if DarkRP then
        return p:getDarkRPVar( "money" ) or 0
    elseif nut then
        return p:getChar():getMoney() or 0
    elseif BaseWars then
        return p:GetMoney() or 0
    elseif ix then
        local ch = p:GetCharacter()
        return ((ch and ch:GetMoney()) or 0)
    end
    return nil
end
function VectivusLib.HasMoney( p, money )
    if !IsValid( p ) then return end
    money = money or 0
    local i = VectivusLib.GetMoney(p)
    if i and i >= money then return true end
    return false
end
if SERVER then
    function VectivusLib.GiveMoney( p, money )
        if !IsValid( p ) then return end
        if DarkRP then
            p:addMoney( money )
            print( p, money )

        elseif nut then
            p:getChar():takeMoney( money )
        elseif BaseWars then
            p:GiveMoney( money )
        elseif ix then
            local ch = p:GetCharacter()
            if ch then ch:SetMoney( (ch:GetMoney() or 0)+money ) end
        end
    end
end
