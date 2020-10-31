crystal_maiden_arcane_aura_lua = class({})
LinkLuaModifier( "modifier_crystal_maiden_arcane_aura_lua", "abilities/modifiers/modifier_crystal_maiden_arcane_aura_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_crystal_maiden_arcane_aura_lua_effect", "abilities/modifiers/modifier_crystal_maiden_arcane_aura_lua_effect", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function crystal_maiden_arcane_aura_lua:GetIntrinsicModifierName()
	return "modifier_crystal_maiden_arcane_aura_lua"
end