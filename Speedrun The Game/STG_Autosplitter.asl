state("SpeedrunGame-Win64-Shipping", "1.0")
{

}
state("SpeedrunGame-Win64-Shipping", "1.0.1")
{

}
state("SpeedrunGame-Win64-Shipping", "2.0")
{
    bool isTimerRunning: "SpeedrunGame-Win64-Shipping.exe", 0x2DC7CB0, 0x140, 0x3F0;
    int mins: "SpeedrunGame-Win64-Shipping.exe", 0x2DC7CB0, 0x140, 0x3F4;
    int secs: "SpeedrunGame-Win64-Shipping.exe", 0x2DC7CB0, 0x140, 0x3F8;
    int ms: "SpeedrunGame-Win64-Shipping.exe", 0x2DC7CB0, 0x140, 0x3Fc;
}

init {
    int mms = modules.First().ModuleMemorySize;
    print("MMS: " + mms.ToString("X"));
    switch (mms) {
        // case 0x2E22000: version = "1.0"; break;
        // case 0x2E22000: version = "1.0.1"; break;
        case 0x30B0000: version = "2.0"; break;
    }
}

startup 
{
    settings.Add("split_each_level", false, "Split upon completing each level");
    settings.Add("il_mode", false, "IL Mode");
}

start
{
    return current.isTimerRunning != old.isTimerRunning && current.isTimerRunning == true;
}

reset
{

} 	
 
split
{
    return current.isTimerRunning != old.isTimerRunning && current.isTimerRunning == false;
}

gameTime
{
    if(current.isTimerRunning == true) {
        if(!settings["il_mode"]) {
            float min = (float)current.mins;
            float sec = (float)current.secs;
            float mili = (float)current.ms/1000;
            TimeSpan.FromMinutes(min + sec * 60 + mili * 6000);
        }
        else 
        {
            return new TimeSpan(0, 0, current.mins, current.secs, current.ms);
        }
    }
}