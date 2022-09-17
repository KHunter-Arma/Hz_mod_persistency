/*******************************************************************************
* Copyright (C) 2020 K.Hunter
*
* The source code contained within this file is licensed under a Creative Commons
* Attribution-NonCommercial-ShareAlike 4.0 International License.
* 
* For more information about this license view the LICENSE.md distributed
* together with this file or visit:
* https://creativecommons.org/licenses/by-nc-sa/4.0/
*******************************************************************************/

// Current only adds missing variables, does not remove obsolete or no-longer-required ones

{
	_x params ["_varName", "_type", "_isPublic"];
	_found = false;
	
	{
		if ((_x select 0) == _varName) exitWith {
			_found = true;
		};
	} foreach Hz_pers_parsingInfo;
	
	if (!_found) then {
		Hz_pers_parsingInfo pushBack _x;
	};	
} foreach _defaultParsingInfo;

{
	_x params ["_varName", "_isPublic"];
	_found = false;
	
	{
		if ((_x select 0) == _varName) exitWith {
			_found = true;
		};
	} foreach Hz_pers_saveVar_players_variableNames;
	
	if (!_found) then {
		Hz_pers_saveVar_players_variableNames pushBack _x;
	};	
} foreach _defaultPlayerVariableInfo;

{
	_x params ["_varName", "_isPublic"];
	_found = false;
	
	{
		if ((_x select 0) == _varName) exitWith {
			_found = true;
		};
	} foreach Hz_pers_saveVar_vehicles_variableNames;
	
	if (!_found) then {
		Hz_pers_saveVar_vehicles_variableNames pushBack _x;
	};	
} foreach _defaultVehicleVariableInfo;

{
	_x params ["_varName", "_isPublic"];
	_found = false;
	
	{
		if ((_x select 0) == _varName) exitWith {
			_found = true;
		};
	} foreach Hz_pers_saveVar_objects_variableNames;
	
	if (!_found) then {
		Hz_pers_saveVar_objects_variableNames pushBack _x;
	};	
} foreach _defaultObjectVariableInfo;

{
	_x params ["_varName", "_isPublic"];
	_found = false;
	
	{
		if ((_x select 0) == _varName) exitWith {
			_found = true;
		};
	} foreach Hz_pers_saveVar_crates_variableNames;
	
	if (!_found) then {
		Hz_pers_saveVar_crates_variableNames pushBack _x;
	};	
} foreach _defaultCrateVariableInfo;
