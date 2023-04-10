/*
Creates a statemachine to manage units under the 'disableAI "PATH"' state.

PARAMETERS:
	None

RETURNS:
	None
*/

#define UNIT_NOT_SIMULATED !(simulationEnabled _this)
#define UNIT_DEAD !alive _this
#define UNIT_AWARE_OF_ENVELOPMENT _this findNearestEnemy _this isNotEqualTo objNull && {_this distance (_this findNearestEnemy _this) <= 20}

private _stateMachine = [{allUnits select {_x getVariable ["PAID_disableAIPATH", false];}}, true] call CBA_statemachine_fnc_create;
private _q1 = [_stateMachine, {}, {}, {}, "q1"] call CBA_statemachine_fnc_addState;
private _q2 = [_stateMachine, {}, {}, {}, "q2"] call CBA_statemachine_fnc_addState;
private _q3 = [_stateMachine, {}, {}, {}, "q3"] call CBA_statemachine_fnc_addState;

[_stateMachine, "q1", "q2", {true}, {
	[_this, "PATH"] remoteExec ["disableAI", owner _this];
}, "q1_q2"] call CBA_statemachine_fnc_addTransition;

[_stateMachine, "q2", "q2", {UNIT_NOT_SIMULATED}, {
}, "q2_q2_1"] call CBA_statemachine_fnc_addTransition;

[_stateMachine, "q2", "q3", {UNIT_DEAD}, {
}, "q2_q3_1"] call CBA_statemachine_fnc_addTransition;

[_stateMachine, "q2", "q3", {UNIT_AWARE_OF_ENVELOPMENT}, {
	private _EHID = _this getVariable "PAID_EHID";
	if (!isNil "_EHID") then {
		_this removeEventHandler ["Local", _EHID];
	};
	[_this, "PATH"] remoteExec ["enableAI", owner _this];
}, "q2_q3_2"] call CBA_statemachine_fnc_addTransition;