function Spawn( entityKeyValues )
    if thisEntity == nil then
        return
    end

    if IsServer() == false then
        return
    end
    BlackHole = thisEntity:FindAbilityByName("enigma_black_hole_lua")
    thisEntity:SetContextThink( "EnigmaThink", EnigmaThink, .1 )
end

function EnigmaThink()
    if GameRules:IsGamePaused() or GameRules:State_Get() == DOTA_GAMERULES_STATE_POST_GAME or not thisEntity:IsAlive() then
        return
    end
    
    if BlackHole ~= nil and BlackHole:IsFullyCastable() then
        CastBlackHole()
    end
    
    return .1
end

function CastBlackHole()
    local enemies = FindUnitsInRadius( thisEntity:GetTeamNumber(), thisEntity:GetOrigin(), thisEntity, 1000, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false )
	if #enemies > 0 then
	Timers:CreateTimer(0.6, function()	
		ExecuteOrderFromTable({
			UnitIndex = thisEntity:entindex(),
			OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
			Position = enemies[1]:GetOrigin(),
			AbilityIndex = BlackHole:entindex(),
		})
		end)
	end
end