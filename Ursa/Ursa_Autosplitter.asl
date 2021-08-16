state("Ursa-Win64-Shipping")
{
	bool  isTrackingTime  : 0x4005240, 0x130, 0x238, 0x0, 0x280, 0x3A0;
	float Time            : 0x4005240, 0x130, 0x238, 0x0, 0x280, 0x3A4;
	int   DataPadsCount   : 0x4005240, 0x188, 0x1B0;
	int   BeaconCount     : 0x4005240, 0x188, 0x1B8;
}

startup
{
	settings.Add("beacons", true, "Split when activating a beacon");
	settings.Add("datapads", true, "Split when reading a datapad");
}

start
{
	return !old.isTrackingTime && current.isTrackingTime && old.Time == 0f;
}

split
{
	return old.DataPadsCount < current.DataPadsCount && settings["datapads"] ||
	       old.BeaconCount < current.BeaconCount && settings["beacons"] ||
	       old.isTrackingTime && !current.isTrackingTime;
}

reset
{
	return old.isTrackingTime && !current.isTrackingTime && current.Time == 0f;
}

gameTime
{
	return TimeSpan.FromSeconds(current.Time);
}

isLoading
{
	return true;
}
