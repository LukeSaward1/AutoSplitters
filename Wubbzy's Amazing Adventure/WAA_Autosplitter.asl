state ("flashplayer_11_sa_32bit", "Flash Player 11"){
    int scene : 0x7336D0, 0x420, 0xE8;
    int playButtonFrame: 0x0733174, 0x448, 0x268, 0x2A0, 0x1FC, 0xB28, 0x3E0;
}

startup {
    settings.Add("wuzzleberg", true, "Split upon finishing Wuzzleberg");
    settings.Add("workshop", true, "Split upon finishing Widget's Workshop");
    settings.Add("lab", true, "Split upon finishing Walden's Laboratory");
}

init {
    var mms = modules.First().ModuleMemorySize;
    print(mms.ToString("X2"));
    switch (mms) {
        case 0x892000: version = "Flash Player 11"; break;
    }
}

start {
    return current.playButtonFrame != old.playButtonFrame && current.playButtonFrame == 0 && old.playButtonFrame == 22;
}

split {
    return current.scene == 820 && current.scene != old.scene && settings["wuzzleberg"]
    || current.scene == 862 && current.scene != old.scene && settings["workshop"]
    || current.scene == 902 && current.scene != old.scene && settings["lab"];
}

reset {
    return current.scene == 16 && current.scene != old.scene;
}