state("flashplayer_11_sa_32bit", "Flash Player 11") {
    int scene : 0x7336D0, 0x420, 0xE8;
}
state("Flash Player", "Flash Player 32") {
    int scene : 0xC951F8, 0xEA8, 0x10, 0x2C, 0xB08, 0x4C;
}
state("flashplayer_32_sa", "Flash Player 32 SA") {
    int scene : 0xC95B64, 0x24, 0xA8C, 0x4, 0x2C, 0x50, 0x264, 0x4C;
}

startup {
    settings.Add("hundredpercent", true, "100%");
    settings.Add("s71", true, "Split upon finishing Q33", "hundredpercent");
    settings.Add("s141", true, "Split upon finishing Q67", "hundredpercent");
    settings.Add("s176", true, "Split upon finishing Q83", "hundredpercent");
    settings.Add("s184", true, "Split upon finishing Q91", "hundredpercent");
    settings.Add("s193", true, "Split upon finishing Q100", "hundredpercent");


    settings.Add("epicten", false, "Epic 10%");
    settings.Add("s196", true, "Split upon finishing Q101", "epicten");
    settings.Add("s197", true, "Split upon finishing Q102", "epicten");
    settings.Add("s199", true, "Split upon finishing Q103", "epicten");
    settings.Add("s201", true, "Split upon finishing Q104", "epicten");
    settings.Add("s204", true, "Split upon finishing Q105", "epicten");
    settings.Add("s205", true, "Split upon finishing Q106", "epicten");
    settings.Add("s210", true, "Split upon finishing Q107", "epicten");
    settings.Add("s211", true, "Split upon finishing Q108", "epicten");
    settings.Add("s213", true, "Split upon finishing Q109", "epicten");
    settings.Add("s222", true, "Split upon finishing Game", "epicten");
}

init {
    var mms = modules.First().ModuleMemorySize;
    switch (mms) {
        case 0x892000: version = "Flash Player 11"; break;
        case 0xFAE000: version = "Flash Player 32"; break;
        case 0x1034000: version = "Flash Player 32 SA"; break;
    }
}

start {
    if (settings["hundredpercent"]) {
        return current.scene == 2 && current.scene != old.scene;
    } else {
        return current.scene == 193 && current.scene != old.scene;
    }
}

split {
    return old.scene != current.scene && settings["s" + current.scene];
}

reset {
    return (current.scene == 0 || current.scene == 1) && current.scene != old.scene;
}
