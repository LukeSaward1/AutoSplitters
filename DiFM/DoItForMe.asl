state("Do It For Me V1.0.1", "v1.0.1")
{
  float igt : "UnityPlayer.dll", 0x1469F30, 0x10, 0x3A8, 0x140;
  byte puppetGiven : "UnityPlayer.dll", 0x1469F30, 0x358, 0x80, 0x9B;
  byte awakeGiven : "UnityPlayer.dll", 0x1469F30, 0x358, 0x80, 0x9C;
  byte psychoGiven : "UnityPlayer.dll", 0x1469F30, 0x358, 0x80, 0x9D;
  byte innocentLoveGiven : "UnityPlayer.dll", 0x1469F30, 0x358, 0x80, 0x9E;
  byte blindLoveGiven : "UnityPlayer.dll", 0x1469F30, 0x358, 0x80, 0x9F;
  int endingCount : "UnityPlayer.dll", 0x1469F30, 0x10, 0x3A8, 0x15C;
  string128 sceneName : "UnityPlayer.dll", 0x1469F30, 0x10, 0x3A8, 0x28, 0x14;
}

startup
{
    settings.Add("endings_list", true, "Endings");
    settings.Add("puppet_ending", true, "Puppet Ending", "endings_list");
    settings.Add("blindlove_ending", true, "Blind Love Ending", "endings_list");
    settings.Add("awake_ending", true, "Awake Ending", "endings_list");
    settings.Add("innocentlove_ending", true, "Innocent Love Ending", "endings_list");
    settings.Add("psychopath_ending", true, "Psychopath Ending", "endings_list");
    settings.Add("all_endings", false, "All Endings", "endings_list");
    
    settings.Add("sections_list", true, "Sections");
    settings.Add("section1", true, "Section 1", "sections_list");
    settings.Add("section2", true, "Section 2", "sections_list");
    settings.Add("section3", true, "Section 3", "sections_list");
    settings.Add("section4", true, "Section 4", "sections_list");

    settings.Add("extras", true, "Extras");
    settings.Add("first_cutscene", true, "Split on finishing first cutscene", "extras");
    vars.timerModel = new TimerModel { CurrentState = timer };
}

init
{
  // MD5 code by CptBrian.
  string MD5Hash;
  using (var md5 = System.Security.Cryptography.MD5.Create())
        using (var s = File.Open(modules.First().FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
            MD5Hash = md5.ComputeHash(s).Select(x => x.ToString("X2")).Aggregate((a, b) => a + b);
    print("MD5Hash: " + MD5Hash);
        switch (MD5Hash) {
        case "D63AA032D5D3BD2ECC90CB103D8A5E50": version = "v1.0.1"; break;
    }
}

start{
  return current.igt > old.igt && old.igt == 0f;
}
split{
  return false;
}

update {
  if(current.sceneName == "Level2" && old.sceneName == "Level1" && settings["section1"] && settings.SplitEnabled) // Level1 Split
  {
    vars.timerModel.Split();
  }
  if(current.sceneName == "Level3" && old.sceneName == "Level2" && settings["section2"] && settings.SplitEnabled) // Level2 Split
  {
    vars.timerModel.Split();
  }
  if(current.sceneName == "Level4" && old.sceneName == "Level3" && settings["section3"] && settings.SplitEnabled) // Level3 Split
  {
    vars.timerModel.Split();
  }
  if(current.sceneName == "Ending0Awake" && old.sceneName == "Level4" && settings["section4"] && settings.SplitEnabled)  // Hallway Split (Awake)
  {
    vars.timerModel.Split();
  }
  if(current.sceneName == "Ending1Puppet" && old.sceneName == "Level4" && settings["section4"] && settings.SplitEnabled) // Hallway Split (Puppet)
  {
    vars.timerModel.Split();
  }
  if(current.sceneName == "Ending2BlindLove" && old.sceneName == "Level4" && settings["section4"] && settings.SplitEnabled) // Hallway Split (Blind Love)
  {
    vars.timerModel.Split();
  }
  if(current.sceneName == "Ending3Psychopath" && old.sceneName == "Level4" && settings["section4"] && settings.SplitEnabled) // Hallway Split (Psychopath)
  {
    vars.timerModel.Split();
  }
  if(current.sceneName == "Ending4TrueLove" && old.sceneName == "Level4" && settings["section4"] && settings.SplitEnabled) // Hallway Split (Innocent Love)
  {
    vars.timerModel.Split();
  }
  if(current.awakeGiven == 1 && current.awakeGiven != old.awakeGiven && old.awakeGiven == 0 && settings["awake_ending"] && settings.SplitEnabled) // Awake Ending Split
  {
    vars.timerModel.Split();
  }
  if(current.puppetGiven == 1 && current.puppetGiven != old.puppetGiven && old.puppetGiven == 0 && settings["puppet_ending"] && settings.SplitEnabled) // Puppet Ending Split
  {
    vars.timerModel.Split();
  }
  if(current.blindLoveGiven == 1 && current.blindLoveGiven != old.blindLoveGiven && old.blindLoveGiven == 0 && settings["blindlove_ending"] && settings.SplitEnabled) // Blind Love Ending Split
  {
    vars.timerModel.Split();
  }
  if(current.psychoGiven == 1 && current.psychoGiven != old.psychoGiven && old.psychoGiven == 0 && settings["puppet_ending"] && settings.SplitEnabled) // Psychopath Ending Split
  {
    vars.timerModel.Split();
  }
  if(current.innocentLoveGiven == 1 && current.innocentLoveGiven != old.innocentLoveGiven && old.innocentLoveGiven == 0 && settings["innocentlove_ending"] && settings.SplitEnabled) // Innocent Love Ending Split
  {
    vars.timerModel.Split();
  }
  if(current.innocentLoveGiven == 1 && current.innocentLoveGiven != old.innocentLoveGiven && old.innocentLoveGiven == 0 && settings["innocentlove_ending"] && settings.SplitEnabled) // Innocent Love Ending Split
  {
    vars.timerModel.Split();
  }
  if(current.endingCount == 5 && current.endingCount != old.endingCount && old.endingCount == 4 && settings["all_endings"] && settings.SplitEnabled) // All Endings Split
  {
    vars.timerModel.Split();
  }
  if(current.sceneName == "Level1" && old.sceneName == "FirstCutscene" && settings["first_cutscene"] && settings.SplitEnabled) // First Cutscene Split
  {
    vars.timerModel.Split();
  }
}

reset {
  return current.igt == 0f && old.igt > 0f;
}

isLoading{
  return true;
}

gameTime{
  return TimeSpan.FromSeconds(current.igt);
}