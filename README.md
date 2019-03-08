# Into-the-Breach-Autosplitter
This is an Into the Breach autosplitter for Livesplit.

It supports ItB version 1.1.22, for all three major distribution platforms (Steam, GoG, and Humble Store). Please look at the autosplitter options to ensure you have the right platform enabled.

As of version 1.0 the following are implemented:

* Automatic Timer Starts
* Automatic Splits
    * Island Secured
    * End of Game
        * This split happens as soon as the Renfield Bomb animation starts at the end of Phase 2.
* Automatic Timer Resets
* Support for all three versions (Steam, GoG, Humble)


To Do:
* Find a way to correctly set the version without requiring the user to set it manually.
    * Cannot use MainModuleSize, since all three versions have the same module size
    * Cannot use FileVersion, since there is no version attached to Breach.exe
    * Will probably have to use MD5, but that's clunky and not futureproof.

Please forward any feedback, questions, or concerns to R30hedron on Discord (@R30hedron#9529)

Special thanks to:
Lemonymous for help with the autosplitter code
Xenesis for finding GoG version addresses

Changelog: 
1.0 (7-Mar-2019): First public release (ItB version 1.1.22)
