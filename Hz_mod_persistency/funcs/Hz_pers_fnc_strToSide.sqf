/*******************************************************************************
* Copyright (C) 2021 K.Hunter
*
* The source code contained within this file is licensed under a Creative Commons
* Attribution-NonCommercial-ShareAlike 4.0 International License.
* 
* For more information about this license view the LICENSE.md distributed
* together with this file or visit:
* https://creativecommons.org/licenses/by-nc-sa/4.0/
*******************************************************************************/

switch (_this) do {
	
	case "WEST" : {west};	
	case "EAST" : {east};
	case "GUER" : {resistance};
	case "CIV" : {civilian};
	case "EMPTY" : {sideEmpty};
	case "UNKNOWN" : {sideUnknown};
	case "ENEMY" : {sideEnemy};
	case "FRIENDLY" : {sideFriendly};
	case "AMBIENT LIFE" : {sideAmbientLife};
	case "LOGIC" : {sideLogic};
	default {sideEmpty};

}
