/* Into the Breach Autosplitter (22-Apr-2020)
 * Created by R30hedron (@R30hedron#9520 on Discord)
 * With assistance from Lemonymous (@Lemonymous#6212 on Discord)
 * Special thanks to Xenesis for the GoG version addresses (@Xenesis#2625 on Discord)

 * Currently accurate for Windows ItB version 1.1.22 and 1.2.21
 * Future versions of ItB should still function as expected, but auto-resets will be disabled.
 */

state("Breach", "Steam 1.1.22")
{
    int runreset     : "Breach.exe", 0x39AAF0;
    int runstart     : "fmodstudio.dll", 0x00101CB8, 0x578, 0x18;
    int missionsplit : "fmodstudio.dll", 0x00101CB8, 0x540, 0x8, 0x0, 0x34, 0xD4;
    int islandsplit  : "fmodstudio.dll", 0x00101CB8, 0x5DC, 0x18;
    int bossonesplit : "fmodstudio.dll", 0x00101CB8, 0x128, 0x18;
    int bosstwosplit : "fmodstudio.dll", 0x00101CB8, 0x318, 0x18;
}

state("Breach", "Humble 1.1.22")
{
    int runreset     : "Breach.exe", 0x39AA00;
    int runstart     : "fmodstudio.dll", 0x00101CB8, 0x578, 0x18;
    int missionsplit : "fmodstudio.dll", 0x00101CB8, 0x540, 0x8, 0x0, 0x34, 0xD4;
    int islandsplit  : "fmodstudio.dll", 0x00101CB8, 0x5DC, 0x18;
    int bossonesplit : "fmodstudio.dll", 0x00101CB8, 0x128, 0x18;
    int bosstwosplit : "fmodstudio.dll", 0x00101CB8, 0x318, 0x18;
}

state("Breach", "GoG 1.1.22")
{
    int runreset     : "Breach.exe", 0x39ACC0;
    int runstart     : "fmodstudio.dll", 0x00101CB8, 0x578, 0x18;
    int missionsplit : "fmodstudio.dll", 0x00101CB8, 0x540, 0x8, 0x0, 0x34, 0xD4;
    int islandsplit  : "fmodstudio.dll", 0x00101CB8, 0x5DC, 0x18;
    int bossonesplit : "fmodstudio.dll", 0x00101CB8, 0x128, 0x18;
    int bosstwosplit : "fmodstudio.dll", 0x00101CB8, 0x318, 0x18;
}

state("Breach", "Steam 1.2.21")
{
    int runreset     : "Breach.exe", 0x44387C;
    int runstart     : "fmodstudio.dll", 0x00101CB8, 0x578, 0x18;
    int missionsplit : "fmodstudio.dll", 0x00101CB8, 0x540, 0x8, 0x0, 0x34, 0xD4;
    int islandsplit  : "fmodstudio.dll", 0x00101CB8, 0x5DC, 0x18;
    int bossonesplit : "fmodstudio.dll", 0x00101CB8, 0x128, 0x18;
    int bosstwosplit : "fmodstudio.dll", 0x00101CB8, 0x318, 0x18;
}

state("Breach", "Humble 1.2.21")
{
    int runreset     : "Breach.exe", 0x4427D4;
    int runstart     : "fmodstudio.dll", 0x00101CB8, 0x578, 0x18;
    int missionsplit : "fmodstudio.dll", 0x00101CB8, 0x540, 0x8, 0x0, 0x34, 0xD4;
    int islandsplit  : "fmodstudio.dll", 0x00101CB8, 0x5DC, 0x18;
    int bossonesplit : "fmodstudio.dll", 0x00101CB8, 0x128, 0x18;
    int bosstwosplit : "fmodstudio.dll", 0x00101CB8, 0x318, 0x18;
}

state("Breach", "GoG 1.2.21")
{
    int runreset     : "Breach.exe", 0x443A8C;
    int runstart     : "fmodstudio.dll", 0x00101CB8, 0x578, 0x18;
    int missionsplit : "fmodstudio.dll", 0x00101CB8, 0x540, 0x8, 0x0, 0x34, 0xD4;
    int islandsplit  : "fmodstudio.dll", 0x00101CB8, 0x5DC, 0x18;
    int bossonesplit : "fmodstudio.dll", 0x00101CB8, 0x128, 0x18;
    int bosstwosplit : "fmodstudio.dll", 0x00101CB8, 0x318, 0x18;
}

state("Breach", "Unknown Version")
{
    //int runreset   : null;
    int runstart     : "fmodstudio.dll", 0x00101CB8, 0x578, 0x18;
    int missionsplit : "fmodstudio.dll", 0x00101CB8, 0x540, 0x8, 0x0, 0x34, 0xD4;
    int islandsplit  : "fmodstudio.dll", 0x00101CB8, 0x5DC, 0x18;
    int bossonesplit : "fmodstudio.dll", 0x00101CB8, 0x128, 0x18;
    int bosstwosplit : "fmodstudio.dll", 0x00101CB8, 0x318, 0x18;
}

/* Variable Info
 * [runreset] : stores game state relative to the hangar screen
 * 0: Main Menu or in-game
 * 1: Hangar / Squad Selection
 *     NOTE: If you win a game, this stays at 0, even at the hangar.
 *     This is used to auto-reset the timer; only works for ItB 1.1.22, and is version specific.
 * 2: Game Start
 * 
 * [runstart] : (FMOD) Triggers on run start.
 * 
 * [missionsplit] : (FMOD) Triggers on mission complete screen
 * 
 * [islandsplit] : (FMOD) Triggers on island zoom out
 * 
 * [bossonesplit] : (FMOD) Triggers on end of final mission phase 1
 * 
 * [bosstwosplit] : (FMOD) Triggers on end of final mission phase 2
 *     Used as end of timer for Any% runs
 */

update
{
    //runs at all times when the game is running
    //print("update");
}

init
{
    //runs once when starting ItB.
    //print("init");
    
    //md5 checksum code pulled from Zment's Defy Gravity autosplitter
    //Legacy code used here for auto resets
    
    byte[] exeMD5HashBytes = new byte[0];
    using (var md5 = System.Security.Cryptography.MD5.Create())
    {
        using (var s = File.Open(modules.First().FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
        {
            exeMD5HashBytes = md5.ComputeHash(s);
        }
    }
    
    var MD5Hash = exeMD5HashBytes.Select(x => x.ToString("X2")).Aggregate((a, b) => a + b);
    print("MD5: " + MD5Hash);
    
    
    switch (MD5Hash)
    {
        case "ADF9B1685400A71D9DEAB09DFCBC8A8D":
            version = "Steam 1.1.22";
            break;
        case "6A0C765E5A7345E0B4D02484696A5CAD":
            version = "Humble 1.1.22";
            break;
        case "D32DF55423EB55621FDFE9CE6708B596":
            version = "GoG 1.1.22";
            break;
        case "82076CF44431A7A1F79E50DABA122143":
            version = "Steam 1.2.21";
            break;
        case "8C4F4DB4DD7207B8DBA51EFCF2FD57E3":
            version = "Humble 1.2.21";
            break;
        case "DE72A8A18C4AE8F6F49108086771B29D":
            version = "GoG 1.2.21";
            break;
        default:
            version = "Unknown Version";
            break;
    }
}

startup
{
    //runs when starting livesplit
    //options added here
    //print("startup);
    
    settings.Add("mission", false, "Mission Splits");
    settings.SetToolTip("mission", "Enable splits when missions are completed.");
    
    settings.Add("island", true, "Island Splits");
    settings.SetToolTip("island", "Enable splits when islands are secured.");
    
    settings.Add("phaseone", false, "Final Mission Phase 1 Split");
    settings.SetToolTip("phaseone", "Enable an additional split at the end of the first phase of the final mission.");
    
    //variable to store current mission
    vars.missions = 0;
    //variable to store current island
    vars.islands = 0;
}

reset
{
    //runs repeatedly when timer is running
    //if true, reset splitter
    //print("reset");
    
    if (old.runreset != 1 && current.runreset == 1)
    {
        print("reset");
        return true;
    }
}

start
{
    //runs repeatedly when timer is at 0.0 and ready to start
    //if true, splitter will start
    //print("start");
    
    if (old.runstart == 0 && current.runstart == 1)
    {
        print("run start");
        vars.missions = 0;
        vars.islands = 0;
        return true;
    }
}

split
{
    //runs repeatedly when timer is running
    //if true, split
    
    //mission splits
    if (old.missionsplit == 0 && current.missionsplit == 1)
    {
        vars.missions = vars.missions + 1;
        print("mission:" + vars.missions + " island:" + vars.islands);
        if (settings["mission"] && vars.missions < 5)
        {
            print("mission split");
            return true;
        }
    }
    
    //island splits
    if (old.islandsplit == 0 && current.islandsplit == 1)
    {
        vars.missions = 0;
        vars.islands = vars.islands + 1;
        print("mission:" + vars.missions + " island:" + vars.islands);
        if (settings["island"])
        {
            print("island split");
            return true;
        }
    }
    
    //final mission splits
    if (old.bossonesplit == 0 && current.bossonesplit == 1)
    {
        if (settings["phaseone"])
        {
            print("phase one split");
            return true;
        }
    }
    
    if (old.bosstwosplit == 0 && current.bosstwosplit == 1)
    {
        print("phase two split");
        return true;
    }
    
    //timeline splits (used only for non-Any% runs)
    if (old.runstart == 0 && current.runstart == 1)
    {
        print("timeline start");
        vars.missions = 0;
        vars.islands = 0;
    }
}

exit
{
    //runs when ItB closes down
}

shutdown
{
    //runs when livesplit closes down
    //print("shutdown");
}
