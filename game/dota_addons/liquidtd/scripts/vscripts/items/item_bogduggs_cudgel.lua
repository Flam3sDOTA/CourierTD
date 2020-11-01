item_bogduggs_cudgel = class({})
LinkLuaModifier( "modifier_item_bogduggs_cudgel", "items/modifiers/modifier_item_bogduggs_cudgel", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function item_bogduggs_cudgel:GetIntrinsicModifierName()
	return "modifier_item_bogduggs_cudgel"
end

--------------------------------------------------------------------------------

function item_bogduggs_cudgel:IsMuted()
	if self:GetCaster():IsHero() then
		return true
	end

	return self.BaseClass.IsMuted( self )
end
