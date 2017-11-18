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

waituntil {sleep 1; !isnil Hz_pers_firstTimeLaunchHandlerFunctionName};

_func = missionnamespace getvariable Hz_pers_firstTimeLaunchHandlerFunctionName;
call _func;