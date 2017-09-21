waituntil {sleep 1; !isnil Hz_pers_firstTimeLaunchHandlerFunctionName};

_func = missionnamespace getvariable Hz_pers_firstTimeLaunchHandlerFunctionName;
call _func;