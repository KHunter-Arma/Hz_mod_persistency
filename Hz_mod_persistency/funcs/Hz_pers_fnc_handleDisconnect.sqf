/*
* File:					Hz_pers_fnc_handleDisconnect.sqf
*
* Author:       K.Hunter
*
* Description: 	Executed via mission event handler of type "HandleDisconnect"
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

_unit = _this select 0;
_uid = _this select 2;


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

if(!isnull (backpackContainer _unit)) then {
	Hz_pers_saveVar_players_backpackMagazines set [_playerIndex,magazinesAmmoCargo backpackContainer _unit];
} else {
	Hz_pers_saveVar_players_backpackMagazines set [_playerIndex,[]];
};

if(!isnull (vestContainer _unit)) then {
	Hz_pers_saveVar_players_vestMagazines set [_playerIndex,magazinesAmmoCargo vestContainer _unit];
} else {
	Hz_pers_saveVar_players_vestMagazines set [_playerIndex,[]];
};

if(!isnull (uniformContainer _unit)) then {
	Hz_pers_saveVar_players_uniformMagazines set [_playerIndex,magazinesAmmoCargo uniformContainer _unit];
} else {
	Hz_pers_saveVar_players_uniformMagazines set [_playerIndex,[]];
};

_temp = [];
{

	if (!("CA_Magazine" in ([(configfile >> "cfgmagazines" >> _x), true] call bis_fnc_returnParents))) then {

		_temp pushback _x;

	};

} foreach uniformItems _unit;

Hz_pers_saveVar_players_uniformItems set [_playerIndex, _temp call Hz_pers_fnc_convert1DArrayTo2D];

_temp = [];
{

	if (!("CA_Magazine" in ([(configfile >> "cfgmagazines" >> _x), true] call bis_fnc_returnParents))) then {

		_temp pushback _x;

	};

} foreach vestItems _unit;

Hz_pers_saveVar_players_vestItems set [_playerIndex, _temp call Hz_pers_fnc_convert1DArrayTo2D];

_temp = [];
{

	if (!("CA_Magazine" in ([(configfile >> "cfgmagazines" >> _x), true] call bis_fnc_returnParents))) then {

		_temp pushback _x;

	};

} foreach backpackItems _unit;

Hz_pers_saveVar_players_backpackItems set [_playerIndex, _temp call Hz_pers_fnc_convert1DArrayTo2D];


Hz_pers_saveVar_players_weaponsItems set [_playerIndex, weaponsItems _unit];

Hz_pers_saveVar_players_hitpointsdamage set [_playerIndex, getAllHitPointsDamage _unit];

	_variables = [];
	{				
		_variables pushback (_unit getVariable [_x,"nil"]);
		
	} foreach Hz_pers_saveVar_players_variableNames;
	
Hz_pers_saveVar_players_variableValues set [_playerIndex, _variables];

// TODO: ACE medical