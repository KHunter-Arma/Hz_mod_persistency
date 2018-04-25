/*******************************************************************************
* file:       Hz_pers_fnc_nestedArrayStructWriter.sqf
*
* author:     K.Hunter
*		
* arguments:  _this select 0: Nested array struct (type: array)
*             _this select 1: Struct name         (type: string)
*             _this select 2: Max array size      (type: number)
*
* return: 	  nothing
********************************************************************************
* Copyright (C) 2016-2018 K.Hunter
*
* This file is licensed under a Creative Commons
* Attribution-NonCommercial-ShareAlike 4.0 International License.
* 
* For more information about this license view the LICENSE.md distributed
* together with this file or visit:
* https://creativecommons.org/licenses/by-nc-sa/4.0/
*******************************************************************************/

#include "debug_console.hpp"

private ["_element","_splitArrays","_foreachIndex","_msg","_struct","_structName","_maxSize"];

_struct = _this select 0;
_structName = _this select 1;
_maxSize = _this select 2;


if ((count _struct) > 0) then {

    {
        _element = _x;        
        // this is to prevent the system from breaking down - otherwise this is an unexpected input
        if((typename _x) != "ARRAY") then {_element = [_x];};
        
        _splitArrays = [_element, _maxSize] call Hz_pers_fnc_arraySplitter;
        [_splitArrays, format ["%1_%2",_structName,_foreachIndex]] call Hz_pers_fnc_splitArrayWriter;
    
    } foreach _struct;

} else {
    
    _msg = format ["%1 = %2;",format ["%1_0_1",_structName],[]];
    conFile(_msg);

};