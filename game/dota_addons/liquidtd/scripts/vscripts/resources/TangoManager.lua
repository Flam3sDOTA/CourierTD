if TangoManager == nil then
	TangoManager = class({})
end

_G.TANGO_GOLD_COST = 500
_G.GOLD_TANGO_COST = 1 -- Not as important but can be useful if you have non mutual exchange rate

function TangoManager:GetPlayerTango(iPlayerID)
	return GameRules.LiquidTD.playersTangoes[iPlayerID]
end

function TangoManager:SetPlayerTango(iPlayerID, iTangoAmount)
	GameRules.LiquidTD.playersTangoes[iPlayerID] = iTangoAmount
end


--Returns new balance amount of tango after deduction.
--No Payment is made if player has insufficient
function TangoManager:PlayerPayTango(iPlayerID, iTangoAmount)
	-- if not enough tango on the player. Nothing is paid. 
	if GameRules.LiquidTD.playersTangoes[iPlayerID] < iTangoAmount then
		return 
	end
	GameRules.LiquidTD.playersTangoes[iPlayerID] = GameRules.LiquidTD.playersTangoes[iPlayerID] - iTangoAmount 		
	return GameRules.LiquidTD.playersTangoes[iPlayerID] 
end


-- Returns new balance after adding.
function TangoManager:PlayerAddTango(iPlayerID, iTangoAmount)
	GameRules.LiquidTD.playersTangoes[iPlayerID] = GameRules.LiquidTD.playersTangoes[iPlayerID] + iTangoAmount 
	return GameRules.LiquidTD.playersTangoes[iPlayerID] 
end