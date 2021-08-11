"use strict";

const SERVER_URL = "http://138.68.85.26";

GameUI.SetCameraDistance( 1520 );

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
	const panel = $("#LeaderboardsRoot");
	panel.visible = !panel.visible;
	Game.EmitSound("ui_chat_slide_out");
}

function OnLeaderboardCloseButtonPressed() {
	const panel = $("#LeaderboardsRoot");
	panel.visible = !panel.visible;
	Game.EmitSound("ui.profile_close");
}

function getLeaderboard() {
	$.AsyncWebRequest(
		`${SERVER_URL}/api/leaderboard`,
		{
			type: 'GET',
			success: function(data) {
				createLeaderboardPanels(data);
			},
			timeout: 5000,
		})
}

function getLocalPlayer() {
	const steamid = Game.GetPlayerInfo(Players.GetLocalPlayer()).player_steamid;
	$.AsyncWebRequest(
		`${SERVER_URL}/api/players/${steamid}`,
		{
			type: 'GET',
			success: function(data) {
				loadPlayerStats(data);
			},
			error: function(err) {
				showDefaultPlayerStats(err);
			},
			timeout: 5000,
		})
}

function loadPlayerStats(data) {
	$("#MMRLocal").text = data.mmr;
}

function showDefaultPlayerStats(err) {
	$.Msg(err);
	// Player was not found
}

function createLeaderboardPanels(data) {
	const rootPanel = $("#LeaderboardsRankingContainer");

	rootPanel.RemoveAndDeleteChildren();

	for(let i=0; i<10; i++) {
		const leaderboardPlayer = data[i];
		if (leaderboardPlayer) {
			const steamID = leaderboardPlayer.steam_id;
			const mmr = leaderboardPlayer.mmr;
			const username = leaderboardPlayer.username;
			const index = i+1;
			const styleIndex = index > 3 ? "" : index;
			rootPanel.BCreateChildren(`
				<Panel hittest="false" id="Player${index}Panel" class="Row">
				<Panel hittest="false" class="NumberContainer${styleIndex}">
					<Label class="NumberContainerLabel" text="${index}"/>
				</Panel>
				<Panel hittest="false" class="SteamAvatarContainer${styleIndex}">
					<DOTAAvatarImage id="Avatar${index}" class="AvatarImage" steamid="local"/>
				</Panel>
				<Panel hittest="false" class="SteamUserNameContainer">
					<Label text="${username}" id="SteamName${index}" class="UserNameLabelSteam"/>
				</Panel>
				<Panel hittest="false" class="MMRContainer">
					<Label text="${mmr}" id="MMR${index}" class="MMRLabel"/>
				</Panel>
			</Panel>
			`);
		}
	}

	const localPlayerName = Players.GetPlayerName(Players.GetLocalPlayer());

	rootPanel.BCreateChildren(`
		<Panel hittest="false" class="LocalPlayerDivider" />
			<Panel hittest="false" id="PlayerLocalPanel" class="Row">
				<Panel hittest="false" class="NumberContainerLocal">
					<Label class="NumberContainerLabelLocal" text="???"/>
				</Panel>
				<Panel hittest="false" class="SteamAvatarContainerLocal">
					<DOTAAvatarImage id="Avatar" steamid="local"/>
				</Panel>
				<Panel hittest="false" class="SteamUserNameContainer">
					<Label text="${localPlayerName}" id="LocalPlayer" class="UserNameLabelSteam"/>
				</Panel>
				<Panel hittest="false" class="MMRContainer">
					<Label text="1000" id="MMRLocal" class="MMRLabel"/>
				</Panel>
			</Panel>
	`);
}

function OnShopButtonPressed()
{
  Game.EmitSound("ui_chat_slide_out")
  $.GetContextPanel().ToggleClass('Minimized')
}

function OnPatreonCloseButtonPressed() {
	let panel = $("#PatreonPopup");
	panel.visible = !panel.visible;
	Game.EmitSound("ui_chat_slide_out")
}

function OnPlayerEliminated(data) {
	const mmrChange = data.mmr_change;
	const sign = mmrChange >= 0 ? "+" : "-";
	const mmrClass = mmrChange >= 0 ? "MMRChangePositive" : "MMRChangeNegative";

	let panel = $("#PlayerDeathInformationPanel");
	let mmrPanel = $("#PlayerDeathInformationPanelMMRChange");
	mmrPanel.AddClass(mmrClass);

	mmrPanel.text = `${sign}${mmrChange}`;
	panel.visible = true;
}

function WatchButtonClicked()
{
	let panel = $("#PlayerDeathInformationPanel");
	panel.visible = !panel.visible;
	Game.EmitSound("ui_chat_slide_out")
}

function RankedSeason0PopupWindowButtonClicked()
{
	let panel = $("#RankedSeason0PopupWindow");
	panel.visible = !panel.visible;
	Game.EmitSound("ui.profile_close")
}

function SchedulePopupClose()
{
	let panel = $("#RankedSeason0PopupWindow");
	$.Schedule(10, function () {
		panel.visible = false;
	});
}

function SecondsToClock(seconds) {
  const sec_num = parseInt(seconds, 10);
  const hours   = Math.floor(sec_num / 3600);
  const minutes = Math.floor((sec_num - (hours * 3600)) / 60);
  const seconds = sec_num - (hours * 3600) - (minutes * 60);

  if (hours   < 10) {hours   = "0"+hours;}
  if (minutes < 10) {minutes = "0"+minutes;}
  if (seconds < 10) {seconds = "0"+seconds;}

  return hours+':'+minutes+':'+seconds;
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
	GameEvents.Subscribe("player_eliminated", OnPlayerEliminated);
	$.GetContextPanel().ToggleClass("Minimized");

	getLeaderboard();
	getLocalPlayer();
	SchedulePopupClose();
})();