sniper_headshot_lua = class({})
LinkLuaModifier( "modifier_sniper_headshot_lua", "abilities/modifiers/modifier_sniper_headshot_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_headshot_lua_slow", "abilities/modifiers/modifier_sniper_headshot_lua_slow", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function sniper_headshot_lua:GetIntrinsicModifierName()
	return "modifier_sniper_headshot_lua"
end