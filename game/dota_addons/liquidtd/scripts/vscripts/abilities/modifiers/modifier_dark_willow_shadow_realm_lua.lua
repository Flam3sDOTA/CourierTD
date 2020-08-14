-- Created by Elfansoer
--[[
Ability checklist (erase if done/checked):
- Scepter Upgrade
- Break behavior
- Linken/Reflect behavior
- Spell Immune/Invulnerable/Invisible behavior
- Illusion behavior
- Stolen behavior
]]
--------------------------------------------------------------------------------
modifier_dark_willow_shadow_realm_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_dark_willow_shadow_realm_lua:IsHidden()
	return false
end

function modifier_dark_willow_shadow_realm_lua:IsDebuff()
	return false
end

function modifier_dark_willow_shadow_realm_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dark_willow_shadow_realm_lua:OnCreated( kv )
	-- references
	self.buff_duration = 3
	self.scepter = self:GetParent():HasScepter()

	if not IsServer() then return end
	-- set creation time
	self.create_time = GameRules:GetGameTime()

	-- dodge projectiles
	ProjectileManager:ProjectileDodge( self:GetParent() )

	-- stop if currently attacking
	if self:GetParent():GetAggroTarget() and not self.scepter then

		-- unit:Stop() is not enough to stop
		local order = {
			UnitIndex = self:GetParent():entindex(),
			OrderType = DOTA_UNIT_ORDER_STOP,
		}
		ExecuteOrderFromTable( order )
	end

	self:PlayEffects()
end

function modifier_dark_willow_shadow_realm_lua:OnRefresh( kv )
	-- references
	self.buff_duration = 3

	if not IsServer() then return end
	-- dodge projectiles
	ProjectileManager:ProjectileDodge( self:GetParent() )
end

function modifier_dark_willow_shadow_realm_lua:OnRemoved()
end

function modifier_dark_willow_shadow_realm_lua:OnDestroy()
	-- stop sound
	local sound_cast = "Hero_DarkWillow.Shadow_Realm"
	StopSoundOn( sound_cast, self:GetParent() )
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_dark_willow_shadow_realm_lua:CheckState()
	local state = {
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_UNTARGETABLE] = true,
		-- [MODIFIER_STATE_UNSELECTABLE] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_dark_willow_shadow_realm_lua:GetStatusEffectName()
	return "particles/status_fx/status_effect_dark_willow_shadow_realm.vpcf"
end

function modifier_dark_willow_shadow_realm_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_dark_willow/dark_willow_shadow_realm.vpcf"
	local sound_cast = "Hero_DarkWillow.Shadow_Realm"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self:GetParent(),
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetParent() )
end