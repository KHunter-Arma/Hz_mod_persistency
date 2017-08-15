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

if ((_this select 1) == 1) then {

	{
		
		[player,_x, player getvariable _x] remoteExecCall ["Hz_pers_fnc_receiveLocalVars", 2, false];
	
	} foreach Hz_pers_saveVar_players_variableNames;

};