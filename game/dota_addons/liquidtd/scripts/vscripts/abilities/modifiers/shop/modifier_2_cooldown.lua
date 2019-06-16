modifier_2_cooldown = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_2_cooldown:IsHidden()
	return false
end

function modifier_2_cooldown:IsBuff()
	return true
end

--------------------------------------------------------------------------------

function modifier_2_cooldown:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_2_cooldown:GetModifierPercentageCooldown( params )
	return -2
end