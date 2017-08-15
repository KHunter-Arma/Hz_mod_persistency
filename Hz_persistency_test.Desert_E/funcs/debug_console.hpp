/*
	KK's gamesavesystem v3.0 macros
	http://killzonekid.com
	
	USAGE:
	
	#include "gamesavesystem.hpp"
	conBeep(); //makes console beep
	conClear(); //clears console screen
	conClose(); //closes console, resets logfile filename
	conWhite("This Line Is White");
	conWhiteTime("This White Line Has Timestamp");
	conRed("This Line Is Red");
	conRedTime("This Red Line Has Timestamp");
	conGreen("This Line Is Green");
	conGreenTime("This Green Line Has Timestamp");
	conBlue("This Line Is Blue");
	conBlueTime("This Blue Line Has Timestamp");
	conYellow("This Line Is Yellow");
	conYellowTime("This Yellow Line Has Timestamp");
	conPurple("This Line Is Purple");
	conPurpleTime("This Purple Line Has Timestamp");
	conCyan("This Line Is Cyan");
	conCyanTime("This Cyan Line Has Timestamp");
	conFile("This Line Is Written To Logfile");
	conFileTime("This Written To Logfile Line Has Timestamp");
	diag_log ("gamesavesystem" callExtension ("i")); //max_output_size
*/

#define conBeep() (Hz_pers_path + "debugconsole") callExtension ("A")
#define conClear() (Hz_pers_path + "debugconsole") callExtension ("C")
#define conClose() (Hz_pers_path + "debugconsole") callExtension ("X")
#define conWhite(_msg) (Hz_pers_path + "debugconsole") callExtension (_msg + "#1110")
#define conWhiteTime(_msg) (Hz_pers_path + "debugconsole") callExtension (_msg + "#1111")
#define conRed(_msg) (Hz_pers_path + "debugconsole") callExtension (_msg + "#1000")
#define conRedTime(_msg) (Hz_pers_path + "debugconsole") callExtension (_msg + "#1001")
#define conGreen(_msg) (Hz_pers_path + "debugconsole") callExtension (_msg + "#0100")
#define conGreenTime(_msg) (Hz_pers_path + "debugconsole") callExtension (_msg + "#0101")
#define conBlue(_msg) (Hz_pers_path + "debugconsole") callExtension (_msg + "#0010")
#define conBlueTime(_msg) (Hz_pers_path + "debugconsole") callExtension (_msg + "#0011")
#define conYellow(_msg) (Hz_pers_path + "debugconsole") callExtension (_msg + "#1100")
#define conYellowTime(_msg) (Hz_pers_path + "debugconsole") callExtension (_msg + "#1101")
#define conPurple(_msg) (Hz_pers_path + "debugconsole") callExtension (_msg + "#1010")
#define conPurpleTime(_msg) (Hz_pers_path + "debugconsole") callExtension (_msg + "#1011")
#define conCyan(_msg) (Hz_pers_path + "debugconsole") callExtension (_msg + "#0110")
#define conCyanTime(_msg) (Hz_pers_path + "debugconsole") callExtension (_msg + "#0111")
#define conFile(_msg) (Hz_pers_path + "debugconsole") callExtension (_msg + "~0000")
#define conFileTime(_msg) (Hz_pers_path + "debugconsole") callExtension (_msg + "~0001")