return {
  -- The Key (template_tower) or whatever is the name of the unit
  -- template_tower = {
  --   level = 1,
  --   price = 100,
  --   tier = 1,

  -- Spawn Values
  --   spawn_sound = "windrunner_wind_spawn_01",
  --   material_group = nil,
  -- Key: AbilityName Value: AbilityLevel
  --   abilities = {
  --     farm_tower_gold = 2
  --   }

  -- Death Values
  --   death_model = nil,
  --   destruction_particle = nil,

  --   is_farm = false,
  -- },

  ----------------------------------------------------------
  -- Farm Towers 
  ----------------------------------------------------------
  tower_farm_1 = {
    is_farm = true,
    level = 1,
    tier = 1,
    death_model = "models/props_structures/tower_upgrade/tower_upgrade_dest.vmdl",
    destruction_particle = "particles/world_tower/tower_upgrade/ti7_radiant_tower_lvl1_dest.vpcf",
    material_group = "radiant_level1",
  },
  
  tower_farm_2 = {
    is_farm = true,
    level = 2,
    tier = 1,
    death_model = "models/props_structures/tower_upgrade/tower_upgrade_dest.vmdl",
    destruction_particle = "particles/world_tower/tower_upgrade/ti7_radiant_tower_lvl3_dest.vpcf",
    material_group = "radiant_level2",
    spawn_sound = "frostivus_ui_select",
    abilities = {
      farm_tower_gold = 2
    },
  },
  
  tower_farm_3 = {
    is_farm = true,
    level = 3,
    tier = 1,
    death_model = "models/props_structures/tower_upgrade/tower_upgrade_dest.vmdl",
    destruction_particle = "particles/world_tower/tower_upgrade/ti7_radiant_tower_lvl5_dest.vpcf",
    material_group = "radiant_level3",
    spawn_sound = "frostivus_ui_select",
    abilities = {
      farm_tower_gold = 3
    },
  },
  
  tower_farm_4 = {
    is_farm = true,
    level = 4,
    tier = 1,
    death_model = "models/props_structures/tower_upgrade/tower_upgrade_dest.vmdl",
    destruction_particle = "particles/world_tower/tower_upgrade/ti7_radiant_tower_lvl7_dest.vpcf",
    material_group = "radiant_level4",
    spawn_sound = "frostivus_ui_select",
    abilities = {
      farm_tower_gold = 4
    },
  },
  
  tower_farm_5 = {
    is_farm = true,
    level = 5,
    tier = 1,
    death_model = "models/props_structures/tower_upgrade/tower_upgrade_dest.vmdl",
    destruction_particle = "particles/world_tower/tower_upgrade/ti7_radiant_tower_lvl9_dest.vpcf",
    material_group = "radiant_level5",
    spawn_sound = "frostivus_ui_select",
    abilities = {
      farm_tower_gold = 5
    },
  },
  
  tower_farm_6 = {
    is_farm = true,
    level = 6,
    tier = 1,
    death_model = "models/props_structures/tower_upgrade/tower_upgrade_dest.vmdl",
    destruction_particle = "particles/world_tower/tower_upgrade/ti7_radiant_tower_lvl11_dest.vpcf",
    material_group = "radiant_level6",
    spawn_sound = "frostivus_ui_select",
    abilities = {
      farm_tower_gold = 6
    },
  },

  ----------------------------------------------------------
  -- Regular Towers
  ----------------------------------------------------------

  tower_windranger_1 = {
    level = 1,
    tier = 1,
    spawn_sound = "frostivus_ui_select",  
  },
  
  tower_windranger_2 = {
    level = 2,
    tier = 1,
    spawn_sound = "frostivus_ui_select",  
  },
  
  tower_windranger_3 = {
    level = 3,
    tier = 1,
    spawn_sound = "frostivus_ui_select",  
  },
  
  tower_luna_1 = {
    level = 1,
    tier = 1,
    spawn_sound = "frostivus_ui_select",
	abilities = {
      luna_moon_glaive = 1
    },
  },
  
  tower_luna_2 = {
    level = 2,
    tier = 1,
    spawn_sound = "frostivus_ui_select",
	abilities = {
      luna_moon_glaive = 2
    },
  },
  
  tower_luna_3 = {
    level = 3,
    tier = 1,
    spawn_sound = "frostivus_ui_select", 
	abilities = {
      luna_moon_glaive = 3
    },
  },
  
  tower_mirana_1 = {
    level = 1,
    tier = 1,
    spawn_sound = "frostivus_ui_select",  
  },
  
  tower_mirana_2 = {
    level = 2,
    tier = 1,
    spawn_sound = "frostivus_ui_select",  
  },
  
  tower_mirana_3 = {
    level = 3,
    tier = 1,
    spawn_sound = "frostivus_ui_select",  
  },
  
  tower_furion_1 = {
    level = 1,
    tier = 1,
    spawn_sound = "frostivus_ui_select",
  },
  
  tower_furion_2 = {
    level = 2,
    tier = 1,
    spawn_sound = "frostivus_ui_select",
  },
  
  tower_furion_3 = {
    level = 3,
    tier = 1,
    spawn_sound = "frostivus_ui_select",
  },
  
  tower_venomancer_1 = {
    level = 1,
    tier = 1,
    spawn_sound = "frostivus_ui_select",
  },
  
  tower_venomancer_2 = {
    level = 2,
    tier = 1,
    spawn_sound = "frostivus_ui_select",
  },
  
  tower_venomancer_3 = {
    level = 3,
    tier = 1,
    spawn_sound = "frostivus_ui_select",
  },
  
  tower_enchantress_1 = {
    level = 1,
    tier = 1,
    spawn_sound = "frostivus_ui_select",
  },
  
  tower_enchantress_2 = {
    level = 2,
    tier = 1,
    spawn_sound = "frostivus_ui_select",
  },
  
  tower_enchantress_3 = {
    level = 3,
    tier = 1,
    spawn_sound = "frostivus_ui_select",
  },
  
  tower_cm_1 = {
    level = 1,
    tier = 1,
    spawn_sound = "frostivus_ui_select",  
  },

  tower_cm_2 = {
    level = 2,
    tier = 1,
    spawn_sound = "frostivus_ui_select",  
  },

  tower_cm_3 = {
    level = 3,
    tier = 1,
    spawn_sound = "frostivus_ui_select",  
  },
  
  tower_morphling_1 = {
    level = 1,
    tier = 1,
    spawn_sound = "frostivus_ui_select",  
  },
  
  tower_morphling_2 = {
    level = 2,
    tier = 1,
    spawn_sound = "frostivus_ui_select",  
  },
  
  tower_morphling_3 = {
    level = 3,
    tier = 1,
    spawn_sound = "frostivus_ui_select",  
  },

  tower_venge_1 = {
    level = 1,
    tier = 1,
    spawn_sound = "frostivus_ui_select",  
  },
  
  tower_venge_2 = {
    level = 2,
    tier = 1,
    spawn_sound = "frostivus_ui_select",  
  },
  
  tower_venge_3 = {
    level = 3,
    tier = 1,
    spawn_sound = "frostivus_ui_select",
  },
  
  tower_drow_1 = {
    level = 1,
    tier = 1,
    spawn_sound = "frostivus_ui_select",  
  },

  tower_drow_2 = {
    level = 2,
    tier = 1,
    spawn_sound = "frostivus_ui_select",  
  },

  tower_drow_3 = {
    level = 3,
    tier = 1,
    spawn_sound = "frostivus_ui_select",  
  },

  tower_medusa_1 = {
    level = 1,
    tier = 1,
    spawn_sound = "frostivus_ui_select",  
  },

  tower_medusa_2 = {
    level = 2,
    tier = 1,
    spawn_sound = "frostivus_ui_select",  
  },

  tower_medusa_3 = {
    level = 3,
    tier = 1,
    spawn_sound = "frostivus_ui_select",  
  },

  tower_sniper_1 = {
    level = 1,
    tier = 1,
    spawn_sound = "frostivus_ui_select",  
  },

  tower_sniper_2 = {
    level = 2,
    tier = 1,
    spawn_sound = "frostivus_ui_select",  
  },

  tower_sniper_3 = {
    level = 3,
    tier = 1,
    spawn_sound = "frostivus_ui_select",  
  },

  tower_troll_1 = {
    level = 1,
    tier = 1,
    spawn_sound = "frostivus_ui_select",
  },

  tower_troll_2 = {
    level = 2,
    tier = 1,
    spawn_sound = "frostivus_ui_select",
  },

  tower_troll_3 = {
    level = 3,
    tier = 1,
    spawn_sound = "frostivus_ui_select",
  },

  tower_viper_1 = {
    level = 1,
    tier = 1,
    spawn_sound = "frostivus_ui_select",
  },

  tower_viper_2 = {
    level = 2,
    tier = 1,
    spawn_sound = "frostivus_ui_select",
  },

  tower_viper_3 = {
    level = 3,
    tier = 1,
    spawn_sound = "frostivus_ui_select",
  },

  tower_ld_1 = {
    level = 1,
    tier = 1,
    spawn_sound = "frostivus_ui_select",
  },

  tower_ld_2 = {
    level = 2,
    tier = 1,
    spawn_sound = "frostivus_ui_select",
  },

  tower_ld_3 = {
    level = 3,
    tier = 1,
    spawn_sound = "frostivus_ui_select",
  },

  tower_lich_1 = {
    level = 1,
    tier = 1,
    spawn_sound = "frostivus_ui_select",  
  },
  
  tower_lich_2 = {
    level = 2,
    tier = 1,
    spawn_sound = "frostivus_ui_select",  
  },
  
  tower_lich_3 = {
    level = 3,
    tier = 1,
    spawn_sound = "frostivus_ui_select",  
  },
  
  tower_zeus_1 = {
    level = 1,
    tier = 1,
    spawn_sound = "frostivus_ui_select",  
  },
  
  tower_zeus_2 = {
    level = 2,
    tier = 1,
    spawn_sound = "frostivus_ui_select",  
  },
  
  tower_zeus_3 = {
    level = 3,
    tier = 1,
    spawn_sound = "frostivus_ui_select",  
  },
  
  tower_sky_1 = {
    level = 1,
    tier = 1,
    spawn_sound = "frostivus_ui_select",  
  },
  
  tower_sky_2 = {
    level = 2,
    tier = 1,
    spawn_sound = "frostivus_ui_select",  
  },
  
  tower_sky_3 = {
    level = 3,
    tier = 1,
    spawn_sound = "frostivus_ui_select",  
  },
  
  tower_arrow = {
    is_farm = true,
    level = 1,
    tier = 1,
    death_model = "models/props_structures/dire_tower002_destruction.vmdl",
    destruction_particle = "particles/dire_fx/dire_tower002_destruction.vpcf",
  },
  
  tower_poison = {
    is_farm = true,
    level = 1,
    tier = 1,
    destruction_particle = "particles/units/heroes/hero_undying/undying_tower_destruction.vpcf",
    abilities = {
      tower_poison_poison = 1
    },
  },
  
  tower_ice = {
    is_farm = true,
    level = 1,
    tier = 1,
    death_model = "models/props_structures/dire_tower002_destruction.vmdl",
    destruction_particle = "particles/radiant_fx/radiant_tower002_destruction.vpcf",
	abilities = {
      tower_ice_slow = 1
    },
  },
}