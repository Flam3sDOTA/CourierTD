GameRules.DropTable = LoadKeyValues("scripts/kv/item_drops.kv")

---------------------------------------------------------------------------
-- Event: OnNPCSpawned
---------------------------------------------------------------------------
function LiquidTD:OnNPCSpawned(event)
    local spawned = EntIndexToHScript(event.entindex)

    if not spawned then
        return
    end
  
  if spawned:IsRealHero() and spawned.bFirstspawned == nil then
    spawned.bFirstspawned = true
    LiquidTD:OnHeroInGame(spawned)
  end
  OnTowerSpawned(spawned)
end

---------------------------------------------------------------------------
-- Event: OnHeroInGame
---------------------------------------------------------------------------
function LiquidTD:OnHeroInGame(hero)
  local abilities = {
    "builder_invulnerable",
    "build_tower_arrow",
    "build_tower_poison",
    "build_tower_ice",
    "build_tower_utility"
  }

  for i = 1, #abilities do
  local current_ability = hero:FindAbilityByName(abilities[i])
    if current_ability then
      current_ability:SetLevel(1)
    end
  end 
end

---------------------------------------------------------------------------
-- Event: OnEntityHurt
---------------------------------------------------------------------------
function LiquidTD:OnEntityHurt(event)
  local attacker = EntIndexToHScript(event.entindex_attacker)
  local inflictor
  if event.entindex_inflictor then
    inflictor = EntIndexToHScript(event.entindex_inflictor)
  end
  local damagebits = event.damagebits
  local damage = event.damage

  -- if the attacker was a tower
  if attacker:GetTeam() ~= DOTA_TEAM_NEUTRALS and not inflictor then
    local maxMana = attacker:GetMaxMana()
    if maxMana > 0 and attacker:GetMana() < maxMana then
      local manaGained = damage * 0.01
      attacker:GiveMana(manaGained)
    end
  end
end


---------------------------------------------------------------------------
-- Event: OnConnectFull
---------------------------------------------------------------------------
function LiquidTD:OnConnectFull(keys) 
	local entIndex = keys.index + 1
	local player = EntIndexToHScript(entIndex)
end

---------------------------------------------------------------------------
-- Event: OnPlayerReconnect
---------------------------------------------------------------------------
function LiquidTD:OnPlayerReconnect(keys)
 
end

---------------------------------------------------------------------------
-- Event: OnPlayerDisconnect
---------------------------------------------------------------------------
function LiquidTD:OnPlayerDisconnect(keys)

end

---------------------------------------------------------------------------
-- Event: OnTeamKillCredit
---------------------------------------------------------------------------
function LiquidTD:OnTeamKillCredit(event)
  local nKillerID = event.killer_userid
  local nTeamID = event.teamnumber
  local nTeamKills = event.herokills
  local KillerName = PlayerResource:GetPlayerName(nKillerID)
end

---------------------------------------------------------------------------
-- Event: OnEntityKilled & RollDrops
---------------------------------------------------------------------------
function LiquidTD:OnEntityKilled(event)
	local killed = EntIndexToHScript(event.entindex_killed)
	if not killed then
		return
	end
	
	OnTowerKilled(killed)
	
	if killed.nodraw_on_death == true then
		killed:AddNoDraw()
	else
		return
	end	
	
	if killed:IsCreature() and not killed.destination_reached then
        RollDrops(killed)
    end
	
  if killed:IsHero() then
    local numAlive = 0
    local lastHero
    -- check to see if we have a winner
    for _,hero in pairs(HeroList:GetAllHeroes()) do
      if hero:IsAlive() then
        numAlive = numAlive + 1
        lastHero = hero
      end
    end

    if numAlive == 1 then
      GameRules:SetGameWinner(lastHero:GetTeam())
    end
  end
end

function RollDrops(unit)
    local DropInfo = GameRules.DropTable[unit:GetUnitName()]
    if DropInfo then
        for item_name,chance in pairs(DropInfo) do
            if RollPercentage(chance) then
                -- Create the item
                local item = CreateItem(item_name, nil, nil)
                local pos = unit:GetAbsOrigin()
                local drop = CreateItemOnPositionSync( pos, item )
                local pos_launch = pos+RandomVector(RandomFloat(150,200))
                item:LaunchLoot(false, 200, 0.75, pos_launch)
            end
        end
    end
end

---------------------------------------------------------------------------
-- Event: OnGameRulesStateChange
---------------------------------------------------------------------------
function LiquidTD:OnGameRulesStateChange()
  local nNewState = GameRules:State_Get()
  if nNewState == DOTA_GAMERULES_STATE_PRE_GAME then
    print( "[PRE_GAME] in Progress" )
  elseif nNewState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
    LiquidTD:OnGameInProgress()
	Convars:SetInt("dota_max_physical_items_purchase_limit", 9999)
    Convars:SetInt("dota_max_physical_items_drop_limit", 9999)
  end
end

function LiquidTD:OnGameInProgress()
  -- Give these players a custom builder model
	Timers:CreateTimer(4, function()
    local maxPlayerID = PlayerResource:GetTeamPlayerCount()
    for playerID=0,(maxPlayerID-1) do
    local sID = PlayerResource:GetSteamAccountID(playerID)
      if sID == 289101818 then 
		local player = PlayerResource:GetPlayer(playerID)
        local hero = player:GetAssignedHero()
        local courier = "models/courier/baby_rosh/babyroshan_ti10.vmdl"
        hero:SetOriginalModel(courier)
        hero:SetModel(courier)
		hero:SetMaterialGroup("5")
      elseif sID == 43305444 then 
        local player = PlayerResource:GetPlayer(playerID)
        local hero = player:GetAssignedHero()
        local courier = "models/courier/baby_rosh/babyroshan_winter18.vmdl"
        hero:SetOriginalModel(courier)
        hero:SetModel(courier)
        hero:SetMaterialGroup("1")
	  elseif sID == 175156710 then 
	    local player = PlayerResource:GetPlayer(playerID)
        local hero = player:GetAssignedHero()
        local courier = "models/courier/baby_rosh/babyroshan.vmdl"
		local particleName = "particles/econ/courier/courier_roshan_ti8/courier_roshan_ti8.vpcf"
        local particle = ParticleManager:CreateParticle( particleName, PATTACH_ABSORIGIN_FOLLOW, hero)
        hero:SetOriginalModel(courier)
        hero:SetModel(courier)
		hero:SetMaterialGroup("5")
		ParticleManager:SetParticleControl(particle, 0, hero:GetOrigin())
        ParticleManager:SetParticleControl(particle, 3, hero:GetOrigin())
      end
    end
    return
  end)

  -- Start incrementing the game timer
  local current_time = 0
  Timers:CreateTimer(1, function() 
    current_time = current_time + 1
    CustomGameEventManager:Send_ServerToAllClients("game_time_changed", {seconds = current_time})
    return 1
  end)

  -- Start spawning creep waves
  StartSpawning() 
end

function LiquidTD:OnExchangeTangoFromGold(msg, event)
    print("Player Has Clicked The Exchange Gold --> for Tango Button !")

    local pID =  event.PlayerID
    print(pID)
    print("Player's Gold : " .. PlayerResource:GetGold(pID))
    print("Player's Tango : " .. self.LiquidTDTangoManager:GetPlayerTango(pID))    
    PlayerResource:SpendGold(pID, _G.TANGO_GOLD_COST, DOTA_ModifyGold_Unspecified )
    self.LiquidTDTangoManager:PlayerAddTango(pID, 1)

    print("Completed ! for player : ".. pID)
    print("Player's Gold : " .. PlayerResource:GetGold(pID))
    print("Player's Tango : " .. self.LiquidTDTangoManager:GetPlayerTango(pID))
    CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(pID), "tangoes_changed", {amount = self.LiquidTDTangoManager:GetPlayerTango(pID)})
    print("Sent to Client!")
end

function LiquidTD:TangoShopButtonPressed(msg, event)
  local playerID = event.PlayerID
  local cost = event.cost
  local purchaseType = event.type
  local amount = event.amount
  local towerType = event.towerType
  local panelID = event.panelID
  print(playerID, cost, purchaseType, amount, towerType, panelID)
  local CurrentTango = self.LiquidTDTangoManager:GetPlayerTango(playerID)
  
  if CurrentTango < cost then
	EmitSoundOnClient("versus_screen.towers_nopass", PlayerResource:GetPlayer(playerID))
  else
	  EmitSoundOnClient("ui.herochallenge_complete", PlayerResource:GetPlayer(playerID))
	  self.LiquidTDTangoManager:PlayerPayTango(playerID, cost)
	  if purchaseType == "damage" then
		if towerType == "classic" and amount == "20" then
			AddNewModifier( self:GetCaster(), self, "modifier_20_attack_damage", {duration = -1})
		end
	  elseif purchaseType == "manacost" then
		-- Give towers mana cost modifier
	  elseif purchaseType == "cooldown" then
		-- Give towers cooldown modifier
	  else
		print("Invalid Purchase Type: " .. purchaseType)
	  end
	  CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "shop_purchase",  
		{
		  latest_amount = self.LiquidTDTangoManager:GetPlayerTango(playerID),
		  panelID = panelID,
		})
	end
end