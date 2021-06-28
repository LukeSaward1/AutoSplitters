state("Neave-Win64-Shipping")
{
    int   cube               : 0x3478A28, 0x8, 0xD0;
    int   resets               : 0x345B5D8, 0xBB8;
    float igt                    : 0x34B8280, 0xD0, 0x3A8, 0xC0, 0x30, 0x30, 0x398, 0x360;
}

startup
{
    settings.Add("cubesplits", true, "Split when touching a cube");

    vars.timerModel = new TimerModel { CurrentState = timer };
}

start
{
    return current.resets > old.resets;
}

split
{
    return
        current.cube > old.cube && settings["cubesplits"];
}

reset
{
    return current.resets > old.resets && current.cube == 0;
}

gameTime
{
    return TimeSpan.FromSeconds(current.igt);
}

exit
{
    vars.timerModel.Reset();
}