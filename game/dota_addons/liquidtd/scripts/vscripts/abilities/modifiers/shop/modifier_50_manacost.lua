modifier_50_manacost = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_50_manacost:IsHidden()
	return false
end

function modifier_50_manacost:IsBuff()
	return true
end

--------------------------------------------------------------------------------

function modifier_50_manacost:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MANACOST_PERCENTAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_50_manacost:GetModifierPercentageManacost( params )
	return -50
end