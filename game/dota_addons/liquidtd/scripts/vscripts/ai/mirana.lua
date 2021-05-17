function Spawn( entityKeyValues )
    if thisEntity == nil then
        return
    end

    if IsServer() == false then
        return
    end
    Starfall = thisEntity:FindAbilityByName("mirana_starfall_datadriven")
    thisEntity:SetContextThink( "MiranaThink", MiranaThink, .1 )
end

function MiranaThink()
    if GameRules:IsGamePaused() or GameRules:State_Get() == DOTA_GAMERULES_STATE_POST_GAME or not thisEntity:IsAlive() then
        return
    end
    
    if Starfall ~= nil and Starfall:IsFullyCastable() then
        CastStarfall()
    end
	
	if thisEntity:GetAttackTarget() == nil and not Starfall:IsFullyCastable() and not thisEntity:IsChanneling() then
		local enemies = FindUnitsInRadius( thisEntity:GetTeamNumber(), thisEntity:GetOrigin(), thisEntity, 800, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false )
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

function CastStarfall()
    local enemies = FindUnitsInRadius( thisEntity:GetTeamNumber(), thisEntity:GetOrigin(), thisEntity, 800, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false )
	if #enemies > 0 then
		ExecuteOrderFromTable({
			UnitIndex = thisEntity:entindex(),
			OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
			AbilityIndex = Starfall:entindex()
		})
	end
end