function Spawn( entityKeyValues )
    if thisEntity == nil then
        return
    end

    if IsServer() == false then
        return
    end
    LightStrikeArray = thisEntity:FindAbilityByName("lina_light_strike_array_lua")
    thisEntity:SetContextThink( "LinaThink", LinaThink, .1 )
end

function LinaThink()
    if GameRules:IsGamePaused() or GameRules:State_Get() == DOTA_GAMERULES_STATE_POST_GAME or not thisEntity:IsAlive() then
        return
    end
    
    if LightStrikeArray ~= nil and LightStrikeArray:IsFullyCastable() and not thisEntity:IsChanneling() then
        CastLightStrikeArray()
    end
	
	if thisEntity:GetAttackTarget() == nil and not LightStrikeArray:IsFullyCastable() and not thisEntity:IsChanneling() then
		local enemies = FindUnitsInRadius( thisEntity:GetTeamNumber(), thisEntity:GetOrigin(), thisEntity, 1000, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false )
		if #enemies > 0 then
			ExecuteOrderFromTable({
				UnitIndex = thisEntity:entindex(),
				OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
				AbilityIndex = nil,
				TargetIndex = enemies[1]:entindex(),
			})
		end
	end
	
    return .1
end

function CastLightStrikeArray()
    local enemies = FindUnitsInRadius( thisEntity:GetTeamNumber(), thisEntity:GetOrigin(), thisEntity, 1000, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false )
	if #enemies > 0 then
	Timers:CreateTimer(0.6, function()	
		ExecuteOrderFromTable({
			UnitIndex = thisEntity:entindex(),
			OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
			Position = enemies[1]:GetOrigin(),
			AbilityIndex = LightStrikeArray:entindex(),
		})
		end)
	end
end