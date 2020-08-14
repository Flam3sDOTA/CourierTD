local wave_table = require("waves/wave_tables")

local CURRENT_WAVE = 0
local TIME_BETWEEN_ROUNDS = 20
local TIME_BEFORE_FIRST_ROUND = 60
local NUM_ROUNDS = TableCount(wave_table)

function StartSpawning()
  local timeToNextRound = TIME_BEFORE_FIRST_ROUND
  Timers:CreateTimer(function()
    CustomGameEventManager:Send_ServerToAllClients("next_round_time_changed", {seconds = timeToNextRound})
    timeToNextRound = timeToNextRound - 1
	if timeToNextRound == 29 then
		EmitGlobalSound("announcer_dlc_fallout4_announcer_misterhandy_countdown_seconds30_01")
	elseif timeToNextRound == 9 then
		EmitGlobalSound("announcer_dlc_fallout4_announcer_misterhandy_countdown_seconds10_02")
	elseif timeToNextRound == 4 then
		EmitGlobalSound("Tutorial.TaskProgress")
	elseif timeToNextRound == 3 then
		EmitGlobalSound("Tutorial.TaskProgress")
	elseif timeToNextRound == 2 then
		EmitGlobalSound("Tutorial.TaskProgress")
	elseif timeToNextRound == 1 then
		EmitGlobalSound("Tutorial.TaskProgress")
	elseif timeToNextRound == 0 then
		EmitGlobalSound("Tutorial.TaskProgress")
	end
    if timeToNextRound <= 0 then
	  EmitGlobalSound("ui.npe_objective_complete")
      print("Starting Waves")
      SpawnNextWave()
      return
    end
    return 1
  end)
end

function SpawnNextWave()
  CURRENT_WAVE = CURRENT_WAVE + 1

  local waveData = wave_table["wave" .. CURRENT_WAVE]
  if not waveData then
    -- start over from the start
    local waveNumber = CURRENT_WAVE % NUM_ROUNDS
    if waveNumber == 0 then
      waveNumber = 50
    end
    waveData = wave_table["wave" .. waveNumber]
  end

  local ascension = math.floor((CURRENT_WAVE - 1) / NUM_ROUNDS)

  CustomGameEventManager:Send_ServerToAllClients("round_started", 
    {
      round_type = waveData.round_type,
      round_number = CURRENT_WAVE,
      unit_count = waveData.wave_count,
    }
  )
  
  local waveDuration = waveData.wave_count * waveData.spawn_interval
  local timeToNextRound = waveDuration + TIME_BETWEEN_ROUNDS

  Timers:CreateTimer(function()
    timeToNextRound = timeToNextRound - 1
    CustomGameEventManager:Send_ServerToAllClients("next_round_time_changed", {seconds = timeToNextRound})
	if timeToNextRound == 5 then
		EmitGlobalSound("Tutorial.TaskProgress")
	elseif timeToNextRound == 4 then
		EmitGlobalSound("Tutorial.TaskProgress")
	elseif timeToNextRound == 3 then
		EmitGlobalSound("Tutorial.TaskProgress")
	elseif timeToNextRound == 2 then
		EmitGlobalSound("Tutorial.TaskProgress")
	elseif timeToNextRound == 1 then
		EmitGlobalSound("Tutorial.TaskProgress")
	end
    if timeToNextRound <= 0 then
      print("Wave " .. CURRENT_WAVE .. " ended")
	  EmitGlobalSound("ui.npe_objective_complete")
      SpawnNextWave()
      return
    end
    return 1
  end)
  
  -- Get the team for each hero (assume there is one hero per player)
  for _,hero in pairs(HeroList:GetAllHeroes()) do
    if hero:IsAlive() then
      SpawnWave(hero, waveData, ascension)
    end
  end
end

function SpawnWave(hero, waveData, ascension)
  local team = hero:GetTeam()
  local map = GameRules.teamToMap[team]

  local spawnPoint = Entities:FindByName(nil, map .. "_spawn"):GetAbsOrigin()

  local creepName = waveData.unit_name
  local numToSpawn = waveData.wave_count
  local spawnInterval = waveData.spawn_interval
  local round_type = waveData.round_type

  local spawned = 0
  Timers:CreateTimer(function()
    if spawned >= numToSpawn then return end

    local creep = CreateUnitByName(creepName, spawnPoint, true, nil, nil, DOTA_TEAM_NEUTRALS)
    creep:RemoveGesture(ACT_DOTA_SPAWN)
    creep:AddNewModifier(nil, nil, "modifier_phased", {})
    creep:CreatureLevelUp(ascension)
    creep.map = map
    creep.heroToDamage = hero

    if round_type == "Boss" then
		creep.leakDamage = 5
	elseif round_type == "Normal" then
		creep.leakDamage = 1
	elseif round_type == "Bonus" then
		creep.leakDamage = 0
	end
	
    spawned = spawned + 1
	
    return spawnInterval
  end)
end