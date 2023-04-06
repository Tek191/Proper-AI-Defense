Written by Tek

Version 1.0.2
13/03/2023

REQUIRES: CBA_A3
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


Inward Defense:
The assigned AI will remain stationary until the defined units (by side) is present in the assigned trigger.
Then the AI will move towards the center of the trigger.
You may add an extra condition to be met for any specific group involved in the inward defense. They may all have no extra condition, or can even 
all have different extra conditions.

Example (No extra conditions):
[triggerA, "taskA"] call PAID_fnc_addInwardDefense;
[this, "taskA"] call PAID_fnc_addGroupToInwardDefense; //execute in group init
.
.
.
[this, "taskA"] call PAID_fnc_addGroupToInwardDefense; //execute in group init


Example (Extra conditions):
[triggerA, "taskA"] call PAID_fnc_addInwardDefense;
isReady = false;
[this, "taskA", "isReady"] call PAID_fnc_addGroupToInwardDefense; //execute in group init
[this, "taskA"] call PAID_fnc_addGroupToInwardDefense; //execute in group init

In this example the first group will not move into the trigger until the variable "isReady" has value of true.
