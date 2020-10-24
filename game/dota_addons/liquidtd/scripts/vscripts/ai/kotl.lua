function Spawn( entityKeyValues )
    if thisEntity == nil then
        return
    end

    if IsServer() == false then
        return
    end
    ChakraMagic = thisEntity:FindAbilityByName("chakra_magic_datadriven")
    thisEntity:SetContextThink( "KotlThink", KotlThink, .1 )
end

function KotlThink()
    if GameRules:IsGamePaused() or GameRules:State_Get() == DOTA_GAMERULES_STATE_POST_GAME or not thisEntity:IsAlive() then
        return
    end
    
    if ChakraMagic ~= nil and ChakraMagic:IsFullyCastable() then
        CastChakraMagic()
    end
    
    return .1
end

function CastChakraMagic()
    local friends = FindUnitsInRadius( thisEntity:GetTeamNumber(), thisEntity:GetOrigin(), thisEntity, 800, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_MANA_ONLY, FIND_ANY_ORDER, false )
    local target
    for i=1, #friends do
		if not target and friends[i] ~= thisEntity and not friends[i]:IsHero() and friends[i]:GetMana() < 90 then
			for mom=0, 8 do
				local item = friends[i]:GetItemInSlot(mom)
				if item == "item_custom_mask_of_madness" then
					return KotlThink()
				else
					target = friends[i]
				end
			end
		end
    end
    if target then
        ExecuteOrderFromTable({
            UnitIndex = thisEntity:entindex(),
            OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
            AbilityIndex = ChakraMagic:entindex(),
            TargetIndex = target:entindex(),
        })
    end
end