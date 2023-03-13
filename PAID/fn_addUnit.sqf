/*
Adds a validated unit to the selected global array.

PARAMETERS:
	OBJECT _unit - The unit to add
	NUMBER _array - 0:doStop, 1:disableAIPATH

RETURNS:
	None
*/

#define NOT_OBJECT typeName _unit isNotEqualTo "OBJECT"
#define NOT_UNIT !(_unit isKindOf "Man")
#define UNIT _this select 0

params ["_unit", "_array"];

if (!isServer) exitWith {};

if (NOT_OBJECT) exitWith {diag_log format["PAID - %1 unit type error", _unit];};
if (NOT_UNIT) exitWith {diag_log format["PAID - %1 unit value error", _unit];};

switch (_array) do {
	case 0: {
		[{!isNil "doStop_array"},  
		{ 
			doStop_array pushBack (UNIT); 
		}, [_unit]] call CBA_fnc_waitUntilAndExecute;
	};
	case 1: {
		[{!isNil "disableAIPATH_array"},  
		{ 
			disableAIPATH_array pushBack (UNIT); 
		}, [_unit]] call CBA_fnc_waitUntilAndExecute;
	};
	default {diag_log format["PAID - Unknown state %1 in {[%2, %3] call PAID_fnc_addUnit}", _array, _unit, _array];};
};