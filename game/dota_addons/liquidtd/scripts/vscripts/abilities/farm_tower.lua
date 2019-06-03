function Farm_Tower(keys)
	local unit = keys.caster
	local Gold = keys.ability:GetSpecialValueFor("Gold")
	local countdown = keys.ability:GetSpecialValueFor("Time")
	Timers:CreateTimer(countdown,function()
		if unit ~= nil and not unit:IsNull() and unit:IsAlive() then
			print("[DUEL TD] Adding Gold for:" ..Gold)
			local hero = unit:GetOwner()
			hero:ModifyGold(Gold,true,0)
			local coins = ParticleManager:CreateParticle("particles/econ/items/alchemist/alchemist_midas_knuckles/alch_knuckles_lasthit_coins.vpcf", PATTACH_CUSTOMORIGIN, dummy)
			ParticleManager:SetParticleControl(coins, 1, unit:GetOrigin())
			ParticleManager:SetParticleControl(coins, 3, unit:GetOrigin())
			return countdown
		else
			print("[DUEL TD] Farm Tower Doesn't Exists.")
		end
	end)
end
