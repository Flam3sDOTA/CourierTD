function Spawn( entityKeyValues )
    if thisEntity == nil then
        return
    end

    if IsServer() == false then
        return
    end
    Impetus = thisEntity:FindAbilityByName("enchantress_impetus")
    thisEntity:SetContextThink( "EnchantressThink", EnchantressThink, 1 )
end

function EnchantressThink()
    if GameRules:IsGamePaused() or GameRules:State_Get() == DOTA_GAMERULES_STATE_POST_GAME or not thisEntity:IsAlive() then
        return
    end
    
    if Impetus ~= nil and Impetus:IsFullyCastable() then
        CastImpetus()
    end
    
    return .1
end

function CastImpetus()
    local enemies = FindUnitsInRadius( thisEntity:GetTeamNumber(), thisEntity:GetOrigin(), thisEntity, 800, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_FARTHEST, false )
	if #enemies > 0 then
		ExecuteOrderFromTable({
			UnitIndex = thisEntity:entindex(),
			OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
			AbilityIndex = Impetus:entindex(),
			TargetIndex = enemies[1]:entindex(),
		})
	end
    return 1
end