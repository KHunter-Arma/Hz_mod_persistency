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
_return = [[],[]];
_typeArray = _return select 0;
_countArray = _return select 1;

{
	_index = _typeArray find _x;

	if (_index == -1) then {
		
		_typeArray pushBack _x;
		_countArray pushBack 1;
		
	} else {
		
		_countArray set [_index, (_countArray select _index) + 1]; 
		
	};

} foreach _this;

_return