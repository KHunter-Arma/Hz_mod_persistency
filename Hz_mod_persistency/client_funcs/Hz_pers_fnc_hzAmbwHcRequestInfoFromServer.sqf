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

[clientOwner] remoteExecCall ["Hz_pers_fnc_sendHzAmbwInfoToHc",2,false];

waitUntil {
	sleep 1;
	!isnil "Hz_pers_network_ambw_pat_gInfantryPosATL"
};

sleep 10;
