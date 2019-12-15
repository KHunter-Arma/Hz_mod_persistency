/*******************************************************************************
* Copyright (C) 2017-2019 K.Hunter
*
* The source code contained within this file is licensed under a Creative Commons
* Attribution-NonCommercial-ShareAlike 4.0 International License.
* 
* For more information about this license view the LICENSE.md distributed
* together with this file or visit:
* https://creativecommons.org/licenses/by-nc-sa/4.0/
*******************************************************************************/
private ["_var","_isPublic","_value","_syncedValue","_variablesToSyncCount"];

_variablesToSyncCount = 0;

{

	_var = _x select 0;
	_isPublic = _x select 1;
	
	_value = player getvariable _var;
	_syncedValue = Hz_pers_playerVariablesLastSyncedWithServer select _foreachIndex;
	
	if ((!_isPublic) && {!isnil "_value"} && {!(_value isEqualTo _syncedValue)}) then {
	
		if (((typeName _value) == "SCALAR") && {(typeName _syncedValue) == "SCALAR"} && {(abs (_value - _syncedValue)) < (0.03*(abs _value))}) exitWith {};
	
		_variablesToSyncCount = _variablesToSyncCount + 1;				
		
		Hz_pers_playerVariablesLastSyncedWithServer set [_foreachIndex, _value];

		[player,_var, _value] remoteExecCall ["Hz_pers_fnc_receiveLocalVars", 2, false];

	};

} foreach Hz_pers_saveVar_players_variableNames;

_variablesToSyncCount
