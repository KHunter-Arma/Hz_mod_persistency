/*******************************************************************************
* file:       Hz_pers_fnc_structArrayElementParser.sqf
*
* author:		  K.Hunter
*	
* arguments:  _this: _varName	(type: string)
*
* return: 	  _resultingArray   (type: array or nil)
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

private ["_resultingArray","_count","_exit","_arrayName","_array","_index","_varName"];

_varName = _this;

_resultingArray = nil; //parsed array

_exit = false;
_index = 1;
while {!_exit} do {

    _arrayName = format ["%1_%2",_varName,_index];
    _array = missionnamespace getvariable [_arrayName,nil];
    
    if(!isnil "_array") then {
        
        if(isnil "_resultingArray") then {_resultingArray = [];};   
        
        _count = count _array;
	
        if (_count > 0) then {
	
            for "_i" from 0 to (_count - 1) do {
		
                _resultingArray set [count _resultingArray,_array select _i];
		
            };	
        };
    
    } else {_exit = true;};

    _index = _index + 1;
	
};

_resultingArray