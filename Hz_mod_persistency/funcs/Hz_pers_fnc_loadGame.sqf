/*******************************************************************************
* Copyright (C) 2017-2020 K.Hunter
*
* The source code contained within this file is licensed under a Creative Commons
* Attribution-NonCommercial-ShareAlike 4.0 International License.
* 
* For more information about this license view the LICENSE.md distributed
* together with this file or visit:
* https://creativecommons.org/licenses/by-nc-sa/4.0/
*******************************************************************************/

#include "..\parsing_descriptors.txt"

call compile _this;

_defaultParsingInfo = +Hz_pers_parsingInfo;
_defaultPlayerVariableInfo = +Hz_pers_saveVar_players_variableNames;
_defaultVehicleVariableInfo = +Hz_pers_saveVar_vehicles_variableNames;
_defaultObjectVariableInfo = +Hz_pers_saveVar_objects_variableNames;
_defaultCrateVariableInfo = +Hz_pers_saveVar_crates_variableNames;
"Hz_pers_parsingInfo" call Hz_pers_fnc_arrayParser;

{
	_objectName = _x select 0;
	
	switch (_x select 1) do {
		
		case ONE_D_ARRAY : {      
			_objectName call Hz_pers_fnc_arrayParser;     
		};
			
		case NESTED_ARRAY_STRUCT : {			
			_parsedStruct = _objectName call Hz_pers_fnc_nestedArrayStructParser;
			missionnamespace setvariable [_objectName,_parsedStruct];			
		};
			
		case ARRAY_OF_STRUCTS : {			
			_objectName call Hz_pers_fnc_structArrayParser;			
		};
			
		default {};    
		
	};
	
	if (_x select 2) then {		
		publicVariable _objectName;		
	};
	
} foreach Hz_pers_parsingInfo;      

_indexVehicle = (count Hz_pers_saveVar_vehicles_type) - 1;  
_indexObject = (count Hz_pers_saveVar_objects_type) - 1;
_indexCrate = (count Hz_pers_saveVar_crates_type) - 1;

//////////////////////////////////////////////////////////////////////////////////////////

//check for updates
call Hz_pers_fnc_updateSaveDataVersion;

/////////////////////////////////////////////////////////////////////////////////////////

sleep Hz_pers_objectsLoadDelay;

//Load Vehicles
_index = 0;

if (_indexVehicle >= 0) then {
	
	for "_i" from 0 to _indexVehicle do {
		
		_veh = (Hz_pers_saveVar_vehicles_type select _index) createvehicle [-5000,-5000,0];
		Hz_pers_network_vehicles pushBack _veh;
		
		clearMagazineCargoGlobal _veh;
		clearBackpackCargoGlobal _veh;
		clearWeaponCargoGlobal _veh;
		clearItemCargoGlobal _veh;
		
		if (isclass (configfile >> "cfgpatches" >> "ace_cargo")) then {
			
			sleep 0.1;
			["ACE_Wheel", _veh, 10] call ace_cargo_fnc_removeCargoItem;
			
		};
		
		_vehCustoms = Hz_pers_saveVar_vehicles_customs select _index;
		_array = [_veh];		
		{_array pushBack _x;} foreach _vehCustoms;		
		_array call BIS_fnc_initVehicle;

		_itemIndex = (count ((Hz_pers_saveVar_vehicles_itemsCargo select _index) select 0)) - 1;
		if (_itemIndex >= 0) then {
			for "_j" from 0 to _itemIndex do {
				_veh addItemCargoGlobal[(((Hz_pers_saveVar_vehicles_itemsCargo select _index) select 0) select _j) call Hz_pers_fnc_handleAcreRadios,(((Hz_pers_saveVar_vehicles_itemsCargo select _index) select 1) select _j)];
			};
		};
		
		_itemIndex = (count ((Hz_pers_saveVar_vehicles_backpackCargo select _index) select 0)) - 1;
		if (_itemIndex >= 0) then {
			for "_j" from 0 to _itemIndex do {
				_veh addBackpackCargoGlobal[(((Hz_pers_saveVar_vehicles_backpackCargo select _index) select 0) select _j),(((Hz_pers_saveVar_vehicles_backpackCargo select _index) select 1) select _j)];
			};
		};
		
		_magazineAmmoIndex = (count (Hz_pers_saveVar_vehicles_magazinesAmmoCargo select _index)) - 1;
		if (_magazineAmmoIndex >= 0) then {
			for "_j" from 0 to _magazineAmmoIndex do {
				_veh addMagazineAmmoCargo [(((Hz_pers_saveVar_vehicles_magazinesAmmoCargo select _index) select _j) select 0),1,(((Hz_pers_saveVar_vehicles_magazinesAmmoCargo select _index) select _j) select 1)];
			};		
		};

		_weaponsItemsIndex = (count ((Hz_pers_saveVar_vehicles_weaponsItems select _index) select 0)) - 1;
		if (_weaponsItemsIndex >= 0) then {
			{
				_veh addWeaponWithAttachmentsCargoGlobal [_x,1];
			} foreach (Hz_pers_saveVar_vehicles_weaponsItems select _index);		
		};	
		
		_veh setdir (Hz_pers_saveVar_vehicles_dir select _index);
		_veh setVectorUp (Hz_pers_saveVar_vehicles_vectorUp select _index);
		_veh setposatl (Hz_pers_saveVar_vehicles_positionATL select _index);		
		_veh setfuel (Hz_pers_saveVar_vehicles_fuel select _index);
		
		_hitPartsIndex = (count ((Hz_pers_saveVar_vehicles_hitpointsdamage select _index) select 0)) - 1;
		for "_j" from 0 to _hitPartsIndex do {
			_selection = ((Hz_pers_saveVar_vehicles_hitpointsdamage select _index) select 1) select _j;
			if (_selection != "") then {
				
				_veh setHit [_selection, (((Hz_pers_saveVar_vehicles_hitpointsdamage select _index) select 2) select _j), false]; 
				
			} else {
				
				_veh setHitPointDamage [(((Hz_pers_saveVar_vehicles_hitpointsdamage select _index) select 0) select _j), (((Hz_pers_saveVar_vehicles_hitpointsdamage select _index) select 2) select _j), false]; 
				
			};			
		};
		
		//does not remove loaded mag
		_veh setVehicleAmmo 0;
		
		_magazinesTurretIndex = (count ((Hz_pers_saveVar_vehicles_magazinesTurrets select _index) select 0)) - 1;
		if(_magazinesTurretIndex >= 0) then {
			
			for "_j" from 0 to _magazinesTurretIndex do {
				
				//remove loaded magazine
				{
					
					_veh removeMagazineTurret [_x,(((Hz_pers_saveVar_vehicles_magazinesTurrets select _index) select 0) select _j)];
					
				} foreach (_veh magazinesTurret (((Hz_pers_saveVar_vehicles_magazinesTurrets select _index) select 0) select _j));
				
				for "_k" from 1 to (((Hz_pers_saveVar_vehicles_magazinesTurrets select _index) select 2) select _j) do {
					
					_veh addMagazineTurret [(((Hz_pers_saveVar_vehicles_magazinesTurrets select _index) select 1) select _j),(((Hz_pers_saveVar_vehicles_magazinesTurrets select _index) select 0) select _j)];
					
				};
			};	

		};
		
		_variableValues = Hz_pers_saveVar_vehicles_variableValues select _index;
		{
			
			_value = _variableValues select _foreachIndex;
			
			if (!(_value isEqualTo "nil")) then {
				
				_veh setvariable [_x select 0,_value,_x select 1];
				
			};
			
		} foreach Hz_pers_saveVar_vehicles_variableNames;
		
		{
			
			_container = _x select 1;
			clearMagazineCargoGlobal _container;
			clearBackpackCargoGlobal _container;
			clearWeaponCargoGlobal _container;
			clearItemCargoGlobal _container;
			
		} foreach everyContainer _veh;
		
		_index = _index + 1;
		
	};
};

publicvariable "Hz_pers_network_vehicles";

//Load objects

_index = 0;    

if (_indexObject >= 0) then {

	for "_i" from 0 to _indexObject do {
		
		_obj = (Hz_pers_saveVar_objects_type select _index) createvehicle [-5000,-5000,0];
		Hz_pers_network_objects pushBack _obj;
		
		_obj setdamage (Hz_pers_saveVar_objects_damage select _index);
		_obj setdir (Hz_pers_saveVar_objects_dir select _index);
		_obj setVectorUp (Hz_pers_saveVar_objects_vectorUp select _index);
		_obj setposatl (Hz_pers_saveVar_objects_positionATL select _index);
		
		_variableValues = Hz_pers_saveVar_objects_variableValues select _index;
		{
			
			_value = _variableValues select _foreachIndex;
			
			if (!(_value isEqualTo "nil")) then {
				
				_obj setvariable [_x select 0,_value,_x select 1];
				
			};
			
		} foreach Hz_pers_saveVar_objects_variableNames;
		
		_index = _index + 1;

	};
};  

publicvariable "Hz_pers_network_objects";


//Load crates

_index = 0;

if (_indexCrate >= 0) then {

	for "_i" from 0 to _indexCrate do {
		
		_crate = (Hz_pers_saveVar_crates_type select _index) createvehicle [-5000,-5000,0];
		Hz_pers_network_crates pushBack _crate;
		
		_crate setDamage (Hz_pers_saveVar_crates_damage select _index);
		_crate setDir (Hz_pers_saveVar_crates_dir select _index);
		_crate setVectorUp (Hz_pers_saveVar_crates_vectorUp select _index);
		_crate setposatl (Hz_pers_saveVar_crates_positionATL select _index);
		
		clearMagazineCargoGlobal _crate;
		clearBackpackCargoGlobal _crate;
		clearWeaponCargoGlobal _crate;
		clearItemCargoGlobal _crate;
		
		_magazineAmmoIndex = (count (Hz_pers_saveVar_crates_magazinesAmmoCargo select _index)) - 1;
		if (_magazineAmmoIndex >= 0) then {
			for "_j" from 0 to _magazineAmmoIndex do {
				_crate addMagazineAmmoCargo [(((Hz_pers_saveVar_crates_magazinesAmmoCargo select _index) select _j) select 0),1,(((Hz_pers_saveVar_crates_magazinesAmmoCargo select _index) select _j) select 1)];
			};		
		};		
		
		_itemIndex = (count ((Hz_pers_saveVar_crates_itemsCargo select _index) select 0)) - 1;
		if (_itemIndex >= 0) then {
			for "_j" from 0 to _itemIndex do {
				_crate addItemCargoGlobal[(((Hz_pers_saveVar_crates_itemsCargo select _index) select 0) select _j) call Hz_pers_fnc_handleAcreRadios,(((Hz_pers_saveVar_crates_itemsCargo select _index) select 1) select _j)];
			};
		};
		
		_itemIndex = (count ((Hz_pers_saveVar_crates_backpackCargo select _index) select 0)) - 1;
		if (_itemIndex >= 0) then {
			for "_j" from 0 to _itemIndex do {
				_crate addBackpackCargoGlobal[(((Hz_pers_saveVar_crates_backpackCargo select _index) select 0) select _j),(((Hz_pers_saveVar_crates_backpackCargo select _index) select 1) select _j)];
			};
		};
		
		_weaponsItemsIndex = (count ((Hz_pers_saveVar_crates_weaponsItems select _index) select 0)) - 1;
		if (_weaponsItemsIndex >= 0) then {
			{
				_crate addWeaponWithAttachmentsCargoGlobal [_x,1];
			} foreach (Hz_pers_saveVar_crates_weaponsItems select _index);		
		};
		
		_variableValues = Hz_pers_saveVar_crates_variableValues select _index;
		{
			
			_value = _variableValues select _foreachIndex;
			
			if (!(_value isEqualTo "nil")) then {
				
				_crate setvariable [_x select 0,_value,_x select 1];
				
			};
			
		} foreach Hz_pers_saveVar_crates_variableNames;
		
		{
			
			_container = _x select 1;
			clearMagazineCargoGlobal _container;
			clearBackpackCargoGlobal _container;
			clearWeaponCargoGlobal _container;
			clearItemCargoGlobal _container;
			
		} foreach everyContainer _crate;
		
		_index = _index + 1;
		
	};

};

publicVariable "Hz_pers_network_crates";

{

	_randomN = round ((random 1000000) + (random 128));
	_marker = "_USER_DEFINED #" + (str _randomN);

	createMarker [_marker, _x];
	_marker setMarkerShape "ICON";
	_marker setMarkerType (Hz_pers_saveVar_markers_type select _foreachIndex);
	_marker setMarkerColor (Hz_pers_saveVar_markers_colour select _foreachIndex);
	_marker setMarkerText (Hz_pers_saveVar_markers_text select _foreachIndex);
	_marker setMarkerPos (Hz_pers_saveVar_markers_pos select _foreachIndex);

} foreach Hz_pers_saveVar_markers_pos;

// Hunter'z Ambient Warfare

if (Hz_pers_enableHzAmbw) then {
	Hz_pers_network_ambw_pat_gSides = +Hz_pers_saveVar_ambw_pat_gSides;
	Hz_pers_network_ambw_pat_gPatMarkers = +Hz_pers_saveVar_ambw_pat_gPatMarkers;			
	Hz_pers_network_ambw_pat_gVehicleTypes = +Hz_pers_saveVar_ambw_pat_gVehicleTypes;
	Hz_pers_network_ambw_pat_gVehicleCrewTypes = +Hz_pers_saveVar_ambw_pat_gVehicleCrewTypes;
	Hz_pers_network_ambw_pat_gInfantryTypes = +Hz_pers_saveVar_ambw_pat_gInfantryTypes;
	Hz_pers_network_ambw_pat_gVehiclePosATL = +Hz_pers_saveVar_ambw_pat_gVehiclePosATL;
	Hz_pers_network_ambw_pat_gVehicleDir = +Hz_pers_saveVar_ambw_pat_gVehicleDir;
	Hz_pers_network_ambw_pat_gInfantryPosATL = +Hz_pers_saveVar_ambw_pat_gInfantryPosATL;	
	
	Hz_pers_network_ambw_sc_sPos = +Hz_pers_saveVar_ambw_sc_sPos;
	Hz_pers_network_ambw_sc_sSides = +Hz_pers_saveVar_ambw_sc_sSides;
	Hz_pers_network_ambw_sc_sObjectTypes = +Hz_pers_saveVar_ambw_sc_sObjectTypes;
	Hz_pers_network_ambw_sc_sObjectPosATL = +Hz_pers_saveVar_ambw_sc_sObjectPosATL;
};

//Run custom code

_func = missionnamespace getvariable [Hz_pers_customLoadFunctionName,{}];
call _func;

call Hz_pers_fnc_updateVariableInfo;

// deallocate -- does arma even do that properly?
//use resize 0?...

_defaultParsingInfo = [];
_defaultPlayerVariableInfo = [];
_defaultVehicleVariableInfo = [];
_defaultObjectVariableInfo = [];
_defaultCrateVariableInfo = [];
Hz_pers_saveVar_vehicles_type = [];
Hz_pers_saveVar_vehicles_customs = [];
Hz_pers_saveVar_vehicles_positionATL = [];
Hz_pers_saveVar_vehicles_vectorUp = [];
Hz_pers_saveVar_vehicles_dir = [];
Hz_pers_saveVar_vehicles_hitpointsdamage = [];
Hz_pers_saveVar_vehicles_fuel = [];
Hz_pers_saveVar_vehicles_magazinesTurrets = [];
Hz_pers_saveVar_vehicles_magazinesAmmoCargo = [];
Hz_pers_saveVar_vehicles_itemsCargo = [];
Hz_pers_saveVar_vehicles_variableValues = [];
Hz_pers_saveVar_vehicles_weaponsItems = [];

Hz_pers_saveVar_objects_type = [];
Hz_pers_saveVar_objects_damage = [];
Hz_pers_saveVar_objects_dir = [];
Hz_pers_saveVar_objects_positionATL = [];
Hz_pers_saveVar_objects_vectorUp = [];
Hz_pers_saveVar_objects_variableValues = [];

Hz_pers_saveVar_markers_type = [];
Hz_pers_saveVar_markers_pos = [];
Hz_pers_saveVar_markers_colour = [];
Hz_pers_saveVar_markers_text = [];

Hz_pers_saveVar_crates_type = [];
Hz_pers_saveVar_crates_damage = [];
Hz_pers_saveVar_crates_dir = [];
Hz_pers_saveVar_crates_positionATL = [];
Hz_pers_saveVar_crates_vectorUp = [];
Hz_pers_saveVar_crates_magazinesAmmoCargo = [];
Hz_pers_saveVar_crates_itemsCargo = [];
Hz_pers_saveVar_crates_variableValues = [];
Hz_pers_saveVar_crates_weaponsItems = [];

Hz_pers_saveVar_ambw_pat_gSides = [];
Hz_pers_saveVar_ambw_pat_gPatMarkers = [];			
Hz_pers_saveVar_ambw_pat_gVehicleTypes = [];
Hz_pers_saveVar_ambw_pat_gVehicleCrewTypes = [];
Hz_pers_saveVar_ambw_pat_gInfantryTypes = [];
Hz_pers_saveVar_ambw_pat_gVehiclePosATL = [];
Hz_pers_saveVar_ambw_pat_gVehicleDir = [];
Hz_pers_saveVar_ambw_pat_gInfantryPosATL = [];

Hz_pers_saveVar_ambw_sc_sPos = [];
Hz_pers_saveVar_ambw_sc_sSides = [];
Hz_pers_saveVar_ambw_sc_sObjectTypes = [];
Hz_pers_saveVar_ambw_sc_sObjectPosATL = [];
