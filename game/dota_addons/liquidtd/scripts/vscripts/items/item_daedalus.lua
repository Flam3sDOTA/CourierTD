function modifier_item_custom_daedalus_crit_chance_on_attack_landed(keys)
	local random_int = RandomInt(1, 100)
	local damageTable = {
	victim = keys.target,
	attacker = keys.caster,
	damage = 175,
	damage_type = DAMAGE_TYPE_PURE,
	damage_flags = nil, --Optional.
	ability = nil, --Optional.
	}
	
	if (random_int <= keys.crit_chance) then
		keys.target:EmitSound("DOTA_Item.Daedelus.Crit")
		keys.ability:ApplyDataDrivenModifier(keys.caster, keys.target, "modifier_item_custom_daedalus_crit", nil)
		ApplyDamage(damageTable)
	end
end

function modifier_item_custom_daedalus_recalculate_crit_chance(keys)
	Timers:CreateTimer({
		callback = function()
			--Temporarily remove all chance modifiers.
			while keys.caster:HasModifier("modifier_item_custom_daedalus_crit_chance") do
				keys.caster:RemoveModifierByName("modifier_item_custom_daedalus_crit_chance")
			end
			--Find out if there is a daedalus in the inventory.
			local daedalus = nil
			for i=0, 5, 1 do
				local current_item = keys.caster:GetItemInSlot(i)
				if current_item ~= nil then
					local item_name = current_item:GetName()
					if item_name == "item_custom_daedalus" then
						daedalus = current_item
					end
				end
			end
			if daedalus ~= nil then
				daedalus:ApplyDataDrivenModifier(keys.caster, keys.caster, "modifier_item_custom_daedalus_crit_chance", {duration = -1})
			end
		end
	})
end