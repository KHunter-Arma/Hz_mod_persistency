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

if (_alt) then {

  {

    if (("_USER_DEFINED #" in _x) && ((markerShape _x) == "ICON")) then {

      if (((markerpos _x) distance2D _pos) <= 20) then {

        deleteMarker _x;

      };

    };

  } foreach allMapMarkers;

};

false