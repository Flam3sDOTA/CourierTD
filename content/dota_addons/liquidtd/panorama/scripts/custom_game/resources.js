function UpdateGold() {
  var playerID = Players.GetLocalPlayer();
  var gold = Players.GetGold(playerID);
  $('#GoldText').text = gold;
  $.Schedule(0.1, UpdateGold);
}

(function () {
  UpdateGold();
})();