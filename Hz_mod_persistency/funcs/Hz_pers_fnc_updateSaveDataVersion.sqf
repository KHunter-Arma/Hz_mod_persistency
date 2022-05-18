/*******************************************************************************
* Copyright (C) 2019-2020 K.Hunter
*
* The source code contained within this file is licensed under a Creative Commons
* Attribution-NonCommercial-ShareAlike 4.0 International License.
* 
* For more information about this license view the LICENSE.md distributed
* together with this file or visit:
* https://creativecommons.org/licenses/by-nc-sa/4.0/
*******************************************************************************/


// check if the save versioning system is defined on this save file at all
private _saveVersioningExists = false;
{
	if ("Hz_pers_saveVar_saveFileVersion" in _x) exitWith {
		_saveVersioningExists = true;
	};
} foreach Hz_pers_parsingInfo;

if (!_saveVersioningExists) then {
	Hz_pers_saveVar_saveFileVersion = 0;
};

if (Hz_pers_saveVar_saveFileVersion < 191201) then {

	["Hz_pers_saveVar_saveFileVersion", 0, false] call Hz_pers_API_addMissionVariable;
	
	["Hz_pers_saveVar_vehicles_weaponsItems",3,false] call Hz_pers_API_addMissionVariable;
	["Hz_pers_saveVar_crates_weaponsItems",3,false] call Hz_pers_API_addMissionVariable;
	
	{
		Hz_pers_saveVar_vehicles_weaponsItems pushBack [];
	} foreach Hz_pers_saveVar_vehicles_type;
	{
		Hz_pers_saveVar_crates_weaponsItems pushBack [];
	} foreach Hz_pers_saveVar_crates_type;

};

if (Hz_pers_saveVar_saveFileVersion < 200104) then {

	if (Hz_pers_enableACEmedical) then {

		["ace_medical_inPain", true] call Hz_pers_API_addPlayerVariable;
		["ace_medical_hemorrhage", true] call Hz_pers_API_addPlayerVariable;
		["ace_medical_stitchedWounds", true] call Hz_pers_API_addPlayerVariable;
		["ace_medical_isLimping", true] call Hz_pers_API_addPlayerVariable;
		["ace_medical_bodyPartDamage", true] call Hz_pers_API_addPlayerVariable;
		["ace_medical_medications", true] call Hz_pers_API_addPlayerVariable;

	};

};

if (Hz_pers_saveVar_saveFileVersion < 220123) then {

	{
		if ((_x select 0) == "acex_field_rations_currentWaterSupply") exitWith {
			Hz_pers_saveVar_objects_variableNames set [_foreachIndex, ["ace_field_rations_currentWaterSupply", true]];
		};
	} foreach Hz_pers_saveVar_objects_variableNames;
	
	{
		if ((_x select 0) == "acex_field_rations_currentWaterSupply") exitWith {
			Hz_pers_saveVar_vehicles_variableNames set [_foreachIndex, ["ace_field_rations_currentWaterSupply", true]];
		};
	} foreach Hz_pers_saveVar_vehicles_variableNames;

};

Hz_pers_saveVar_saveFileVersion = Hz_pers_currentSaveFileVersion;