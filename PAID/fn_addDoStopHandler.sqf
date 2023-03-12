/*
Creates a statemachine to manage units under the doStop state.

PARAMETERS:
	None

RETURNS:
	None
*/

#define ARRAY_EMPTY doStop_array isEqualTo []
#define ARRAY_NOT_EMPTY doStop_array isNotEqualTo []
#define UNIT_NOT_SIMULATED !(simulationEnabled _this)
#define UNIT_DEAD !alive _this
#define UNIT_IN_COMBAT _this findNearestEnemy _this isNotEqualTo objNull

doStop_array = [];

[{ARRAY_NOT_EMPTY}, {
	private _stateMachine = [doStop_array, true] call CBA_statemachine_fnc_create;
	private _q1 = [_stateMachine, {}, {}, {}, "q1"] call CBA_statemachine_fnc_addState;
	private _q2 = [_stateMachine, {}, {}, {}, "q2"] call CBA_statemachine_fnc_addState;
	private _q3 = [_stateMachine, {}, {}, {}, "q3"] call CBA_statemachine_fnc_addState;

	[_stateMachine, "q1", "q2", {true}, {
		_this disableAI "PATH";
	}, "q1_q2"] call CBA_statemachine_fnc_addTransition;

	[_stateMachine, "q2", "q3", {ARRAY_EMPTY}, {
		[_stateMachine] call CBA_statemachine_fnc_delete;
	}, "q2_q3"] call CBA_statemachine_fnc_addTransition;

	[_stateMachine, "q2", "q2", {UNIT_NOT_SIMULATED}, {
	}, "q2_q2_1"] call CBA_statemachine_fnc_addTransition;

	[_stateMachine, "q2", "q2", {UNIT_DEAD}, {
		doStop_array = doStop_array - [_this];
	}, "q2_q2_2"] call CBA_statemachine_fnc_addTransition;

	[_stateMachine, "q2", "q2", {UNIT_IN_COMBAT}, {
		doStop_array = doStop_array - [_this];
		_this enableAI "PATH";
	}, "q2_q2_3"] call CBA_statemachine_fnc_addTransition;
}, []] call CBA_fnc_waitUntilAndExecute;