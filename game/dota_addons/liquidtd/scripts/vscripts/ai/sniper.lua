function Spawn( entityKeyValues )
    if thisEntity == nil then
        return
    end

    if IsServer() == false then
        return
    end
    thisEntity:SetContextThink( "SniperThink", SniperThink, .1 )
end

function SniperThink()
    if GameRules:IsGamePaused() or GameRules:State_Get() == DOTA_GAMERULES_STATE_POST_GAME or not thisEntity:IsAlive() then
        return
    end
    
	if thisEntity:GetAttackTarget() == nil and not thisEntity:IsChanneling() then
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