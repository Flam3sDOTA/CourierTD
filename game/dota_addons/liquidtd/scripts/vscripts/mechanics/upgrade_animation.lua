function UpgradeNormalTower2(keys)
	local tower = keys.caster
	local player = tower:GetOwner()
	local playerID = player:GetPlayerID()
	local team = player:GetTeam()
	local pos = tower:GetAbsOrigin()
	local newName = keys.tower
	
	-- Play Animation
	StartAnimation(tower, {duration=3.8, activity=ACT_DOTA_TELEPORT, rate=1})
	
	-- Add Level Up Particle as Upgrade Effect.
	local particleName = "particles/upgrade/upgrade_tier2.vpcf"
	local particle = ParticleManager:CreateParticle( particleName, PATTACH_ABSORIGIN_FOLLOW, tower)
	ParticleManager:SetParticleControl(particle, 0, tower:GetOrigin())
	ParticleManager:SetParticleControl(particle, 3, tower:GetOrigin())
end

function UpgradeNormalTower3(keys)
	local tower = keys.caster
	local player = tower:GetOwner()
	local playerID = player:GetPlayerID()
	local team = player:GetTeam()
	local pos = tower:GetAbsOrigin()
	local newName = keys.tower
	
	-- Play Animation
	StartAnimation(tower, {duration=4.8, activity=ACT_DOTA_TELEPORT, rate=1})
	
	-- Add Level Up Particle as Upgrade Effect.
	local particleName = "particles/upgrade/upgrade_tier2.vpcf"
	local particle = ParticleManager:CreateParticle( particleName, PATTACH_ABSORIGIN_FOLLOW, tower)
	ParticleManager:SetParticleControl(particle, 0, tower:GetOrigin())
	ParticleManager:SetParticleControl(particle, 3, tower:GetOrigin())
end

function UpgradeUtilityTower2(keys)
	local tower = keys.caster
	local player = tower:GetOwner()
	local playerID = player:GetPlayerID()
	local team = player:GetTeam()
	local pos = tower:GetAbsOrigin()
	local newName = keys.tower
	
	-- Play Animation
	StartAnimation(tower, {duration=5.8, activity=ACT_DOTA_TELEPORT, rate=1})
	
	-- Add Level Up Particle as Upgrade Effect.
	local particleName = "particles/upgrade/upgrade_tier3.vpcf"
	local particle = ParticleManager:CreateParticle( particleName, PATTACH_ABSORIGIN_FOLLOW, tower)
	ParticleManager:SetParticleControl(particle, 0, tower:GetOrigin())
	ParticleManager:SetParticleControl(particle, 3, tower:GetOrigin())
end

function UpgradeUtilityTower3(keys)
	local tower = keys.caster
	local player = tower:GetOwner()
	local playerID = player:GetPlayerID()
	local team = player:GetTeam()
	local pos = tower:GetAbsOrigin()
	local newName = keys.tower
	
	-- Play Animation
	StartAnimation(tower, {duration=6.8, activity=ACT_DOTA_TELEPORT, rate=1})
	
	-- Add Level Up Particle as Upgrade Effect.
	local particleName = "particles/upgrade/upgrade_tier3.vpcf"
	local particle = ParticleManager:CreateParticle( particleName, PATTACH_ABSORIGIN_FOLLOW, tower)
	ParticleManager:SetParticleControl(particle, 0, tower:GetOrigin())
	ParticleManager:SetParticleControl(particle, 3, tower:GetOrigin())
end