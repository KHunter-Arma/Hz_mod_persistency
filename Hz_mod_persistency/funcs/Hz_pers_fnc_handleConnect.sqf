/*
* File:					Hz_pers_fnc_handleConnect.sqf
*
* Author:       K.Hunter
*
* Description: 	Executed via mission event handler of type "PlayerConnected"
*               added on server during mission init
********************************************************************************
* Copyright (C) 2017-2018 K.Hunter
*
* This file is licensed under a Creative Commons
* Attribution-NonCommercial-ShareAlike 4.0 International License.
* 
* For more information about this license view the LICENSE.md distributed
* together with this file or visit:
* https://creativecommons.org/licenses/by-nc-sa/4.0/
*******************************************************************************/				

//#define DEBUG

_this spawn {

  _ownerID = _this select 4;
  _uid = _this select 1;
	
	Hz_pers_clientConnectSafeguardArray pushBack _uid;

  _playerIndex = Hz_pers_saveVar_players_UID find _uid;

  //player not on record
  if (_playerIndex == -1) exitWith {[_uid] call Hz_pers_fnc_ackClientLoadSuccess};

  //find player object
  _player = objNull;
  _timeout = time + 120;
  
  // mutex sleep
  sleep 0.5;
  
  while {(isnull _player) && (time < _timeout)} do {
  
    sleep 0.1;
    
    {
      
      if ((getplayeruid _x) == _uid) exitWith {_player = _x;};
    
    } foreach playableUnits;
  
  };
  
  if (isNull _player) exitWith {};
  
  // mutex against repeated reconnects
  if (_player getvariable ["Hz_pers_clientHandledConnect",false]) exitwith {};
  _player setvariable ["Hz_pers_clientHandledConnect",true];
  
  waitUntil {
  
    sleep 0.1;
    
    if (!isnull _player) then {
    
    _player getVariable ["Hz_pers_clientReadyForLoad",false]
    
    } else {
    
    true
    
    }
    
  };
  
  if (isNull _player) exitWith {};

#ifdef DEBUG
	diag_log "################ HZ PERSISTENCY HANDLE CONNECT DEBUG #################";
	diag_log _ownerID;
	diag_log _uid;
  diag_log Hz_pers_saveVar_players_vestType select _playerIndex;
  diag_log Hz_pers_saveVar_players_uniformType select _playerIndex;
  diag_log Hz_pers_saveVar_players_backpackType select _playerIndex;
  diag_log Hz_pers_saveVar_players_headGear select _playerIndex;
  diag_log Hz_pers_saveVar_players_goggles select _playerIndex;
  diag_log Hz_pers_saveVar_players_backpackMagazines select _playerIndex;
  diag_log Hz_pers_saveVar_players_vestMagazines select _playerIndex;
  diag_log Hz_pers_saveVar_players_uniformMagazines select _playerIndex;
  diag_log Hz_pers_saveVar_players_uniformItems select _playerIndex;
  diag_log Hz_pers_saveVar_players_vestItems select _playerIndex;
  diag_log Hz_pers_saveVar_players_backpackItems select _playerIndex;
  diag_log Hz_pers_saveVar_players_weaponsItems select _playerIndex;
  diag_log Hz_pers_saveVar_players_assignedItems select _playerIndex;
  diag_log Hz_pers_saveVar_players_positionATL select _playerIndex;
  diag_log Hz_pers_saveVar_players_dir select _playerIndex;
  diag_log Hz_pers_saveVar_players_anim select _playerIndex;
  diag_log Hz_pers_saveVar_players_hitpointsdamage select _playerIndex;
  diag_log Hz_pers_saveVar_players_variableNames;
  diag_log Hz_pers_saveVar_players_variableValues select _playerIndex;
	diag_log "###########################################################################";
#endif

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

};