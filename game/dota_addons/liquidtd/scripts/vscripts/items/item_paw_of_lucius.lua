item_paw_of_lucius = class({})
LinkLuaModifier( "modifier_item_paw_of_lucius", "items/modifiers/modifier_item_paw_of_lucius", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function item_paw_of_lucius:GetIntrinsicModifierName()
	return "modifier_item_paw_of_lucius"
end

--------------------------------------------------------------------------------

function item_paw_of_lucius:IsMuted()
	if self:GetCaster():IsHero() then
		return true
	end

	return self.BaseClass.IsMuted( self )
end

