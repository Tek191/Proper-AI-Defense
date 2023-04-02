/*
Handles checking if friendlies have broken through any of the defined zones.
This is only called in fn_main after at least one zone is declared. Upon 
completion of all zones defined, the PFH is removed.

PARAMETERS:
	None

RETURNS:
	None
*/

#define DEFENSE_BYPASSED PAID_inwardDefense_isDefenseBypassed getOrDefault [_x, true]
#define P_friendlies _this select 0 select 0
#define PER_FRAME_HANDLER _this select 1
#define FRIENDLY_UNIT_IN_TRIGGER [P_friendlies, _trigger] call PAID_fnc_isInArea
#define ID_NAME keys PAID_inwardDefense_isDefenseBypassed

private _friendlies = [];
{_friendlies append units _x} forEach PAID_inwardDefense_friendlySides;

[{
	private _counter = 0;

	{
		if (DEFENSE_BYPASSED) then {continue;};
		_counter = _counter + 1;
		private _trigger = PAID_inwardDefense_triggerIDs getOrDefault [_x, objNull];

		if (FRIENDLY_UNIT_IN_TRIGGER) then {
			PAID_inwardDefense_isDefenseBypassed set [_x, true];
		};
	} forEach ID_NAME;

	if (_counter isEqualTo 0) then {
		[PER_FRAME_HANDLER] call CBA_fnc_removePerFrameHandler;
	};
}, 10, [_friendlies]] call CBA_fnc_addPerFrameHandler;