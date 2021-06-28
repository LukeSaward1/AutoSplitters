state("Ursa-Win64-Shipping"){
    float igt                    : 0x3F79D48, 0x10, 0x240, 0x2B0, 0xD0, 0x0, 0xA0, 0x3A4;
    int beacons                      : 0x3EC7678, 0x2D8, 0x2B0, 0x390, 0x220, 0xB0, 0x80, 0x1B8;
}

startup {
    settings.Add("splitsettings", true, "Split");
        settings.Add("beaconsplits", true, "Split when activating a beacon", "splitsettings");

    settings.Add("resetsettings", true, "Reset");
        settings.Add("resetonnewgame", true, "Reset on new game", "resetsettings");
    
    vars.timerModel = new TimerModel { CurrentState = timer };
}

start{
    return old.igt == 0 && current.igt > 0;
}

split{
    return current.beacons > old.beacons && settings["beaconsplits"];
}

reset{
    return old.igt == 0;
}

gameTime{
    return TimeSpan.FromSeconds(current.igt);
}

isLoading{
    return true;
}