modifier_bristleback_bristleback_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_bristleback_bristleback_lua:IsHidden()
	return true
end

function modifier_bristleback_bristleback_lua:IsDebuff()
	return false
end

function modifier_bristleback_bristleback_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_bristleback_bristleback_lua:OnCreated( kv )
	-- references
	self.reduction_back = self:GetAbility():GetSpecialValueFor( "back_damage_reduction" )
	self.reduction_side = self:GetAbility():GetSpecialValueFor( "side_damage_reduction" )
	self.angle_back = self:GetAbility():GetSpecialValueFor( "back_angle" )
	self.angle_side = self:GetAbility():GetSpecialValueFor( "side_angle" )
end

function modifier_bristleback_bristleback_lua:OnRefresh( kv )
	-- references
	self.reduction_back = self:GetAbility():GetSpecialValueFor( "back_damage_reduction" )
	self.reduction_side = self:GetAbility():GetSpecialValueFor( "side_damage_reduction" )
	self.angle_back = self:GetAbility():GetSpecialValueFor( "back_angle" )
	self.angle_side = self:GetAbility():GetSpecialValueFor( "side_angle" )
end

function modifier_bristleback_bristleback_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_bristleback_bristleback_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		-- MODIFIER_EVENT_ON_TAKEDAMAGE,
	}

	return funcs
end

function modifier_bristleback_bristleback_lua:GetModifierIncomingDamage_Percentage( params )
	if IsServer() and (not self:GetParent():PassivesDisabled()) then
		local parent = self:GetParent()
		local attacker = params.attacker
		local reduction = 0

		if attacker:IsTower() then
			return 0
		end

		-- Check target position
		local facing_direction = parent:GetAnglesAsVector().y
		local attacker_vector = (attacker:GetOrigin() - parent:GetOrigin()):Normalized()
		local attacker_direction = VectorToAngles( attacker_vector ).y
		local angle_diff = AngleDiff( facing_direction, attacker_direction )
		angle_diff = math.abs(angle_diff)

		-- calculate damage reduction
		if angle_diff > (180-self.angle_back) then
			reduction = self.reduction_back
			self:PlayEffects( true, attacker_vector )

		elseif angle_diff > (180-self.angle_side) then
			reduction = self.reduction_side
			self:PlayEffects( false, attacker_vector )
		end

		return -reduction
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_bristleback_bristleback_lua:PlayEffects( bBack, direction )
	-- Get Resources
	local particle_cast_back = "particles/units/heroes/hero_bristleback/bristleback_back_dmg.vpcf"
	local particle_cast_side = "particles/units/heroes/hero_bristleback/bristleback_side_dmg.vpcf"
	local sound_cast = "Hero_Bristleback.Bristleback"

	local effect_cast = nil
	if bBack then
		effect_cast = ParticleManager:CreateParticle( particle_cast_back, PATTACH_ABSORIGIN, self:GetParent() )
		ParticleManager:SetParticleControlEnt(
			effect_cast,
			1,
			self:GetParent(),
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			self:GetParent():GetOrigin(), -- unknown
			true -- unknown, true
		)
		EmitSoundOn( sound_cast, self:GetParent() )
	else
		effect_cast = ParticleManager:CreateParticle( particle_cast_side, PATTACH_ABSORIGIN, self:GetParent() )
		ParticleManager:SetParticleControlEnt(
			effect_cast,
			1,
			self:GetParent(),
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			self:GetParent():GetOrigin(), -- unknown
			true -- unknown, true
		)
		ParticleManager:SetParticleControlForward( effect_cast, 3, -direction )

	end
	ParticleManager:ReleaseParticleIndex( effect_cast )
end