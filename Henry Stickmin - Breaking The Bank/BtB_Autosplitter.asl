state("flashplayer_32_sa") {
    int scene : 0xC95B64, 0x24, 0xA8C, 0x4, 0x2C, 0x50, 0x264, 0x4C;
}

startup {
    settings.Add("s161", true, "Split upon selecting the Tunnel option");
    settings.Add("s764", true, "Split upon selecting the Explosion option");
    settings.Add("s1251", true, "Split upon selecting the Lazer Drill option");
    settings.Add("s1650", true, "Split upon selecting the Wrecking Ball option");
    settings.Add("s2359", true, "Split upon selecting the Teleporter option");
    settings.Add("s2735", true, "Split upon selecting the Teleporter option");
    settings.Add("s4035", true, "Split upon fadeout after Henry is caught");

    settings.Add("special", false, "Special");
        settings.Add("refresh", false, "Do not reset on refresh", "special");
}

start {
    return current.scene == 1 && current.scene != old.scene;
}

split {
    return old.scene != current.scene && settings["s" + current.scene];
}

reset {
    return current.scene == 0 && current.scene != old.scene && !settings["refresh"];
}