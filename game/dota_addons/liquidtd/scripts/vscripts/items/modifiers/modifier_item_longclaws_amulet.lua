modifier_item_longclaws_amulet = class({})

--------------------------------------------------------------------------------

function modifier_item_longclaws_amulet:IsHidden()
	return true
end

--------------------------------------------------------------------------------

function modifier_item_longclaws_amulet:IsPurgable()
	return false
end

--------------------------------------------------------------------------------

function modifier_item_longclaws_amulet:OnCreated( kv )
	self.cooldown_reduction_pct = self:GetAbility():GetSpecialValueFor( "cooldown_reduction_pct" )
	self.mana_cost_reduction_pct = self:GetAbility():GetSpecialValueFor( "mana_cost_reduction_pct" )
end

--------------------------------------------------------------------------------

function modifier_item_longclaws_amulet:DeclareFunctions()
	local funcs =
	{
		MODIFIER_PROPERTY_MANACOST_PERCENTAGE,
	}
	return funcs
end

--------------------------------------------------------------------------------

function modifier_item_longclaws_amulet:GetModifierPercentageManacost( params )
	return self.mana_cost_reduction_pct
end

