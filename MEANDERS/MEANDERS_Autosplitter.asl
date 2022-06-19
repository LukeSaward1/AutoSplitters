//do whatever with it
//Golzeb#0663
//LukeSaward1#6028

state("ISLE-Win64-Shipping", "Older Patch")
{
	int levelID: "ISLE-Win64-Shipping.exe", 0x03225A10, 0x30, 0x400, 0x7A0, 0x658, 0x184;
	float yPosition: "ISLE-Win64-Shipping.exe", 0x03226A80, 0x8, 0x8, 0xA0, 0x3D0, 0x288;
}
state("ISLE-Win64-Shipping", "1.09")
{
    int levelID: "ISLE-Win64-Shipping.exe", 0x2A27748, 0x140, 0x184;
	float yPosition: "ISLE-Win64-Shipping.exe", 0x2A27748, 0x140, 0x38, 0x0, 0x30, 0x370, 0x160, 0x164;
}

init {
    int mms = modules.First().ModuleMemorySize;
    switch (mms) {
        case 0x2E22000: version = "1.09"; break;
        default: version = "Unknown"; break;
    }
}

start
{
    return current.yPosition != 37495.15234f && old.yPosition == 37495.15234f;
}

reset
{
    return current.yPosition == 37495.15234f && old.yPosition == 37495.15234f;
} 	
 
split
{
	return current.levelID != 0 && current.levelID != old.levelID || current.yPosition > 22200.0f && current.levelID == 39;
}