// Perfect Vermin autosplitter V1
// Author: Luke Saward
// Features: Auto Start, Auto Split, [optional] Auto Reset
// Versions supported: Latest Steam/Itch.io, Vanilla [Terminal Velocity beta], Terminal Velocity Edition
// Unreal Engine version 4.18
// PV 1.3 is not yet implemented as I do not have the download for it, the Google Drive link doesn't exist.
// Commented out features are not yet available

state("PerfectVermin-Win64-Shipping", "Latest Steam/Itch")
{
    bool canPause:            0x2F8E9F8, 0x140, 0x38, 0x0, 0x30, 0x380, 0x838;
    bool canMove:             0x2F8E9F8, 0x140, 0x38, 0x0, 0x30, 0x380, 0x871;
    bool lightswitchesBroken: 0x2F8E9F8, 0x140, 0x38, 0x0, 0x30, 0x380, 0x8B0;
    int furnitureLeft:        0x2F8E9F8, 0xF0, 0x410;
    string128 mapName:        0x2F8E9F8, 0x6F8, 0x0;
}
state("PerfectVermin-Win64-Shipping", "Vanilla - TV")
{
    bool canPause:            0x2F8A778, 0x140, 0x38, 0x0, 0x30, 0x380, 0x838;
    bool canMove:             0x2F8A778, 0x140, 0x38, 0x0, 0x30, 0x380, 0x871;
    bool lightswitchesBroken: 0x2F8A778, 0x140, 0x38, 0x0, 0x30, 0x380, 0x8B0;
    int furnitureLeft:        0x2F8A778, 0xF0, 0x410;
    string128 mapName:        0x2F8A778, 0x6F8, 0x0;
}

state("PerfectVermin-Win64-Shipping", "Terminal Velocity")
{
    bool canPause:            0x2F8AD78, 0x140, 0x38, 0x0, 0x30, 0x380, 0x838;
    bool canMove:             0x2F8AD78, 0x140, 0x38, 0x0, 0x30, 0x380, 0x871;
    bool lightswitchesBroken: 0x2F8AD78, 0x140, 0x38, 0x0, 0x30, 0x380, 0x8B0;
    int furnitureLeft:        0x2F8AD78, 0xF0, 0x410;
    string128 mapName:        0x2F8AD78, 0x6F8, 0x0;
}

startup
{
    vars.Splits = new Dictionary<string, Func<dynamic, dynamic, bool>>
    {
        // { "furnitureNoneLeft",      (_o, _c) => _o.furnitureLeft > _c.furnitureLeft && _c.furnitureLeft == 0 },
        // { "furnitureSubtract",      (_o, _c) => _o.furnitureLeft > _c.furnitureLeft},
        // { "firstRound",             (_o, _c) => _o.canMove != _c.canMove && vars.staticBlackenCount % 2 == 0 && vars.staticBlackenCount > 0},
        { "groundFirstFloorSplit",  (_o, _c) => _o.mapName != _c.mapName && _c.mapName == "/Game/Maps/DoubleTrouble"},
        { "doubleTroubleSplit",     (_o, _c) => _o.mapName != _c.mapName && _c.mapName == "/Game/Maps/EndLevel"},
        { "endLevelSplit",          (_o, _c) => _o.mapName != _c.mapName && _c.mapName == "/Game/Maps/SayAhhFullMap"},
        { "doctorOfficeSplit",      (_o, _c) => _o.mapName != _c.mapName && _c.mapName == "/Game/Maps/DoctorsOfficeFullMap"},
    };
    vars.staticBlackenCount = 0;
    settings.Add("objectCountMain", false, "Objects");
        settings.Add("furnitureCountMain", false, "Furniture", "objectCountMain");
            settings.Add("furnitureNoneLeft", false, "Split when all furniture has been killed", "furnitureCountMain");
            settings.Add("furnitureSubtract", false, "Split upon killing a piece of furniture", "furnitureCountMain");
        // settings.Add("lightswitchCountMain", false, "Lightswitches", "objectCountMain");
        //     settings.Add("lightswitchNoneLeft", false, "Split when all lightswitches have been destroyed", "lightswitchCountMain");
        //     settings.Add("lightswitchSubtract", false, "Split upon destroying a lightswitch", "lightswitchCountMain");
    settings.Add("levelMain", true, "Level");
        // settings.Add("roundsMain", false, "Rounds", "levelMain");
        //     settings.Add("firstRound", false, "Split when you complete the first round", "roundsMain");
        //     settings.Add("secondRoundButBetter", false, "Split when you complete the second round (first round but better)", "roundsMain");
        //     settings.Add("thirdRoundNoNonsense", false, "Split when you complete the third round (wih no nonsense)", "roundsMain");
        //     settings.Add("fourthRoundUncoopGeometry", false, "Split when you complete the fourth round (upside down furniture)", "roundsMain");
        settings.Add("groundFirstFloorSplit", true, "Split when you complete the ground and first floors", "levelMain");
        settings.Add("doubleTroubleSplit", true, "Split when you complete Double Trouble", "levelMain");
        settings.Add("endLevelSplit", true, "Split when you complete End Level", "levelMain");
        settings.Add("doctorOfficeSplit", true, "Split when you appear in the hospital", "levelMain");
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
            case "D28DFC82F68E8E3B283BB45B0254FFD3": version = "Latest Steam/Itch"; break;
            case "4E3DDE45560E052260342757C4F828DC": version = "Vanilla - Terminal Velocity"; break;
            case "FB3853D7C037F0DE76AF127852B4A133": version = "Terminal Velocity"; break;
    }
    print(MD5Hash);
}

start
{
    if(current.canPause != old.canPause && current.canPause == true && current.mapName == "/Game/Maps/GroundFloor") {
        vars.staticBlackenCount = 0;
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

// update
// {
//     if(current.canMove != old.canMove && current.canMove == false && current.canPause == false)
//     {
//         vars.staticBlackenCount++;
//         print("vars.staticBlackenCount: " + vars.staticBlackenCount.ToString());
//     }
// }