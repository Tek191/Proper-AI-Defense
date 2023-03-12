/*
Adds validated units from the passed group to the selected global array.

PARAMETERS:
	GROUP _group - Origin group
	NUMBER _array - 0:doStop, 1:disableAIPATH

RETURNS:
	None
*/

#define NOT_GROUP typeName _group isNotEqualTo "GROUP"
#define GROUP_MEMBERS units (_this select 0)

params ["_group", "_array"];

if (!isServer) exitWith {};

if (NOT_GROUP) exitWith {diag_log format["PAID - %1 group type error", _group];};
/*Value validation not required as {units grpNull} returns []*/

if (_array isEqualTo 0) then {
	[{!isNil "doStop_array"},  
	{ 
		{doStop_array pushBack _x;} forEach GROUP_MEMBERS;
	}, [_group]] call CBA_fnc_waitUntilAndExecute;
} else {
	[{!isNil "disableAIPATH_array"},  
	{ 
		{disableAIPATH_array pushBack _x;} forEach GROUP_MEMBERS;
	}, [_group]] call CBA_fnc_waitUntilAndExecute;	
};