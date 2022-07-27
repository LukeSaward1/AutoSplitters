state("flashplayer_11_sa_32bit") {
    int scene : 0x7336D0, 0x420, 0xE8;
}

startup {
    settings.Add("s12443", true, "Split upon completing the Sneaky Ending");
    settings.Add("s15983", true, "Split upon completing the Badass Ending");
    settings.Add("s8782", true, "Split upon completing the Lame Ending");
}

start {
    return old.scene == 1114 && current.scene != old.scene;
}

split {
    return old.scene != current.scene && settings["s" + current.scene];
}

reset {
    return current.scene == 0 && current.scene != old.scene;
}