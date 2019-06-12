"use strict"

var TangoAmount = 0;

function UpdateGold() {
	var playerID = Players.GetLocalPlayer();
	var gold = Players.GetGold(playerID);
	$('#GoldText').text = gold;
	$.Schedule(0.1, UpdateGold);
}

function OnExchangeButtonPressed() {
	var playerID = Players.GetLocalPlayer();
	var gold = Players.GetGold(playerID);
	if(gold < 500){
        Game.EmitSound("versus_screen.towers_nopass");
    }
    else{
        Game.EmitSound("ui_select_blue");
		TangoAmount = TangoAmount+1;
		$('#LumberText').text = TangoAmount;
    }
}

(function () {
  UpdateGold();
})();