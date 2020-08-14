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
modifier_dark_willow_shadow_realm_lua_buff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_dark_willow_shadow_realm_lua_buff:IsHidden()
	return true
end

function modifier_dark_willow_shadow_realm_lua_buff:IsDebuff()
	return false
end

function modifier_dark_willow_shadow_realm_lua_buff:IsPurgable()
	return false
end

function modifier_dark_willow_shadow_realm_lua_buff:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dark_willow_shadow_realm_lua_buff:OnCreated( kv )
	if not IsServer() then return end

	-- references
	self.time = kv.time

	-- create custom projectile
	self:PlayEffects()
end

function modifier_dark_willow_shadow_realm_lua_buff:OnRefresh( kv )
end

function modifier_dark_willow_shadow_realm_lua_buff:OnRemoved()
end

function modifier_dark_willow_shadow_realm_lua_buff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_dark_willow_shadow_realm_lua_buff:DeclareFunctions()
end
