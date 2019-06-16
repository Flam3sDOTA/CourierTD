"use strict"
var playerID = Players.GetLocalPlayer();
var Tangoes = 0;

function UpdateGold() {
	var gold = Players.GetGold(playerID);
	$('#GoldText').text = gold;
	$.Schedule(0.1, UpdateGold);
}

function UpdateTangoesOnClient(msg){
	$('#LumberText').text = msg.amount;
	Tangoes = msg.amount;
}

function OnExchangeButtonPressed() {
	var gold = Players.GetGold(playerID);
	if (gold < 5000){
		Game.EmitSound("versus_screen.towers_nopass");
	}
	else {
		GameEvents.SendCustomGameEventToServer("exchange_tango_from_gold", {});
		Game.EmitSound("ui_select_blue");
	}
}

function OnShopPurchase(data)
{
	var latest_amount = data.latest_amount;
	var id = data.panelID;
	$('#LumberText').text = latest_amount;
	var shopbutton = $("#" + id);
	shopbutton.SetHasClass("DemoButtonActivated", true)
}

function TangoShopButtonPressed(id, cost, type, amount, towerType) {
	GameEvents.SendCustomGameEventToServer("TangoShopButtonPressed",
	{
		"cost" : cost,
		"type" : type,
		"amount" : amount,
		"towerType" : towerType,
		"panelID" : id
	});
}


(function () {
  GameEvents.Subscribe("tangoes_changed", UpdateTangoesOnClient);	
  GameEvents.Subscribe("shop_purchase", OnShopPurchase);
  UpdateGold();
})();