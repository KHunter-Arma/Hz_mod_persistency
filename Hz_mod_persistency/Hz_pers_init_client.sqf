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

_logic = _this select 0;

Hz_pers_clientFuncs_path = Hz_pers_path + "client_funcs\";

//compile funcs
Hz_pers_fnc_clientLoadState = compile preprocessFileLineNumbers (Hz_pers_clientFuncs_path + "Hz_pers_fnc_clientLoadState.sqf");
Hz_pers_fnc_clientSendLocalVars = compile preprocessFileLineNumbers (Hz_pers_clientFuncs_path + "Hz_pers_fnc_clientSendLocalVars.sqf");
Hz_pers_fnc_clientDeletePersistentMarker = compile preprocessFileLineNumbers (Hz_pers_clientFuncs_path + "Hz_pers_fnc_clientDeletePersistentMarker.sqf");

waituntil {sleep 0.1; !isnull (finddisplay 46)};
waitUntil {sleep 0.1; !isnull player};

//init delay
sleep 10;

//add EHs
(findDisplay 46) displayAddEventHandler ["KeyDown", Hz_pers_fnc_clientSendLocalVars];
addMissionEventHandler ["MapSingleClick", Hz_pers_fnc_clientDeletePersistentMarker];
