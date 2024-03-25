
AddCSLuaFile()

ENT.Type = "ai"
ENT.Base = "base_ai"
ENT.PrintName = "[BUBBLE NPC]"
ENT.Category = "Vectivus´s Shields"
ENT.Spawnable = true

if CLIENT then
    function ENT:Draw()

        self:DrawModel()
        local p, col, col2 = LocalPlayer(), Color(87,39,210,25), Color(0,0,0,200)
        if !IsValid(p) then return end
        if p:GetPos():Distance( self:GetPos() ) > 180 then return end

        local Pos = self:GetPos() + self:GetUp() * 85
        Pos = Pos + self:GetUp() * math.abs( math.sin( CurTime() ) * 1.2 )
        local Ang = Angle( 0, p:EyeAngles().y - 90, 90 )
        cam.Start3D2D( Pos, Ang, 0.1 )
            surface.SetFont( "vs.shields.ui.50" )
            local text = "Bubble Shields"
            local tW, _ = surface.GetTextSize( text )+40
            draw.RoundedBox( 22, -125, 30, tW, 60, col2 )
            draw.SimpleTextOutlined( text, "vs.shields.ui.50", 1, 62, color_white, 1, 1, 3, col )
            draw.NoTexture()
        cam.End3D2D()
    end
end

if SERVER then
    function ENT:Initialize()
        self:SetModel( "models/Combine_Super_Soldier.mdl" )
        self:SetHullType( HULL_HUMAN )
        self:SetHullSizeNormal()
        self:SetNPCState( NPC_STATE_SCRIPT )
        self:SetSolid( SOLID_BBOX )
        self:CapabilitiesAdd( CAP_ANIMATEDFACE )
        self:CapabilitiesAdd( CAP_TURN_HEAD )
        self:SetMaxYawSpeed( 90 )
        self:SetUseType( SIMPLE_USE )
        self:SetTrigger( true )
        local phys = self:GetPhysicsObject()
        if phys:IsValid() then
            phys:Wake()
        end
    end
    function ENT:Use(p)
        p:ConCommand("vs.shield.npc")
    end
end
