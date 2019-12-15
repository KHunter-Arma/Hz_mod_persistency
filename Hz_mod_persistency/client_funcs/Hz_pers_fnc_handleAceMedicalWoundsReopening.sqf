// this definitely doesn't work... we need new variables inside ACE to store information from reopen handler scripts
// we could iterate through the wounds with a random reopening chance just like the real reopen handler does when the wound is new though...

/*
if (isnil "ace_medical_level") exitWith {};
if (isnil "ace_medical_enableAdvancedWounds") exitWith {};

if ((ace_medical_level >= 2) && {ace_medical_enableAdvancedWounds}) then {

	{

		[objnull, player, _x, "QuikClot", "", -1] call ace_medical_fnc_treatmentAdvanced_bandage;

	} foreach ["head","body","hand_l","hand_r","leg_l","leg_r"];

};
*/