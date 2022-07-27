state("flashplayer_11_sa_32bit", "Flash Player 11") {
    int scene : 0x7336D0, 0x420, 0xE8;
}
state("flashplayer_32_sa", "Flash Player 32 SA") {
    int scene : 0xC95B64, 0x24, 0xA8C, 0x4, 0x2C, 0x50, 0x264, 0x4C;
}

startup {
	settings.Add("lvlmsg", true, "Level Messages");
	    settings.Add("s71", true, "Split upon the message after finishing Level 1", "lvlmsg");
		settings.Add("s75", true, "Split upon the message after finishing Level 2", "lvlmsg");
		settings.Add("s79", true, "Split upon the message after finishing Level 3", "lvlmsg");
		settings.Add("s84", true, "Split upon the message after finishing Level 4", "lvlmsg");
		settings.Add("s87", true, "Split upon the message after finishing Level 5", "lvlmsg");
		settings.Add("s91", true, "Split upon the message after finishing Level 6", "lvlmsg");
		settings.Add("s95", true, "Split upon the message after finishing Level 7", "lvlmsg");
		settings.Add("s99", true, "Split upon the message after finishing Level 8", "lvlmsg");
		settings.Add("s104", true, "Split upon the message after finishing Level 9", "lvlmsg");
		settings.Add("s107", true, "Split upon the message after finishing Level 10", "lvlmsg");
		settings.Add("s111", true, "Split upon the message after finishing Level 11", "lvlmsg");
		settings.Add("s115", true, "Split upon the message after finishing Level 12", "lvlmsg");
		settings.Add("s119", true, "Split upon the message after finishing Level 13", "lvlmsg");
		settings.Add("s124", true, "Split upon the message after finishing Level 14", "lvlmsg");
		settings.Add("s127", true, "Split upon the message after finishing Level 15", "lvlmsg");
		settings.Add("s131", true, "Split upon the message after finishing Level 16", "lvlmsg");
		settings.Add("s135", true, "Split upon the message after finishing Level 17", "lvlmsg");
		settings.Add("s139", true, "Split upon the message after finishing Level 18", "lvlmsg");
		settings.Add("s144", true, "Split upon the message after finishing Level 19", "lvlmsg");
		settings.Add("s147", true, "Split upon the message after finishing Level 20", "lvlmsg");
		settings.Add("s151", true, "Split upon the message after finishing Level 21", "lvlmsg");
		settings.Add("s155", true, "Split upon the message after finishing Level 22", "lvlmsg");
		settings.Add("s159", true, "Split upon the message after finishing Level 23", "lvlmsg");
		settings.Add("s164", true, "Split upon the message after finishing Level 24", "lvlmsg");
		settings.Add("s167", true, "Split upon the message after finishing Level 25", "lvlmsg");
		settings.Add("s171", true, "Split upon the message after finishing Level 26", "lvlmsg");
		settings.Add("s175", true, "Split upon the message after finishing Level 27", "lvlmsg");
		settings.Add("s179", true, "Split upon the message after finishing Level 28", "lvlmsg");
		settings.Add("s184", true, "Split upon the message after finishing Level 29", "lvlmsg");
		settings.Add("s51", true, "Split upon the finishing Level 30", "lvlmsg");

	settings.Add("lvlappear", false, "Level Appear");
	    settings.Add("s70", true, "Split upon Level 1 appearing", "lvlappear");
		settings.Add("s74", true, "Split upon Level 2 appearing", "lvlappear");
		settings.Add("s78", true, "Split upon Level 3 appearing", "lvlappear");
		settings.Add("s82", true, "Split upon Level 4 appearing", "lvlappear");
		settings.Add("s86", true, "Split upon Level 5 appearing", "lvlappear");
		settings.Add("s90", true, "Split upon Level 6 appearing", "lvlappear");
		settings.Add("s94", true, "Split upon Level 7 appearing", "lvlappear");
		settings.Add("s98", true, "Split upon Level 8 appearing", "lvlappear");
		settings.Add("s102", true, "Split upon Level 9 appearing", "lvlappear");
		settings.Add("s106", true, "Split upon Level 10 appearing", "lvlappear");
		settings.Add("s110", true, "Split upon Level 11 appearing", "lvlappear");
		settings.Add("s114", true, "Split upon Level 12 appearing", "lvlappear");
		settings.Add("s118", true, "Split upon Level 13 appearing", "lvlappear");
		settings.Add("s122", true, "Split upon Level 14 appearing", "lvlappear");
		settings.Add("s126", true, "Split upon Level 15 appearing", "lvlappear");
		settings.Add("s130", true, "Split upon Level 16 appearing", "lvlappear");
		settings.Add("s134", true, "Split upon Level 17 appearing", "lvlappear");
		settings.Add("s138", true, "Split upon Level 18 appearing", "lvlappear");
		settings.Add("s142", true, "Split upon Level 19 appearing", "lvlappear");
		settings.Add("s146", true, "Split upon Level 20 appearing", "lvlappear");
		settings.Add("s150", true, "Split upon Level 21 appearing", "lvlappear");
		settings.Add("s154", true, "Split upon Level 22 appearing", "lvlappear");
		settings.Add("s158", true, "Split upon Level 23 appearing", "lvlappear");
		settings.Add("s162", true, "Split upon Level 24 appearing", "lvlappear");
		settings.Add("s166", true, "Split upon Level 25 appearing", "lvlappear");
		settings.Add("s170", true, "Split upon Level 26 appearing", "lvlappear");
		settings.Add("s174", true, "Split upon Level 27 appearing", "lvlappear");
		settings.Add("s178", true, "Split upon Level 28 appearing", "lvlappear");
		settings.Add("s182", true, "Split upon Level 29 appearing", "lvlappear");
		settings.Add("s186", true, "Split upon Level 30 appearing", "lvlappear");

	settings.Add("lvltips", false, "Level Tips");
	    settings.Add("s83", true, "Split upon the tip after finishing Level 4", "lvltips");
		settings.Add("s103", true, "Split upon the tip after finishing Level 9", "lvltips");
		settings.Add("s123", true, "Split upon the tip after finishing Level 14", "lvltips");
		settings.Add("s143", true, "Split upon the tip after finishing Level 19", "lvltips");
		settings.Add("s163", true, "Split upon the tip after finishing Level 24", "lvltips");
		settings.Add("s183", true, "Split upon the tip after finishing Level 29", "lvltips");
}

init {
    var mms = modules.First().ModuleMemorySize;
    switch (mms) {
        case 0x892000: version = "Flash Player 11"; break;
		case 0xFAA000: version = "Flash Player 32"; break;
    }
}

start {
    return current.scene == 60 && current.scene != old.scene;
}

split {
    return old.scene != current.scene && settings["s" + current.scene];
}

reset {
	return current.scene == 26 && current.scene != old.scene;
}
