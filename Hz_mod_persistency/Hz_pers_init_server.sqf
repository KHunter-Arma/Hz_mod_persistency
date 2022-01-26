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

#include "parsing_descriptors.txt"

Hz_pers_funcs_path = Hz_pers_path + "funcs\";

Hz_pers_clientConnectSafeguardArray = [];
Hz_pers_serverInitialised = false;
publicVariable "Hz_pers_serverInitialised";

// init public variables that should be persistent throughout server uptime

Hz_pers_network_vehicles = [];
Hz_pers_network_objects = [];
Hz_pers_network_crates = [];
Hz_pers_saveVar_players_variableNames = [];

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
Hz_pers_saveVar_vehicles_vectorUp = [];
Hz_pers_saveVar_vehicles_dir = [];
Hz_pers_saveVar_vehicles_hitpointsdamage = [];
Hz_pers_saveVar_vehicles_fuel = [];
Hz_pers_saveVar_vehicles_magazinesTurrets = [];
Hz_pers_saveVar_vehicles_magazinesAmmoCargo = [];
Hz_pers_saveVar_vehicles_itemsCargo = [];
Hz_pers_saveVar_vehicles_backpackCargo = [];
Hz_pers_saveVar_vehicles_variableValues = [];
Hz_pers_saveVar_vehicles_weaponsItems = [];

Hz_pers_saveVar_objects_type = [];
Hz_pers_saveVar_objects_damage = [];
Hz_pers_saveVar_objects_dir = [];
Hz_pers_saveVar_objects_vectorUp = [];
Hz_pers_saveVar_objects_positionATL = [];
Hz_pers_saveVar_objects_variableValues = [];

Hz_pers_saveVar_crates_type = [];
Hz_pers_saveVar_crates_damage = [];
Hz_pers_saveVar_crates_dir = [];
Hz_pers_saveVar_crates_vectorUp = [];
Hz_pers_saveVar_crates_positionATL = [];
Hz_pers_saveVar_crates_magazinesAmmoCargo = [];
Hz_pers_saveVar_crates_itemsCargo = [];
Hz_pers_saveVar_crates_backpackCargo = [];
Hz_pers_saveVar_crates_variableValues = [];
Hz_pers_saveVar_crates_weaponsItems = [];

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
Hz_pers_fnc_updateSaveDataVersion = compile preprocessFileLineNumbers (Hz_pers_funcs_path + "Hz_pers_fnc_updateSaveDataVersion.sqf");
Hz_pers_fnc_updateVariableInfo = compile preprocessFileLineNumbers (Hz_pers_funcs_path + "Hz_pers_fnc_updateVariableInfo.sqf");
Hz_pers_fnc_sendHzAmbwInfoToHc = compile preprocessFileLineNumbers (Hz_pers_funcs_path + "Hz_pers_fnc_sendHzAmbwInfoToHc.sqf");
Hz_pers_fnc_strToSide = compile preprocessFileLineNumbers (Hz_pers_funcs_path + "Hz_pers_fnc_strToSide.sqf");
Hz_pers_fnc_sideToStr = compile preprocessFileLineNumbers (Hz_pers_funcs_path + "Hz_pers_fnc_sideToStr.sqf");

//current save-file version
Hz_pers_currentSaveFileVersion = 220123;

//init parsing info
Hz_pers_parsingInfo = [
  ["Hz_pers_saveVar_vehicles_type",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_vehicles_customs",ARRAY_OF_STRUCTS,false],
  ["Hz_pers_saveVar_vehicles_positionATL",ONE_D_ARRAY,false],
	["Hz_pers_saveVar_vehicles_vectorUp",ONE_D_ARRAY,false],	
  ["Hz_pers_saveVar_vehicles_hitpointsdamage",ARRAY_OF_STRUCTS,false],
  ["Hz_pers_saveVar_vehicles_dir",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_vehicles_fuel",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_vehicles_magazinesTurrets",ARRAY_OF_STRUCTS,false],
  ["Hz_pers_saveVar_vehicles_magazinesAmmoCargo",NESTED_ARRAY_STRUCT,false],
  ["Hz_pers_saveVar_vehicles_itemsCargo",ARRAY_OF_STRUCTS,false],
	["Hz_pers_saveVar_vehicles_backpackCargo",ARRAY_OF_STRUCTS,false],
  ["Hz_pers_saveVar_vehicles_variableValues",NESTED_ARRAY_STRUCT,false],
  ["Hz_pers_saveVar_objects_type",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_objects_damage",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_objects_dir",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_objects_positionATL",ONE_D_ARRAY,false],
	["Hz_pers_saveVar_objects_vectorUp",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_objects_variableValues",NESTED_ARRAY_STRUCT,false],
  ["Hz_pers_saveVar_crates_type",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_crates_damage",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_crates_dir",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_crates_positionATL",ONE_D_ARRAY,false],
	["Hz_pers_saveVar_crates_vectorUp",ONE_D_ARRAY,false],
  ["Hz_pers_saveVar_crates_magazinesAmmoCargo",NESTED_ARRAY_STRUCT,false],
  ["Hz_pers_saveVar_crates_itemsCargo",ARRAY_OF_STRUCTS,false],
	["Hz_pers_saveVar_crates_backpackCargo",ARRAY_OF_STRUCTS,false],
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
  ["Hz_pers_saveVar_markers_text",ONE_D_ARRAY,false],
	["Hz_pers_saveVar_saveFileVersion", SINGLE_VARIABLE, false],
	["Hz_pers_saveVar_vehicles_weaponsItems",ARRAY_OF_STRUCTS,false],
	["Hz_pers_saveVar_crates_weaponsItems",ARRAY_OF_STRUCTS,false]	
];


//load custom parameters from module framework
private _logic = _this select 0;
Hz_pers_enableACEmedical = _logic getVariable "AceMedical";
Hz_pers_firstTimeLaunchHandlerFunctionName = _logic getVariable "FirstTimeLaunchHandlerFunctionName";
Hz_pers_maxWriteArraySize = call compile (_logic getVariable "MaxArraySize");
Hz_pers_customLoadFunctionName = _logic getVariable "CustomLoadFunctionName";
Hz_pers_autoLoadDelay = call compile (_logic getVariable "AutoLoadDelay");
Hz_pers_pathToSaveFile = _logic getVariable "PathToSaveFile";
Hz_pers_objectsLoadDelay = call compile (_logic getVariable "ObjectsLoadDelay");
Hz_pers_enableACEXFieldRations = _logic getVariable "AcexFieldRations";

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
						["ace_medical_inPain",true],					
            ["ace_medical_morphine",true],   //remove
            ["ace_medical_bloodVolume",true],
						["ace_medical_hemorrhage",true],
            //["ACE_isUnconscious",true],
            ["ace_medical_tourniquets",true],
            ["ace_medical_occludedMedications",true],
            ["ace_medical_openWounds",true],
            ["ace_medical_bandagedWounds",true],
            ["ace_medical_internalWounds",true],  //remove
						["ace_medical_stitchedWounds",true],
						["ace_medical_isLimping",true],
						["ace_medical_bodyPartDamage",true],
						["ace_medical_medications",true],
						//["ace_medical_lastWakeUpCheck",true], //add?						
            ["ace_medical_lastUniqueWoundID",true],  //possibly will be removed from future versions of ACE
            ["ace_medical_heartRate",true],
            ["ace_medical_heartRateAdjustments",false], //remove
            ["ace_medical_bloodPressure",true],
            ["ace_medical_peripheralResistance",true],
            ["ace_medical_fractures",true],
            ["ace_medical_triageLevel",true],
            ["ace_medical_triageCard",true],
            ["ace_medical_ivBags",true],
            ["ace_medical_bodyPartStatus",true], //remove
            ["ace_medical_airwayStatus",false], //remove?
            ["ace_medical_airwayOccluded",false], //remove?
            ["ace_medical_airwayCollapsed",false], //remove?
            //["ace_medical_addedToUnitLoop",true],
            ["ace_medical_inCardiacArrest",true],
            ["ace_medical_hasLostBlood",true], //remove
            ["ace_medical_isBleeding",true], //remove
            ["ace_medical_hasPain",true], //remove
            ["ace_medical_amountOfReviveLives",true], //remove
            ["ace_medical_painSuppress",true],
            ["ace_medical_allUsedMedication",true], //remove
            ["ace_medical_allLogs",true]
            ];

};

if (Hz_pers_enableACEXFieldRations) then {

  {

    Hz_pers_saveVar_players_variableNames pushBackUnique _x;

  } foreach [
              ["acex_field_rations_hunger",false],
              ["acex_field_rations_thirst",false]
            ];

  {
    
    Hz_pers_saveVar_objects_variableNames pushBackUnique _x;
  
  } foreach [
              ["ace_field_rations_currentWaterSupply",true] 
            ];
						
	{
    
    Hz_pers_saveVar_vehicles_variableNames pushBackUnique _x;
  
  } foreach [
              ["ace_field_rations_currentWaterSupply",true] 
            ];					

};

publicVariable "Hz_pers_network_vehicles";
publicVariable "Hz_pers_saveVar_players_variableNames";
publicVariable "Hz_pers_network_objects";
publicVariable "Hz_pers_network_crates";


_logic spawn {

	// Hunter'z modules auto-integration
	Hz_pers_enableHzAmbw = false;
	if ((isClass (configFile >> "cfgPatches" >> "Hz_mod_ambientWar"))
			|| {isClass (configFile >> "cfgPatches" >> "Hz_mod_economy")}
			) then {
								
		sleep 30;
		
		if ((!isNil "Hz_ambw_initDone") && {Hz_ambw_initDone}) then {
			Hz_pers_enableHzAmbw = true;
			
			["Hz_ambw_srel_relationsCivilian",SINGLE_VARIABLE,true] call Hz_pers_API_addMissionVariable;
			["Hz_ambw_srel_relationsOwnSide",SINGLE_VARIABLE,true] call Hz_pers_API_addMissionVariable;
			
			Hz_pers_saveVar_ambw_pat_gSides = [];
			Hz_pers_saveVar_ambw_pat_gPatMarkers = [];			
			Hz_pers_saveVar_ambw_pat_gVehicleTypes = [];
			Hz_pers_saveVar_ambw_pat_gVehicleCrewTypes = [];
			Hz_pers_saveVar_ambw_pat_gInfantryTypes = [];
			Hz_pers_saveVar_ambw_pat_gVehiclePosATL = [];
			Hz_pers_saveVar_ambw_pat_gVehicleDir = [];
			Hz_pers_saveVar_ambw_pat_gInfantryPosATL = [];
			
			Hz_pers_network_ambw_pat_gSides = [];
			Hz_pers_network_ambw_pat_gPatMarkers = [];			
			Hz_pers_network_ambw_pat_gVehicleTypes = [];
			Hz_pers_network_ambw_pat_gVehicleCrewTypes = [];
			Hz_pers_network_ambw_pat_gInfantryTypes = [];
			Hz_pers_network_ambw_pat_gVehiclePosATL = [];
			Hz_pers_network_ambw_pat_gVehicleDir = [];
			Hz_pers_network_ambw_pat_gInfantryPosATL = [];			
			
			["Hz_pers_saveVar_ambw_pat_gSides",ONE_D_ARRAY,false] call Hz_pers_API_addMissionVariable;
			["Hz_pers_saveVar_ambw_pat_gPatMarkers",ONE_D_ARRAY,false] call Hz_pers_API_addMissionVariable;
			["Hz_pers_saveVar_ambw_pat_gVehicleTypes",NESTED_ARRAY_STRUCT,false] call Hz_pers_API_addMissionVariable;
			["Hz_pers_saveVar_ambw_pat_gVehicleCrewTypes",ARRAY_OF_STRUCTS,false] call Hz_pers_API_addMissionVariable;
			["Hz_pers_saveVar_ambw_pat_gInfantryTypes",NESTED_ARRAY_STRUCT,false] call Hz_pers_API_addMissionVariable;
			["Hz_pers_saveVar_ambw_pat_gVehiclePosATL",NESTED_ARRAY_STRUCT,false] call Hz_pers_API_addMissionVariable;
			["Hz_pers_saveVar_ambw_pat_gVehicleDir",NESTED_ARRAY_STRUCT,false] call Hz_pers_API_addMissionVariable;
			["Hz_pers_saveVar_ambw_pat_gInfantryPosATL",NESTED_ARRAY_STRUCT,false] call Hz_pers_API_addMissionVariable;	
			
			Hz_pers_saveVar_ambw_sc_sPos = [];
			Hz_pers_saveVar_ambw_sc_sSides = [];
			Hz_pers_saveVar_ambw_sc_sObjectTypes = [];
			Hz_pers_saveVar_ambw_sc_sObjectPosATL = [];
			
			Hz_pers_network_ambw_sc_sPos = [];
			Hz_pers_network_ambw_sc_sSides = [];
			Hz_pers_network_ambw_sc_sObjectTypes = [];
			Hz_pers_network_ambw_sc_sObjectPosATL = [];
			
			["Hz_pers_saveVar_ambw_sc_sPos",ONE_D_ARRAY,false] call Hz_pers_API_addMissionVariable;
			["Hz_pers_saveVar_ambw_sc_sSides",ONE_D_ARRAY,false] call Hz_pers_API_addMissionVariable;
			["Hz_pers_saveVar_ambw_sc_sObjectTypes",NESTED_ARRAY_STRUCT,false] call Hz_pers_API_addMissionVariable;
			["Hz_pers_saveVar_ambw_sc_sObjectPosATL",NESTED_ARRAY_STRUCT,false] call Hz_pers_API_addMissionVariable;
			
		};
		
		if ((!isNil "Hz_econ_preInitDone") && {Hz_econ_preInitDone}) then {
			["Hz_econ_funds",SINGLE_VARIABLE,true] call Hz_pers_API_addMissionVariable;
		};
			
	};			
	
	//auto-load

	_loadCodeString = preprocessfilelinenumbers Hz_pers_pathToSaveFile;
	
	if (_loadCodeString == "") then {
	
		call Hz_pers_fnc_handleFirstTimeLaunch;
		Hz_pers_serverInitialised = true;
		publicVariable "Hz_pers_serverInitialised";
	
	} else {

		sleep Hz_pers_autoLoadDelay;

		_loadCodeString call Hz_pers_fnc_loadGame;
		
		//load states of already connected players
		{
					
			[nil, getPlayerUID _x,nil,nil,owner _x] call Hz_pers_fnc_handleConnect;
		
		} foreach playableUnits;
		
		Hz_pers_serverInitialised = true;
		publicVariable "Hz_pers_serverInitialised";
	
	};
	
	private _delay = call compile (_this getVariable "AutoSaveFreq");
	
	Hz_pers_enableAutoSave = true;
	
	while {true} do {
	
		uisleep _delay;
		
		if (Hz_pers_enableAutoSave) then {
		
			call Hz_pers_fnc_saveGame;
		
		};
	
	};

};

//set EH
addMissionEventHandler ["PlayerConnected",Hz_pers_fnc_handleConnect];
addMissionEventHandler ["HandleDisconnect",Hz_pers_fnc_handleDisconnect];