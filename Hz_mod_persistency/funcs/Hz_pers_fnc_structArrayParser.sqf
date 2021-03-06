/*******************************************************************************
* file:       Hz_pers_fnc_structArrayParser.sqf
*
* author:     K.Hunter
*	
* arguments:  _this : Name of array of nested array structs       (type: string)
*
* return: 	  nothing
********************************************************************************
* Copyright (C) 2016-2018 K.Hunter
*
* The source code contained within this file is licensed under a Creative Commons
* Attribution-NonCommercial-ShareAlike 4.0 International License.
* 
* For more information about this license view the LICENSE.md distributed
* together with this file or visit:
* https://creativecommons.org/licenses/by-nc-sa/4.0/
*******************************************************************************/

private ["_structArrayName", "_structArray", "_parsedArray", "_structIndex", "_exit", "_structName", "_structElement", "_parsedStruct"];

_structArrayName = _this;

_structArray = missionnamespace getvariable [format ["%1_0_0_1",_structArrayName],nil];
_parsedArray = [];

if (!isnil "_structArray") then { 
    
    _structIndex = 0;
    _exit = false;
    
    while {!_exit} do {

        _structName = format ["%1_%2",_structArrayName,_structIndex];
        _structElement = missionnamespace getvariable [format ["%1_0_1",_structName],nil];
	
        //does struct exist?
        if (!isnil "_structElement") then {            
	
            _parsedStruct = _structName call Hz_pers_fnc_nestedArrayStructParser;   
            _parsedArray set [count _parsedArray,_parsedStruct];
	
        } else {_exit = true;};       
	
        _structIndex = _structIndex + 1;
  
    };
  
};
    
missionnamespace setvariable [_structArrayName,_parsedArray];
 