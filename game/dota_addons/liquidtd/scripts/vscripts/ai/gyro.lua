function Spawn( entityKeyValues )
    if thisEntity == nil then
        return
    end

    if IsServer() == false then
        return
    end
    FlakCannon = thisEntity:FindAbilityByName("flak_cannon_datadriven")
    thisEntity:SetContextThink( "GyroThink", GyroThink, .1 )
end

function GyroThink()
    if GameRules:IsGamePaused() or GameRules:State_Get() == DOTA_GAMERULES_STATE_POST_GAME or not thisEntity:IsAlive() then
        return
    end
    
    if FlakCannon ~= nil and FlakCannon:IsFullyCastable() then
        CastFlakCannon()
    end
    
    return .1
end

function CastFlakCannon()
    local enemies = FindUnitsInRadius( thisEntity:GetTeamNumber(), thisEntity:GetOrigin(), thisEntity, 900, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false )
	if #enemies > 1 then
		ExecuteOrderFromTable({
			UnitIndex = thisEntity:entindex(),
			OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
			AbilityIndex = FlakCannon:entindex()
		})
	end
end