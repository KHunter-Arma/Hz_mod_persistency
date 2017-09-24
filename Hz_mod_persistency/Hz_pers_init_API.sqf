/*******************************************************************************
* Copyright (C) Hunter'z Persistency Module
*
* This file is licensed under a Creative Commons
* Attribution-NonCommercial-ShareAlike 4.0 International License.
* 
* For more information about this license view the LICENSE.md distributed
* together with this file or visit:
* https://creativecommons.org/licenses/by-nc-sa/4.0/
*******************************************************************************/

Hz_pers_API_path = Hz_pers_path + "API\";

Hz_pers_API_addCrate = compile preprocessFileLineNumbers (Hz_pers_API_path + "Hz_pers_API_addCrate.sqf");
Hz_pers_API_addCrateVariable = compile preprocessFileLineNumbers (Hz_pers_API_path + "Hz_pers_API_addCrateVariable.sqf");
Hz_pers_API_addMissionVariable = compile preprocessFileLineNumbers (Hz_pers_API_path + "Hz_pers_API_addMissionVariable.sqf");
Hz_pers_API_addObject = compile preprocessFileLineNumbers (Hz_pers_API_path + "Hz_pers_API_addObject.sqf");
Hz_pers_API_addObjectVariable = compile preprocessFileLineNumbers (Hz_pers_API_path + "Hz_pers_API_addObjectVariable.sqf");
Hz_pers_API_addPlayerVariable = compile preprocessFileLineNumbers (Hz_pers_API_path + "Hz_pers_API_addPlayerVariable.sqf");
Hz_pers_API_addVehicle = compile preprocessFileLineNumbers (Hz_pers_API_path + "Hz_pers_API_addVehicle.sqf");
Hz_pers_API_addVehicleVariable = compile preprocessFileLineNumbers (Hz_pers_API_path + "Hz_pers_API_addVehicleVariable.sqf");
Hz_pers_API_disablePlayerSaveStateOnDisconnect = compile preprocessFileLineNumbers (Hz_pers_API_path + "Hz_pers_API_disablePlayerSaveStateOnDisconnect.sqf");
Hz_pers_API_enablePlayerSaveStateOnDisconnect = compile preprocessFileLineNumbers (Hz_pers_API_path + "Hz_pers_API_enablePlayerSaveStateOnDisconnect.sqf");