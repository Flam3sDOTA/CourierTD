"use strict";

var Root = $.GetContextPanel();

var currentlearn=1;
var maxpages=12;

function prev() {
	Game.EmitSound("General.ButtonClickRelease")
	$("#Image"+currentlearn).style.width = "0%";
if(currentlearn==1)
{
	currentlearn=maxpages
}
else
{
	currentlearn--;
}

	$("#Image"+currentlearn).style.width = "100%";
	$("#pageCountLabel").text = currentlearn+"/"+maxpages

}

function next() {
	Game.EmitSound("General.ButtonClickRelease")
	$("#Image"+currentlearn).style.width = "0%";
	if(currentlearn==maxpages)
	{
		currentlearn=1
	}
	else
	{
		currentlearn++;
	}

	$("#Image"+currentlearn).style.width = "100%";
	$("#pageCountLabel").text = currentlearn+"/"+maxpages
}