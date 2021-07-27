AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( vs.cfg.Npc.Model )
	self:SetHullType( HULL_HUMAN )
	self:SetHullSizeNormal()
	self:SetNPCState( NPC_STATE_SCRIPT )
	self:SetSolid( SOLID_BBOX )
	self:CapabilitiesAdd( CAP_ANIMATEDFACE )
	self:CapabilitiesAdd( CAP_TURN_HEAD )
	self:SetMaxYawSpeed( 90 )
	self:SetUseType( SIMPLE_USE )
	self:DropToFloor()
	self:SetTrigger( true )
	local phys = self:GetPhysicsObject()
	if ( phys:IsValid() ) then
		phys:Wake()
	end
end

function ENT:Use( p )
	if ( p:IsPlayer() ) then
		p:ConCommand( "p.shield.menu" )		
	end
end