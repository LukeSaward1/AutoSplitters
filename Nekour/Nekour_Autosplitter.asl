state("ProjectCat-Win32-Shipping")
{
    int maxDiamondCount      : 0x23F1550, 0xE4, 0x100;
    int diamondCount         : 0x23F1550, 0xE4, 0x104;
    bool hasRedKey           : 0x23F1550, 0xE4, 0x108;
    bool hasBlueKey          : 0x23F1550, 0xE4, 0x109;
    bool hasYellowKey        : 0x23F1550, 0xE4, 0x10A;
    bool hasGreenKey         : 0x23F1550, 0xE4, 0x10B;
    bool hasUnlockedBridge   : 0x23F1550, 0xE4, 0x10C;
    string64 levelName       : 0x23F1550, 0x2C8, 0x0;
    string64 alwaysLevelName : 0x23EF8E8, 0x64C, 0x0;
}

startup
{
    vars.Splits = new Dictionary<string, Func<dynamic, dynamic, bool>>
    {
        { "diamondsplit",      (_o, _c) => _o.diamondCount < _c.diamondCount && _c.diamondCount == _c.maxDiamondCount },
        { "redkeysplit",       (_o, _c) => !_o.hasRedKey && _c.hasRedKey },
        { "bluekeysplit",      (_o, _c) => !_o.hasBlueKey && _c.hasBlueKey },
        { "yellowkeysplit",    (_o, _c) => !_o.hasYellowKey && _c.hasYellowKey },
        { "greenkeysplit",     (_o, _c) => !_o.hasGreenKey && _c.hasGreenKey },
        { "bridgeunlocksplit", (_o, _c) => !_o.hasUnlockedBridge && _c.hasUnlockedBridge },
        { "enterheavensplit",  (_o, _c) => _o.alwaysLevelName != _c.alwaysLevelName && _c.alwaysLevelName == "/Game/Maps/Heaven" }
    };

    settings.Add("diamondsplit", true, "Split upon collecting all 200 diamonds");
    settings.Add("redkeysplit", true, "Split upon collecting the red key");
    settings.Add("bluekeysplit", true, "Split upon collecting the blue key");
    settings.Add("yellowkeysplit", true, "Split upon collecting the yellow key");
    settings.Add("greenkeysplit", true, "Split upon collecting the green key");
    settings.Add("bridgeunlocksplit", true, "Split upon unlocking the bridge");
    settings.Add("enterheavensplit", true, "Split upon entering Heaven");
}

start
{
    return old.levelName != current.levelName && current.levelName == "/Game/Maps/World";
}

split
{
    foreach (var split in vars.Splits)
    {
        if (split.Value(old, current))
            return settings[split.Key];
    }
}

reset
{
    return old.levelName != current.levelName && current.levelName == "" && !current.hasUnlockedBridge;
}