/*
Adds the execution to begin the inward collapse for a given group and _idName. 
Once PAID_fnc_addInwardDefenseHandler checks if an enemy is inside the trigger, the execution of the inward defense begins.

PARAMETERS:
	GROUP _group
	STRING _idName
	STRING / BOOLEAN _condition - Global variable name, true (BOOLEAN) by default

RETURNS:
	None
*/

if (!isServer) exitWith {};

#define P_group _this select 0
#define P_idName _this select 1
#define P_condition _this select 2
#define P_trigger _this select 3
#define CONDITION_DEFINED typeName (P_condition) isEqualTo "STRING"

params ["_group", "_idName", ["_condition", true]];

[{
	!isNil "PAID_inwardDefense_triggerIDs" && {count keys PAID_inwardDefense_triggerIDs > 0}
}, {
	private _trigger = PAID_inwardDefense_triggerIDs getOrDefault [P_idName, -1];
	if (_trigger isEqualTo -1) exitWith {diag_log format ["PAID - inwardDefenseID not found in {[%1, %2] call PAID_fnc_addGroupToInwardDefense}", P_group, P_idName];};

	{
		[_x, "PATH"] remoteExec ["disableAI", owner _x];
		private _EHID = _x addEventHandler ["Local", {
			params ["_entity", "_isLocal"];
			if (!_isLocal) exitWith {};
			_entity disableAI "PATH";
		}];
		_x setVariable ["PAID_EHID", _EHID, false];
	} forEach units (P_group);

	[{
		PAID_inwardDefense_isDefenseBypassed getOrDefault [P_idName, false] && {if (CONDITION_DEFINED) then {missionNamespace getVariable (P_condition);} else {true;}}
	}, {
		for "_i" from count waypoints (P_group) - 1 to 0 step -1 do {deleteWaypoint [(P_group), _i];};

		(P_group) addWaypoint [getPos (P_trigger), 25, 0, "MOVE"];
		(P_group) addWaypoint [getPos (P_trigger), 25, 1, "GUARD"];

		{
			private _EHID = _x getVariable "PAID_EHID";
			if (!isNil "_EHID") then {
				_x removeEventHandler ["Local", _EHID];
			};
			[_x, "PATH"] remoteExec ["enableAI", owner _x];
		} forEach units (P_group);
	}, [P_group, P_idName, P_condition, _trigger]] call CBA_fnc_waitUntilAndExecute;
}, [_group, _idName, _condition]] call CBA_fnc_waitUntilAndExecute;