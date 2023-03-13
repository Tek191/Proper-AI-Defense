/*
Maps _trigger onto _idName in PAID_inwardDefense_triggerIDs

PARAMETERS:
	TRIGGER _trigger
	STRING _idName

RETURNS:
	None
*/

if (!isServer) exitWith {};

#define P_trigger _this select 0
#define P_idName _this select 1

params ["_trigger", "_idName"];

[{!isNil "PAID_inwardDefense_triggerIDs"}, {
	PAID_inwardDefense_triggerIDs set [P_idName, P_trigger];
	PAID_inwardDefense_isDefenseBypassed set [P_idName, false];
}, [_trigger, _idName]] call CBA_fnc_waitUntilAndExecute;