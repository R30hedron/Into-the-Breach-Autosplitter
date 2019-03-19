/* Into the Breach Autosplitter (19-Mar-2019)
 * Created by R30hedron (@R30hedron#9520 on Discord)
 * With assistance from Lemonymous (@Lemonymous#6212 on Discord)
 * Special thanks to Xenesis for the GoG version addresses (@Xenesis#2625 on Discord)

 * Currently accurate for Windows ItB version 1.1.22 (Steam, Humble, and GoG)
 */


state("Breach", "Steam")
{
    //int island : "Breach.exe", 0x0039D824, 0x28, 0x0, 0x148; Unstable --R30
    int island : "Breach.exe", 0x39AC58, 0x3D60;
    int hangar : "Breach.exe", 0x39AAF0;
    int endAnim : "fmodstudio.dll", 0x101CB8, 0x318, 0x40;
}

state("Breach", "Humble")
{
    int island : "Breach.exe", 0x39AB68, 0x3D60;
    int hangar : "Breach.exe", 0x39AA00;
    int endAnim : "fmodstudio.dll", 0x101CB8, 0x318, 0x40;
}

state("Breach", "GoG")
{
    int island : "Breach.exe", 0x39AE28, 0x3D60;
    int hangar : "Breach.exe", 0x39ACC0;
    int endAnim : "fmodstudio.dll", 0x101CB8, 0x318, 0x40;
}

/* Variable Info:
 * [island] stores number of completed islands.
 * [hangar] stores gamestate relative to the squad select screen
 * 0: Main Menu or in-game
 * 1: Hangar / Squad selection
 *     NOTE: If you win a game, this stays at 0, even at the hangar.
 * 2: Game Start
 * [endAnim] stores gamestate relative to the ending cutscene
 * 1: Renfield Bomb explosion cutscene active
 * endAnim is identical between Steam and non-Steam releases.
 *
 * Logic:
 * Start when hangar is equal to 2
 * Reset when hangar changes from !1 -> 1
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
    
    //md5 checksum code pulled from Zment's Defy Gravity autosplitter
    
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
            version = "Steam";
            break;
        case "6A0C765E5A7345E0B4D02484696A5CAD":
            version = "Humble";
            break;
        case "D32DF55423EB55621FDFE9CE6708B596":
            version = "GoG";
            break;
        default:
            MessageBox.Show(timer.Form,
            "ItB Autosplitter startup failure:\n\n"
            + "Unknown version. Only supports ItB v1.1.22.\n"
            + "Please message @R30hedron#9520 on Discord with what version you are using.\n"
            + "Important number: " + MD5Hash,
            "ItB Autosplitter Unknown Version",
            MessageBoxButtons.OK,
            MessageBoxIcon.Error);
            break;
    }
}

startup
{
    // runs when starting livesplit.
    // add options here.
    // print("startup");
    
    settings.Add("Island Splits", true, "Island Splits");
    settings.SetToolTip("Island Splits", "Enable splits when islands are secured.\nThis will automatically disable auto-resets for running All Squads%");
    
    
    //settings.Add("Steam Version", true, "Steam Version");
    //settings.SetToolTip("Steam Version", "Enable if you are running the Steam version of the game.");
    //settings.Add("GoG Version", false, "GoG Version");
    //settings.SetToolTip("GoG Version", "Enable if you are running the GoG version of the game.");
    
    // NOTE: 3 Islands option was removed from here, since there are currently no 3 island any% runs
    /* settings.Add("4 Islands", false, "4 Islands", "Island Splits");
     * settings.SetToolTip("4 Islands", "Enable if running a 4-Island category.");
     */
     
    //variable to store current island
    //Needed, since island loses the correct pointer if the player goes into the main menu, or rarely during turn resets.
    //This will remain static even if ItB crashes or accidentally closed.
    vars.secured = 0;
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
    
    if (settings["Island Splits"] && (old.hangar != 1 && current.hangar == 1))
    {
        vars.secured = 0;
        return true;
    }
}

split
{
    // runs repeatedly when the timer is running.
    // returning true advances to the next split.
    print("island:" + current.island + " secured:" + vars.secured);
    print("hangar=" + current.hangar + " endAnim=" + current.endAnim);
	
    if (settings["Island Splits"] && (vars.secured + 1 == current.island)){
        vars.secured = vars.secured + 1;
        return true;
    }
    
    if (old.endAnim == 0 && current.endAnim == 1)
    {
        vars.secured = 0;
        return true;
    }
}

exit
{
    //Runs once when ItB closes down
}

shutdown
{
    // runs when livesplit closes down.
    // print("shutting down...");
}
