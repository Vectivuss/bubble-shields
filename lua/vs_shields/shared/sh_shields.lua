
function VectivusShields.GetShields( p )
    return IsValid(p) and p:GetNWInt( "VectivusShields.Amount", 0 ) or nil
end 

function VectivusShields.HasShields( p )
    return IsValid(p) and VectivusShields.GetShields(p) > 0 and true or false 
end

function VectivusShields.HasActiveShield( p )
    return IsValid(p) and p:GetNWBool( "VectivusShields.ActiveShield", false )
end

function VectivusShields.GetMaxShields( p )
    if !IsValid(p) then return end
    local sid, sid64, rank = p:SteamID(), p:SteamID64(), p:GetUserGroup()
    return ( (VectivusShields.Config.Access.Steam[sid] or VectivusShields.Config.Access.Steam[sid64]) or VectivusShields.Config.Access.UserGroup[rank] or VectivusShields.Config.Shield_Max )
end
