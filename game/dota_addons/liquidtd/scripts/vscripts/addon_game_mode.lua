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


function Precache( context )
-- Sound Files
	PrecacheResource( "soundfile", "soundevents/game_sounds.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_main.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_greevils.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_items.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/soundevents_conquest.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/soundevents_dota_ui.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_ui_imported.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/music/game_sounds_music_tutorial.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_announcer.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_lycan.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_drowranger.vsndevts", context)
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_troll_warlord.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_furion.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_luna.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_lina.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_keeper_of_the_light.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_ancient_apparition.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_jakiro.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_mirana.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_venomancer.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_enchantress.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_crystalmaiden.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_skywrath_mage.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_zuus.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_warlock.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_lone_druid.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_viper.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_sniper.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_medusa.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_windrunner.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_wisp.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_vengefulspirit.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_morphling.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_lion.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_shadowshaman.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_meepo.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_gyrocopter.vsndevts", context)
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_sven.vsndevts", context)
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_abyssal_underlord.vsndevts", context)
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_faceless_void.vsndevts", context)
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_enigma.vsndevts", context)
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_medusa.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_sniper.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_viper.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_lone_druid.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_warlock.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_zuus.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_skywrath_mage.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_crystalmaiden.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_enchantress.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_venomancer.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_jakiro.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_ancient_apparition.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_keeper_of_the_light.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_lina.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_troll_warlord.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_drowranger.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_furion.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_mirana.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_luna.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_windrunner.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_wisp.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_announcer_dlc_bastion.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_announcer_dlc_darkest_dungeon.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_announcer_dlc_workshop_pirate.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_announcer_dlc_fallout4.vsndevts", context )
	
-- Particles
	PrecacheResource( "particle_folder", "particles/buildinghelper", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_drow/drow_base_attack.vpcf", context )
	PrecacheResource( "particle", "particles/econ/items/alchemist/alchemist_midas_knuckles/alch_knuckles_lasthit_coins.vpcf", context )
	PrecacheResource( "particle", "particles/econ/items/ogre_magi/ogre_ti8_immortal_weapon/ogre_ti8_immortal_bloodlust_buff.vpcf", context )
	PrecacheResource( "particle", "particles/base_attacks/ranged_siege_good.vpcf", context )
	PrecacheResource( "particle", "particles/base_attacks/ranged_siege_good_explosion.vpcf", context )
	PrecacheResource( "particle", "particles/econ/world/towers/rock_golem/radiant_rock_golem_attack.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_undying/undying_tower_destruction.vpcf", context )
	PrecacheResource( "particle", "particles/radiant_fx/radiant_tower002_destruction.vpcf", context )
	PrecacheResource( "particle", "particles/dire_fx/dire_tower002_destruction.vpcf", context )
	PrecacheResource( "particle", "particles/world_tower/tower_upgrade/ti7_radiant_tower_lvl1_dest.vpcf", context )
	PrecacheResource( "particle", "particles/world_tower/tower_upgrade/ti7_radiant_tower_lvl3_dest.vpcf", context )
	PrecacheResource( "particle", "particles/world_tower/tower_upgrade/ti7_radiant_tower_lvl5_dest.vpcf", context )
	PrecacheResource( "particle", "particles/world_tower/tower_upgrade/ti7_radiant_tower_lvl7_dest.vpcf", context )
	PrecacheResource( "particle", "particles/world_tower/tower_upgrade/ti7_radiant_tower_lvl9_dest.vpcf", context )
	PrecacheResource( "particle", "particles/world_tower/tower_upgrade/ti7_radiant_tower_lvl11_dest.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_sandking/sandking_caustic_finale_explode.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_monkey_king/monkey_king_jump_armor_debuff_model.vpcf", context )
	PrecacheResource( "particle", "particles/econ/items/viper/viper_ti7_immortal/viper_poison_debuff_ti7.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_winter_wyvern/wyvern_arctic_burn_slow.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_lina/lina_base_attack.vpcf", context )
	PrecacheResource( "particle", "particles/creep_effects/spawn_effect.vpcf", context )
	PrecacheResource( "particle", "particles/creep_effects/leak_effect.vpcf", context )
	PrecacheResource( "particle", "particles/econ/events/ti8/hero_levelup_ti8.vpcf", contetxt )
	-- Tower Stars
	PrecacheResource( "particle", "particles/arrow/star1.vpcf", context )
	PrecacheResource( "particle", "particles/arrow/star2_1.vpcf", context )
	PrecacheResource( "particle", "particles/arrow/star3_1.vpcf", context )
	PrecacheResource( "particle", "particles/arrow/star3_2.vpcf", context )
	PrecacheResource( "particle", "particles/arrow/4/star1.vpcf", context )
	PrecacheResource( "particle", "particles/arrow/4/star2_1.vpcf", context )
	PrecacheResource( "particle", "particles/arrow/4/star3_1.vpcf", context )
	PrecacheResource( "particle", "particles/arrow/4/star3_2.vpcf", context )
	PrecacheResource( "particle", "particles/arrow/5/star1.vpcf", context )
	PrecacheResource( "particle", "particles/arrow/5/star2_1.vpcf", context )
	PrecacheResource( "particle", "particles/arrow/5/star3_1.vpcf", context )
	PrecacheResource( "particle", "particles/arrow/5/star3_2.vpcf", context )
	-- Tower Base Attacks
	PrecacheResource( "particle", "particles/tower_effects/arrow_tower_base_attack.vpcf", context )
	PrecacheResource( "particle", "particles/tower_effects/tower_windranger_1_base_attack.vpcf", context )
	PrecacheResource( "particle", "particles/tower_effects/tower_windranger_2_base_attack.vpcf", context )
	PrecacheResource( "particle", "particles/tower_effects/tower_windranger_3_base_attack.vpcf", context )
	PrecacheResource( "particle", "particles/tower_effects/tower_mirana_1_base_attack.vpcf", context )
	PrecacheResource( "particle", "particles/tower_effects/tower_mirana_2_base_attack.vpcf", context )
	PrecacheResource( "particle", "particles/tower_effects/tower_mirana_3_base_attack.vpcf", context )
	PrecacheResource( "particle", "particles/tower_effects/tower_luna_1_base_attack.vpcf", context )
	PrecacheResource( "particle", "particles/tower_effects/tower_luna_2_base_attack.vpcf", context )
	PrecacheResource( "particle", "particles/tower_effects/tower_luna_3_base_attack.vpcf", context )
	-- Courier Particles
	PrecacheResource( "particle", "particles/courier_effects/trail_baby_roshan_platinum.vpcf", context )
	PrecacheResource( "particle", "particles/econ/courier/courier_roshan_ti8/courier_roshan_ti8.vpcf", context )
	
	
-- Models
	-- Tower Pedestals
	PrecacheResource( "model", "models/items/pedestals/pedestal_2/pedestal_2.vmdl", context )
	PrecacheResource( "model", "models/heroes/pedestal/pedestal_1_small.vmdl", context )
	PrecacheResource( "model", "models/heroes/pedestal/mesh/effigy_pedestal_fm16.vmdl", context )
	PrecacheResource( "model", "models/heroes/pedestal/pedestal_effigy_jade.vmdl", context )
	PrecacheResource( "model", "models/heroes/pedestal/mesh/effigy_pedestal_fm16_dire_wood.vmdl", context )
	PrecacheResource( "model", "models/heroes/pedestal/mesh/effigy_pedestal_ti6_dire_model.vmdl", context )
	PrecacheResource( "model", "models/heroes/pedestal/mesh/effigy_pedestal_wm16.vmdl", context )
	PrecacheResource( "model", "models/heroes/pedestal/effigy_pedestal_frost_radiant.vmdl", context )
	PrecacheResource( "model", "models/heroes/shadow_fiend/pedestal_sf.vmdl", context )
	PrecacheResource( "model", "models/heroes/crystal_maiden/pedestal_cm_arcana.vmdl", context )
	PrecacheResource( "model", "models/props_structures/tower_upgrade/tower_upgrade_base.vmdl", context )
	-- Towers
	PrecacheResource( "model", "models/props_structures/rock_golem/tower_radiant_rock_golem.vmdl", context )
	PrecacheResource( "model", "models/heroes/drow/drow_base.vmdl", context )
	PrecacheResource( "model", "models/heroes/furion/furion.vmdl", context )
	PrecacheResource( "model", "models/heroes/luna/luna.vmdl", context )
	PrecacheResource( "model", "models/heroes/lina/lina.vmdl", context )
	PrecacheResource( "model", "models/heroes/keeper_of_the_light/keeper_of_the_light.vmdl", context )
	PrecacheResource( "model", "models/heroes/mirana/mirana.vmdl", context )
	PrecacheResource( "model", "models/heroes/venomancer/venomancer.vmdl", context )
	PrecacheResource( "model", "models/heroes/enchantress/enchantress.vmdl", context )
	PrecacheResource( "model", "models/heroes/crystal_maiden/crystal_maiden.vmdl", context )
	PrecacheResource( "model", "models/heroes/skywrath_mage/skywrath_mage.vmdl", context )
	PrecacheResource( "model", "models/heroes/zeus/zeus.vmdl", context )
	PrecacheResource( "model", "models/heroes/warlock/warlock.vmdl", context )
	PrecacheResource( "model", "models/heroes/lone_druid/lone_druid.vmdl", context )
	PrecacheResource( "model", "models/heroes/viper/viper.vmdl", context )
	PrecacheResource( "model", "models/heroes/troll_warlord/troll_warlord.vmdl", context )
	PrecacheResource( "model", "models/heroes/sniper/sniper.vmdl", context )
	PrecacheResource( "model", "models/heroes/medusa/medusa.vmdl", context )
	PrecacheResource( "model", "models/heroes/windrunner/windrunner.vmdl", context )
	-- Couriers
		-- Rare
	PrecacheResource( "model", "models/items/courier/basim/basim.vmdl", context )
	PrecacheResource( "model", "models/items/courier/blue_lightning_horse/blue_lightning_horse.vmdl", context )
	PrecacheResource( "model", "models/items/courier/boooofus_courier/boooofus_courier.vmdl", context )
	PrecacheResource( "model", "models/items/courier/duskie/duskie.vmdl", context )
	PrecacheResource( "model", "models/items/courier/jumo/jumo.vmdl", context )
	PrecacheResource( "model", "models/items/courier/beaverknight_s1/beaverknight_s1.vmdl", context )
	PrecacheResource( "model", "models/items/courier/beaverknight_s2/beaverknight_s2.vmdl", context )
	PrecacheResource( "model", "models/items/courier/butch_pudge_dog/butch_pudge_dog.vmdl", context )
	PrecacheResource( "model", "models/courier/seekling/seekling.vmdl,", context )
	PrecacheResource( "model", "models/courier/doom_demihero_courier/doom_demihero_courier.vmdl", context )
	PrecacheResource( "model", "models/courier/huntling/huntling.vmdl", context )
	PrecacheResource( "model", "models/items/courier/krobeling/krobeling.vmdl", context )
	PrecacheResource( "model", "models/courier/venoling/venoling.vmdl", context )
	PrecacheResource( "model", "models/items/courier/devourling/devourling.vmdl", context )
	PrecacheResource( "model", "models/courier/baby_winter_wyvern/baby_winter_wyvern.vmdl", context )
		-- Mythical
	PrecacheResource( "model", "models/courier/donkey_crummy_wizard_2014/donkey_crummy_wizard_2014.vmdll", context )
	PrecacheResource( "model", "models/courier/donkey_unicorn/donkey_unicorn.vmdl", context )
	PrecacheResource( "model", "models/courier/donkey_ti7/donkey_ti7.vmdl", context )
	PrecacheResource( "model", "models/courier/greevil/gold_greevil.vmdl", context )
	PrecacheResource( "model", "models/courier/trapjaw/trapjaw.vmdl", context )
	PrecacheResource( "model", "models/items/courier/carty/carty.vmdl", context )
	PrecacheResource( "model", "models/items/courier/faceless_rex/faceless_rex.vmdl", context )
	PrecacheResource( "model", "models/courier/drodo/drodo.vmdl", context )
	PrecacheResource( "model", "models/courier/otter_dragon/otter_dragon.vmdl", context )
	PrecacheResource( "model", "models/items/courier/mole_messenger/mole_messenger_lvl7.vmdl", context )
		-- Legendary
	PrecacheResource( "model", "models/courier/baby_rosh/babyroshan.vmdl", context )
	PrecacheResource( "model", "models/courier/baby_rosh/babyroshan_elemental.vmdl", context )
	PrecacheResource( "model", "models/courier/baby_rosh/babyroshan_alt.vmdl", context )
	PrecacheResource( "model", "models/courier/baby_rosh/babyroshan_ti9.vmdl", context )
	PrecacheResource( "model", "models/courier/baby_rosh/babyroshan_winter18.vmdl", context )
	
		-- Developer
	PrecacheResource( "model", "models/items/courier/shagbark/shagbark.vmdl", context )
end

function Activate()
	GameRules.LiquidTD = LiquidTD()
	GameRules.LiquidTD:InitGameMode()
end

function LiquidTD:InitGameMode()
	print( "Duel TD is loaded." )

	-- Handle Team Colors
	self.m_TeamColors = {}
	self.m_TeamColors[DOTA_TEAM_GOODGUYS] = { 61, 210, 150 }	--		Teal
	self.m_TeamColors[DOTA_TEAM_BADGUYS]  = { 243, 201, 9 }		--		Yellow
	self.m_TeamColors[DOTA_TEAM_CUSTOM_1] = { 197, 77, 168 }	--      Pink
	self.m_TeamColors[DOTA_TEAM_CUSTOM_2] = { 255, 108, 0 }		--		Orange
	self.m_TeamColors[DOTA_TEAM_CUSTOM_3] = { 52, 85, 255 }		--		Blue
	self.m_TeamColors[DOTA_TEAM_CUSTOM_4] = { 101, 212, 19 }	--		Green
	self.m_TeamColors[DOTA_TEAM_CUSTOM_5] = { 129, 83, 54 }		--		Brown
	self.m_TeamColors[DOTA_TEAM_CUSTOM_6] = { 27, 192, 216 }	--		Cyan
	self.m_TeamColors[DOTA_TEAM_CUSTOM_7] = { 199, 228, 13 }	--		Olive
	self.m_TeamColors[DOTA_TEAM_CUSTOM_8] = { 140, 42, 244 }	--		Purple
	
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
	GameRules:SetUseUniversalShopMode(false)
	GameRules:SetHeroRespawnEnabled(false)
	GameRules:SetSafeToLeave(true)
	GameRules:SetCustomGameSetupAutoLaunchDelay(5)
	GameRules:SetCustomGameEndDelay(0)
	GameRules:SetHeroSelectionTime(0)
	GameRules:SetPreGameTime(0)
	GameRules:SetStrategyTime(0)
	GameRules:SetShowcaseTime(0)
	GameRules:SetGoldTickTime(0)
	GameRules:SetStartingGold(195) -- default 185
	GameRules:SetGoldPerTick(0)
	
	-- Gamemode Rules
	local GameMode = GameRules:GetGameModeEntity()
	GameMode:SetUseCustomHeroLevels(false)
	GameMode:SetCustomXPRequiredToReachNextLevel(XP_PER_LEVEL_TABLE)
	GameMode:DisableHudFlip(true)
	GameMode:SetBuybackEnabled(false)
	GameMode:SetFogOfWarDisabled(true)
	GameMode:SetLoseGoldOnDeath(false)
	GameMode:SetAnnouncerDisabled(true)
	GameMode:SetDeathOverlayDisabled(true)
	GameMode:SetDaynightCycleDisabled(true)
	GameMode:SetWeatherEffectsDisabled(true)
	GameMode:SetUnseenFogOfWarEnabled(false)
	GameMode:SetRemoveIllusionsOnDeath(true)
	GameMode:SetStashPurchasingDisabled(true)
	GameMode:SetTopBarTeamValuesVisible(false)
	GameMode:SetTopBarTeamValuesOverride(true)
	GameMode:SetRecommendedItemsDisabled(true)
	GameMode:SetSelectionGoldPenaltyEnabled(false)
	GameMode:SetKillingSpreeAnnouncerDisabled(true)
	GameMode:SetCustomGameForceHero("npc_dota_hero_ursa")
	
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
	
	CustomGameEventManager:RegisterListener( "DamagePressed20Classic", function(...) return self:DamagePressed20Classic( ... ) end)
	CustomGameEventManager:RegisterListener( "exchange_tango_from_gold", function(...) return self:OnExchangeTangoFromGold( ... ) end)
	
	
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

	-- Setting up tango profile of all 6 players ( all zero at start )
	self.playersTangoes = {}
	for i=0, 6-1 do
		self.playersTangoes[i] = 0
	end
	self.LiquidTDTangoManager = TangoManager()

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