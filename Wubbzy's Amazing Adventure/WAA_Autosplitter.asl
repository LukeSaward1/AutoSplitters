state("flashplayer_32_sa") {
    int scene : 0xC95B64, 0x24, 0xA8C, 0x4, 0x2C, 0x50, 0x264, 0x4C;
}

startup {
    settings.Add("wuzzleberg", true, "Split upon finishing Wuzzleberg");
    settings.Add("workshop", true, "Split upon finishing Widget's Workshop");
    settings.Add("lab", true, "Split upon finishing Walden's Laboratory");
}

split {
    return current.scene == 820 && current.scene != old.scene && settings["wuzzleberg"]
    || current.scene == 862 && current.scene != old.scene && settings["workshop"]
    || current.scene == 902 && current.scene != old.scene && settings["lab"];
}

reset {
    return current.scene == 16 && current.scene != old.scene;
}