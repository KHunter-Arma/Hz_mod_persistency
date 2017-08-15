/*
* File:					Hz_pers_fnc_handleConnect.sqf
*
* Author:       K.Hunter
*
* Description: 	Executed via mission event handler of type "PlayerConnected"
*               added on server during mission init
********************************************************************************
* Copyright (C) Hunter'z Persistency Module
*
* This file is licensed under a Creative Commons
* Attribution-NonCommercial-ShareAlike 4.0 International License.
* 
* For more information about this license view the LICENSE.md distributed
* together with this file or visit:
* https://creativecommons.org/licenses/by-nc-sa/4.0/
*******************************************************************************/					

_ownerID = _this select 0;
_uid = _this select 1;

_playerIndex = Hz_pers_saveVar_players_UID find _uid;

//player not on record
if (_playerIndex == -1) exitWith {};

[
Hz_pers_saveVar_players_vestType select _playerIndex,
Hz_pers_saveVar_players_uniformType select _playerIndex,
Hz_pers_saveVar_players_backpackType select _playerIndex,
Hz_pers_saveVar_players_headGear select _playerIndex,
Hz_pers_saveVar_players_goggles select _playerIndex,
Hz_pers_saveVar_players_backpackMagazines select _playerIndex,
Hz_pers_saveVar_players_vestMagazines select _playerIndex,
Hz_pers_saveVar_players_uniformMagazines select _playerIndex,
Hz_pers_saveVar_players_uniformItems select _playerIndex,
Hz_pers_saveVar_players_vestItems select _playerIndex,
Hz_pers_saveVar_players_backpackItems select _playerIndex,
Hz_pers_saveVar_players_weaponsItems select _playerIndex,
Hz_pers_saveVar_players_assignedItems select _playerIndex,
Hz_pers_saveVar_players_positionATL select _playerIndex,
Hz_pers_saveVar_players_dir select _playerIndex,
Hz_pers_saveVar_players_anim select _playerIndex,
Hz_pers_saveVar_players_hitpointsdamage select _playerIndex,
Hz_pers_saveVar_players_variableNames,
Hz_pers_saveVar_players_variableValues select _playerIndex
] remoteExec ["Hz_pers_fnc_clientLoadState",_ownerID,false];