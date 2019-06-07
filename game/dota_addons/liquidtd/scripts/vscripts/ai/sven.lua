function Spawn( entityKeyValues )
    if thisEntity == nil then
        return
    end

    if IsServer() == false then
        return
    end
    StormBolt = thisEntity:FindAbilityByName("sven_storm_bolt")
    thisEntity:SetContextThink( "SvenThink", SvenThink, .1 )
end

function SvenThink()
    if GameRules:IsGamePaused() or GameRules:State_Get() == DOTA_GAMERULES_STATE_POST_GAME or not thisEntity:IsAlive() then
        return
    end
    
    if StormBolt ~= nil and StormBolt:IsFullyCastable() then
        CastStormBolt()
    end
    
    return .1
end

function CastStormBolt()
    local enemies = FindUnitsInRadius( thisEntity:GetTeamNumber(), thisEntity:GetOrigin(), thisEntity, 800, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false )
	if #enemies > 0 then
		ExecuteOrderFromTable({
			UnitIndex = thisEntity:entindex(),
			OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
			AbilityIndex = StormBolt:entindex(),
			TargetIndex = enemies[1]:entindex(),
		})
	end
end