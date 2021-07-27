do end

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:Initialize()
    self:SetModel( "models/hunter/misc/shell2x2.mdl" )
	self:SetMaterial( vs.cfg.Bubble.Material )
	self:SetColor( vs.cfg.Bubble.Colour )
    self:SetCollisionGroup( 1 )
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )

	if ( !vs.cfg.Bubble.Shadows ) then
		self:DrawShadow( false )
	else
		self:DrawShadow( true )
	end
    local p = self:GetPhysicsObject()
    if ( p:IsValid() ) then
        p:Wake()
    end
end

function ENT:OnRemove() end