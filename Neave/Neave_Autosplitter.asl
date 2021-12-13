state("Neave-Win64-Shipping"){
    int   cube               : 0x347C218, 0x170, 0x170;
    int   resets               : 0x345B5D8, 0xBB8;
    float igt                    : 0x3391B08, 0x28, 0x228, 0x10, 0x360;
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

    if (old.resets < current.resets && settings["startonanewgame"]){
		vars.timerModel.Start();
	}

	if (old.resets < current.resets){
		if (current.cube == 0 && settings.ResetEnabled){
			vars.timerModel.Reset();
        }
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
