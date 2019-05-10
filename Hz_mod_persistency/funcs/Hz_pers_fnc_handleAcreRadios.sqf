/*******************************************************************************
* Copyright (C) 2017-2018 K.Hunter
*
* The source code contained within this file is licensed under a Creative Commons
* Attribution-NonCommercial-ShareAlike 4.0 International License.
* 
* For more information about this license view the LICENSE.md distributed
* together with this file or visit:
* https://creativecommons.org/licenses/by-nc-sa/4.0/
*******************************************************************************/

private _return = _this;
private _parents = [configfile >> "cfgweapons" >> _return, true] call bis_fnc_returnparents;

if ("ACRE_BaseRadio" in _parents) then {

	switch (true) do {
	
		case ("ACRE_PRC343" in _parents) : {
		
			_return = "ACRE_PRC343";
		
		};
		
		case ("ACRE_PRC148" in _parents) : {
		
			_return = "ACRE_PRC148";
		
		};
		
		case ("ACRE_PRC117F" in _parents) : {
		
			_return = "ACRE_PRC117F";
		
		};
		
		case ("ACRE_PRC152" in _parents) : {
		
			_return = "ACRE_PRC152";
		
		};
		
		case ("ACRE_PRC77" in _parents) : {
		
			_return = "ACRE_PRC77";
		
		};
	
	};

};

_return