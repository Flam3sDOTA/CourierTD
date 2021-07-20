local SERVER_URL = (IsInToolsMode() and "http://localhost:3000") or "http://138.68.85.26";
local SERVER_KEY = "v1";

function SendDataToServer(request_url, data)
  print(request_url)
  local raw_json_text = json.encode(data)
  local req = CreateHTTPRequestScriptVM("POST", request_url)
  req:SetHTTPRequestGetOrPostParameter(
    "server_key",
    GetDedicatedServerKeyV2(SERVER_KEY)
  )
  req:SetHTTPRequestGetOrPostParameter(
    "data",
    raw_json_text
  )
  DeepPrintTable(req)
  req:Send(function(res)
    if not res.StatusCode == 201 then
      print("Failed SendGameStatsToServer error: " .. res.StatusCode)
      return
    end
    local body = json.decode(res.Body)
    print(res.Body)
  end)
end

function GetDataFromServer(request_url, onSuccess, onError)
  local req = CreateHTTPRequestScriptVM("GET", request_url)

  req:Send(function(response)
    if response.StatusCode >= 200 and response.StatusCode < 300 then
      local data = json.decode(response.Body)
      if onSuccess then
        onSuccess(data)
      end
    else
      local err = json.decode(response.Body)

      print("Server request (".. request_url ..") error:")
      DeepPrintTable(err)

      if onError then
        onError(err)
      end
    end
  end)
end

function SaveGamePlayer(player, place)
  local request_url = SERVER_URL .. "/api/games/addGamePlayer"
  local playerID = player:GetPlayerID()

  local data = {
    matchID = GameRules.GameData.matchID,
    steamID = tostring(PlayerResource:GetSteamAccountID(playerID)),
    username = PlayerResource:GetPlayerName(playerID),
    ranked = IsRanked(),
    place = place,
    rounds = CURRENT_WAVE,
    players = GameRules.GameData.playerInfo,
  }

  SendDataToServer(request_url, data)
end

function SaveGameDuration(duration)
  local request_url = SERVER_URL .. "/api/games/addGamePlayer"
  local data = {
    matchID = GameRules.GameData.matchID,
    duration = duration
  }  
  SendDataToServer(request_url, data)
end

function GetPlayerDataFromServer(steamID, onSuccess, onError)
  local request_url = SERVER_URL .. "/api/players/" .. steamID
  GetDataFromServer(request_url, onSuccess, onError)
end

-- Check whether this game is eligbile for mmr
function IsRanked()
  if GameRules:IsCheatMode() then
    return false
  elseif TableCount(GameRules.playerIDs) < 3 then
    return false
  end

  return true
end