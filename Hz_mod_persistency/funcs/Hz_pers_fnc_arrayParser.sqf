/******************************************************************************
* file: Hz_pers_fnc_arrayParser.sqf
*
* author:		  K.Hunter
*		
* arguments:  _this:   _varName	(type: string)
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

private ["_varName", "_resultingArray", "_exit", "_index", "_arrayName", "_array", "_count", "_varname"];

_varName = _this;

_resultingArray = []; //parsed array

_exit = false;
_index = 1;
while {!_exit} do {

    _arrayName = format ["%1_%2",_varName,_index];
    _array = missionnamespace getvariable [_arrayName,[]];
    _count = count _array;
	
    if (_count > 0) then {
	
        for "_i" from 0 to (_count - 1) do {
		
            _resultingArray set [count _resultingArray,_array select _i];
		
        };
				
				//deallocate
				_array resize 0;
				_array = nil;
	
    } else {_exit = true;};

    _index = _index + 1;
	
};

missionnamespace setvariable [_varname,_resultingArray];