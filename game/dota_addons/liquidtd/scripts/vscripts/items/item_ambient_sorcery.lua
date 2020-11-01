
item_ambient_sorcery = class({})
LinkLuaModifier( "modifier_item_ambient_sorcery", "items/modifiers/modifier_item_ambient_sorcery", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_ambient_sorcery_effect", "items/modifiers/modifier_item_ambient_sorcery_effect", LUA_MODIFIER_MOTION_NONE )


--------------------------------------------------------------------------------

function item_ambient_sorcery:GetIntrinsicModifierName()
	return "modifier_item_ambient_sorcery"
end

--------------------------------------------------------------------------------

function item_ambient_sorcery:Spawn()
end

--------------------------------------------------------------------------------

function item_ambient_sorcery:IsMuted()
	if self:GetCaster():IsHero() then
		return true
	end

	return self.BaseClass.IsMuted( self )
end

--------------------------------------------------------------------------------
