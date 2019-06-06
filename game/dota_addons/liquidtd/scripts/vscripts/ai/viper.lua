function Spawn( entityKeyValues )
    if thisEntity == nil then
        return
    end

    if IsServer() == false then
        return
    end
    ViperStrike = thisEntity:FindAbilityByName("viper_viper_strike_datadriven")
    thisEntity:SetContextThink( "ViperThink", ViperThink, .1 )
end

function ViperThink()
    if GameRules:IsGamePaused() or GameRules:State_Get() == DOTA_GAMERULES_STATE_POST_GAME or not thisEntity:IsAlive() then
        return
    end
    
    if ViperStrike ~= nil and ViperStrike:IsFullyCastable() then
        CastViperStrike()
    end
    
    return .1
end

function CastViperStrike()
    local enemies = FindUnitsInRadius( thisEntity:GetTeamNumber(), thisEntity:GetOrigin(), thisEntity, 800, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_FARTHEST, false )
	if #enemies > 0 then
		ExecuteOrderFromTable({
			UnitIndex = thisEntity:entindex(),
			OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
			AbilityIndex = ViperStrike:entindex(),
			TargetIndex = enemies[1]:entindex(),
		})
	end
end