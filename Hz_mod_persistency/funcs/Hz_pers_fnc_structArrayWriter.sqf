/*******************************************************************************
* file:       Hz_pers_fnc_structArrayWriter.sqf
*
* author:     K.Hunter
*		
* arguments:  _this select 0: Array of nested array structs (type: array)
*             _this select 1: Array name                    (type: string)
*             _this select 2: Max array size                (type: number)
*
* return: 	  nothing
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

private ["_array","_arrayName","_maxSize","_element","_foreachIndex"];

_array = _this select 0;
_arrayName = _this select 1;
_maxSize = _this select 2;

if ((count _array) > 0) then {

    {
        _element = _x;        
        // this is to prevent the system from breaking down - otherwise this is an unexpected input
        if((typename _x) != "ARRAY") then {_element = [_x];};
    
        [_element,format ["%1_%2",_arrayName,_foreachIndex],_maxSize] call Hz_pers_fnc_nestedArrayStructWriter;
    
    } foreach _array;

};