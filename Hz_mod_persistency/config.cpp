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

class CfgMods
{
	class Mod_Base;
	class Hz_mod_persistency: Mod_Base
	{
		name = "Hunter'z Persistency Module";
		picture = "\x\Hz\Hz_mod_persistency\media\Hunterz_logo.paa";
		logo = "\x\Hz\Hz_mod_persistency\media\Hunterz_icon.paa";
		logoSmall = "\x\Hz\Hz_mod_persistency\media\Hunterz_iconSmall.paa";
		logoOver = "\x\Hz\Hz_mod_persistency\media\Hunterz_icon.paa";
		tooltipOwned = "";
		action = "https://github.com/KHunter-Arma";
		dlcColor[] = {1,00,00,0.8};
		overview = "";
		hideName = 0;
		hidePicture = 0;
		dir = "@Hz_mod_persistency";
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

class CfgRemoteExec
{        
	// List of script functions allowed to be sent from client via remoteExec
	class Functions
	{
		 // State of remoteExec: 0-turned off, 1-turned on, taking whitelist into account, 2-turned on, however, ignoring whitelists (default because of backward compatibility)
		 mode = 2;
		 // Ability to send jip messages: 0-disabled, 1-enabled (default)
		 jip = 1;
		 //your functions here
		 class Hz_pers_fnc_clientLoadState
		 {
			allowedTargets=1; // can target only clients
			jip = 0;
		 };
		 class Hz_pers_fnc_ackClientLoadSuccess
		 {
			allowedTargets=2; // can target only server
			jip = 0;
		 };
		 class Hz_pers_fnc_clientSendLocalVars
		 {
			allowedTargets=1;
			jip = 0;
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
    icon = "\x\Hz\Hz_mod_persistency\media\Hunterz_icon.paa"; // Map icon. Delete this entry to use the default icon
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
			class FirstTimeLaunchHandlerFunctionName: Edit
      {
				property = "Hz_pers_module_pFirstTimeLaunchHandlerFunctionName";
        displayName = "First Time Launch Handler Function";
        tooltip = "Name of your function that will be called when the mission is ran for the first time, or when no save file is found at the specified location. Use this function to initialise and set up your custom persistent variables using the API. This function must exist if no save file is found, or the module will be stuck waiting for this function to be defined before proceeding.";
        // Default text filled in the input box
        // Because it's an expression, to return a String one must have a string within a string
        defaultValue = """awesomeScripter_fnc_handleFirstTimeLaunch""";
      };
      // Module specific arguments
      class AceMedical: Checkbox
      {
        // Unique property, use "<moduleClass>_<attributeClass>" format to make sure the name is unique in the world
        property = "Hz_pers_module_pAceMedical";
        displayName = "Enable ACE Medical"; // Argument label
        tooltip = "Enable persistency of full medical status when using ACE medical system."; // Tooltip description
      };
      class PathToSaveFile: Edit
      {
				property = "Hz_pers_module_pPathToSaveFile";
        displayName = "Path to Save File";
        tooltip = "Path describing the location and name of save file that will be used for loading the game at server restart.";
        // Default text filled in the input box
        // Because it's an expression, to return a String one must have a string within a string
        defaultValue = """\Hz_cfg\Hz_pers\Hz_pers_saveFile.sqf""";
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
        defaultValue = """60""";
      };
			 class AutoSaveFreq: Edit
      {
				property = "Hz_pers_module_pAutoSaveFreq";
        displayName = "Auto-save Frequency";
        tooltip = "Frequency in seconds for auto-save to file.";
        defaultValue = """3600""";
      };
      class ClientEnableManualLoadSwitch: Checkbox
      {
				// Unique property, use "<moduleClass>_<attributeClass>" format to make sure the name is unique in the world
        property = "Hz_pers_module_pClientEnableManualLoadSwitch";
        displayName = "Enable Client Manual Load"; // Argument label
        tooltip = "If enabled, instead of waiting for the duration of the delay you specify below, you will have manual control over when the persistent state of a player is loaded. This allows you to complete all your initialisations and tell the module when the player is ready to load its state. You do this by setting 'Hz_pers_clientReadyForLoad = true;' at the end of your own initialisations.";
      };
      class ClientLoadDelay: Edit
      {
				property = "Hz_pers_module_pClientLoadDelay";
        displayName = "Client Load Delay";
        tooltip = "Seconds to wait after a player joins the mission before loading their persistent state. This setting will be ignored if the manual switch setting above is enabled.";
        defaultValue = """10""";
      };
      class MaxArraySize: Edit
      {
				property = "Hz_pers_module_pMaxArraySize";
        displayName = "Max Array Size for Write";
        tooltip = "Arma has a hardcoded limit on how much data it can output to a file in one go, so changing this setting may lead to corruption of your save file! Leave this setting at default unless you know what you're doing! Description: Maximum size (in number of elements) an array that is written to file is allowed to have, without being split into further arrays. If you have elements in your arrays characterised as long arrays or strings, you should keep this low for safety.";
        defaultValue = """10""";
      };
      class AcexFieldRations: Checkbox
      {
        // Unique property, use "<moduleClass>_<attributeClass>" format to make sure the name is unique in the world
        property = "Hz_pers_module_pAcexFieldRations";
        displayName = "Enable ACEX Field Rations"; // Argument label
        tooltip = "Enable persistency for ACEX Field Rations."; // Tooltip description
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