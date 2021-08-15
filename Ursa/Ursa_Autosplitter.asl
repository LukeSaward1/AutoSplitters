state("Ursa-Win64-Shipping")
{
    //             UrsaMiniMap.GameState.PlayerArray[0].PawnPrivate.time
    float igt    : 0x4005240, 0x130, 0x238, 0x0, 0x280, 0x3A4;

    //             UrsaMiniMap.UrsaGameInstance.datapads
    int datapads : 0x4005240, 0x188, 0x1B0;

    //             UrsaMiniMap.UrsaGameInstance.beacon
    int beacons  : 0x4005240, 0x188, 0x1B8;
}

startup
{
    settings.Add("beacons", true, "Split when activating a beacon");
    settings.Add("datapads", true, "Split when reading a datapad");;
}

start
{
    return old.igt == 0 && current.igt > 0;
}

split
{
    return old.datapads < current.datapads && settings["datapads"] ||
           old.beacons < current.beacons && settings["beacons"];
}

reset
{
    return old.igt == 0;
}

gameTime
{
    return TimeSpan.FromSeconds(current.igt);
}

isLoading
{
    return true;
}
