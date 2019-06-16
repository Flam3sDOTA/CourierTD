modifier_100_attack_damage = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_100_attack_damage:IsHidden()
	return false
end

function modifier_100_attack_damage:IsBuff()
	return true
end

--------------------------------------------------------------------------------

function modifier_100_attack_damage:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_100_attack_damage:GetModifierPreAttack_BonusDamage( params )
	return 100
end