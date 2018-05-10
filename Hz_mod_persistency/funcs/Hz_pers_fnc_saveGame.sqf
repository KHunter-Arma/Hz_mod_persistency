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

#include "..\parsing_descriptors.txt"
#include "debug_console.hpp"

// force current connected clients to save (not saving dead guys for now... lots of problems to think about there)

{

	[] remoteExecCall ["Hz_pers_fnc_clientSendLocalVars",_x,false];

} foreach allPlayers;

sleep (2*(count allPlayers)/4);

{

	[_x, nil, getplayeruid _x,nil,true] call Hz_pers_fnc_handleDisconnect;

} foreach allPlayers;
	
	
//get vehicle info

{
  if(alive _x) then {
    
    _vehicle = _x;
    
    Hz_pers_saveVar_vehicles_type pushBack (typeof _vehicle);				
    Hz_pers_saveVar_vehicles_customs pushback (_vehicle call bis_fnc_getVehicleCustomization);
    Hz_pers_saveVar_vehicles_positionATL pushback (getposatl _vehicle);
    Hz_pers_saveVar_vehicles_dir pushBack (getdir _vehicle);
    Hz_pers_saveVar_vehicles_hitpointsdamage pushBack (getAllHitPointsDamage _vehicle);
    Hz_pers_saveVar_vehicles_fuel pushBack (fuel _vehicle);
    
    _turrPaths = allTurrets [_vehicle, false];
    _turrCount = count _turrPaths;
    
    if (_turrCount > 0) then {
      
      _magTurretArray = [[],[],[]];
      
      for "_i" from 0 to (_turrCount - 1) do {

        _turret = _turrPaths select _i;
        _mags = _vehicle magazinesturret _turret;				

        {
          if(!(_x in (_magTurretArray select 1))) then {
            _magType = _x;
            _cnt = {_x == _magType} count _mags;
            (_magTurretArray select 0) pushback _turret;
            (_magTurretArray select 1) pushBack _magType;
            (_magTurretArray select 2) pushBack _cnt;					
          };		
        }foreach _mags;
        
      };                               
      
      Hz_pers_saveVar_vehicles_magazinesTurrets pushback _magTurretArray;
      
    } else {
      
      Hz_pers_saveVar_vehicles_magazinesTurrets pushBack [[],[],[]];
      
    };

    _itemsCargo = [];
		_magazinesAmmoCargo = magazinesAmmoCargo _vehicle;
		
		{
		
			_itemsCargo pushBack ([_x select 0] call bis_fnc_baseweapon);	
			
			{
			
				if (_x != "") then {
				
					_itemsCargo pushBack _x;
				
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
		
		} foreach weaponsItemsCargo _vehicle;		
		
		Hz_pers_saveVar_vehicles_magazinesAmmoCargo pushBack _magazinesAmmoCargo;		
		
    {

      if (!("CA_Magazine" in ([(configfile >> "cfgmagazines" >> _x), true] call bis_fnc_returnParents))) then {

        _itemsCargo pushback _x;

      };

    } foreach (itemCargo _vehicle);

    Hz_pers_saveVar_vehicles_itemsCargo pushBack (_itemsCargo call Hz_pers_fnc_convert1DArrayTo2D);
		
		Hz_pers_saveVar_vehicles_backpackCargo pushBack ((backpackCargo _vehicle) call Hz_pers_fnc_convert1DArrayTo2D);
    
    _variables = [];
    {
			if ((_x select 0) == "ace_cargo_loaded") then {
			
				_correctedList = _vehicle getVariable ["ace_cargo_loaded",[]];
				
				{
				
					if ((typename _x) == "OBJECT") then {
					
						_correctedList set [_foreachIndex, typeof _x];
					
					};
				
				} foreach _correctedList;
				
				_variables pushback _correctedList;
			
			} else {
			
				_variables pushback (_vehicle getVariable [_x select 0,"nil"]);
			
			};
		
    } foreach Hz_pers_saveVar_vehicles_variableNames;
    
    Hz_pers_saveVar_vehicles_variableValues pushback _variables;			
    
  };
  
} foreach Hz_pers_network_vehicles;

{

  if(alive _x) then {
    
    Hz_pers_saveVar_objects_type pushBack (typeof _x);
    Hz_pers_saveVar_objects_damage pushBack (getdammage _x);
    Hz_pers_saveVar_objects_dir pushBack (getdir _x);
    Hz_pers_saveVar_objects_positionATL pushBack (getPosATL _x);
    
    _variables = [];
    _object = _x;
    {				
      _variables pushback (_object getVariable [_x select 0,"nil"]);
      
    } foreach Hz_pers_saveVar_objects_variableNames;
    
    Hz_pers_saveVar_objects_variableValues pushback _variables;
    
  };

} foreach Hz_pers_network_objects;

{

  Hz_pers_saveVar_crates_type pushBack (typeof _x);
  Hz_pers_saveVar_crates_damage pushBack (getdammage _x);
  Hz_pers_saveVar_crates_dir pushBack (getdir _x);
  Hz_pers_saveVar_crates_positionATL pushBack (getPosATL _x);
  
  _itemsCargo = [];
  _crate = _x;
	
	_magazinesAmmoCargo = magazinesAmmoCargo _crate;
		
	{
	
		_itemsCargo pushBack ([_x select 0] call bis_fnc_baseweapon);	
		
		{
		
			if (_x != "") then {
			
				_itemsCargo pushBack _x;
			
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
	
	} foreach weaponsItemsCargo _crate;
	
	Hz_pers_saveVar_crates_magazinesAmmoCargo pushback _magazinesAmmoCargo;
	
  {

    if (!("CA_Magazine" in ([(configfile >> "cfgmagazines" >> _x), true] call bis_fnc_returnParents))) then {

      _itemsCargo pushback _x;

    };

  } foreach (itemCargo _crate);

  Hz_pers_saveVar_crates_itemsCargo pushBack (_itemsCargo call Hz_pers_fnc_convert1DArrayTo2D);
  
	Hz_pers_saveVar_crates_backpackCargo pushBack ((backpackCargo _crate) call Hz_pers_fnc_convert1DArrayTo2D);
  
  _variables = [];
  {				
    _variables pushback (_crate getVariable [_x select 0,"nil"]);
    
  } foreach Hz_pers_saveVar_crates_variableNames;
  
  Hz_pers_saveVar_crates_variableValues pushback _variables;
  

} foreach Hz_pers_network_crates;

//get user placed markers

{

  if (((_x find "_USER_DEFINED #") != -1) && ((markerShape _x) == "ICON")) then {

    Hz_pers_saveVar_markers_type pushBack (markerType _x);
    Hz_pers_saveVar_markers_pos pushBack (markerpos _x);
    Hz_pers_saveVar_markers_colour pushBack (markerColor _x);
    Hz_pers_saveVar_markers_text pushBack (markerText _x);

  };

} foreach allMapMarkers;

//write parsing info to file as 1D array for safety
_splitArrays = [(missionnamespace getvariable ["Hz_pers_parsingInfo",[]]), Hz_pers_maxWriteArraySize] call Hz_pers_fnc_arraySplitter;
[_splitArrays, "Hz_pers_parsingInfo"] call Hz_pers_fnc_splitArrayWriter;    

{
  _objectName = _x select 0;
  
  switch (_x select 1) do {
    
  case SINGLE_VARIABLE : {
      
      _variable = missionnamespace getvariable [_objectName,"nil"];
      if ((typeName _variable) == "STRING") then {
        
        _save = format ['%1 = "%2";',_objectName, _variable];
        conFile(_save);
        
      } else {
        
        _save = format ["%1 = %2;",_objectName, _variable];
        conFile(_save);
        
      };		
      
    };
    
  case ONE_D_ARRAY : {
      
      _splitArrays = [(missionnamespace getvariable [_objectName,[]]), Hz_pers_maxWriteArraySize] call Hz_pers_fnc_arraySplitter;
      [_splitArrays, _objectName] call Hz_pers_fnc_splitArrayWriter;     
      
    };
    
  case NESTED_ARRAY_STRUCT : {
      
      [(missionnamespace getvariable [_objectName,[]]), _objectName, Hz_pers_maxWriteArraySize] call Hz_pers_fnc_nestedArrayStructWriter;
      
    };
    
  case ARRAY_OF_STRUCTS : {
      
      [(missionnamespace getvariable [_objectName,[]]), _objectName, Hz_pers_maxWriteArraySize] call Hz_pers_fnc_structArrayWriter;
      
    };
    
    default {};    
    
  };
  
} foreach Hz_pers_parsingInfo; 

//close console
conClose();

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