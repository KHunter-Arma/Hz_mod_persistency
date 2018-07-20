/*
* File:					Hz_pers_fnc_handleDisconnect.sqf
*
* Author:       K.Hunter
*
* Description: 	Executed via mission event handler of type "HandleDisconnect"
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

_this call {

	_unit = _this select 0;
	_uid = _this select 2;
	_forcedSave = false;
	
	if ((_uid find "HC") != -1) exitWith {};
	
	//Something went wrong at connection - exit without doing anything
	if (_uid in Hz_pers_clientConnectSafeguardArray) exitWith {
	
		deletevehicle _unit;
	
	};

	if ((count _this) > 4) then {

		_forcedSave = _this select 4;

	};

	_playerIndex = Hz_pers_saveVar_players_UID find _uid;

	if(_playerIndex == -1) then {

		_playerIndex = count Hz_pers_saveVar_players_UID;

		Hz_pers_saveVar_players_UID pushback _uid;

	};
	
	//Get all gear with full detail

	Hz_pers_saveVar_players_vestType set [_playerIndex, vest _unit];
	Hz_pers_saveVar_players_uniformType set [_playerIndex, uniform _unit];
	Hz_pers_saveVar_players_backpackType set [_playerIndex, backpack _unit];
	Hz_pers_saveVar_players_headGear set [_playerIndex, headgear _unit];
	Hz_pers_saveVar_players_goggles set [_playerIndex, goggles _unit];
	Hz_pers_saveVar_players_dir set [_playerIndex, getdir _unit];

	if ((vehicle _unit) == _unit) then {

		Hz_pers_saveVar_players_anim set [_playerIndex, animationState _unit];

	} else {

		Hz_pers_saveVar_players_anim set [_playerIndex, ""];

	};

	_pos = getposatl _unit;

	if((vehicle _unit) iskindof "Air") then {

		Hz_pers_saveVar_players_positionATL set [_playerIndex, [_pos select 0, _pos select 1, 0]];

	} else {

		Hz_pers_saveVar_players_positionATL set [_playerIndex, _pos];

	};

	Hz_pers_saveVar_players_assignedItems set [_playerIndex, assignedItems _unit];

	_itemCargo = [];
	_magazinesAmmoCargo = [];
	_container = uniformContainer _unit;

	if(!isnull _container) then {

		_magazinesAmmoCargo = magazinesAmmoCargo _container;
		
		{

			if (!("CA_Magazine" in ([(configfile >> "cfgmagazines" >> _x), true] call bis_fnc_returnParents))) then {

				_itemCargo pushback _x;

			};

		} foreach itemCargo _container;
		
		{
			
				_itemCargo pushBack ([_x select 0] call bis_fnc_baseweapon);	
				
				{
				
					if (_x != "") then {
					
						_itemCargo pushBack _x;
					
					};
				
				} foreach [_x select 1, _x select 2, _x select 3];
				
				_magArray = _x select 4;
				if ((count _magArray) > 0) then {			
					_magazinesAmmoCargo pushBack [(_magArray select 0), (_magArray select 1)];
				};
				
				//Grenade launcher?
				if ((typename (_x select 5)) == "ARRAY") then {
					
					_magArray = _x select 5;
					if ((count _magArray) > 0) then {
						_magazinesAmmoCargo pushBack [(_magArray select 0), (_magArray select 1)];
					};

				};
			
			} foreach weaponsItemsCargo _container;	
		
	};

	Hz_pers_saveVar_players_uniformMagazines set [_playerIndex,_magazinesAmmoCargo];
	Hz_pers_saveVar_players_uniformItems set [_playerIndex, _itemCargo call Hz_pers_fnc_convert1DArrayTo2D];


	_itemCargo = [];
	_magazinesAmmoCargo = [];
	_container = vestContainer _unit;

	if(!isnull _container) then {

		_magazinesAmmoCargo = magazinesAmmoCargo _container;
		
		{

			if (!("CA_Magazine" in ([(configfile >> "cfgmagazines" >> _x), true] call bis_fnc_returnParents))) then {

				_itemCargo pushback _x;

			};

		} foreach itemCargo _container;
		
		{
			
				_itemCargo pushBack ([_x select 0] call bis_fnc_baseweapon);	
				
				{
				
					if (_x != "") then {
					
						_itemCargo pushBack _x;
					
					};
				
				} foreach [_x select 1, _x select 2, _x select 3];
				
				_magArray = _x select 4;
				if ((count _magArray) > 0) then {			
					_magazinesAmmoCargo pushBack [(_magArray select 0), (_magArray select 1)];
				};
				
				//Grenade launcher?
				if ((typename (_x select 5)) == "ARRAY") then {
					
					_magArray = _x select 5;
					if ((count _magArray) > 0) then {
						_magazinesAmmoCargo pushBack [(_magArray select 0), (_magArray select 1)];
					};

				};
			
			} foreach weaponsItemsCargo _container;	
		
	};

	Hz_pers_saveVar_players_vestMagazines set [_playerIndex,_magazinesAmmoCargo];
	Hz_pers_saveVar_players_vestItems set [_playerIndex, _itemCargo call Hz_pers_fnc_convert1DArrayTo2D];


	_itemCargo = [];
	_magazinesAmmoCargo = [];
	_container = backpackContainer _unit;

	if(!isnull _container) then {

		_magazinesAmmoCargo = magazinesAmmoCargo _container;
		
		{

			if (!("CA_Magazine" in ([(configfile >> "cfgmagazines" >> _x), true] call bis_fnc_returnParents))) then {

				_itemCargo pushback _x;

			};

		} foreach itemCargo _container;
		
		{
			
				_itemCargo pushBack ([_x select 0] call bis_fnc_baseweapon);	
				
				{
				
					if (_x != "") then {
					
						_itemCargo pushBack _x;
					
					};
				
				} foreach [_x select 1, _x select 2, _x select 3];
				
				_magArray = _x select 4;
				if ((count _magArray) > 0) then {			
					_magazinesAmmoCargo pushBack [(_magArray select 0), (_magArray select 1)];
				};
				
				//Grenade launcher?
				if ((typename (_x select 5)) == "ARRAY") then {
					
					_magArray = _x select 5;
					if ((count _magArray) > 0) then {
						_magazinesAmmoCargo pushBack [(_magArray select 0), (_magArray select 1)];
					};

				};
			
			} foreach weaponsItemsCargo _container;	
		
	};

	Hz_pers_saveVar_players_backpackMagazines set [_playerIndex,_magazinesAmmoCargo];
	Hz_pers_saveVar_players_backpackItems set [_playerIndex, _itemCargo call Hz_pers_fnc_convert1DArrayTo2D];
	
	_weaponsItems = [];
	
	{
	
		_wep = _x select 0;
	
		if (
				(_wep == (primaryWeapon _unit))
				|| (_wep == (secondaryWeapon _unit))
				|| (_wep == (handgunWeapon _unit))
				|| (_wep in (assignedItems _unit))
				) then {
		
			_weaponsItems pushBack _x;
		
		};	
	
	} foreach weaponsItems _unit;	

	Hz_pers_saveVar_players_weaponsItems set [_playerIndex, _weaponsItems];

	Hz_pers_saveVar_players_hitpointsdamage set [_playerIndex, getAllHitPointsDamage _unit];

	_variables = [];
	{				
		_variables pushback (_unit getVariable [_x select 0,"nil"]);
		
	} foreach Hz_pers_saveVar_players_variableNames;
		
	Hz_pers_saveVar_players_variableValues set [_playerIndex, _variables];

	#ifdef DEBUG
	diag_log "################ HZ PERSISTENCY HANDLE DISCONNECT DEBUG #################";
	diag_log Hz_pers_saveVar_players_UID;
	diag_log Hz_pers_saveVar_players_vestType;
	diag_log Hz_pers_saveVar_players_uniformType;
	diag_log Hz_pers_saveVar_players_backpackType;
	diag_log Hz_pers_saveVar_players_headGear;
	diag_log Hz_pers_saveVar_players_goggles;
	diag_log Hz_pers_saveVar_players_positionATL;
	diag_log Hz_pers_saveVar_players_dir;
	diag_log Hz_pers_saveVar_players_anim;
	diag_log Hz_pers_saveVar_players_assignedItems;
	diag_log Hz_pers_saveVar_players_backpackMagazines;
	diag_log Hz_pers_saveVar_players_vestMagazines;
	diag_log Hz_pers_saveVar_players_uniformMagazines;
	diag_log Hz_pers_saveVar_players_uniformItems;
	diag_log Hz_pers_saveVar_players_vestItems;
	diag_log Hz_pers_saveVar_players_backpackItems;
	diag_log Hz_pers_saveVar_players_weaponsItems;
	diag_log Hz_pers_saveVar_players_hitpointsdamage;
	diag_log Hz_pers_saveVar_players_variableValues;
	diag_log "###########################################################################";
	#endif
	
	//exit conditions are down here to make sure no save variable is undefined (not really necessary though)
	if ((!alive _unit) && !_forcedSave) exitWith {

		deletevehicle _unit;
		Hz_pers_saveVar_players_positionATL set [_playerIndex, []];
		
	};

	if ((_unit getvariable ["Hz_pers_clientDisableSaveStateOnDisconnect",false]) && !_forcedSave) exitWith {

		deletevehicle _unit;
		Hz_pers_saveVar_players_positionATL set [_playerIndex, []];

	};

	if (!_forcedSave) then {

		deletevehicle _unit;

	};

};

false