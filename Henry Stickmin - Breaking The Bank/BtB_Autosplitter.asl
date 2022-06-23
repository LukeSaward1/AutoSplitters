state("flashplayer_32_sa") {
    int scene : 0xC95B64, 0x24, 0xA8C, 0x4, 0x2C, 0x50, 0x264, 0x4C;
}

startup {
    settings.Add("tunnel", true, "Split upon selecting the Tunnel option");
    settings.Add("tnt", true, "Split upon selecting the Explosion option");
    settings.Add("lazer", true, "Split upon selecting the Lazer Drill option");
    settings.Add("ball", true, "Split upon selecting the Wrecking Ball option");
    settings.Add("tele", true, "Split upon selecting the Teleporter option");
    settings.Add("bag", true, "Split upon selecting the Teleporter option");
    settings.Add("arrest", true, "Split upon fadeout after Henry is caught");

    settings.Add("special", false, "Special");
        settings.Add("refresh", false, "Do not reset on refresh", "special");
}

start {
    return current.scene == 1 && current.scene != old.scene;
}

split {
    return current.scene == 161 && current.scene != old.scene && settings["tunnel"]
    || current.scene == 764 && current.scene != old.scene && settings["tnt"]
    || current.scene == 1251 && current.scene != old.scene && settings["lazer"]
    || current.scene == 1650 && current.scene != old.scene && settings["ball"]
    || current.scene == 2359 && current.scene != old.scene && settings["tele"]
    || current.scene == 2735 && current.scene != old.scene && settings["bag"]
    || current.scene == 4035 && current.scene != old.scene && settings["arrest"];
}

reset {
    return current.scene == 0 && current.scene != old.scene && !settings["refresh"];
}