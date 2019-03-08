/* Into the Breach Autosplitter (07-Mar-2019)
 * Created by R30hedron (@R30hedron#9520 on Discord)
 * With assistance from Lemonymous (@Lemonymous#6212 on Discord)
 * Special thanks to Xenesis for the GoG version addresses (@Xenesis#2625 pn Discord)

 * Currently accurate for Windows ItB version 1.1.22 (Steam, Humble, and GoG)
 */


state("Breach", "Steam")
{
	//int island : "Breach.exe", 0x0039D824, 0x28, 0x0, 0x148; Unstable --R30
    int island : "Breach.exe", 0x39AC58, 0x3D60;
    // island stores number of completed islands.
    // NOTE: Currently doesn't work for some reason... Seems to depend on what computer the splitter is used on. --R30
    
    int hangar : "Breach.exe", 0x39AAF0;
    // hangar stores gamestate relative to the squad select screen
    // 0: Main Menu or in-game
    // 1: Hangar / Squad selection
    //     NOTE: If you win a game, this stays at 0, even at the hangar. --R30
    // 2: Game Start
    
    int endAnim : "fmodstudio.dll", 0x101CB8, 0x318, 0x40;
    // endAnim stores gamestate relative to the ending cutscene
    // 1: Renfield Bomb explosion cutscene active
}

state("Breach", "Humble")
{
    int island : "Breach.exe", 0x39AB68, 0x3D60;
    int hangar : "Breach.exe", 0x39AA00;
    int endAnim : "fmodstudio.dll", 0x101CB8, 0x318, 0x40;
    //endAnim is identical between Steam and non-Steam releases. --R30
}

state("Breach", "GoG")
{
    int island : "Breach.exe", 0x39AE28, 0x3D60;
    int hangar : "Breach.exe", 0x39ACC0;
    int endAnim : "fmodstudio.dll", 0x101CB8, 0x318, 0x40;
    //endAnim is identical between Steam and non-Steam releases. --R30
}

/* Logic:
 * Start when hangar is equal to 2
 * Reset when hangar changes from 0 -> 1
 * Split when 
 *     island increases
 *     when endAnim changes from 0 -> 1
 */

update
{
	// runs at all times when the game is running.
	// print("update");
}

init
{
	// runs once at when starting ITB.
    // print("init");
    
    //if (MD5Hash == "3f8163dc3447de135854a61c8c88357e") version = "Standalone";
    //if (MD5Hash == "ebac5d0edba6c2ebbbba77e396a31625") version = "Steam";
    
    if(settings["Steam Version"])
    {
        version = "Steam";
    }
    /* else if (settings["GoG Version"])
    {
        version = "GoG";
    }*/
    else
    {
        version = "Humble";
    }
    
}

startup
{
	// runs when starting livesplit.
	// add options here.
	// print("startup");
    
    settings.Add("Island Splits", true, "Island Splits");
    settings.SetToolTip("Island Splits", "Enable splits when islands are secured.\nIf you are running All Squads%, please\ndisable both this and automatic Resets.");
    
    
    settings.Add("Steam Version", true, "Steam Version");
    settings.SetToolTip("Steam Version", "Enable if you are running the Steam version of the game.");
    //settings.Add("GoG Version", false, "GoG Version");
    //settings.SetToolTip("GoG Version", "Enable if you are running the GoG version of the game.");
    
    // NOTE: I removed the 3 Islands option here, since there are currently no 3 island any% runs --R30
    /* settings.Add("4 Islands", false, "4 Islands", "Island Splits");
     * settings.SetToolTip("4 Islands", "Enable if running a 4-Island category.");
     */
}

start
{
	// this runs repeatedly when splitter is on 0.0 and ready to start.
	// if returning true, splitter will start.
	// print("start");
	
	if (current.hangar == 2)
	{
		return true;
	}
}

reset
{
    // this runs repeatedly when timer is running.
    // if returning true, splitter resets
    // print("reset");
    
    if (old.hangar != 1 && current.hangar == 1)
    {
        return true;
    }
}

split
{
	// runs repeatedly when the timer is running.
	// returning true advances to the next split.
	// print("island=" + current.island + " hangar=" + current.hangar + " endAnim=" + current.endAnim);
	
    if (settings["Island Splits"] && (old.island < current.island)){
        return true;
    }
    
	if (old.endAnim == 0 && current.endAnim == 1)
	{
		return true;
	}
}

shutdown
{
	// runs when livesplit closes down.
	// print("shutting down...");
}