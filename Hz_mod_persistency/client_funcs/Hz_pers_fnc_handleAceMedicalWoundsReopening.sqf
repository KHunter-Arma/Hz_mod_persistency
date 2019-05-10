// Under testing...

if (isnil "ace_medical_level") exitWith {};
if (isnil "ace_medical_enableAdvancedWounds") exitWith {};

if ((ace_medical_level >= 2) && {ace_medical_enableAdvancedWounds}) then {

	{

		[objnull, player, _x, "QuikClot", "", -1] call ace_medical_fnc_treatmentAdvanced_bandage;

	} foreach ["head","body","hand_l","hand_r","leg_l","leg_r"];

};