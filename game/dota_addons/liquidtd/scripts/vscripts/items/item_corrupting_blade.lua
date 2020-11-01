
item_corrupting_blade = class({})
LinkLuaModifier( "modifier_item_corrupting_blade", "items/modifiers/modifier_item_corrupting_blade", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_corrupting_blade_buff", "items/modifiers/modifier_item_corrupting_blade_buff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function item_corrupting_blade:GetIntrinsicModifierName()
	return "modifier_item_corrupting_blade"
end

--------------------------------------------------------------------------------

function item_corrupting_blade:IsMuted()
	if self:GetCaster():IsHero() then
		return true
	end

	return self.BaseClass.IsMuted( self )
end

--------------------------------------------------------------------------------