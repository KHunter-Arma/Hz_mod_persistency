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

#include "parsing_descriptors.txt"

Hz_pers_funcs_path = Hz_pers_path + "funcs\";

Hz_pers_clientConnectSafeguardArray = [];

// init public variables that should be persistent throughout server uptime

Hz_pers_network_vehicles = [];
Hz_pers_network_objects = [];
Hz_pers_network_crates = [];
Hz_pers_saveVar_players_variableNames = [];
publicVariable "Hz_pers_network_vehicles";
publicVariable "Hz_pers_saveVar_players_variableNames";
publicVariable "Hz_pers_network_objects";
publicVariable "Hz_pers_network_crates";

// init server-side variables that should be persistent throughout server uptime

Hz_pers_saveVar_vehicles_variableNames = [];
Hz_pers_saveVar_crates_variableNames = [];
Hz_pers_saveVar_objects_variableNames = [];

Hz_pers_saveVar_players_UID = [];
Hz_pers_saveVar_players_vestType = [];
Hz_pers_saveVar_players_uniformType = [];
Hz_pers_saveVar_players_backpackType = [];
Hz_pers_saveVar_players_headGear = [];
Hz_pers_saveVar_players_goggles = [];
Hz_pers_saveVar_players_positionATL = [];
Hz_pers_saveVar_players_dir = [];
Hz_pers_saveVar_players_anim = [];
Hz_pers_saveVar_players_assignedItems = [];
Hz_pers_saveVar_players_backpackMagazines = [];
Hz_pers_saveVar_players_vestMagazines = [];
Hz_pers_saveVar_players_uniformMagazines = [];
Hz_pers_saveVar_players_uniformItems = [];
Hz_pers_saveVar_players_vestItems = [];
Hz_pers_saveVar_players_backpackItems = [];
Hz_pers_saveVar_players_weaponsItems = [];
Hz_pers_saveVar_players_hitpointsdamage = [];
Hz_pers_saveVar_players_variableValues = [];

//init global variables used for temporarily storing and outputting save data

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

Hz_pers_saveVar_crates_type = [];
Hz_pers_saveVar_crates_damage = [];
Hz_pers_saveVar_crates_dir = [];
Hz_pers_saveVar_crates_positionATL = [];
Hz_pers_saveVar_crates_magazinesAmmoCargo = [];
Hz_pers_saveVar_crates_itemsCargo = [];
Hz_pers_saveVar_crates_variableValues = [];

Hz_pers_saveVar_markers_type = [];
Hz_pers_saveVar_markers_pos = [];
Hz_pers_saveVar_markers_colour = [];
Hz_pers_saveVar_markers_text = [];

// compile funcs
Hz_pers_fnc_handleAcreRadios = compile preprocessFileLineNumbers (Hz_pers_funcs_path + "Hz_pers_fnc_handleAcreRadios.sqf");
Hz_pers_fnc_handleDisconnect = compile preprocessFileLineNumbers (Hz_pers_funcs_path + "Hz_pers_fnc_handleDisconnect.sqf");
Hz_pers_fnc_handleConnect = compile preprocessFileLineNumbers (Hz_pers_funcs_path + "Hz_pers_fnc_handleConnect.sqf");
Hz_pers_fnc_arrayParser = compile preprocessFileLineNumbers (Hz_pers_funcs_path + "Hz_pers_fnc_arrayParser.sqf");
Hz_pers_fnc_arraySplitter = compile preprocessFileLineNumbers (Hz_pers_funcs_path + "Hz_pers_fnc_arraySplitter.sqf");
Hz_pers_fnc_nestedArrayStructParser = compile preprocessFileLineNumbers (Hz_pers_funcs_path + "Hz_pers_fnc_nestedArrayStructParser.sqf");
Hz_pers_fnc_nestedArrayStructWriter = compile preprocessFileLineNumbers (Hz_pers_funcs_path + "Hz_pers_fnc_nestedArrayStructWriter.sqf");
Hz_pers_fnc_splitArrayWriter = compile preprocessFileLineNumbers (Hz_pers_funcs_path + "Hz_pers_fnc_splitArrayWriter.sqf");
Hz_pers_fnc_structArrayElementParser = compile preprocessFileLineNumbers (Hz_pers_funcs_path + "Hz_pers_fnc_structArrayElementParser.sqf");
Hz_pers_fnc_structArrayParser = compile preprocessFileLineNumbers (Hz_pers_funcs_path + "Hz_pers_fnc_structArrayParser.sqf");
Hz_pers_fnc_structArrayWriter = compile preprocessFileLineNumbers (Hz_pers_funcs_path + "Hz_pers_fnc_structArrayWriter.sqf");
Hz_pers_fnc_saveGame = compile preprocessFileLineNumbers (Hz_pers_funcs_path + "Hz_pers_fnc_saveGame.sqf");
Hz_pers_fnc_convert1DArrayTo2D = compile preprocessFileLineNumbers (Hz_pers_funcs_path + "Hz_pers_fnc_convert1DArrayTo2D.sqf");
Hz_pers_fnc_receiveLocalVars = compile preprocessFileLineNumbers (Hz_pers_funcs_path + "Hz_pers_fnc_receiveLocalVars.sqf");
Hz_pers_fnc_loadGame = compile preprocessFileLineNumbers (Hz_pers_funcs_path + "Hz_pers_fnc_loadGame.sqf");
Hz_pers_fnc_handleFirstTimeLaunch = compile preprocessFileLineNumbers (Hz_pers_funcs_path + "Hz_pers_fnc_handleFirstTimeLaunch.sqf");
Hz_pers_fnc_ackClientLoadSuccess = compile preprocessFileLineNumbers (Hz_pers_funcs_path + "Hz_pers_fnc_ackClientLoadSuccess.sqf");

//init parsing info
Hz_pers_parsingInfo = [
  ["Hz_pers_saveVar_vehicles_type",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_vehicles_customs",ARRAY_OF_STRUCTS,false],
  ["Hz_pers_saveVar_vehicles_positionATL",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_vehicles_hitpointsdamage",ARRAY_OF_STRUCTS,false],
  ["Hz_pers_saveVar_vehicles_dir",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_vehicles_fuel",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_vehicles_magazinesTurrets",ARRAY_OF_STRUCTS,false],
  ["Hz_pers_saveVar_vehicles_magazinesAmmoCargo",NESTED_ARRAY_STRUCT,false],
  ["Hz_pers_saveVar_vehicles_itemsCargo",ARRAY_OF_STRUCTS,false],
  ["Hz_pers_saveVar_vehicles_variableValues",NESTED_ARRAY_STRUCT,false],
  ["Hz_pers_saveVar_objects_type",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_objects_damage",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_objects_dir",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_objects_positionATL",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_objects_variableValues",NESTED_ARRAY_STRUCT,false],
  ["Hz_pers_saveVar_crates_type",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_crates_damage",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_crates_dir",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_crates_positionATL",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_crates_magazinesAmmoCargo",NESTED_ARRAY_STRUCT,false],
  ["Hz_pers_saveVar_crates_itemsCargo",ARRAY_OF_STRUCTS,false],
  ["Hz_pers_saveVar_crates_variableValues",NESTED_ARRAY_STRUCT,false],
  ["Hz_pers_saveVar_players_variableNames",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_vehicles_variableNames",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_crates_variableNames",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_objects_variableNames",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_players_UID",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_players_vestType",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_players_uniformType",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_players_backpackType",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_players_headGear",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_players_goggles",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_players_positionATL",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_players_dir",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_players_anim",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_players_assignedItems",NESTED_ARRAY_STRUCT,false],
  ["Hz_pers_saveVar_players_backpackMagazines",NESTED_ARRAY_STRUCT,false],
  ["Hz_pers_saveVar_players_vestMagazines",NESTED_ARRAY_STRUCT,false],
  ["Hz_pers_saveVar_players_uniformMagazines",NESTED_ARRAY_STRUCT,false],
  ["Hz_pers_saveVar_players_uniformItems",ARRAY_OF_STRUCTS,false],
  ["Hz_pers_saveVar_players_vestItems",ARRAY_OF_STRUCTS,false],
  ["Hz_pers_saveVar_players_backpackItems",ARRAY_OF_STRUCTS,false],
  ["Hz_pers_saveVar_players_weaponsItems",ARRAY_OF_STRUCTS,false],
  ["Hz_pers_saveVar_players_hitpointsdamage",ARRAY_OF_STRUCTS,false],
  ["Hz_pers_saveVar_players_variableValues",NESTED_ARRAY_STRUCT,false],
  ["Hz_pers_saveVar_markers_type",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_markers_pos", ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_markers_colour", ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_markers_text",ONE_D_ARRAY,false]
];


//load custom parameters from module framework
private _logic = _this select 0;
Hz_pers_enableACEmedical = _logic getVariable "AceMedical";
Hz_pers_firstTimeLaunchHandlerFunctionName = _logic getVariable "FirstTimeLaunchHandlerFunctionName";
Hz_pers_maxWriteArraySize = call compile (_logic getVariable "MaxArraySize");
Hz_pers_customLoadFunctionName = _logic getVariable "CustomLoadFunctionName";
Hz_pers_autoLoadDelay = call compile (_logic getVariable "AutoLoadDelay");
Hz_pers_pathToSaveFile = _logic getVariable "PathToSaveFile";


if (isclass (configfile >> "cfgpatches" >> "ace_hearing")) then {

	Hz_pers_saveVar_players_variableNames pushBackUnique ["ACE_hasEarPlugsin",false];

};

if (isclass (configfile >> "cfgpatches" >> "ace_cargo")) then {

	Hz_pers_saveVar_vehicles_variableNames pushBackUnique ["ace_cargo_loaded",true];
	
	["ace_cargoUnloaded", {
	
		_item = _this select 0;
	
		if ((typeName _item) == "OBJECT") exitWith {
		
			_item call hz_pers_api_addobject;
		
		};
				
		_nearItems = nearestobjects [_this select 1, [_item], 20];
		
		{
		
			if (!(_x in Hz_pers_network_objects)) exitWith {
			
				_x call hz_pers_api_addobject;
			
			};
		
		} foreach _nearItems;
			
	}] call CBA_fnc_addEventHandler;
	
	["ace_cargoLoaded", {
	
		_item = _this select 0;
	
		if ((typeName _item) == "OBJECT") exitWith {
		
			Hz_pers_network_objects = Hz_pers_network_objects - [_item];
			publicVariable "Hz_pers_network_objects";
		
		};
			
	}] call CBA_fnc_addEventHandler;
	
};

if (Hz_pers_enableACEmedical) then {

  {

    Hz_pers_saveVar_players_variableNames pushBackUnique _x;

  } foreach [
						["ace_medical_pain",true],
            ["ace_medical_morphine",true],
            ["ace_medical_bloodVolume",true],
            ["ACE_isUnconscious",true],
            ["ace_medical_tourniquets",true],
            ["ace_medical_occludedMedications",true],
            ["ace_medical_openWounds",true],
            ["ace_medical_bandagedWounds",true],
            ["ace_medical_internalWounds",true],
            ["ace_medical_lastUniqueWoundID",true],
            ["ace_medical_heartRate",false],
            ["ace_medical_heartRateAdjustments",false],
            ["ace_medical_bloodPressure",false],
            ["ace_medical_peripheralResistance",false],
            ["ace_medical_fractures",true],
            ["ace_medical_triageLevel",true],
            ["ace_medical_triageCard",true],
            ["ace_medical_ivBags",true],
            ["ace_medical_bodyPartStatus",true],
            ["ace_medical_airwayStatus",false],
            ["ace_medical_airwayOccluded",false],
            ["ace_medical_airwayCollapsed",false],
            ["ace_medical_addedToUnitLoop",true],
            ["ace_medical_inCardiacArrest",true],
            ["ace_medical_hasLostBlood",true],
            ["ace_medical_isBleeding",true],
            ["ace_medical_hasPain",true],
            ["ace_medical_amountOfReviveLives",true],
            ["ace_medical_painSuppress",true],
            ["ace_medical_allUsedMedication",true],
            ["ace_medical_allLogs",true]
            ];

};

publicVariable "Hz_pers_saveVar_players_variableNames";

//auto-load
_logic spawn {

	_loadCodeString = preprocessfilelinenumbers Hz_pers_pathToSaveFile;
	
	if (_loadCodeString == "") then {
	
		call Hz_pers_fnc_handleFirstTimeLaunch;
	
	} else {

		sleep Hz_pers_autoLoadDelay;

		_loadCodeString call Hz_pers_fnc_loadGame;
	
	};
	
	private _delay = call compile (_this getVariable "AutoSaveFreq");
	
	while {true} do {
	
		uisleep _delay;
		
		call Hz_pers_fnc_saveGame;
	
	};

};

//set EH
addMissionEventHandler ["PlayerConnected",Hz_pers_fnc_handleConnect];
addMissionEventHandler ["HandleDisconnect",Hz_pers_fnc_handleDisconnect];