PROGRAM_NAME='xtra-pc-control-control'


#if_not_defined __XTRA_PC_CONTROL_CONTROL__
#define __XTRA_PC_CONTROL_CONTROL__

/*
 * --------------------
 * xtra-pc-control-control
 *
 * For usage, check out the readme for the xtra-pc-control-library.
 * --------------------
 */

define_constant

char VERSION_XTRA_PC_CONTROL_CONTROL[] = 'v1.0.0'

#include 'xtra-pc-control-api'
#include 'amx-device-control'



/*
 * Function:    xtraPcControlShutdown
 * 
 * Arguments:   dev xtraPcControl - Xtra PC Control application
 * 
 * Description: Shutdown the PC
 */
define_function xtraPcControlShutdown (dev xtraPcControl)
{
	sendCommand (xtraPcControl, "XTRA_PC_CONTROL_COMMAND_SHUTDOWN")
}

/*
 * Function:    xtraPcControlReboot
 * 
 * Arguments:   dev xtraPcControl - Xtra PC Control application
 * 
 * Description: Reboot the PC
 */
define_function xtraPcControlReboot (dev xtraPcControl)
{
	sendCommand (xtraPcControl, "XTRA_PC_CONTROL_COMMAND_REBOOT")
}

/*
 * Function:    xtraPcControlLogoff
 * 
 * Arguments:   dev xtraPcControl - Xtra PC Control application
 * 
 * Description: Logoff the PC
 */
define_function xtraPcControlLogoff (dev xtraPcControl)
{
	sendCommand (xtraPcControl, "XTRA_PC_CONTROL_COMMAND_LOGOFF")
}

/*
 * Function:    xtraPcControlLock
 * 
 * Arguments:   dev xtraPcControl - Xtra PC Control application
 * 
 * Description: Lock the PC
 */
define_function xtraPcControlLock (dev xtraPcControl)
{
	sendCommand (xtraPcControl, "XTRA_PC_CONTROL_COMMAND_LOCK")
}

/*
 * Function:    xtraPcControlRequestLockStatus
 * 
 * Arguments:   dev xtraPcControl - Xtra PC Control application
 * 
 * Description: Request the PC lock status
 */
define_function xtraPcControlRequestLockStatus (dev xtraPcControl)
{
	sendCommand (xtraPcControl, "XTRA_PC_CONTROL_QUERY_LOCK")
}

/*
 * Function:    xtraPcControlLaunchApplication
 * 
 * Arguments:   dev xtraPcControl - Xtra PC Control application
 *              char applicationName[] - application name (e.g., 'Lync.exe')
 * 
 * Description: Launch an application on the PC
 */
define_function xtraPcControlLaunchApplication (dev xtraPcControl, char applicationName[])
{
	sendCommand (xtraPcControl, "XTRA_PC_CONTROL_COMMAND_LAUNCH_APPLICATION,applicationName")
}

/*
 * Function:    xtraPcControlStopProcess
 * 
 * Arguments:   dev xtraPcControl - Xtra PC Control application
 *              char processName[] - process name (e.g., 'Lync')
 * 
 * Description: Stop a process from running on the PC
 */
define_function xtraPcControlStopProcess (dev xtraPcControl, char applicationName[])
{
	sendCommand (xtraPcControl, "XTRA_PC_CONTROL_COMMAND_STOP_PROCESS,applicationName")
}

/*
 * Function:    xtraPcControlRequestProcessList
 * 
 * Arguments:   dev xtraPcControl - Xtra PC Control application
 * 
 * Description: Request the list of services running on the PC
 */
define_function xtraPcControlRequestProcessList (dev xtraPcControl)
{
	sendCommand (xtraPcControl, "XTRA_PC_CONTROL_QUERY_PROCESS_LIST")
}

/*
 * Function:    xtraPcControlSendKeyStroke
 * 
 * Arguments:   dev xtraPcControl - Xtra PC Control application
 *              char keyStroke - single key stroke
 * 
 * Description: Send a keystroke to the PC
 */
define_function xtraPcControlSendKeyStroke (dev xtraPcControl, char keyStroke)
{
	sendCommand (xtraPcControl, "XTRA_PC_CONTROL_COMMAND_SEND_KEYSTROKE,keyStroke")
}

#end_if