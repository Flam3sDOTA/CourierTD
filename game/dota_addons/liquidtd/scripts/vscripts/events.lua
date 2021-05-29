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
    "hero_nohealthbar",
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
      local manaGained = damage * 0.02
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
	Timers:CreateTimer(5, function()
    local maxPlayerID = PlayerResource:GetNumConnectedHumanPlayers()
    for playerID=0,(maxPlayerID) do
	  local sID = PlayerResource:GetSteamAccountID(playerID)
      if sID then 
		    local player = PlayerResource:GetPlayer(playerID)
        local hero = player:GetAssignedHero()
        AssignCosmetics(sID, hero)
        print( "[Cosmetics] AssignCosmetics" )
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