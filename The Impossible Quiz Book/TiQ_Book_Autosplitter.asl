state("flashplayer_11_sa_32bit", "Flash Player 11") {
    int scene : 0x7336D0, 0x420, 0xE8;
}
state("flashplayer_32_sa", "Flash Player 32 SA") {
    int scene : 0xC95B64, 0x24, 0xA8C, 0x4, 0x2C, 0x50, 0x264, 0x4C;
}

startup {
    settings.Add("c1", false, "Chapter 1");
        settings.Add("s13", true, "Split upon finishing Q12", "c1");
        settings.Add("s24", true, "Split upon finishing Q23", "c1");
        settings.Add("s38", true, "Split upon finishing Q37", "c1");
        settings.Add("s43", true, "Split upon finishing Q42", "c1");
    settings.Add("c2", false, "Chapter 2");
        settings.Add("s1042", true, "Split upon finishing Q60", "c2");
        settings.Add("s24", true, "Split upon finishing Q70", "c2");
        settings.Add("s38", true, "Split upon finishing Q80", "c2");
        settings.Add("s43", true, "Split upon finishing Q90", "c2");
        settings.Add("s43", true, "Split upon finishing the chapter", "c2");
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