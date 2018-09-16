/*******************************************************************************
* Copyright (C) 2017-2018 K.Hunter
*
* This file is licensed under a Creative Commons
* Attribution-NonCommercial-ShareAlike 4.0 International License.
* 
* For more information about this license view the LICENSE.md distributed
* together with this file or visit:
* https://creativecommons.org/licenses/by-nc-sa/4.0/
*******************************************************************************/

_logic = _this select 0;
Hz_pers_clientEnableManualLoadSwitch = _logic getVariable "ClientEnableManualLoadSwitch";
Hz_pers_enableACEmedical = _logic getVariable "AceMedical";

Hz_pers_clientFuncs_path = Hz_pers_path + "client_funcs\";

//compile funcs
Hz_pers_fnc_handleAcreRadios = compile preprocessFileLineNumbers (Hz_pers_path + "funcs\Hz_pers_fnc_handleAcreRadios.sqf");
Hz_pers_fnc_clientSendLocalVars = compile preprocessFileLineNumbers (Hz_pers_clientFuncs_path + "Hz_pers_fnc_clientSendLocalVars.sqf");
Hz_pers_fnc_clientLoadState = compile preprocessFileLineNumbers (Hz_pers_clientFuncs_path + "Hz_pers_fnc_clientLoadState.sqf");
Hz_pers_fnc_clientDeletePersistentMarker = compile preprocessFileLineNumbers (Hz_pers_clientFuncs_path + "Hz_pers_fnc_clientDeletePersistentMarker.sqf");
Hz_pers_fnc_clientHandleEscButtonPushed = compile preprocessFileLineNumbers (Hz_pers_clientFuncs_path + "Hz_pers_fnc_clientHandleEscButtonPushed.sqf"); 

waituntil {sleep 0.1; !isnull (finddisplay 46)};
waitUntil {sleep 0.1; !isnull player};

//add EHs
(findDisplay 46) displayAddEventHandler ["KeyDown", Hz_pers_fnc_clientHandleEscButtonPushed];

/* looks like not needed
addMissionEventHandler ["MapSingleClick", Hz_pers_fnc_clientDeletePersistentMarker];
*/

//load state
if (Hz_pers_clientEnableManualLoadSwitch) then {
  
  if (isnil "Hz_pers_clientReadyForLoad") then {Hz_pers_clientReadyForLoad = false;};
  waitUntil {sleep 0.1; Hz_pers_clientReadyForLoad};
  
  //notify server
  player setVariable ["Hz_pers_clientReadyForLoad",true,true];

} else {

  Hz_pers_clientLoadDelay = call compile (_logic getVariable "ClientLoadDelay");
  sleep Hz_pers_clientLoadDelay;
  player setVariable ["Hz_pers_clientReadyForLoad",true,true];

};


