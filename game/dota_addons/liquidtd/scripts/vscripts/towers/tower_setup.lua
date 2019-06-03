local tower_data = require("towers/tower_data")

function AddTowerParticle(tower, level, tier)
  -- "particles/arrow/4/star1.vpcf"
  local baseParticle = "particles/arrow/star"
  if tier == 2 then
    baseParticle = "particles/arrow/4/star1.vpcf"
  end

  local particle = ParticleManager:CreateParticle( baseParticle .. "1.vpcf", PATTACH_OVERHEAD_FOLLOW, tower)
  ParticleManager:SetParticleControl(particle, 0, tower:GetOrigin())
  ParticleManager:SetParticleControl(particle, 3, tower:GetOrigin())

  if level >= 2 then
    particle = ParticleManager:CreateParticle( baseParticle .. "3_1.vpcf", PATTACH_OVERHEAD_FOLLOW, tower)
    ParticleManager:SetParticleControl(particle, 0, tower:GetOrigin())
    ParticleManager:SetParticleControl(particle, 3, tower:GetOrigin())
  end

  if level >= 3 then
    particle = ParticleManager:CreateParticle( baseParticle .. "3_2.vpcf", PATTACH_OVERHEAD_FOLLOW, tower)
    ParticleManager:SetParticleControl(particle, 0, tower:GetOrigin())
    ParticleManager:SetParticleControl(particle, 3, tower:GetOrigin())
  end
end

function OnTowerSpawned(tower)
  local towerName = tower:GetUnitName()
  local towerInfo = tower_data[towerName]
  -- If it's not in the tower_data
  if not towerInfo then return end


  if towerInfo.start_animation then towerInfo.start_animation() end
  if towerInfo.material_group then tower:SetMaterialGroup(towerInfo.material_group) end
  if towerInfo.spawn_sound then tower:EmitSound(towerInfo.spawn_sound) end
  if towerInfo.is_farm then
    StartAnimation(tower, {duration=-1, activity=ACT_DOTA_CONSTANT_LAYER, rate=0.8, translate="level" .. towerInfo.level})
  end
  if not towerInfo.is_farm then AddTowerParticle(tower, towerInfo.level, towerInfo.tier) end

  if towerInfo.abilities then
    for abilityName, abilityLevel in pairs(towerInfo.abilities) do
      local ability = tower:FindAbilityByName(abilityName)
      if ability then
		Timers:CreateTimer(0.1, function() 
			ability:SetLevel(abilityLevel)
		end)
      else
        print(towerName .. " doesn't have " .. abilityName .. " to level.")
      end
    end
  end
end

function OnTowerKilled(tower)
  local towerInfo = tower_data[tower:GetUnitName()]
  -- If it's not in the tower_data
  if not towerInfo then return end

  if towerInfo.death_model then tower:SetOriginalModel(towerInfo.death_model) end
  if towerInfo.destruction_particle then 
    local destruction_particle = ParticleManager:CreateParticle(towerInfo.destruction_particle, PATTACH_ABSORIGIN, tower) 
    ParticleManager:ReleaseParticleIndex(destruction_particle)
  end

  if tower:GetUnitName() == "tower_poison" then
    StartAnimation(tower, {duration=1, activity=ACT_DOTA_DIE, rate=1})
  end
end