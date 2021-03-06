function ChangePage(keys)
    local tower = keys.caster
    local player = tower:GetOwner()
	local playerID = player:GetPlayerID()
    local team = player:GetTeam()
    local pos = tower:GetAbsOrigin()
    local newName = keys.tower
	
	local ability = tower:FindAbilityByName("lina_light_strike_array_lua")
	local cooldownleft = ability:GetCooldownTimeRemaining()
	
	local mana = tower:GetMana()
	local items = {}
	for i=0, 8 do
		local item = tower:GetItemInSlot(i)
		if item then
			table.insert(items,item)
		end
	end
	
    -- Kill the old building
    tower:AddEffects(EF_NODRAW) --Hide it, so that it's still accessible after this script
    tower.upgraded = true --Skips visual effects
    tower:ForceKill(true) --Kill the tower
    
    -- Create the new building
    local new_building = BuildingHelper:PlaceBuilding(playerID, newName, pos, BuildingHelper:GetConstructionSize(newName), BuildingHelper:GetBlockPathingSize(newName), angle)
	-- Add Old Building's Items to the new tower
	for _,v in pairs(items) do
		new_building:AddItem(v)
	end
	
	new_building:GiveMana(mana)
	local abilitynew = new_building:FindAbilityByName("lina_light_strike_array_lua")
	local cooldown = cooldownleft - 0.5
	abilitynew:StartCooldown(cooldown)
	
	
	-- If the building to ugprade is selected, change the selection to the new one
	if PlayerResource:IsUnitSelected(playerID, tower) then
      PlayerResource:AddToSelection(playerID, new_building)
	end
    return new_building
end