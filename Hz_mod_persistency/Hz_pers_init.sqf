/*******************************************************************************
* Copyright (C) 2017-2018 K.Hunter
*
* The source code contained within this file is licensed under a Creative Commons
* Attribution-NonCommercial-ShareAlike 4.0 International License.
* 
* For more information about this license view the LICENSE.md distributed
* together with this file or visit:
* https://creativecommons.org/licenses/by-nc-sa/4.0/
*******************************************************************************/

_this spawn {

	Hz_pers_path = "\x\Hz\Hz_mod_persistency\";

	Hz_pers_initDone = false;

	call compile preprocessFileLineNumbers (Hz_pers_path + "Hz_pers_init_API.sqf");

	if (isServer) then {_this call compile preprocessFileLineNumbers (Hz_pers_path + "Hz_pers_init_server.sqf");};
	if (!isDedicated) then {_this call compile preprocessFileLineNumbers (Hz_pers_path + "Hz_pers_init_client.sqf");};

	Hz_pers_initDone = true;

};