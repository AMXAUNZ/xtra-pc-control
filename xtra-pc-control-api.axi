PROGRAM_NAME='xtra-pc-control-api'

#if_not_defined __XTRA_PC_CONTROL_API__
#define __XTRA_PC_CONTROL_API__

/*
 * --------------------
 * xtra-pc-control-api
 *
 * For usage, check out the readme for the xtra-pc-control-library.
 * --------------------
 */

define_constant

char VERSION_XTRA_PC_CONTROL_API[] = 'v1.0.0'


/*
 * --------------------
 * Xtra PC Control constants
 * --------------------
 */

define_constant


/*
 * --------------------
 * Xtra PC Control command headers
 * --------------------
 */


char XTRA_PC_CONTROL_COMMAND_LOGOFF[]               = 'LOGOFF'
char XTRA_PC_CONTROL_COMMAND_LAUNCH_APPLICATION[]   = 'LAUNCH-'
char XTRA_PC_CONTROL_COMMAND_STOP_PROCESS[]         = 'STOP-'
char XTRA_PC_CONTROL_COMMAND_LOCK[]                 = 'LOCK'
char XTRA_PC_CONTROL_QUERY_LOCK[]                   = '?LOCK'
char XTRA_PC_CONTROL_COMMAND_SHUTDOWN[]             = 'SHUTDOWN'
char XTRA_PC_CONTROL_COMMAND_REBOOT[]               = 'REBOOT'
char XTRA_PC_CONTROL_QUERY_PROCESS_LIST[]           = '?PROCESS_LIST'
xhar XTRA_PC_CONTROL_RESPONSE_PROCESS_LIST[]        = 'PROCESS_LIST-'
char XTRA_PC_CONTROL_COMMAND_SEND_KEYSTROKE[]       = 'SEND_KEY-'
char XTRA_PC_CONTROL_RESPONSE_UNLOCKED[]            = 'UNLOCKED-'
char XTRA_PC_CONTROL_RESPONSE_LOCKED[]              = 'LOCKED-'


/*
 * --------------------
 * Xtra PC Control command parameter values
 * --------------------
 */

char XTRA_PC_CONTROL_LOCK_STATUS_LOCKED[]   = 'LOCKED'
char XTRA_PC_CONTROL_LOCK_STATUS_UNLOCKED[] = 'UNLOCKED'

#end_if
