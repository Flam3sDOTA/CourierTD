item_ice_dragon_maw = class({})
LinkLuaModifier( "modifier_item_ice_dragon_maw", "items/modifiers/modifier_item_ice_dragon_maw", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_large_frostbitten_icicle", "items/modifiers/modifier_large_frostbitten_icicle", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function item_ice_dragon_maw:GetIntrinsicModifierName()
	return "modifier_item_ice_dragon_maw"
end

--------------------------------------------------------------------------------

function item_ice_dragon_maw:IsMuted()
	if self:GetCaster():IsHero() then
		return true
	end

	return self.BaseClass.IsMuted( self )
end
