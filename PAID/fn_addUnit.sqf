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

params ["_unit", "_array"];

if (!(isServer || !hasInterface)) exitWith {};

if (NOT_OBJECT) exitWith {diag_log format["PAID - %1 unit type error", _unit];};
if (NOT_UNIT) exitWith {diag_log format["PAID - %1 unit value error", _unit];};

switch (_array) do {
	case 0: { 
		_unit setVariable ["PAID_doStop", true, false];

		private _EHID = _unit addEventHandler ["Local", {
			params ["_entity", "_isLocal"];
			if (!_isLocal) exitWith {};
			_entity disableAI "PATH";
		}];
		_unit setVariable ["PAID_EHID", _EHID, false];
	};
	case 1: {
		_unit setVariable ["PAID_disableAIPATH", true, false];

		private _EHID = _unit addEventHandler ["Local", {
			params ["_entity", "_isLocal"];
			if (!_isLocal) exitWith {};
			_entity disableAI "PATH";
		}];
		_unit setVariable ["PAID_EHID", _EHID, false];
	};
	default {diag_log format["PAID - Unknown state %1 in {[%2, %3] call PAID_fnc_addUnit}", _array, _unit, _array];};
};