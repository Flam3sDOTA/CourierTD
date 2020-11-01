item_longclaws_amulet = class({})
LinkLuaModifier( "modifier_item_longclaws_amulet", "items/modifiers/modifier_item_longclaws_amulet", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function item_longclaws_amulet:GetIntrinsicModifierName()
	return "modifier_item_longclaws_amulet"
end

--------------------------------------------------------------------------------

function item_longclaws_amulet:IsMuted()
	if self:GetCaster():IsHero() then
		return true
	end

	return self.BaseClass.IsMuted( self )
end
