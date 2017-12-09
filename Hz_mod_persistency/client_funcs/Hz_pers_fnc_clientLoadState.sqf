/*******************************************************************************
* File:					Hz_pers_fnc_clientLoadState.sqf
*
* Author:       K.Hunter
*
* Description: 	Executed on client via remote execution after client connects.
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

//#define DEBUG

_vestType = _this select 0;
_uniformType = _this select 1;
_backpackType = _this select 2;
_headGear = _this select 3;
_goggles = _this select 4;
_backpackMagazines = _this select 5;
_vestMagazines = _this select 6;
_uniformMagazines = _this select 7;
_uniformItems = _this select 8;
_vestItems = _this select 9;
_backpackItems = _this select 10;
_weaponsItems = _this select 11;
_assignedItems = _this select 12;
_positionATL = _this select 13;
_dir = _this select 14;
_anim = _this select 15;
_hitPointsDamage = _this select 16;
_variableNames = _this select 17;
_variableValues = _this select 18;

#ifdef DEBUG
diag_log "################ HZ PERSISTENCY CLIENT LOAD STATE DEBUG #################";
{

	diag_log _x;

} foreach _this;
diag_log "###########################################################################";
#endif

waitUntil {sleep 0.1; !isnull player};

//exit if no data
if ((count _positionATL) < 1) exitWith {Hz_pers_fnc_clientInitDone = true;};

startLoadingScreen ["Loading..."];

// remove all gear

removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;

progressLoadingScreen 0.1;

sleep 0.1;

progressLoadingScreen 0.2;

//load gear

player addvest _vestType;
player addUniform _uniformType;
player addbackpack _backpackType;
player addHeadgear _headGear;
player addGoggles _goggles;

sleep 0.1;

progressLoadingScreen 0.3;

clearMagazineCargoGlobal (vestContainer player);
clearWeaponCargoGlobal (vestContainer player);
clearItemCargoGlobal (vestContainer player);
clearItemCargoGlobal (uniformContainer player);
clearMagazineCargoGlobal (uniformContainer player);
clearWeaponCargoGlobal (uniformContainer player);
clearItemCargoGlobal (backpackContainer player);
clearMagazineCargoGlobal (backpackContainer player);
clearWeaponCargoGlobal (backpackContainer player);

sleep 0.1;

progressLoadingScreen 0.4;

{

	player addWeapon (_x select 0);
	
	//add magazine
	_magArray = _x select 4;
	if ((count _magArray) > 0) then {
		player addWeaponItem [(_x select 0), [(_magArray select 0), (_magArray select 1)]];
	};
	
	//Grenade launcher?
	if ((typename (_x select 5)) == "ARRAY") then {
		
		_magArray = _x select 5;
		if ((count _magArray) > 0) then {
			player addWeaponItem [(_x select 0), [(_magArray select 0), (_magArray select 1)]];
		};

	};
	
	//attachments
	player addWeaponItem [_x select 0, _x select 1];
	player addWeaponItem [_x select 0, _x select 2];
	player addWeaponItem [_x select 0, _x select 3];

} foreach _weaponsItems;

/*

{
	_magArray = _x select 4;
	if ((count _magArray) > 0) then {
		player addMagazine [(_magArray select 0),(_magArray select 1)];
	};
	
	//Grenade launcher?
	if ((typename (_x select 5)) == "ARRAY") then {
		
		_magArray = _x select 5;
		if ((count _magArray) > 0) then {
			player addMagazine [(_magArray select 0),(_magArray select 1)];
		};

	};

	player addWeapon (_x select 0);

}foreach _weaponsItems;


_weapon = primaryweapon player;
player selectweapon _weapon;
reload player;
player setWeaponReloadingTime [player, currentMuzzle player, 0];

_muzzles = getarray (configfile >> "cfgWeapons" >> _weapon >> "muzzles");
if ((count _muzzles) > 1) then {

	player selectweapon (_muzzles select 1);
	reload player;
	player setWeaponReloadingTime [player, currentMuzzle player, 0];

};

_weapon = handgunWeapon player;
player selectweapon _weapon;
reload player;
player setWeaponReloadingTime [player, currentMuzzle player, 0];

*/

progressLoadingScreen 0.5;

// if any of these don't exist, array will be empty, so should be safe for foreach loop

_container = vestContainer player;
{
	_container addMagazineAmmoCargo [_x select 0, 1, _x select 1];
}foreach _vestMagazines;

{
	_container addItemCargoGlobal [_x,(_vestItems select 1) select _foreachIndex];
} foreach (_vestItems select 0);

_container = backpackContainer player;
{
	_container addMagazineAmmoCargo [_x select 0, 1, _x select 1];
}foreach _backpackMagazines;

{
	_container addItemCargoGlobal [_x,(_backpackItems select 1) select _foreachIndex];
} foreach (_backpackItems select 0);

_container = uniformContainer player;
{
	_container addMagazineAmmoCargo [_x select 0, 1, _x select 1];
}foreach _uniformMagazines;

{
	_container addItemCargoGlobal [_x,(_uniformItems select 1) select _foreachIndex];
} foreach (_uniformItems select 0);


progressLoadingScreen 0.75;

{
	player linkItem _x;
}foreach _assignedItems;

{
	player setHitPointDamage [_x, (_hitPointsDamage select 2) select _foreachIndex];
}foreach (_hitPointsDamage select 0);

{

	_variable = _variableValues select _foreachIndex;
	
	if ((typeName _variable) == "STRING") then {
	
		if (_variable != "nil") then {
			
			player setvariable [_x select 0,_variable,_x select 1];
		};
	
	} else {
		
		player setvariable [_x select 0,_variable,_x select 1];
	
	};

} foreach _variableNames;

progressLoadingScreen 1;

player setdir _dir;
player switchMove _anim;
player setposatl _positionATL;

Hz_pers_fnc_clientInitDone = true;

endLoadingScreen;
