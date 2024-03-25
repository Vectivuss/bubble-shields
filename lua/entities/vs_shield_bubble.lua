
AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "[BUBBLE]"
ENT.Category = "Vectivus´s Shields"
ENT.Spawnable = false

if CLIENT then
    function ENT:DrawTranslucent()
        self:DrawModel()
    end
end

if SERVER then
    local col = Color(87,39,210,155)
    function ENT:Initialize()
        self:SetModel( "models/hunter/misc/shell2x2.mdl" )
        self:SetMaterial( "models/wireframe" )
        self:SetColor(col)
        self:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:SetSolid( SOLID_VPHYSICS )
        local phys = self:GetPhysicsObject()
        if phys:IsValid() then
            phys:Wake()
        end
    end
end
