function Spawn( entityKeyValues )
    if thisEntity == nil then
        return
    end

    if IsServer() == false then
        return
    end
    CrystalNova = thisEntity:FindAbilityByName("crystal_maiden_crystal_nova")
    thisEntity:SetContextThink( "CMThink", CMThink, 1 )
end

function CMThink()
    if GameRules:IsGamePaused() or GameRules:State_Get() == DOTA_GAMERULES_STATE_POST_GAME or not thisEntity:IsAlive() then
        return
    end
    
    if CrystalNova ~= nil and CrystalNova:IsFullyCastable() then
        CastCrystalNova()
    end

    return .1
end

function CastCrystalNova()
    local enemies = FindUnitsInRadius( thisEntity:GetTeamNumber(), thisEntity:GetOrigin(), thisEntity, 800, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false )
	if #enemies > 0 then
		ExecuteOrderFromTable({
			UnitIndex = thisEntity:entindex(),
			OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
			Position = enemies[1]:GetOrigin(),
			AbilityIndex = CrystalNova:entindex(),
		})
	end
    return 1
end