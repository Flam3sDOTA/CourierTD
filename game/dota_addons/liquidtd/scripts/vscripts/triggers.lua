function OnStartTouch(trigger)
	local activator = trigger.activator
	if not activator:IsRealHero() then
		activator.destination_reached = true
	-- Kill the creep
		activator:ForceKill(false)
		activator:AddNoDraw()
		-- Damage the player
		local hero = activator.heroToDamage
		EmitSoundOnClient( "Frostivus.PointScored.Enemy", PlayerResource:GetPlayer( hero:GetPlayerID() ) )
		ScreenShake(hero:GetAbsOrigin(), 5, 150, 0.25, 2000, 0, true)
		if hero and hero:IsAlive() then      
			local damage = activator.leakDamage or 1
			local damageTable = {
			victim = hero,
			attacker = activator,
			damage = damage,
			damage_type = DAMAGE_TYPE_PURE,
			damage_flags = nil, --Optional.
			ability = nil, --Optional.
			}
			ApplyDamage(damageTable)
			SendOverheadEventMessage( hero, OVERHEAD_ALERT_LAST_HIT_MISS , hero, damage, nil )
			-- Check if the health is 0
			if hero:GetHealth() <= 0 then
				-- Player is dead.
				-- Drop the items.
				for i=0, 8 do
					local item = hero:GetItemInSlot(i)
					if item then
						hero:DropItemAtPositionImmediate(item, hero:GetOrigin())
					end
				end
				-- Clean towers
				local units = FindUnitsInRadius( hero:GetTeam(), hero:GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED, FIND_ANY_ORDER, false )
				for _,unit in pairs(units) do
					unit:ForceKill(true)
				end
				
				-- Clean dropped items
				Timers:CreateTimer(2, function()
					for _,item in pairs( Entities:FindAllByClassname( "dota_item_drop")) do
						local containedItem = item:GetContainedItem()
						UTIL_Remove( item )
					end
				end)
				Timers:CreateTimer(5, function()
					hero:AddNoDraw()
				end)
			end
		end	
	end
end