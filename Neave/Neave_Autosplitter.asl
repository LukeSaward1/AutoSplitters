state("Neave-Win64-Shipping"){
    int   cube               : 0x3478A28, 0x8, 0xD0;
    int   resets               : 0x345B5D8, 0xBB8;
    float igt                    : 0x34B8280, 0xD0, 0x3A8, 0xC0, 0x30, 0x30, 0x398, 0x360;
    string64 levelname             : 0x347C218, 0x410, 0x0;
}

startup {
    settings.Add("startsettings", true, "Start");
        settings.Add("startonigtstart", true, "Start on IGT start", "startsettings");
        settings.Add("startonanewgame", true, "Start on new game", "startsettings");

    settings.Add("splitsettings", true, "Split");
        settings.Add("cubesplits", true, "Split when touching a cube", "splitsettings");

    settings.Add("resetsettings", true, "Reset");
        settings.Add("resetonnewgame", true, "Reset on new game", "resetsettings");
    
    vars.timerModel = new TimerModel { CurrentState = timer };
}

start{
    if (old.resets < current.resets && settings["startonanewgame"])
	{
		vars.cube = current.cube;
		return true;
	}
    return old.igt == 0 && current.igt > 0 && settings["startonigtstart"];
}

split{
    return current.cube > old.cube && settings["cubesplits"];
}

reset{
    return current.resets > old.resets && current.cube == 0 && settings["resetonnewgame"];
}

gameTime{
    return TimeSpan.FromSeconds(current.igt);
}