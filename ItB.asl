/* Into the Breach Autosplitter (22-Apr-2020)
 * Created by R30hedron (@R30hedron#9520 on Discord)
 * With assistance from:
 * Lemonymous (@Lemonymous#6212 on Discord) for initial setup
 * Xenesis (@Xenesis#2625 on Discord) for verifying the autosplitter works for the GOG version.

 * Currently accurate up to Windows ItB version 1.2.21
 */

state("Breach")
{
    int runreset     : "fmodstudio.dll", 0x00101CB8, 0x0, 0x8, 0x21C, 0xC, 0x1C, 0x11C, 0x28;
    int runstart     : "fmodstudio.dll", 0x00101CB8, 0x578, 0x18;
    int missionsplit : "fmodstudio.dll", 0x00101CB8, 0x540, 0x8, 0x0, 0x34, 0xD4;
    int islandsplit  : "fmodstudio.dll", 0x00101CB8, 0x5DC, 0x18;
    int bossonesplit : "fmodstudio.dll", 0x00101CB8, 0x128, 0x18;
    int bosstwosplit : "fmodstudio.dll", 0x00101CB8, 0x318, 0x18;
}

/* Variable Info
 * [runreset]     : (FMOD) Triggers on entering hangar (New Game)
 * 
 * [runstart]     : (FMOD) Triggers on run start.
 * 
 * [missionsplit] : (FMOD) Triggers on mission complete screen
 * 
 * [islandsplit]  : (FMOD) Triggers on island zoom out
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
