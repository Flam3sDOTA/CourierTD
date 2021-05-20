function SellTower( entityKeyValues )
	local tower = entityKeyValues.caster
	local hero = tower:GetOwner()
	local playerID = hero:GetPlayerID()
	local player = PlayerResource:GetPlayer(playerID)
	local sellPrice = tower:GetLevel()/2
	hero:ModifyGold(sellPrice, true, 0)
	
	-- Drop Any Item in Tower's Inventory.
	for i=0, 8 do
		local item = tower:GetItemInSlot(i)
		if item then
			tower:DropItemAtPositionImmediate(item, tower:GetOrigin())
		end
	end
	
	tower:AddNoDraw()
	tower:ForceKill(true)
	SendOverheadEventMessage(player, OVERHEAD_ALERT_GOLD, tower, sellPrice, nil)
end