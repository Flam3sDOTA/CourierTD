function Spawn(keys)
  -- Wait one frame to do logic on a spawned unit
  Timers:CreateTimer(.1, function()
	thisEntity.nodraw_on_death = true
	destination_reached = false
    local map = thisEntity.map
    local waypoints = {}
	local particleName = "particles/creep_effects/spawn_effect.vpcf"
    local particle = ParticleManager:CreateParticle( particleName, PATTACH_ABSORIGIN_FOLLOW, thisEntity)
	ParticleManager:SetParticleControl(particle, 0, thisEntity:GetOrigin())
    ParticleManager:SetParticleControl(particle, 3, thisEntity:GetOrigin())
	
    for i=1,7 do
      local waypointName = map .. "_goal" .. i
      local waypoint = Entities:FindByName(nil, waypointName)
	  table.insert(waypoints, waypoint)
      ExecuteOrderFromTable({
        UnitIndex = thisEntity:entindex(),
        OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
        TargetIndex = 0, --Optional.  Only used when targeting units
        AbilityIndex = 0, --Optional.  Only used when casting abilities
        Position = waypoint:GetAbsOrigin(), --Optional.  Only used when targeting the ground
        Queue = true
      })
    end

    thisEntity.waypoints = waypoints
    thisEntity.goal = waypoints[1]:GetAbsOrigin()
	
	Shukuchi = thisEntity:FindAbilityByName("weaver_shukuchi")

    Timers:CreateTimer(function() return thisEntity:AIThink() end)
  end)
end


function thisEntity:AIThink()
  if self:IsNull() then return end
  if not self:IsAlive() then return end

  if not self.goal then
    return
  end
  
  if Shukuchi ~= nil and Shukuchi:IsFullyCastable() and self:GetHealthPercent() <= 80 then
	CastShukuchi()
  elseif Shukuchi ~= nil and Shukuchi:IsFullyCastable() and self:GetHealthPercent() <= 30 then
    CastShukuchi()
  end

  if self:ArrivedAtGoal() then
    self:UpdateGoal()
  end
  return .1
end

function thisEntity:ArrivedAtGoal()
  local distanceToGoal = GridNav:FindPathLength(self:GetAbsOrigin(), self.goal)
  if distanceToGoal < 50 then
    return true
  else
    return false
  end
end

function thisEntity:UpdateGoal()
  local nextGoal = table.remove(self.waypoints, 1)
  if nextGoal then
    self.goal = nextGoal:GetAbsOrigin()
  else
    self.goal = nil
  end
end

function CastShukuchi()
		ExecuteOrderFromTable({
			UnitIndex = thisEntity:entindex(),
			OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
			AbilityIndex = Shukuchi:entindex()
		})
end