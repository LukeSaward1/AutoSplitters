// Perfect Vermin autosplitter V1
// Author: Luke Saward
// Features: Auto Start, Auto Split, [optional] Auto Reset
// Versions supported: v1.3, v2.1/Terminal Velocity
// Unreal Engine version 4.18

state("PerfectVermin-Win64-Shipping", "v1.3")
{
    bool canPause:            0x2EF7E78, 0x140, 0x38, 0x0, 0x30, 0x380, 0x838;
    bool canMove:             0x2EF7E78, 0x140, 0x38, 0x0, 0x30, 0x380, 0x871;
    int lightswitchesBroken:  0x2EF7E78, 0x140, 0x38, 0x0, 0x30, 0x380, 0x8B0;
    int furnitureLeft:        0x2EF7E78, 0x140, 0x38, 0x0, 0x30, 0x380, 0x8A8;
    string128 mapName:        0x2EF7E78, 0x6F8, 0x0;
}
state("PerfectVermin-Win64-Shipping", "v2.1/Terminal Velocity")
{
    bool canPause:            0x2F9FE78, 0x140, 0x38, 0x0, 0x30, 0x380, 0x838;
    bool canMove:             0x2F9FE78, 0x140, 0x38, 0x0, 0x30, 0x380, 0x871;
    int lightswitchesBroken:  0x2F9FE78, 0x140, 0x38, 0x0, 0x30, 0x380, 0x8B0;
    int furnitureLeft:        0x2F9FE78, 0x140, 0x38, 0x0, 0x30, 0x380, 0x8A8;
    string128 mapName:        0x2F9FE78, 0x6F8, 0x0;
}

startup
{
    vars.Splits = new Dictionary<string, Func<dynamic, dynamic, bool>>
    {
        { "groundFirstFloorSplit",  (_o, _c) => _o.mapName != _c.mapName && _c.mapName == "/Game/Maps/DoubleTrouble"},
        { "doubleTroubleSplit",     (_o, _c) => _o.mapName != _c.mapName && _c.mapName == "/Game/Maps/EndLevel"},
        { "endLevelSplit",          (_o, _c) => _o.mapName != _c.mapName && _c.mapName == "/Game/Maps/SayAhhFullMap"},
        { "doctorOfficeSplit",      (_o, _c) => _o.mapName != _c.mapName && _c.mapName == "/Game/Maps/DoctorsOfficeFullMap"},
        { "furnitureNoneLeft",      (_o, _c) => _o.furnitureLeft < _c.furnitureLeft && _c.furnitureLeft == 0},
        { "furnitureCount",         (_o, _c) => _o.furnitureLeft < _c.furnitureLeft},
        { "lightswitchNoneLeft",    (_o, _c) => _o.lightswitchesBroken < _c.lightswitchesBroken && _c.lightswitchesBroken == 33},
        { "lightswitchCount",       (_o, _c) => _o.lightswitchesBroken < _c.lightswitchesBroken},
    };
    settings.Add("objectCountMain", false, "Objects");
        settings.Add("furnitureCountMain", false, "Furniture", "objectCountMain");
            settings.Add("furnitureNoneLeft", false, "Split when all furniture has been killed", "furnitureCountMain");
            settings.Add("furnitureCount", false, "Split upon killing a piece of furniture", "furnitureCountMain");
        settings.Add("lightswitchCountMain", false, "Lightswitches", "objectCountMain");
            settings.Add("lightswitchNoneLeft", false, "Split when all lightswitches have been destroyed (v2.1+)", "lightswitchCountMain");
            settings.Add("lightswitchCount", false, "Split upon destroying a lightswitch (v2.1+)", "lightswitchCountMain");
    settings.Add("levelMain", true, "Level");
        settings.Add("groundFirstFloorSplit", true, "Split when you complete the ground and first floors", "levelMain");
        settings.Add("doubleTroubleSplit", true, "Split when you complete Double Trouble", "levelMain");
        settings.Add("endLevelSplit", true, "Split when you complete Say Ahh", "levelMain");
        settings.Add("doctorOfficeSplit", true, "Split when you appear in the doctor's office", "levelMain");
    settings.Add("resetMain", true, "Reset");
        settings.Add("resetMainMenu", false, "Reset upon entering the main menu", "resetMain");
}

init
{
  // MD5 code by CptBrian.
  string MD5Hash;
  using (var md5 = System.Security.Cryptography.MD5.Create())
        using (var s = File.Open(modules.First().FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
            MD5Hash = md5.ComputeHash(s).Select(x => x.ToString("X2")).Aggregate((a, b) => a + b);
        switch (MD5Hash) {
            case "AD1E08BD35DF32EEEBBB31E7E18F6224": version = "v1.3"; break;
            case "A3C6D18FCAD437235379358E34AE1B7B": version = "v2.1/Terminal Velocity"; break;
    }
}

start
{
    if(current.canPause != old.canMove && current.canMove == true && current.mapName == "/Game/Maps/GroundFloor") {
        return true;
    }
}

split
{
    foreach (var split in vars.Splits)
    {
        if (split.Value(old, current)){
            return settings[split.Key];
        }
    }
}

reset
{
    return current.mapName == "/Game/Maps/MainMenu" && settings["resetMainMenu"];
}