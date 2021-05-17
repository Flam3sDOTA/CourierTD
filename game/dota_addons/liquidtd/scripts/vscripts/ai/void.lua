function Spawn( entityKeyValues )
    if thisEntity == nil then
        return
    end

    if IsServer() == false then
        return
    end
    Chrono = thisEntity:FindAbilityByName("faceless_void_chronosphere_lua")
    thisEntity:SetContextThink( "VoidThink", VoidThink, .1 )
end

function VoidThink()
    if GameRules:IsGamePaused() or GameRules:State_Get() == DOTA_GAMERULES_STATE_POST_GAME or not thisEntity:IsAlive() then
        return
    end
    
    if Chrono ~= nil and Chrono:IsFullyCastable() then
        CastChrono()
    end
	
	if thisEntity:GetAttackTarget() == nil and not Chrono:IsFullyCastable() then
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

function CastChrono()
    local enemies = FindUnitsInRadius( thisEntity:GetTeamNumber(), thisEntity:GetOrigin(), thisEntity, 1000, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false )
	if #enemies > 0 then
	Timers:CreateTimer(0.6, function()	
		ExecuteOrderFromTable({
			UnitIndex = thisEntity:entindex(),
			OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
			Position = enemies[1]:GetOrigin(),
			AbilityIndex = Chrono:entindex(),
		})
		end)
	end
end