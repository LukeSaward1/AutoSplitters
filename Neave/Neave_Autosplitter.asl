state("Neave-Win64-Shipping"){
    int   cube               : 0x347C218, 0x170, 0x170;
    float igt                    : 0x347C218, 0x170, 0x38, 0x0, 0x30, 0x258, 0x740, 0x360;
    string64 levelName             : 0x347C218, 0x410, 0x0;
}

startup {
    settings.Add("startsettings", true, "Start");
        settings.Add("startonigtstart", true, "Start on IGT start", "startsettings");
        settings.Add("startonanewgame", false, "Start on new game", "startsettings");

    settings.Add("splitsettings", true, "Split");
        settings.Add("cubesplits", true, "Split when touching a cube", "splitsettings");

    settings.Add("resetsettings", true, "Reset");
        settings.Add("resetonnewgame", true, "Reset on new game", "resetsettings");
        settings.Add("resetonmainmenu", false, "Reset on main menu", "resetsettings");
    
    vars.timerModel = new TimerModel { CurrentState = timer };
}

update{
    if(current.levelName != old.levelName && current.levelName == "/Game/Maps/StartMenu" && settings["resetonmainmenu"]){
        vars.timerModel.Reset();
    }

	if (current.levelName != old.levelName){
		if (current.cube == 0 && settings.ResetEnabled && settings["resetonnewgame"]){
			vars.timerModel.Reset();
        }
	}

    if (current.levelName != old.levelName && current.levelName == "/Game/Maps/TheWorldReborn" && settings["startonanewgame"]){
		vars.timerModel.Start();
	}
}

start{
    return old.igt == 0 && current.igt > 0 && settings["startonigtstart"];
}

split{
    return current.cube > old.cube && settings["cubesplits"];
}

reset{
    return false;
}

exit{
    vars.timerModel.Reset();
}

gameTime{
    return TimeSpan.FromSeconds(current.igt);
}

isLoading{
    return true;
}
