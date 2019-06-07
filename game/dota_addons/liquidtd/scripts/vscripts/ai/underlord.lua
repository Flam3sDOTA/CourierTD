function Spawn( entityKeyValues )
    if thisEntity == nil then
        return
    end

    if IsServer() == false then
        return
    end
    Malice = thisEntity:FindAbilityByName("abyssal_underlord_pit_of_malice")
    thisEntity:SetContextThink( "UnderlordThink", UnderlordThink, .1 )
end

function UnderlordThink()
    if GameRules:IsGamePaused() or GameRules:State_Get() == DOTA_GAMERULES_STATE_POST_GAME or not thisEntity:IsAlive() then
        return
    end
    
    if Malice ~= nil and Malice:IsFullyCastable() then
        CastMalice()
    end
    
    return .1
end

function CastMalice()
    local enemies = FindUnitsInRadius( thisEntity:GetTeamNumber(), thisEntity:GetOrigin(), thisEntity, 1000, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false )
	if #enemies > 0 then
	Timers:CreateTimer(0.6, function()	
		ExecuteOrderFromTable({
			UnitIndex = thisEntity:entindex(),
			OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
			Position = enemies[1]:GetOrigin(),
			AbilityIndex = Malice:entindex(),
		})
		end)
	end
end