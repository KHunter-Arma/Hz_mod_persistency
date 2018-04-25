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

{
	
	if (!(_x select 1)) then {

		[player,_x select 0, player getvariable (_x select 0)] remoteExecCall ["Hz_pers_fnc_receiveLocalVars", 2, false];

	};

} foreach Hz_pers_saveVar_players_variableNames;