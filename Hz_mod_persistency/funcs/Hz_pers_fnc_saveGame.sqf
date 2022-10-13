/*******************************************************************************
* Copyright (C) 2017-2019 K.Hunter
*
* The source code contained within this file is licensed under a Creative Commons
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
		Hz_pers_saveVar_vehicles_vectorUp pushback (vectorUp _vehicle);
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
		
		Hz_pers_saveVar_vehicles_weaponsItems pushBack (weaponsItemsCargo _vehicle);		
		
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
		Hz_pers_saveVar_objects_vectorUp pushBack (vectorUp _x);
    
    _variables = [];
    _object = _x;
    {				
      _variables pushback (_object getVariable [_x select 0,"nil"]);
      
    } foreach Hz_pers_saveVar_objects_variableNames;
    
    Hz_pers_saveVar_objects_variableValues pushback _variables;
    
  };

} foreach Hz_pers_network_objects;

{

	if (alive _x) then {

		Hz_pers_saveVar_crates_type pushBack (typeof _x);
		Hz_pers_saveVar_crates_damage pushBack (getdammage _x);
		Hz_pers_saveVar_crates_dir pushBack (getdir _x);
		Hz_pers_saveVar_crates_positionATL pushBack (getPosATL _x);
		Hz_pers_saveVar_crates_vectorUp pushBack (vectorUp _x);
		
		_itemsCargo = [];
		_crate = _x;
		
		_magazinesAmmoCargo = magazinesAmmoCargo _crate;
			
		Hz_pers_saveVar_crates_weaponsItems pushBack (weaponsItemsCargo _crate);
		
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
  
	};

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

// Hunter'z Ambient Warfare

if (Hz_pers_enableHzAmbw) then {

	{
		_x params ["_group", "_patrolMarker"];
		_side = side _group;		
		if ((_side == blufor) || {_side == opfor} || {_side == resistance}) then {
			Hz_pers_saveVar_ambw_pat_gSides pushBack (_side call Hz_pers_fnc_sideToStr);
			Hz_pers_saveVar_ambw_pat_gPatMarkers pushBack _patrolMarker;
			private _vehicles = [];
			private _infantryTypes = [];
			private _infantryPosATL = [];
			{
				private _veh = vehicle _x;
				if (_veh != _x) then {
					_vehicles pushBackUnique _veh;
				} else {
					_infantryTypes pushBack (typeOf _x);
					_infantryPosATL pushBack (getPosATL _x);
				};
			} foreach units _group;
			Hz_pers_saveVar_ambw_pat_gVehicleTypes pushBack (_vehicles apply {typeOf _x});
			Hz_pers_saveVar_ambw_pat_gInfantryPosATL pushBack _infantryPosATL;
			Hz_pers_saveVar_ambw_pat_gInfantryTypes pushBack _infantryTypes;
			private _vehiclesCrewTypes = [];
			private _vPosATL = [];
			private _vDir = [];
			{
				_vPosATL pushBack (getPosATL _x);
				_vDir pushBack (getDir _x);
				private _crewTypes = [];
				{
					if (alive _x) then {
						_crewTypes pushBack (typeOf _x);
					};
				} foreach crew _x;
				_vehiclesCrewTypes pushBack _crewTypes;
			} foreach _vehicles;
			Hz_pers_saveVar_ambw_pat_gVehicleCrewTypes pushBack _vehiclesCrewTypes;
			Hz_pers_saveVar_ambw_pat_gVehiclePosATL pushBack _vPosATL;
			Hz_pers_saveVar_ambw_pat_gVehicleDir pushBack _vDir;
		};		
	} foreach Hz_ambw_pat_patrolGroups;
	
	{
		_x params ["_pos", "_radius", "_dir", "_side", "_marker","_flag","_objects"];
		Hz_pers_saveVar_ambw_sc_sPos pushBack _pos;
		Hz_pers_saveVar_ambw_sc_sSides pushBack (_side call Hz_pers_fnc_sideToStr);
		private _objTypes = [];
		private _objPos = [];
		{	
			if (alive _x) then {
				if (_x isKindOf "StaticWeapon") then {
					if (({alive _x} count crew _x) > 0) then {
						_objPos pushBack (getPosATL _x);
						_objTypes pushBack (typeOf _x);
					};
				} else {			
					_objPos pushBack (getPosATL _x);
					_objTypes pushBack (typeOf _x);
				};
			};
		} foreach _objects;
		Hz_pers_saveVar_ambw_sc_sObjectTypes pushBack _objTypes;
		Hz_pers_saveVar_ambw_sc_sObjectPosATL pushBack _objPos;
	} foreach Hz_ambw_sc_sectors;
	
};


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

Hz_pers_saveVar_vehicles_type resize 0;
Hz_pers_saveVar_vehicles_customs resize 0;
Hz_pers_saveVar_vehicles_positionATL resize 0;
Hz_pers_saveVar_vehicles_vectorUp resize 0;
Hz_pers_saveVar_vehicles_dir resize 0;
Hz_pers_saveVar_vehicles_hitpointsdamage resize 0;
Hz_pers_saveVar_vehicles_fuel resize 0;
Hz_pers_saveVar_vehicles_magazinesTurrets resize 0;
Hz_pers_saveVar_vehicles_magazinesAmmoCargo resize 0;
Hz_pers_saveVar_vehicles_itemsCargo resize 0;
Hz_pers_saveVar_vehicles_backpackCargo resize 0;
Hz_pers_saveVar_vehicles_variableValues resize 0;
Hz_pers_saveVar_vehicles_weaponsItems resize 0;

Hz_pers_saveVar_objects_type resize 0;
Hz_pers_saveVar_objects_damage resize 0;
Hz_pers_saveVar_objects_dir resize 0;
Hz_pers_saveVar_objects_positionATL resize 0;
Hz_pers_saveVar_objects_vectorUp resize 0;
Hz_pers_saveVar_objects_variableValues resize 0;

Hz_pers_saveVar_markers_type resize 0;
Hz_pers_saveVar_markers_pos resize 0;
Hz_pers_saveVar_markers_colour resize 0;
Hz_pers_saveVar_markers_text resize 0;

Hz_pers_saveVar_crates_type resize 0;
Hz_pers_saveVar_crates_damage resize 0;
Hz_pers_saveVar_crates_dir resize 0;
Hz_pers_saveVar_crates_positionATL resize 0;
Hz_pers_saveVar_crates_vectorUp resize 0;
Hz_pers_saveVar_crates_magazinesAmmoCargo resize 0;
Hz_pers_saveVar_crates_itemsCargo resize 0;
Hz_pers_saveVar_crates_backpackCargo resize 0;
Hz_pers_saveVar_crates_variableValues resize 0;
Hz_pers_saveVar_crates_weaponsItems resize 0;

if (Hz_pers_enableHzAmbw) then {

	Hz_pers_saveVar_ambw_pat_gSides resize 0;
	Hz_pers_saveVar_ambw_pat_gPatMarkers resize 0;			
	Hz_pers_saveVar_ambw_pat_gVehicleTypes resize 0;
	Hz_pers_saveVar_ambw_pat_gVehicleCrewTypes resize 0;
	Hz_pers_saveVar_ambw_pat_gInfantryTypes resize 0;
	Hz_pers_saveVar_ambw_pat_gVehiclePosATL resize 0;
	Hz_pers_saveVar_ambw_pat_gVehicleDir resize 0;
	Hz_pers_saveVar_ambw_pat_gInfantryPosATL resize 0;

	Hz_pers_saveVar_ambw_sc_sPos resize 0;
	Hz_pers_saveVar_ambw_sc_sSides resize 0;
	Hz_pers_saveVar_ambw_sc_sObjectTypes resize 0;
	Hz_pers_saveVar_ambw_sc_sObjectPosATL resize 0;

};