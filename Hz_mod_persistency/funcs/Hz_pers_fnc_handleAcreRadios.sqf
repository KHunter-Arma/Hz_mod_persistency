private _return = _this;

if ("ACRE_BaseRadio" in ([configfile >> "cfgweapons" >> _return, true] call bis_fnc_returnparents)) then {

	switch (true) do {
	
		case ("ACRE_PRC343" in ([configfile >> "cfgweapons" >> _return, true] call bis_fnc_returnparents)) : {
		
			_return = "ACRE_PRC343";
		
		};
		
		case ("ACRE_PRC148" in ([configfile >> "cfgweapons" >> _return, true] call bis_fnc_returnparents)) : {
		
			_return = "ACRE_PRC148";
		
		};
		
		case ("ACRE_PRC117F" in ([configfile >> "cfgweapons" >> _return, true] call bis_fnc_returnparents)) : {
		
			_return = "ACRE_PRC117F";
		
		};
		
		case ("ACRE_PRC152" in ([configfile >> "cfgweapons" >> _return, true] call bis_fnc_returnparents)) : {
		
			_return = "ACRE_PRC152";
		
		};
		
		case ("ACRE_PRC77" in ([configfile >> "cfgweapons" >> _return, true] call bis_fnc_returnparents)) : {
		
			_return = "ACRE_PRC77";
		
		};
	
	};

};

_return