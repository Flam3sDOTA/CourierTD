vengeful_spirit_vengeance_aura_lua = class({})
LinkLuaModifier( "modifier_vengeful_spirit_vengeance_aura_lua", "abilities/modifiers/modifier_vengeful_spirit_vengeance_aura_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_vengeful_spirit_vengeance_aura_lua_effect", "abilities/modifiers/modifier_vengeful_spirit_vengeance_aura_lua_effect", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function vengeful_spirit_vengeance_aura_lua:GetIntrinsicModifierName()
	return "modifier_vengeful_spirit_vengeance_aura_lua"
end