state("ProjectCat-Win32-Shipping", "V1.0")
{
    int maxDiamondCount      : 0x23F1550, 0xE4, 0x100;
    int diamondCount         : 0x23F1550, 0xE4, 0x104;
    bool hasRedKey           : 0x23F1550, 0xE4, 0x108;
    bool hasBlueKey          : 0x23F1550, 0xE4, 0x109;
    bool hasYellowKey        : 0x23F1550, 0xE4, 0x10A;
    bool hasGreenKey         : 0x23F1550, 0xE4, 0x10B;
    bool hasUnlockedBridge   : 0x23F1550, 0xE4, 0x10C;
    string64 levelName       : 0x23F1550, 0x2C8, 0x0;
}
state("ProjectCat-Win64-Shipping", "V1.1")
{
    int maxDiamondCount      : 0x4A3CD30, 0x180, 0x1B0;
    int diamondCount         : 0x4A3CD30, 0x180, 0x1B4;
    bool hasRedKey           : 0x4A3CD30, 0x180, 0x1B8;
    bool hasBlueKey          : 0x4A3CD30, 0x180, 0x1B9;
    bool hasYellowKey        : 0x4A3CD30, 0x180, 0x1BA;
    bool hasGreenKey         : 0x4A3CD30, 0x180, 0x1BB;
    bool hasUnlockedBridge   : 0x4A3CD30, 0x180, 0x1BC;
    string64 levelName       : 0x4A3CD30, 0x4A8, 0x0;
}

init
{
    // MD5 code by CptBrian.
    string MD5Hash;
    using (var md5 = System.Security.Cryptography.MD5.Create())
        using (var s = File.Open(modules.First().FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
            MD5Hash = md5.ComputeHash(s).Select(x => x.ToString("X2")).Aggregate((a, b) => a + b);
        switch (MD5Hash) {
        case "B0037E8E52A7062A05139FB89D5413D4": version = "v1.0"; break;
        case "E52DDC172CC0E113B37CACD161A8BCD4": version = "v1.1"; break;
    }
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
        { "enterheavensplit",  (_o, _c) => _o.levelName != _c.levelName && _c.levelName == "/Game/Maps/Heaven" }
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