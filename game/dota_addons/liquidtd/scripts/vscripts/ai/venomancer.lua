function Spawn( entityKeyValues )
    if thisEntity == nil then
        return
    end

    if IsServer() == false then
        return
    end
    VenomousGale = thisEntity:FindAbilityByName("venomancer_venomous_gale_datadriven")
    thisEntity:SetContextThink( "VenomancerThink", VenomancerThink, .1 )
end

function VenomancerThink()
    if GameRules:IsGamePaused() or GameRules:State_Get() == DOTA_GAMERULES_STATE_POST_GAME or not thisEntity:IsAlive() then
        return
    end
    
    if VenomousGale ~= nil and VenomousGale:IsFullyCastable() then
        CastVenomousGale()
    end
	
	if thisEntity:GetAttackTarget() == nil and not VenomousGale:IsFullyCastable() and not thisEntity:IsChanneling() then
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

function CastVenomousGale()
    local enemies = FindUnitsInRadius( thisEntity:GetTeamNumber(), thisEntity:GetOrigin(), thisEntity, 800, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false )
	if #enemies > 0 then
		ExecuteOrderFromTable({
			UnitIndex = thisEntity:entindex(),
			OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
			Position = enemies[1]:GetOrigin(),
			AbilityIndex = VenomousGale:entindex(),
		})
	end
end