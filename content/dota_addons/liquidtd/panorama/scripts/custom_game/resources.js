"use strict"
var playerID = Players.GetLocalPlayer();

function UpdateGold() {
	var gold = Players.GetGold(playerID);
	$('#GoldText').text = gold;
	$.Schedule(0.1, UpdateGold);
}

function UpdateTangoesOnClient(msg){
	$('#LumberText').text = msg.amount;
}

function OnExchangeButtonPressed() {
	var gold = Players.GetGold(playerID);
	if(gold < 500){
        Game.EmitSound("versus_screen.towers_nopass");
    }
    else{
		GameEvents.SendCustomGameEventToServer( "exchange_tango_from_gold", 
				{ "playerID" : playerID });
        Game.EmitSound("ui_select_blue");
    }
}

function DamagePressed20Classic() {
    GameEvents.SendCustomGameEventToServer( "DamagePressed20Classic", 
                { "playerID" : playerID ,
        "cost" : 1});
}

function Damage20ClassicPaymentDone(msg)
{
	var IsSuccess = msg.result 
    if(IsSuccess){
		Game.EmitSound("ui_select_blue");
		$('#LumberText').text = msg.latest_amount ;
	}
	else{
		Game.EmitSound("versus_screen.towers_nopass");
	}
}



function DamagePressed50Classic() {
	if(Tango < 250){
        Game.EmitSound("versus_screen.towers_nopass");
    }
    else{
	Game.EmitSound("ui_select_blue");
	}
}


function DamagePressed100Classic() {
	if(Tango < 750){
        Game.EmitSound("versus_screen.towers_nopass");
    }
    else{
	Game.EmitSound("ui_select_blue");
	}
}

function ManaCost20Classic() {
	if(Tango < 50){
        Game.EmitSound("versus_screen.towers_nopass");
    }
    else{
	Game.EmitSound("ui_select_blue");
	}
}

function ManaCost30Classic() {
	if(Tango < 250){
        Game.EmitSound("versus_screen.towers_nopass");
    }
    else{
	Game.EmitSound("ui_select_blue");
	}
}

function ManaCost50Classic() {
	if(Tango < 750){
        Game.EmitSound("versus_screen.towers_nopass");
    }
    else{
	Game.EmitSound("ui_select_blue");
	}
}

function CD1Classic() {
	if(Tango < 50){
        Game.EmitSound("versus_screen.towers_nopass");
    }
    else{
	Game.EmitSound("ui_select_blue");
	}
}

function CD2Classic() {
	if(Tango < 250){
        Game.EmitSound("versus_screen.towers_nopass");
    }
    else{
	Game.EmitSound("ui_select_blue");
	}
}

function CD3Classic() {
	if(Tango < 750){
        Game.EmitSound("versus_screen.towers_nopass");
    }
    else{
	Game.EmitSound("ui_select_blue");
	}
}

function DamagePressed20Utility() {
	if(Tango < 50){
        Game.EmitSound("versus_screen.towers_nopass");
    }
    else{
	Game.EmitSound("ui_select_blue");
	}
}


function DamagePressed50Utility() {
	if(Tango < 250){
        Game.EmitSound("versus_screen.towers_nopass");
    }
    else{
	Game.EmitSound("ui_select_blue");
	}
}


function DamagePressed100Utility() {
	if(Tango < 750){
        Game.EmitSound("versus_screen.towers_nopass");
    }
    else{
	Game.EmitSound("ui_select_blue");
	}
}

function ManaCost20Utility() {
	if(Tango < 50){
        Game.EmitSound("versus_screen.towers_nopass");
    }
    else{
	Game.EmitSound("ui_select_blue");
	}
}

function ManaCost30Utility() {
	if(Tango < 250){
        Game.EmitSound("versus_screen.towers_nopass");
    }
    else{
	Game.EmitSound("ui_select_blue");
	}
}

function ManaCost50Utility() {
	if(Tango < 750){
        Game.EmitSound("versus_screen.towers_nopass");
    }
    else{
	Game.EmitSound("ui_select_blue");
	}
}

function CD1Utility() {
	if(Tango < 50){
        Game.EmitSound("versus_screen.towers_nopass");
    }
    else{
	Game.EmitSound("ui_select_blue");
	}
}

function CD2Utility() {
	if(Tango < 250){
        Game.EmitSound("versus_screen.towers_nopass");
    }
    else{
	Game.EmitSound("ui_select_blue");
	}
}

function CD3Utility() {
	if(Tango < 750){
        Game.EmitSound("versus_screen.towers_nopass");
    }
    else{
	Game.EmitSound("ui_select_blue");
	}
}


(function () {
  GameEvents.Subscribe( "tangoes_changed", UpdateTangoesOnClient);	
  GameEvents.Subscribe( "Damage20Classic_payment_processed", Damage20ClassicPaymentDone);
  UpdateGold();
})();