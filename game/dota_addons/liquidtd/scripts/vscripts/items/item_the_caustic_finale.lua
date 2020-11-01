item_the_caustic_finale = class({})
LinkLuaModifier( "modifier_item_the_caustic_finale", "items/modifiers/modifier_item_the_caustic_finale", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sand_king_boss_caustic_finale", "items/modifiers/modifier_sand_king_boss_caustic_finale", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function item_the_caustic_finale:GetIntrinsicModifierName()
	return "modifier_item_the_caustic_finale"
end

--------------------------------------------------------------------------------


function item_the_caustic_finale:IsMuted()
	if self:GetCaster():IsHero() then
		return true
	end

	return self.BaseClass.IsMuted( self )
end