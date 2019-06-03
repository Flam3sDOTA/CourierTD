function Spawn( entityKeyValues )
    if thisEntity == nil then
        return
    end

    if IsServer() == false then
        return
    end
    Sprout = thisEntity:FindAbilityByName("furion_sprout_datadriven")
    thisEntity:SetContextThink( "FurionThink", FurionThink, 1 )
end

function FurionThink()
    if GameRules:IsGamePaused() or GameRules:State_Get() == DOTA_GAMERULES_STATE_POST_GAME or not thisEntity:IsAlive() then
        return
    end
    
    if Sprout ~= nil and Sprout:IsFullyCastable() then
        CastSprout()
    end
    
    return .1
end

function CastSprout()
    local enemies = FindUnitsInRadius( thisEntity:GetTeamNumber(), thisEntity:GetOrigin(), thisEntity, 800, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false )
	if #enemies > 0 then
		ExecuteOrderFromTable({
			UnitIndex = thisEntity:entindex(),
			OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
			AbilityIndex = Sprout:entindex(),
			TargetIndex = enemies[1]:entindex(),
		})
	end
    return 1
end