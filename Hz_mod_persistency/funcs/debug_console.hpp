/*
	KK's debug_console v3.0 macros
	http://killzonekid.com
	
	USAGE:
	
	#include "debug_console.hpp"
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
	diag_log ("debug_console" callExtension ("i")); //max_output_size
*/

#define conBeep() ("!Workshop\@Hunter'z Persistency Module\extensions\debug_console") callExtension ("A")
#define conClear() ("!Workshop\@Hunter'z Persistency Module\extensions\debug_console") callExtension ("C")
#define conClose() ("!Workshop\@Hunter'z Persistency Module\extensions\debug_console") callExtension ("X")
#define conWhite(_msg) ("!Workshop\@Hunter'z Persistency Module\extensions\debug_console") callExtension (_msg + "#1110")
#define conWhiteTime(_msg) ("!Workshop\@Hunter'z Persistency Module\extensions\debug_console") callExtension (_msg + "#1111")
#define conRed(_msg) ("!Workshop\@Hunter'z Persistency Module\extensions\debug_console") callExtension (_msg + "#1000")
#define conRedTime(_msg) ("!Workshop\@Hunter'z Persistency Module\extensions\debug_console") callExtension (_msg + "#1001")
#define conGreen(_msg) ("!Workshop\@Hunter'z Persistency Module\extensions\debug_console") callExtension (_msg + "#0100")
#define conGreenTime(_msg) ("!Workshop\@Hunter'z Persistency Module\extensions\debug_console") callExtension (_msg + "#0101")
#define conBlue(_msg) ("!Workshop\@Hunter'z Persistency Module\extensions\debug_console") callExtension (_msg + "#0010")
#define conBlueTime(_msg) ("!Workshop\@Hunter'z Persistency Module\extensions\debug_console") callExtension (_msg + "#0011")
#define conYellow(_msg) ("!Workshop\@Hunter'z Persistency Module\extensions\debug_console") callExtension (_msg + "#1100")
#define conYellowTime(_msg) ("!Workshop\@Hunter'z Persistency Module\extensions\debug_console") callExtension (_msg + "#1101")
#define conPurple(_msg) ("!Workshop\@Hunter'z Persistency Module\extensions\debug_console") callExtension (_msg + "#1010")
#define conPurpleTime(_msg) ("!Workshop\@Hunter'z Persistency Module\extensions\debug_console") callExtension (_msg + "#1011")
#define conCyan(_msg) ("!Workshop\@Hunter'z Persistency Module\extensions\debug_console") callExtension (_msg + "#0110")
#define conCyanTime(_msg) ("!Workshop\@Hunter'z Persistency Module\extensions\debug_console") callExtension (_msg + "#0111")
#define conFile(_msg) ("!Workshop\@Hunter'z Persistency Module\extensions\debug_console") callExtension (_msg + "~0000")
#define conFileTime(_msg) ("!Workshop\@Hunter'z Persistency Module\extensions\debug_console") callExtension (_msg + "~0001")