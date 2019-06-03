function ChakraMagic( keys )
	local target = keys.target
	local ability = keys.ability
	local mana_restore = ability:GetLevelSpecialValueFor("mana_restore", (ability:GetLevel() - 1))

	target:GiveMana(mana_restore)
end