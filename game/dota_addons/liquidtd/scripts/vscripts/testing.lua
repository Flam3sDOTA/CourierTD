function LiquidTD:OnScriptReload()
  print("Script Reload")

  local player = PlayerResource:GetPlayer(0)
  local steamID = PlayerResource:GetSteamAccountID(0)

  -- GetPlayerDataFromServer(
  --     steamID,
  --     function(data)
  --       print("data", data)
  --     end,
  --     function(err)
  --       print("Error looking up player data, using default mmr/rank")
  --       print("err", err)
  --     end
  --   )

  CustomGameEventManager:Send_ServerToPlayer(
        player,
        "player_eliminated",
        {
          mmr_change = 50,
        }
      )
end