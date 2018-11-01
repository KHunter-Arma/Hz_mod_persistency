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

if (!isServer) exitWith {hint "Only the server may add variables!"};

Hz_pers_saveVar_players_variableNames pushBackUnique _this;
publicvariable "Hz_pers_saveVar_players_variableNames";