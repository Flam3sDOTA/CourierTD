"use strict";

GameUI.SetCameraDistance( 1800 );
Game.AddCommand( "ToggleStatistics", ToggleStatistics, "", 0);
var StatisticsOn = false;

/* ERROR FRAME */
function ErrorMessage(data) {
	$.GetContextPanel().SetHasClass("error_appeared", true);
	$.Msg(data.error);
	$("#ErrorMessage").text = $.Localize(data.error);

	$.Schedule(1, ClearErrorMessage);
}

function ClearErrorMessage() {
	$.GetContextPanel().SetHasClass("error_appeared", false);
	$("#ErrorMessage").text = "";
}

/* LEADERBOARD */
function OnLeaderboardOpenButtonPressed() {
	/*var panel = $("#LeaderboardsRoot");
	panel.visible = !panel.visible;
	StatisticsOn = true;
	Game.EmitSound("ui_chat_slide_out")*/
}

function OnLeaderboardCloseButtonPressed() {
	/*var panel = $("#LeaderboardsRoot");
	panel.visible = !panel.visible;
	StatisticsOn = false;
	Game.EmitSound("ui.profile_close")*/
}

function SecondsToClock(seconds) {
  var sec_num = parseInt(seconds, 10);
  var hours   = Math.floor(sec_num / 3600);
  var minutes = Math.floor((sec_num - (hours * 3600)) / 60);
  var seconds = sec_num - (hours * 3600) - (minutes * 60);

  if (hours   < 10) {hours   = "0"+hours;}
  if (minutes < 10) {minutes = "0"+minutes;}
  if (seconds < 10) {seconds = "0"+seconds;}

  return hours+':'+minutes+':'+seconds;
}	

function ToggleStatistics() {
    if(StatisticsOn){
        OnLeaderboardCloseButtonPressed()
    }
    else{
        OnLeaderboardOpenButtonPressed()
    }
}

function UpdateGameTime(data) {
  $("#Timer").text = SecondsToClock(data.seconds);
}

function UpdateNextRoundTime(data) {
  $("#NextRoundLabel").text = SecondsToClock(data.seconds);
}

function OnRoundStart(data){
  $("#RoundNameLabel").text = data.round_type;
  $("#RoundNumberLabel").text = data.round_number;
  $("#UnitCountLabel").text = data.unit_count;
}

(function () {
	GameEvents.Subscribe("game_time_changed", UpdateGameTime);
    GameEvents.Subscribe("next_round_time_changed", UpdateNextRoundTime);
	GameEvents.Subscribe("error", ErrorMessage);
	GameEvents.Subscribe("round_started", OnRoundStart);
	$.GetContextPanel().ToggleClass("Minimized");
})();