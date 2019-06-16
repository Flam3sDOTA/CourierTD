modifier_20_manacost = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_20_manacost:IsHidden()
	return false
end

function modifier_20_manacost:IsBuff()
	return true
end

--------------------------------------------------------------------------------

function modifier_20_manacost:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MANACOST_PERCENTAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_20_manacost:GetModifierPercentageManacost( params )
	return -20
end