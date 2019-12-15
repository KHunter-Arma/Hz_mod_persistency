/*******************************************************************************
* Copyright (C) 2019 K.Hunter
*
* The source code contained within this file is licensed under a Creative Commons
* Attribution-NonCommercial-ShareAlike 4.0 International License.
* 
* For more information about this license view the LICENSE.md distributed
* together with this file or visit:
* https://creativecommons.org/licenses/by-nc-sa/4.0/
*******************************************************************************/

if (isnil "Hz_pers_saveVar_saveFileVersion") then {
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

Hz_pers_saveVar_saveFileVersion = Hz_pers_currentSaveFileVersion;