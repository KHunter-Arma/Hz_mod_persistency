/*******************************************************************************
* file: Hz_pers_fnc_nestedArrayStructParser.sqf
*
* author:     K.Hunter
*	
* arguments:  _this: Name of nested array struct   (type: string)
*           
- return: 	  _parsedStruct                        (type: array)
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

private ["_parsedStruct", "_structName", "_structElementIndex", "_exit", "_structElementName", "_structElement"];

_structName = _this;

_parsedStruct = [];

_structElementIndex = 0;
_exit = false;
    
while {!_exit} do {

    _structElementName = format ["%1_%2",_structName,_structElementIndex];
    
    _structElement = _structElementName call Hz_pers_fnc_structArrayElementParser;    
    
    //does struct element exist?
    if(!isnil "_structElement") then {
	
        //is struct empty?
        if ((count _structElement) > 0) then {
        
            _parsedStruct set [count _parsedStruct, _structElement];
        
        } else {
                            
            //empty array
            //RULE: If first array of struct is empty, that signifies the struct itself is empty, so we replace nested array structure with an empty array and exit.
      //      if(_structElementIndex == 0) then {
             
       //         _exit = true;   
             
      //      } else {
                
                //not first element -- so add it to the struct and continue
                _parsedStruct set [count _parsedStruct, _structElement];                    
                        
      //      };
        
        };  
    
    } else {_exit = true;};
	
    _structElementIndex = _structElementIndex + 1;
  
};

_parsedStruct