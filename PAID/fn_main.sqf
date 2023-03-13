/*
Manages doStop and disableAIPATH states.
When an inward defense event is created, manages that.

PARAMETERS:
	None

RETURNS:
	None
*/

if (!isServer) exitWith {};

PAID_inwardDefense_triggerIDs = createHashMap;
PAID_inwardDefense_isDefenseBypassed = createHashMap;
PAID_inwardDefense_friendlySides = [blufor]; //[blufor, opfor, independent]

call PAID_fnc_addDisableAIPATHHandler;
call PAID_fnc_addDoStopHandler;

[{
	count keys PAID_inwardDefense_triggerIDs > 0
}, {
	call PAID_fnc_addInwardDefenseHandler;
}, []] call CBA_fnc_waitUntilAndExecute;