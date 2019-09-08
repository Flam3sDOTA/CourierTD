var rootPanel = $("#Avatars");

for (var i = 0; i < DOTALimits_t.DOTA_MAX_TEAM_PLAYERS; i++){
  if (Game.GetPlayerInfo(i)) {
    var steam_id = Game.GetPlayerInfo(i).player_steamid;
    var team = Players.GetTeam(i);
	var hero = Players.GetPlayerSelectedHero(i);

    createPlayerPanel(i, steam_id);
	// createPlayerPanel(i, steam_id);
	// createPlayerPanel(i, steam_id);
	// createPlayerPanel(i, steam_id);
	// createPlayerPanel(i, steam_id);
	// createPlayerPanel(i, steam_id);
	
    $("#player_avatar_" + i).steamid = steam_id;
  }
}

updateHealthBars();

function createPlayerPanel(id, steam_id){
  $.Msg("Creating Panel " + id);
  var playerPanel = $.CreatePanel("Panel", rootPanel, "player_panel_" + id);
  playerPanel.AddClass("PlayerPanel");

  playerPanel.BCreateChildren(
    '<DOTAAvatarImage hittest="false" id="player_avatar_' + id + '" class="UserAvatar"/>',
    false,
    false
  );

  var usernamePanel = $.CreatePanel("DOTAUserName", playerPanel, "username_player_" + id);
  usernamePanel.AddClass("Username");
  usernamePanel.steamid = steam_id;

  // var heronamepanel = $.CreatePanel("Label", playerPanel, "");
  // heronamepanel.AddClass("HeroName");
  // heronamepanel.text = $.Localize("Rank");
  
  var HeroHealthPanel = $.CreatePanel("ProgressBar", playerPanel, "health_bar_" + id);
  HeroHealthPanel.AddClass("PlayerHealth");
  HeroHealthPanel.min = 0;
  HeroHealthPanel.max = 100;
  HeroHealthPanel.value = 100;
  
  var HealthPercentage = $.CreatePanel("Label", playerPanel, "health_percentage_" + id);
  HealthPercentage.AddClass("HealthPercentage");
}

function updateHealthBars() {
  for (var i = 0; i < DOTALimits_t.DOTA_MAX_TEAM_PLAYERS; i++){
    if (Game.GetPlayerInfo(i)) {
      updateHealthBar(i);
    }
  }
  $.Schedule(1.0/30.0, updateHealthBars);
}

function updateHealthBar(id) {
  var hero = Players.GetPlayerHeroEntityIndex(id);

  var healthBar = $("#health_bar_" + id);
  healthBar.value = Entities.GetHealthPercent(hero);
  var HealthPercentages = $("#health_percentage_" + id);
  HealthPercentages.text = Entities.GetHealthPercent(hero) + "%";
  
  var playerPanels = $("#player_panel_" + id);
 
  
  if (Entities.GetHealthPercent(hero) == 0 ) {
      HealthPercentages.text = "FAILED";
	  playerPanels.RemoveClass("PlayerPanel");
	  playerPanels.AddClass("GrayOut");
    }
}