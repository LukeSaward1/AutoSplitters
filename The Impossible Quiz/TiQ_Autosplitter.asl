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
    settings.Add("q33", true, "Split upon finishing Q33");
    settings.Add("q67", true, "Split upon finishing Q67");
    settings.Add("q83", true, "Split upon finishing Q83");
    settings.Add("q91", true, "Split upon finishing Q91");
    settings.Add("q100", true, "Split upon finishing Q100");
    settings.Add("q101", true, "Split upon finishing Q101");
    settings.Add("q102", true, "Split upon finishing Q102");
    settings.Add("q103", true, "Split upon finishing Q103");
    settings.Add("q107", true, "Split upon finishing Q107");
    settings.Add("q108", true, "Split upon finishing Q108");
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
    return current.scene == 2 && current.scene != old.scene;
}

split {
    return current.scene == 222 && current.scene != old.scene
    || current.scene == 71 && current.scene != old.scene && settings["q33"]
    || current.scene == 141 && current.scene != old.scene && settings["q67"]
    || current.scene == 176 && current.scene != old.scene && settings["q83"]
    || current.scene == 184 && current.scene != old.scene && settings["q91"]
    || current.scene == 193 && current.scene != old.scene && settings["q100"]
    || current.scene == 196 && current.scene != old.scene && settings["q101"]
    || current.scene == 197 && current.scene != old.scene && settings["q102"]
    || current.scene == 199 && current.scene != old.scene && settings["q103"]
    || current.scene == 209 && current.scene != old.scene && settings["q107"]
    || current.scene == 211 && current.scene != old.scene && settings["q108"];
}
reset {
    return current.scene == 0 && current.scene != old.scene;
}