state("flashplayer_11_sa_32bit", "Flash Player 11") {
    int scene : 0x7336D0, 0x420, 0xE8;
}
state("flashplayer_32_sa", "Flash Player 32 SA") {
    int scene : 0xC95B64, 0x24, 0xA8C, 0x4, 0x2C, 0x50, 0x264, 0x4C;
}

startup {
    settings.Add("s17", true, "Split upon finishing Q16");
    settings.Add("s29", true, "Split upon finishing Q28");
    settings.Add("s43", true, "Split upon finishing Q42");
    settings.Add("s50", true, "Split upon finishing Q49");
    settings.Add("s68", true, "Split upon finishing Q67");
    settings.Add("s92", true, "Split upon finishing Q91");
    settings.Add("s101", true, "Split upon finishing Q100");
    settings.Add("s110", true, "Split upon finishing Q104");
    settings.Add("s124", true, "Split upon finishing Q111");
    settings.Add("s142", true, "Split upon finishing the game");
}

init {
    var mms = modules.First().ModuleMemorySize;
    switch (mms) {
        case 0x892000: version = "Flash Player 11"; break;
        case 0x1034000: version = "Flash Player 32 SA"; break;
    }
}

start {
    return current.scene == 2 && current.scene != old.scene;
}

split {
    return old.scene != current.scene && settings["s" + current.scene];
}

reset {
    return current.scene == 0 && current.scene != old.scene;
}