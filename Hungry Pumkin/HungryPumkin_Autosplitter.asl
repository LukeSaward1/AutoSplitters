state ("flashplayer_11_sa_32bit", "Flash Player 11"){
    int scene : 0x7336D0, 0x420, 0xE8;
}
state ("flashplayer_32_sa", "Flash Player 32 SA") {
    int scene : 0xC95B64, 0x24, 0xA8C, 0x4, 0x2C, 0x50, 0x264, 0x4C;
}

startup {
    settings.Add("set1", true, "Split upon completing Set 1");
    settings.Add("set2", true, "Split upon completing Set 2");
    settings.Add("set3", true, "Split upon completing Set 3");
    settings.Add("set4", true, "Split upon completing Set 4");
    settings.Add("set5", false, "Split upon completing Set 5");
    settings.Add("set5walkout", true, "Split when the pumkin walks out completing Set 5");
}

init {
    var mms = modules.First().ModuleMemorySize;
    print(mms.ToString("X2"));
    switch (mms) {
        case 0x892000: version = "Flash Player 11"; break;
        case 0x1034000: version = "Flash Player 32 SA"; break;
    }

    vars.foodWrong = 0;
    vars.foodCorrect = 0;
}

start {
    return current.scene == 2 && current.scene != old.scene;
}

split {
    if ((vars.foodCorrect + vars.foodWrong == 4)) {
        return current.scene == 164 && current.scene != old.scene && settings["set1"] 
        || current.scene == 164 && current.scene != old.scene && settings["set2"]
        || current.scene == 164 && current.scene != old.scene && settings["set3"]
        || current.scene == 164 && current.scene != old.scene && settings["set4"]
        || current.scene == 164 && current.scene != old.scene && settings["set5"]
        || current.scene == 264 && current.scene != old.scene && settings["set5walkout"];
    }
}

update {
    if (current.scene == 191 && current.scene != old.scene) {
        vars.foodWrong += 1;
    }
    if (current.scene == 119 && current.scene != old.scene) {
        vars.foodWrong = 0;
        vars.foodCorrect = 0;
    }
    if (current.scene == 164 && current.scene != old.scene) {
        vars.foodCorrect += 1;
    }
}