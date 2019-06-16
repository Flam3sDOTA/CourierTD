modifier_3_cooldown = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_3_cooldown:IsHidden()
	return false
end

function modifier_3_cooldown:IsBuff()
	return true
end

--------------------------------------------------------------------------------

function modifier_3_cooldown:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_3_cooldown:GetModifierPercentageCooldown( params )
	return -3
end