modifier_vengeful_spirit_vengeance_aura_lua_effect = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_vengeful_spirit_vengeance_aura_lua_effect:IsHidden()
	return false
end

function modifier_vengeful_spirit_vengeance_aura_lua_effect:IsDebuff()
	return false
end

function modifier_vengeful_spirit_vengeance_aura_lua_effect:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_vengeful_spirit_vengeance_aura_lua_effect:OnCreated( kv )
	-- references
	self.bonus_attack_damage = self:GetAbility():GetSpecialValueFor( "bonus_attack_damage" ) -- special value
end

function modifier_vengeful_spirit_vengeance_aura_lua_effect:OnRefresh( kv )
	-- references
	self.bonus_attack_damage = self:GetAbility():GetSpecialValueFor( "bonus_attack_damage" ) -- special value
end

function modifier_vengeful_spirit_vengeance_aura_lua_effect:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_vengeful_spirit_vengeance_aura_lua_effect:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	}

	return funcs
end
function modifier_vengeful_spirit_vengeance_aura_lua_effect:GetModifierDamageOutgoing_Percentage()
	return self.bonus_attack_damage
end