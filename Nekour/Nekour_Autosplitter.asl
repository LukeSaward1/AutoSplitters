state("ProjectCat-Win32-Shipping")
{
    int maxDiamondCount            : 0x23F1550, 0xE4, 0x100;
    int diamondCount               : 0x23F1550, 0xE4, 0x104;
    byte hasRedKey                 : 0x23F1550, 0xE4, 0x108;
    byte hasBlueKey                : 0x23F1550, 0xE4, 0x109;
    byte hasYellowKey              : 0x23F1550, 0xE4, 0x10A;
    byte hasGreenKey               : 0x23F1550, 0xE4, 0x10B;
    byte hasUnlockedBridge         : 0x23F1550, 0xE4, 0x10C;
    string64 levelName             : 0x23F1550, 0x2C8, 0x0;
    string64 alwaysLevelName       : 0x23EF8E8, 0x64C, 0x0;
}

startup
{
    settings.Add("diamondsplit", true, "Split upon collecting all 200 diamonds");
    settings.Add("redkeysplit", true, "Split upon collecting the red key");
    settings.Add("bluekeysplit", true, "Split upon collecting the blue key");
    settings.Add("yellowkeysplit", true, "Split upon collecting the yellow key");
    settings.Add("greenkeysplit", true, "Split upon collecting the green key");
    settings.Add("bridgeunlocksplit", true, "Split upon unlocking the bridge");
    settings.Add("enterheavensplit", true, "Split upon entering Heaven");

    vars.timerModel = new TimerModel { CurrentState = timer };

    vars.timesChecked = 0;
}

update
{
    if(current.levelName != old.levelName && settings.ResetEnabled && current.levelName == "" && current.hasUnlockedBridge == 0)
    {
        vars.timerModel.Reset();
    }

	if (current.levelName != old.levelName && current.levelName == "/Game/Maps/World" && settings.StartEnabled)
    {
		vars.timerModel.Start();
	}

    if(current.diamondCount != old.diamondCount && current.diamondCount == current.maxDiamondCount && settings["diamondsplit"])
    {
        vars.timerModel.Split();
    }
    if(current.hasRedKey != old.hasRedKey && current.hasRedKey == 1 && settings["redkeysplit"])
    {
        vars.timerModel.Split();
    }
    if(current.hasBlueKey != old.hasBlueKey && current.hasBlueKey == 1 && settings["bluekeysplit"])
    {
        vars.timerModel.Split();
    }
    if(current.hasYellowKey != old.hasYellowKey && current.hasYellowKey == 1 && settings["yellowkeysplit"])
    {
        vars.timerModel.Split();
    }
    if(current.hasGreenKey != old.hasGreenKey && current.hasGreenKey == 1 && settings["greenkeysplit"])
    {
        vars.timerModel.Split();
    }
    if(current.diamondCount != old.diamondCount && current.diamondCount == current.maxDiamondCount && settings["diamondsplit"])
    {
        vars.timerModel.Split();
    }
    if(current.hasUnlockedBridge != old.hasUnlockedBridge && current.hasUnlockedBridge == 1 && settings["bridgeunlocksplit"])
    {
        vars.timerModel.Split();
    }
}

start
{
    return false;
}

split
{
    return current.alwaysLevelName != old.alwaysLevelName && current.alwaysLevelName == "/Game/Maps/Heaven" && settings.SplitEnabled && settings["enterheavensplit"];
}

reset
{
    return false;
}

exit
{
    vars.timerModel.Reset();
}