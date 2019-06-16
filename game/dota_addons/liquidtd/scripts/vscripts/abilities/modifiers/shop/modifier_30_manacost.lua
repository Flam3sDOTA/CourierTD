modifier_30_manacost = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_30_manacost:IsHidden()
	return false
end

function modifier_30_manacost:IsBuff()
	return true
end

--------------------------------------------------------------------------------

function modifier_30_manacost:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MANACOST_PERCENTAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_30_manacost:GetModifierPercentageManacost( params )
	return -30
end