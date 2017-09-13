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

#include "parsing_descriptors.txt"

call compile preprocessfilelinenumbers Hz_pers_pathToSaveFile;

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
  
} foreach Hz_pers_parsingInfo;   

_indexVehicle = (count Hz_pers_saveVar_vehicles_type) - 1;  
_indexObject = (count Hz_pers_saveVar_objects_type) - 1;
_indexCrate = (count Hz_pers_saveVar_crates_type) - 1;

/////////////////////////////////////////////////////////////////////////////////////////

//Load Vehicles
_index = 0;

if (_indexVehicle >= 0) then {
  
  for "_i" from 0 to _indexVehicle do {
    
    _veh = (Hz_pers_saveVar_vehicles_type select _index) createvehicle [-5000,-5000,0];
    Hz_pers_network_vehicles pushBack _veh;
    
    clearMagazineCargoGlobal _veh;
    clearWeaponCargoGlobal _veh;
    clearItemCargoGlobal _veh;

    _itemIndex = (count ((Hz_pers_saveVar_vehicles_itemsCargo select _index) select 0)) - 1;
    if (_itemIndex >= 0) then {
      for "_j" from 0 to _itemIndex do {
        _veh addItemCargoGlobal[(((Hz_pers_saveVar_vehicles_itemsCargo select _index) select 0) select _j),(((Hz_pers_saveVar_vehicles_itemsCargo select _index) select 1) select _j)];
      };
    };
    
    _magazineAmmoIndex = (count (Hz_pers_saveVar_vehicles_magazinesAmmoCargo select _index)) - 1;
    if (_magazineAmmoIndex >= 0) then {
      for "_j" from 0 to _magazineAmmoIndex do {
        _veh addMagazineAmmoCargo [(((Hz_pers_saveVar_vehicles_magazinesAmmoCargo select _index) select _j) select 0),1,(((Hz_pers_saveVar_vehicles_magazinesAmmoCargo select _index) select _j) select 1)];
      };		
    };		
    
    _veh setdir (Hz_pers_saveVar_vehicles_dir select _index);
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
    
    _veh setVehicleAmmo 0;
    _magazinesTurretIndex = (count ((Hz_pers_saveVar_vehicles_magazinesTurrets select _index) select 0)) - 1;
    if(_magazinesTurretIndex >= 0) then {
      
      for "_j" from 0 to _magazinesTurretIndex do {
        
        for "_k" from 1 to (((Hz_pers_saveVar_vehicles_magazinesTurrets select _index) select 2) select _j) do {
          
          _veh addMagazineTurret [(((Hz_pers_saveVar_vehicles_magazinesTurrets select _index) select 1) select _j),(((Hz_pers_saveVar_vehicles_magazinesTurrets select _index) select 0) select _j)];
          
        };
      };	

    };
    
    _variableValues = Hz_pers_saveVar_vehicles_variableValues select _index;
    {
      
      _value = _variableValues select _foreachIndex;
      
      if (_value != "nil") then {
        
        _veh setvariable [_x,_value];
        
      };
      
    } foreach Hz_pers_saveVar_vehicles_variableNames;
    
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
    _obj setposatl (Hz_pers_saveVar_objects_positionATL select _index);
    
    _variableValues = Hz_pers_saveVar_objects_variableValues select _index;
    {
      
      _value = _variableValues select _foreachIndex;
      
      if (_value != "nil") then {
        
        _obj setvariable [_x,_value];
        
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
    _crate setposatl (Hz_pers_saveVar_crates_positionATL select _index);
    
    clearMagazineCargoGlobal _crate;
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
        _crate addItemCargoGlobal[(((Hz_pers_saveVar_crates_itemsCargo select _index) select 0) select _j),(((Hz_pers_saveVar_crates_itemsCargo select _index) select 1) select _j)];
      };
    };
    
    _variableValues = Hz_pers_saveVar_crates_variableValues select _index;
    {
      
      _value = _variableValues select _foreachIndex;
      
      if (_value != "nil") then {
        
        _crate setvariable [_x,_value];
        
      };
      
    } foreach Hz_pers_saveVar_crates_variableNames;
    
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

//Run custom code

_func = missionnamespace getvariable [Hz_pers_customLoadFunctionName,{}];
call _func;


// deallocate

Hz_pers_saveVar_vehicles_type = [];
Hz_pers_saveVar_vehicles_customs = [];
Hz_pers_saveVar_vehicles_positionATL = [];
Hz_pers_saveVar_vehicles_dir = [];
Hz_pers_saveVar_vehicles_hitpointsdamage = [];
Hz_pers_saveVar_vehicles_fuel = [];
Hz_pers_saveVar_vehicles_magazinesTurrets = [];
Hz_pers_saveVar_vehicles_magazinesAmmoCargo = [];
Hz_pers_saveVar_vehicles_itemsCargo = [];
Hz_pers_saveVar_vehicles_variableValues = [];

Hz_pers_saveVar_objects_type = [];
Hz_pers_saveVar_objects_damage = [];
Hz_pers_saveVar_objects_dir = [];
Hz_pers_saveVar_objects_positionATL = [];
Hz_pers_saveVar_objects_variableValues = [];

Hz_pers_saveVar_markers_type = [];
Hz_pers_saveVar_markers_pos = [];
Hz_pers_saveVar_markers_colour = [];
Hz_pers_saveVar_markers_text = [];

Hz_pers_saveVar_crates_type = [];
Hz_pers_saveVar_crates_damage = [];
Hz_pers_saveVar_crates_dir = [];
Hz_pers_saveVar_crates_positionATL = [];
Hz_pers_saveVar_crates_magazinesAmmoCargo = [];
Hz_pers_saveVar_crates_itemsCargo = [];
Hz_pers_saveVar_crates_variableValues = [];