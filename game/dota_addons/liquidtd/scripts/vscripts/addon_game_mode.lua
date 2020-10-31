if LiquidTD == nil then
	_G.LiquidTD = class({})
end

require("libraries/timers")
require("libraries/notifications")
require("libraries/buildinghelper")
require("libraries/projectiles")
require("libraries/keyvalues")
require("libraries/animations")
require("libraries/utility_functions")
require("towers/tower_setup")
require("waves/wave_controller")
require("events")
require("precache")

function Precache( context )
	for _,Model in pairs( g_ModelPrecache ) do
		PrecacheResource( "model", Model, context )
	end

	for _,Particle in pairs( g_ParticlePrecache ) do
		PrecacheResource( "particle", Particle, context )
	end

	for _,ParticleFolder in pairs( g_ParticleFolderPrecache ) do
		PrecacheResource( "particle_folder", Particle, context )
	end

	for _,Sound in pairs( g_SoundPrecache ) do
		PrecacheResource( "soundfile", Sound, context )
	end
end

function Activate()
	GameRules.LiquidTD = LiquidTD()
	GameRules.LiquidTD:InitGameMode()
end

function LiquidTD:InitGameMode()
	print( "Courier TD is loaded." )

	-- Handle Team Colors
	self.m_TeamColors = {}
	self.m_TeamColors[DOTA_TEAM_GOODGUYS] = { 0, 100, 0 }		--		Green
	self.m_TeamColors[DOTA_TEAM_BADGUYS]  = { 178, 34, 34 }		--		Red
	self.m_TeamColors[DOTA_TEAM_CUSTOM_1] = { 255, 99, 71 }		--      Orange
	self.m_TeamColors[DOTA_TEAM_CUSTOM_2] = { 218, 112, 214 }	--		Purple
	self.m_TeamColors[DOTA_TEAM_CUSTOM_3] = { 30, 144, 225 }	--		Blue
	self.m_TeamColors[DOTA_TEAM_CUSTOM_4] = { 212, 212, 37 }	--		Yellow
	self.m_TeamColors[DOTA_TEAM_CUSTOM_5] = { 129, 83, 54 }		--
	self.m_TeamColors[DOTA_TEAM_CUSTOM_6] = { 27, 192, 216 }	--
	self.m_TeamColors[DOTA_TEAM_CUSTOM_7] = { 199, 228, 13 }	--
	self.m_TeamColors[DOTA_TEAM_CUSTOM_8] = { 140, 42, 244 }	--
	
	-- Handle Player Colors
	PLAYER_COLORS = {}
    PLAYER_COLORS[0] = "#3dd296;"
    PLAYER_COLORS[1] = "#f3c909;"
    PLAYER_COLORS[2] = "#c54da8;"
    PLAYER_COLORS[3] = "#FF6C00;"
    PLAYER_COLORS[4] = "#3455FF;"
    PLAYER_COLORS[5] = "#65d413;"
    PLAYER_COLORS[6] = "#815336;"
    PLAYER_COLORS[7] = "#1bc0d8;"
    PLAYER_COLORS[8] = "#c7e40d;"
    PLAYER_COLORS[9] = "#8c2af4;"

	for team = 0, (DOTA_TEAM_COUNT-1) do
		color = self.m_TeamColors[ team ]
		if color then
			SetTeamCustomHealthbarColor( team, color[1], color[2], color[3] )
		end
	end
	
	self.m_VictoryMessages = {}
	self.m_VictoryMessages[DOTA_TEAM_GOODGUYS] = "#VictoryMessage_GoodGuys"
	self.m_VictoryMessages[DOTA_TEAM_BADGUYS]  = "#VictoryMessage_BadGuys"
	self.m_VictoryMessages[DOTA_TEAM_CUSTOM_1] = "#VictoryMessage_Custom1"
	self.m_VictoryMessages[DOTA_TEAM_CUSTOM_2] = "#VictoryMessage_Custom2"
	self.m_VictoryMessages[DOTA_TEAM_CUSTOM_3] = "#VictoryMessage_Custom3"
	self.m_VictoryMessages[DOTA_TEAM_CUSTOM_4] = "#VictoryMessage_Custom4"
	self.m_VictoryMessages[DOTA_TEAM_CUSTOM_5] = "#VictoryMessage_Custom5"
	self.m_VictoryMessages[DOTA_TEAM_CUSTOM_6] = "#VictoryMessage_Custom6"
	self.m_VictoryMessages[DOTA_TEAM_CUSTOM_7] = "#VictoryMessage_Custom7"
	self.m_VictoryMessages[DOTA_TEAM_CUSTOM_8] = "#VictoryMessage_Custom8"
	
	-- Game Rules
	GameRules:SetCustomGameAllowMusicAtGameStart(false)
	GameRules:SetCustomGameAllowBattleMusic(false)
	GameRules:SetCustomGameAllowHeroPickMusic(false)
	GameRules:EnableCustomGameSetupAutoLaunch(true)
	GameRules:SetSameHeroSelectionEnabled(true)
	GameRules:SetHideKillMessageHeaders(true)
	GameRules:SetUseUniversalShopMode(true)
	GameRules:SetHeroRespawnEnabled(false)
	GameRules:SetSafeToLeave(true)
	GameRules:SetCustomGameSetupAutoLaunchDelay(15)
	GameRules:SetCustomGameEndDelay(0)
	GameRules:SetHeroSelectionTime(0)
	GameRules:SetPreGameTime(0)
	GameRules:SetStrategyTime(0)
	GameRules:SetShowcaseTime(0)
	GameRules:SetGoldTickTime(0)
	GameRules:SetStartingGold(160) -- default 195
	GameRules:SetGoldPerTick(0)
	
	-- Gamemode Rules
	local GameMode = GameRules:GetGameModeEntity()
	GameMode:SetUseCustomHeroLevels(false)
	GameMode:SetCustomXPRequiredToReachNextLevel(XP_PER_LEVEL_TABLE)
	GameMode:DisableHudFlip(true)
	GameMode:SetBuybackEnabled(false)
	GameMode:SetFogOfWarDisabled(true)
	GameMode:SetUnseenFogOfWarEnabled(false)
	GameMode:SetLoseGoldOnDeath(false)
	GameMode:SetAnnouncerDisabled(true)
	GameMode:SetDeathOverlayDisabled(true)
	GameMode:SetDaynightCycleDisabled(true)
	GameMode:SetWeatherEffectsDisabled(true)
	GameMode:SetRemoveIllusionsOnDeath(true)
	GameMode:SetStashPurchasingDisabled(false)
	GameMode:SetTopBarTeamValuesVisible(false)
	GameMode:SetTopBarTeamValuesOverride(true)
	GameMode:SetRecommendedItemsDisabled(true)
	GameMode:SetSelectionGoldPenaltyEnabled(false)
	GameMode:SetKillingSpreeAnnouncerDisabled(true)
	GameMode:SetCustomGameForceHero("npc_dota_hero_ursa")
	--GameMode:SetTPScrollSlotItemOverride("item_blink")
	
	XP_PER_LEVEL_TABLE = {
		99999, -- 1
		99999, -- 2
		99999, -- 3
		99999, -- 4
		99999, -- 5
		99999, -- 6
		99999, -- 7
		99999, -- 8
		99999, -- 9
		99999, -- 10
		99999, -- 11
		99999,  -- 12
		99999,  -- 13
		99999,  -- 14
		99999,  -- 15
		99999,  -- 16
		99999,  -- 17
		99999,  -- 18
		99999,  -- 19
		99999,  -- 20
		99999,  -- 21
		99999,  -- 22
		99999,  -- 23
		99999,  -- 24
		99999,  -- 25
	}

	-- Events
	ListenToGameEvent("npc_spawned", Dynamic_Wrap(LiquidTD, "OnNPCSpawned"), self)
	ListenToGameEvent("player_connect_full", Dynamic_Wrap(LiquidTD, "OnConnectFull"), self)
	ListenToGameEvent("player_reconnected", Dynamic_Wrap(LiquidTD, "OnPlayerReconnect"), self)
	ListenToGameEvent("player_disconnect", Dynamic_Wrap(LiquidTD, "OnPlayerDisconnect"), self)
	ListenToGameEvent('dota_team_kill_credit', Dynamic_Wrap(LiquidTD, "OnTeamKillCredit" ), self )
	ListenToGameEvent('entity_killed', Dynamic_Wrap(LiquidTD, 'OnEntityKilled'), self)
	ListenToGameEvent('entity_hurt', Dynamic_Wrap(LiquidTD, 'OnEntityHurt'), self)
	ListenToGameEvent('game_rules_state_change', Dynamic_Wrap( LiquidTD, 'OnGameRulesStateChange' ), self )
	
	MAX_NUMBER_OF_TEAMS = 6   
	CUSTOM_TEAM_PLAYER_COUNT = {}        
	CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_GOODGUYS] = 1
	CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_BADGUYS]  = 1
	CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_1] = 1
	CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_2] = 1
	CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_3] = 1
	CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_4] = 1
	local count = 0
	for team,number in pairs(CUSTOM_TEAM_PLAYER_COUNT) do
		if count >= MAX_NUMBER_OF_TEAMS then
			GameRules:SetCustomGameTeamMaxPlayers(team, 0)
		else
			GameRules:SetCustomGameTeamMaxPlayers(team, number)
		end
		count = count + 1
	end

	LimitPathingSearchDepth(0.5)

	-- Set up global values
	GameRules.teamToMap = {
		[DOTA_TEAM_GOODGUYS] = "map1",
		[DOTA_TEAM_BADGUYS]  = "map2",
		[DOTA_TEAM_CUSTOM_1] = "map3",
		[DOTA_TEAM_CUSTOM_2] = "map4",
		[DOTA_TEAM_CUSTOM_3] = "map5",
		[DOTA_TEAM_CUSTOM_4] = "map6",
	}
	
	if IsInToolsMode() then
		 GameRules:SetStartingGold(99999)
	end
end