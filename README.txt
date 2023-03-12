Written by Tek

Version 1.0.0
12/03/2023
------------------------------------------------------------------------------------

Ensure you have the following files and folders in your mission directory:
<ROOT>/description.ext
<ROOT>/PAID

State: doStop
The AI will not move into formation and will remain stationary until they are aware of an enemy unit.
Then they will regain the ability to move.

State: disableAIPATH
The AI will not move into formation and will remain stationary until they are aware of an enemy who is within 20 meters.

Use the init of a unit or group to give them either state.
0 -> doStop 
1 -> disableAIPATH 

[this, STATE] call PAID_fnc_addUnit;
[this, STATE] call PAID_fnc_addGroup;

Example:
To add an entire group to have the state disableAIPATH, inside of the group's init field enter:
[this, 1] call PAID_fnc_addGroup;
