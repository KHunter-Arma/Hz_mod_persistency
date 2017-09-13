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

Hz_pers_path = "\";

Hz_pers_initDone = false;

if (isServer) then {_this call compile preprocessFileLineNumbers (Hz_pers_path + "Hz_pers_init_server.sqf");};
if (!isDedicated) then {call compile preprocessFileLineNumbers (Hz_pers_path + "Hz_pers_init_client.sqf");};

call compile preprocessFileLineNumbers (Hz_pers_path + "Hz_pers_init_API.sqf");};

Hz_pers_initDone = true;