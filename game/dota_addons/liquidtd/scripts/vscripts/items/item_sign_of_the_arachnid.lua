item_sign_of_the_arachnid = class({})
LinkLuaModifier( "modifier_item_sign_of_the_arachnid", "items/modifiers/modifier_item_sign_of_the_arachnid", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_sign_of_the_arachnid_effect", "items/modifiers/modifier_item_sign_of_the_arachnid_effect", LUA_MODIFIER_MOTION_NONE )


--------------------------------------------------------------------------------

function item_sign_of_the_arachnid:GetIntrinsicModifierName()
	return "modifier_item_sign_of_the_arachnid"
end

--------------------------------------------------------------------------------

function item_sign_of_the_arachnid:IsMuted()
	if self:GetCaster():IsHero() then
		return true
	end

	return self.BaseClass.IsMuted( self )
end