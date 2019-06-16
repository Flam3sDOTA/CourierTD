modifier_1_cooldown = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_1_cooldown:IsHidden()
	return false
end

function modifier_1_cooldown:IsBuff()
	return true
end

--------------------------------------------------------------------------------

function modifier_1_cooldown:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_1_cooldown:GetModifierPercentageCooldown( params )
	return -1
end