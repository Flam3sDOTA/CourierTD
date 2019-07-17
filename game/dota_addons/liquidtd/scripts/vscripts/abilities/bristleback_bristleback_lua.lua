bristleback_bristleback_lua = class({})
LinkLuaModifier( "modifier_bristleback_bristleback_lua", "abilities/modifiers/modifier_bristleback_bristleback_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function bristleback_bristleback_lua:GetIntrinsicModifierName()
	return "modifier_bristleback_bristleback_lua"
end