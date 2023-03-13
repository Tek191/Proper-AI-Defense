/*
Checks if units are in area

PARAMETERS:
	ARRAY _units 
	MARKER / OBJECT / LOCATION _area 

RETURNS:
	BOOLEAN 
*/

params ["_units", "_area"];
if (_units findIf {_x inArea _area} isNotEqualTo -1) exitWith {true;};
false;