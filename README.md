# Into-the-Breach-Autosplitter
This is an Into the Breach autosplitter for Livesplit. 

For information on what an autosplitter is, go [here](https://github.com/LiveSplit/LiveSplit.AutoSplitters/blob/master/README.md). For information on ItB Speedruns, go [here](https://www.speedrun.com/itb/full_game).

This autosplitter should support ItB on Windows, regardless of storefront. If there are any issues, please notify R30hedron on Discord (@R30hedron#9529).

The following are implemented:

* Automatic Timer Starts
* Automatic Splits
    * Mission Completed
    * Island Secured
    * End of Phase 1 of the Last Stand
    * End of Phase 2 of the Last Stand
        * This split happens as soon as the Renfield Bomb animation starts at the end of Phase 2.
* Automatic Timer Resets
* Support for all Windows versions.

Please forward any feedback, questions, or concerns to R30hedron on Discord (@R30hedron#9529)

Special thanks to:
* Lemonymous for inital help with the autosplitter code
* Xenesis for verifying that the autosplitter works as expected for the GoG version of the game.

Changelog: 
* 1.3 (22-Apr-2020): All memory addresses have been updated to be version agnostic.
* 1.2.1 (22-Apr-2020): Updated (and verified) the addresses for ItB version 1.2.21
* 1.2 (13-Jun-2019): Implemented options for mission splits and an additional split on phase 1 for the final mission. Cleaned up most of the code to be more version agnostic.
* 1.1 (16-Mar-2019): Implemented a temporary md5 version check, fixed GoG version
* 1.0 (07-Mar-2019): First public release (ItB version 1.1.22)
