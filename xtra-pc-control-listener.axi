PROGRAM_NAME='xtra-pc-control-listener'

#if_not_defined __XTRA_PC_CONTROL_LISTENER__
#define __XTRA_PC_CONTROL_LISTENER__

/*
 * --------------------
 * xtra-pc-control-listener
 *
 * For usage, check out the readme for the xtra-pc-control-library.
 * --------------------
 */

define_constant

char VERSION_XTRA_PC_CONTROL_LISTENER[] = 'v1.0.0'

include 'xtra-pc-control-api'


/*
 * --------------------
 * Device arrays
 * --------------------
 */

define_variable

#if_not_defined dvXtraPcControlMainPorts
dev dvXtraPcControlMainPorts[] = {9001:1:0}
#end_if


/*
 * --------------------
 * Callback functions
 * --------------------
 */

#warn '@TODO - xtra-pc-control - '

/*
#define INCLUDE_XTRA_PC_CONTROL_NOTIFY_LOCK_STATUS_CALLBACK
define_function xtraPcControlNotifyLockStatus (dev xtraPcControl, char lockStatus[], char user[])
{
	// dvXtraPcControl is Xtra PC Control application.
	// lockStatus contains the PC lock status (XTRA_PC_CONTROL_LOCK_STATUS_LOCKED | XTRA_PC_CONTROL_LOCK_STATUS_UNLOCKED)
	// user contains the Windows username.
}
*/

#warn '@TODO - xtra-pc-listener - parsing data for process list response'
/*
#define INCLUDE_XTRA_PC_CONTROL_NOTIFY_PROCESS_LIST_ITEM_CALLBACK
define_function xtraPcControlNotifyProcessListItem (dev xtraPcControl, integer processListCount, integer processListItemIndex, char processName[])
{
	// dvXtraPcControl is Xtra PC Control application.
	// processListCount contains the ......
	// user contains the Windows username.
}
*/



/*
 * --------------------
 * Events to capture responses from the Xtra PC Control application
 * --------------------
 */

define_event


/*
 * --------------------
 * Data events
 * --------------------
 */


data_event [dvXtraPcControlMainPorts]
{
	command:
	{
		stack_var char cmdHeader[30]
		
		// remove the header
		cmdHeader = remove_string(data.text,"'-'",1)
		// cmdHeader contains the header
		// data.text is left with the parameters
		
		switch (cmdHeader)
		{
			#if_defined INCLUDE_XTRA_PC_CONTROL_NOTIFY_LOCK_STATUS_CALLBACK
			case XTRA_PC_CONTROL_RESPONSE_UNLOCKED:
			{
				xtraPcControlNotifyLockStatus (data.device, XTRA_PC_CONTROL_LOCK_STATUS_UNLOCKED, data.text)
			}
			#end_if
			
			#if_defined INCLUDE_XTRA_PC_CONTROL_NOTIFY_LOCK_STATUS_CALLBACK
			case XTRA_PC_CONTROL_RESPONSE_LOCKED:
			{
				xtraPcControlNotifyLockStatus (data.device, XTRA_PC_CONTROL_LOCK_STATUS_LOCKED, data.text)
			}
			#end_if
			
			default:
			{
				// unhandled - ignore
			}
		}
	}
}

#end_if