local cosmetics_data = require("cosmetics/cosmetics_data")

function AssignCosmetics(sID, hero)
  local PlayerInfo = cosmetics_data[sID]
  
  if not PlayerInfo then return end

  if PlayerInfo then
    if PlayerInfo.model then
      hero:SetModel(PlayerInfo.model)
      hero:SetOriginalModel(PlayerInfo.model)
      print( "[Cosmetics] Model Set" )
    end

    if PlayerInfo.particle then 
      local particle = ParticleManager:CreateParticle( PlayerInfo.particle, PATTACH_ABSORIGIN_FOLLOW, hero) 
      print( "[Cosmetics] Partical Set" )
    end

    if PlayerInfo.material_group then
      hero:SetMaterialGroup(PlayerInfo.material_group)
      print( "[Cosmetics] Material Group Set" )
    end
  end
end