state("StealthGame-Win32-Shipping")
{
    float CleanAnim_Brightness: 0x1806298, 0x20, 0x88, 0x474, 0x238;
    float playerX: 0x1806298, 0xBC, 0x24, 0x0, 0x20, 0x244, 0x114, 0xEC;
    float playerY: 0x1806298, 0xBC, 0x24, 0x0, 0x20, 0x244, 0x114, 0xF0;
    float playerZ: 0x1806298, 0xBC, 0x24, 0x0, 0x20, 0x244, 0x114, 0xF4;
    float doorAnimationProgress: 0x1806298, 0x20, 0x88, 0x478, 0x254;
    bool isLoading: 0x1806298, 0x20, 0x88, 0x478, 0x2A2;
    string128 levelName: 0x1806298, 0x3D0, 0x0;
    float playerCamY: 0x1806298, 0xBC, 0x24, 0x0, 0x20, 0x294, 0x114, 0xF0;
    float playerCamZ: 0x1806298, 0xBC, 0x24, 0x0, 0x20, 0x294, 0x114, 0xF4;
}

startup
{
    vars.Splits = new Dictionary<string, Func<dynamic, dynamic, bool>>
    {
        { "cube1fizzlersplit",      (_o, _c) => _o.CleanAnim_Brightness < _c.CleanAnim_Brightness && _c.CleanAnim_Brightness > 0f },
        { "cube1transitionsplit",      (_o, _c) => _o.doorAnimationProgress != _c.doorAnimationProgress && _c.doorAnimationProgress < 0f && _c.isLoading == true && vars.SplitCount == 0},
        { "cube2fizzlersplit",      (_o, _c) => _o.CleanAnim_Brightness < _c.CleanAnim_Brightness && _c.CleanAnim_Brightness > 0f},
        { "cube2transitionsplit",      (_o, _c) => _o.doorAnimationProgress != _c.doorAnimationProgress && _c.doorAnimationProgress < 0f && _c.isLoading == true && vars.SplitCount == 1 },
        { "cube3fizzlersplit",      (_o, _c) => _o.CleanAnim_Brightness < _c.CleanAnim_Brightness && _c.CleanAnim_Brightness > 0f},
        { "cube3transitionsplit",      (_o, _c) => _o.doorAnimationProgress != _c.doorAnimationProgress && _c.doorAnimationProgress < 0f && _c.isLoading == true && vars.SplitCount == 2 },
        { "cube4fizzlersplit",      (_o, _c) => _o.CleanAnim_Brightness < _c.CleanAnim_Brightness && _c.CleanAnim_Brightness > 0f},
        { "cube4transitionsplit",      (_o, _c) => _o.doorAnimationProgress != _c.doorAnimationProgress && _c.doorAnimationProgress < 0f && _c.isLoading == true && vars.SplitCount == 3 },
        { "cube5fizzlersplit",      (_o, _c) => _o.CleanAnim_Brightness < _c.CleanAnim_Brightness && _c.CleanAnim_Brightness > 0f},
        { "cube5transitionsplit",      (_o, _c) => _o.doorAnimationProgress != _c.doorAnimationProgress && _c.doorAnimationProgress < 0f && _c.isLoading == true && vars.SplitCount == 4 },
        { "cube6fizzlersplit",      (_o, _c) => _o.CleanAnim_Brightness < _c.CleanAnim_Brightness && _c.CleanAnim_Brightness > 0f},
        { "cube6transitionsplit",      (_o, _c) => _o.doorAnimationProgress != _c.doorAnimationProgress && _c.doorAnimationProgress < 0f && _c.isLoading == true && vars.SplitCount == 5 },
        { "cube7fizzlersplit",      (_o, _c) => _o.CleanAnim_Brightness < _c.CleanAnim_Brightness && _c.CleanAnim_Brightness > 0f},
        { "cube7transitionsplit",      (_o, _c) => _o.doorAnimationProgress != _c.doorAnimationProgress && _c.doorAnimationProgress < 0f && _c.isLoading == true && vars.SplitCount == 6 },
    };

    settings.Add("cube1", true, "Cube 1");
    settings.Add("cube1fizzlersplit", true, "Split upon putting Cube 1 in the clearer", "cube1");
    settings.Add("cube1transitionsplit", false, "Split upon transitioning to the second area", "cube1");
    settings.Add("cube2", true, "Cube 2");
    settings.Add("cube2fizzlersplit", true, "Split upon putting Cube 2 in the clearer", "cube2");
    settings.Add("cube2transitionsplit", false, "Split upon transitioning to the second area", "cube2");
    settings.Add("cube3", true, "Cube 3");
    settings.Add("cube3fizzlersplit", true, "Split upon putting Cube 3 in the clearer", "cube3");
    settings.Add("cube3transitionsplit", false, "Split upon transitioning to the second area", "cube3");
    settings.Add("cube4", true, "Cube 4");
    settings.Add("cube4fizzlersplit", true, "Split upon putting Cube 4 in the clearer", "cube4");
    settings.Add("cube4transitionsplit", false, "Split upon transitioning to the second area", "cube4");
    settings.Add("cube5", true, "Cube 5");
    settings.Add("cube5fizzlersplit", true, "Split upon putting Cube 5 in the clearer", "cube5");
    settings.Add("cube5transitionsplit", false, "Split upon transitioning to the second area", "cube5");
    settings.Add("cube6", true, "Cube 6");
    settings.Add("cube6fizzlersplit", true, "Split upon putting Cube 6 in the clearer", "cube6");
    settings.Add("cube6transitionsplit", false, "Split upon transitioning to the second area", "cube6");
    settings.Add("cube7", true, "Cube 7");
    settings.Add("cube7fizzlersplit", true, "Split upon putting Cube 7 in the clearer", "cube7");
    settings.Add("cube7transitionsplit", false, "Split upon transitioning to the second area", "cube7");
    settings.Add("cube8fizzlersplit", true, "Cube 8");

    vars.SplitCount = 0;
}

start
{
    return current.playerX != old.playerX && current.playerX == -200f && current.playerY != old.playerY && current.playerY == 1150f;
}

split
{
    foreach (var split in vars.Splits)
    {
        if (split.Value(old, current)){
            return settings[split.Key];
        }
    }
    if(old.doorAnimationProgress != current.doorAnimationProgress && current.doorAnimationProgress < 0f && current.isLoading == true && current.levelName == "/Game/Maps/LevelHub1")
    {
        vars.SplitCount++;
    }
}
