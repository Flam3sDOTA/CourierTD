function ChakraMagic( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local mana_restore = ability:GetLevelSpecialValueFor("mana_restore", (ability:GetLevel() - 1))
	if caster:IsHero() then
        return
    end

	target:GiveMana(mana_restore)
end