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

class cfgPatches {

  class Hz_mod_persistency {
    
    name = "Hunter'z Persistency Module";
    author = "K.Hunter";
    url = "https://github.com/KHunter-Arma";
    
    requiredVersion = 1.58; 
    requiredAddons[] = {"A3_Modules_F"};
    units[] = {"Hz_mod_persistency_module"};
    weapons[] = {};
    
  };

};

class cfgFunctions
{
  class Hz {
      
      class Hz_moduleFunctions {
				
				class pers_init {
					
					file = "\x\Hz\Hz_mod_persistency\Hz_pers_init.sqf";					
					
				};           
        
      };
    
  };
  
};

class CfgFactionClasses
{
	class NO_CATEGORY;
	class Hz_editorModules: NO_CATEGORY
	{
		displayName = "Hz";
	};
};

class CfgVehicles
{
  class Logic;
  class Module_F: Logic
  {
    class AttributesBase
    {
      class Default;
      class Edit; // Default edit box (i.e., text input field)
      class Combo; // Default combo box (i.e., drop-down menu)
      class Checkbox; // Default checkbox (returned value is Bool)
      class CheckboxNumber; // Default checkbox (returned value is Number)
      class ModuleDescription; // Module description
    };
    // Description base classes, for more information see below
    class ModuleDescription
    {
      
    };
  };
  class Hz_mod_persistency_module: Module_F
  {
    // Standard object definitions
    scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
    displayName = "Hunter'z Persistency"; // Name displayed in the menu
    icon = "\x\Hz\Hz_mod_persistency\media\Hunterz_logo.paa"; // Map icon. Delete this entry to use the default icon
    category = "Hz_editorModules";

    // Name of function triggered once conditions are met
    function = "Hz_fnc_pers_init";
    // Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
    functionPriority = 0;
    // 0 for server only execution, 1 for global execution, 2 for persistent global execution
    isGlobal = 2;
    // 1 for module waiting until all synced triggers are activated
    isTriggerActivated = 0;
    // 1 if modules is to be disabled once it's activated (i.e., repeated trigger activation won't work)
    isDisposable = 0;
    // 1 to run init function in Eden Editor as well
    is3DEN = 0;

    // Menu displayed when the module is placed or double-clicked on by Zeus
    curatorInfoType = "";

    // Module attributes, uses https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes#Entity_Specific
    class Attributes: AttributesBase
    {      
      // Module specific arguments
      class AceMedical: Combo
      {
        // Unique property, use "<moduleClass>_<attributeClass>" format to make sure the name is unique in the world
        property = "Hz_pers_module_pAceMedical";
        displayName = "Enable ACE Medical"; // Argument label
        tooltip = "Enable/disable persistency of full medical status when using ACE medical system."; // Tooltip description
        typeName = "BOOL"; // Value type, can be "NUMBER", "STRING" or "BOOL"
        defaultValue = "false"; // Default attribute value. WARNING: This is an expression, and its returned value will be used (50 in this case)
        class Values
        {
					class disabled	{name = "Disable"; value = false;};
          class enabled	{name = "Enable";	value = true;}; // Listbox item
        };
      };
      class PathToSaveFile: Edit
      {
				property = "Hz_pers_module_pPathToSaveFile";
        displayName = "Path to Save File";
        tooltip = "Path describing the location and name of save file that will be used for loading the game at server restart.";
        // Default text filled in the input box
        // Because it's an expression, to return a String one must have a string within a string
        defaultValue = """\Hz_config\Hz_mod_persistency\Hz_pers_saveFile.sqf""";
      };
      class CustomLoadFunctionName: Edit
      {
				property = "Hz_pers_module_pCustomLoadFunctionName";
        displayName = "Custom Load Function Name";
        tooltip = "This setting is optional. Name of your function where you have your custom code that you want to run just before game loading from file is finished and load variables are deallocated.";
        defaultValue = """""";
      };
      class AutoLoadDelay: Edit
      {
				property = "Hz_pers_module_pAutoLoadDelay";
        displayName = "Auto-load Delay";
        tooltip = "Delay in seconds after mission start before the game is loaded from file.";
        defaultValue = "60";
      };
      class ClientLoadDelay: Edit
      {
				property = "Hz_pers_module_pClientLoadDelay";
        displayName = "Client Load Delay";
        tooltip = "Seconds to wait after a player joins the mission before loading their persistent state.";
        defaultValue = "10";
      };
      class MaxArraySize: Edit
      {
				property = "Hz_pers_module_pMaxArraySize";
        displayName = "Max Array Size for Write";
        tooltip = "Maximum size (in number of elements) an array that is written to file can have. If you have elements in your arrays characterised as long arrays or strings, you should keep this low for safety.";
        defaultValue = "10";
      };
      class ModuleDescription: ModuleDescription{}; // Module description should be shown last
    };

    // Module description. Must inherit from base class, otherwise pre-defined entities won't be available
    class ModuleDescription: ModuleDescription
    {
      description = "Hunter'z Persistency Module"; // Short description, will be formatted as structured text
      sync[] = {}; // Array of synced entities (can contain base classes)      

    };
  };
};