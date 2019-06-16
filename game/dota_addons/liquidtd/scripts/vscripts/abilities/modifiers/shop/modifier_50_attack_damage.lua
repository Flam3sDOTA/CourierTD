modifier_50_attack_damage = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_50_attack_damage:IsHidden()
	return false
end

function modifier_50_attack_damage:IsBuff()
	return true
end

--------------------------------------------------------------------------------

function modifier_50_attack_damage:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_50_attack_damage:GetModifierPreAttack_BonusDamage( params )
	return 50
end