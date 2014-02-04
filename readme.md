xtra-pc-control-library
===============


Files
-----
+ xtra-pc-control-api.axi
+ xtra-pc-control-control.axi
+ xtra-pc-control-listener.axi


Overview
--------
The **xtra-pc-control-library** NetLinx library is intended as a tool to make things easier for anyone tasked with programming an AMX system interfacing with the Xtra PC Control software application.

The Xtra PC Control software application utilises the i!-PcLink-Xtra plugin and registers on the AMX master controller as a native NetLinx device. It is used for controlling different aspects of the PC (e.g., locking the screen, logging off, shutting down, rebooting, launching applications, killing running processes, etc...)

The built-in constants, control functions, callback functions, and events within **xtra-pc-control-library** assist you by simplifying control and feedback.

Everything is a function!

Consistent, descriptive control function names within **xtra-pc-control-control** make it easy for you to control the PC and request information. E.g:

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

With the use of **xtra-pc-control-control** you are not required required to work out what command headers are required or how to build a control string containing all the required values. This process was time consuming and often involved converting numeric data to string form and building string expressions which were long and complex.

With the control functions defined within **xtra-pc-control-control** values for commands are simply passed through as arguments in the appropriate data types (constants defined within **xtra-pc-control-api** can be used where required) and the control functions do the hard work.

Similarly, you no longer have to build events (data/channel/level, etc...) to capture returning information from the Xtra PC Control software application and parse the incoming string/command (coverting data types where required) to obtain the required information in the correct format. **xtra-pc-control-listener**, listens for all types of responses from the software and triggers pre-written callback functions which you can copy to the main program, uncomment and fill in. E.g:

	#define INCLUDE_XTRA_PC_CONTROL_NOTIFY_LOCK_STATUS_CALLBACK
	define_function xtraPcControlNotifyLockStatus (dev xtraPcControl, char lockStatus[], char user[])
	{
		// xtraPcControl is Xtra PC Control application.
		// lockStatus contains the PC lock status
		// user contains the Windows username.
	}

Functions also assist to neaten up the programming and provide added readability to the code and the auto-prompter within the NetLinx Studio editor makes it easy to find the function you're looking for.

Extremely flexible!

All control and callback functions have a DEV parameter. This makes **xtra-pc-control-library** extremely flexible as you can use the same control/callback functions for different multiple instances of the Xtra PC Control software application running on multiple PC's. For the control functions you simply pass through the dev for the Xtra PC Control software instance you want to control and the dev parameter of the callback functions allows you to check to see which instances of the software triggered the notification.


xtra-pc-control-api
-----------
#####Dependencies:
+ none

#####Description:
Contains constants for Xtra PC Control NetLinx command headers and parameter values. These are used extensively by the accompanying library files **xtra-pc-control-control** and **xtra-pc-control-listener**. The constants defined within **xtra-pc-control-api** can also be referenced when passing values to control functions (where function parameters have a limited allowable set of values for one or more parameters) or checking to see the values of the callback function parameters.

#####Usage:
Include **xtra-pc-control-api** into the main program using the `#include` compiler directive. E.g:

	#include 'xtra-pc-control-api'

NOTE: If the main program file includes **xtra-pc-control-control** and/or **xtra-pc-control-listener** it is not neccessary to include **xtra-pc-control-api** in the main program file as well as each of them already includes **xtra-pc-control-api** but doing so will not cause any issues.


xtra-pc-control-control
---------------
#####Dependencies:
+ xtra-pc-control-api
+ amx-device-control (*see readme for amx-device-library for info*)

#####Description: 
Contains functions for controlling a PC through the Xtra PC Control software and requesting information from the PC.

Some functions defined within **xtra-pc-control-control** have an limited allowable set of values for one or more parameters. In these instances the allowable values will be printed within the accompanying commenting as constants defined within **xtra-pc-control-api**.

#####Usage:
Include **xtra-pc-control-control** into the main program using the `#include` compiler directive. E.g:

	#include 'xtra-pc-control-control'

and call the function(s) defined within **xtra-pc-control-control** from the main program file,. E.g:

	button_event [dvIo,ioOccupancySensor]
	{
		release:	// no-one in the rrom
		{
			xtraPcControlLock (dvXtraPcControl)	// lock the PC, stops unauthorised access
		}
	}

	button_event [dvTp,btnSystemOff]
	{
		push:	// turn the system off
		{
			xtraPcControlLogoff (dvXtraPcControl)	// logoff the PC, in case the user forgot
		}
	}


xtra-pc-control-listener
----------------
#####Dependencies:
+ xtra-pc-control-api

#####Description:
Contains dev arrays for listening to traffic returned from the Xtra PC Control software.

You should copy the required dev arrays to their main program and instantiate them with dev values corresponding to the instances of the Xtra PC Control software you wish to listen to.

Contains commented out callback functions and events required to capture information from the Xtra PC Control software. The events (data_events, channel_events, & level_events) will parse the information returned from the software and call the associated callback functions passing the information through as arguments to the call back functions' parameter list.

Callback functions may be triggered from both unprompted data and responses to requests for information.

#####Usage:
Include **xtra-pc-control-listener** into the main program using the `#include` compiler directive. E.g:

	#include 'xtra-pc-control-listener'

Copy the required DEV arrays from **xtra-pc-control-listener**:

	define_variable

	#if_not_defined dvXtraPcControlMainPorts
	dev dvXtraPcControlMainPorts[] = {9001:1:0}
	#end_if

to the main program file and populate the contents of the DEV arrays with only the instances of the Xtra PC Contorl software that you want to listen to. E.g:

	define_device

	dvXtraPcControl = 9001:1:0

	define_variable

	// DEV array for Xtra PC Control software copied from xtra-pc-control-listener
	dev dvXtraPcControlMainPorts[] = {dvXtraPcControl}

NOTE: The order of the devices within the DEV arrays does not matter. You can also have device ports from multiple Xtra PC Control software instances within the same DEV array. You can have as few (1) or as many devices defined within the DEV array as you want to listen to.

Copy whichever callback functions you would like to use to monitor changes on the PC or capture responses to requests for information in your main program file. The callback function should then be uncommented and the contents of the statement block filled in appropriately. The callback functions should not be uncommented within **xtra-pc-control-listener**. E.g:

Copy an empty, commented out callback function from **xtra-pc-control-listener** and the associated `#define` statement:

	/*
	#define INCLUDE_XTRA_PC_CONTROL_NOTIFY_LOCK_STATUS_CALLBACK
	define_function xtraPcControlNotifyLockStatus (dev xtraPcControl, char lockStatus[], char user[])
	{
		// xtraPcControl is Xtra PC Control application.
		// lockStatus contains the PC lock status
		// user contains the Windows username.
	}
	*/

paste the callback function and `#define` statement into the main program file, uncomment, and add any code statements you want:

	#define INCLUDE_XTRA_PC_CONTROL_NOTIFY_LOCK_STATUS_CALLBACK
	define_function xtraPcControlNotifyLockStatus (dev xtraPcControl, char lockStatus[], char user[])
	{
		// xtraPcControl is Xtra PC Control application.
		// lockStatus contains the PC lock status
		// user contains the Windows username.

		if (xtraPcControl = dvXtraPcControlMeetingRoom)
		{
			switch (lockStatus)
			{
				case XTRA_PC_CONTROL_LOCK_STATUS_LOCKED:
				{
					// pc is locked for <user>
				}    
				case XTRA_PC_CONTROL_LOCK_STATUS_UNLOCKED:
				{
					// pc is unlocked by <user>
				}
			}
		}
	}

The callback function will be automatically triggered whenever a change occurs on the PC (that initiates an unsolicted feedback response) or a response to a request for information is received.

###IMPORTANT!
1. The `#define` compiler directive found directly above the callback function within **xtra-pc-control-listener** must also be copied to the main program and uncommented along with the callback function itself.

2. Due to the way the NetLinx compiler scans the program for `#define` staments **xtra-pc-control-listener** must be included in the main program file underneath any callback functions and associated `#define` statements or the callback functions will not trigger.

E.g:

		#program_name='main program'
			
		define_device

		dvXtraPcControl = 9001:1:0

		define_variable

		// DEV array for Xtra PC Control software copied from xtra-pc-control-listener
		dev dvXtraPcControlMainPorts[] = {dvXtraPcControl}
			
		#define INCLUDE_XTRA_PC_CONTROL_NOTIFY_LOCK_STATUS_CALLBACK
		define_function xtraPcControlNotifyLockStatus (dev xtraPcControl, char lockStatus[], char user[])
		{
		}

		#define INCLUDE_XTRA_PC_CONTROL_NOTIFY_PROCESS_LIST_ITEM_CALLBACK
		define_function xtraPcControlNotifyProcessListItem (dev xtraPcControl, integer processListCount, integer processListItemIndex, char processName[])
		}
		
		#include 'xtra-pc-control-listener'

---------------------------------------------------------------

Author: David Vine - AMX Australia  
Readme formatted with markdown  
Any questions, email <support@amxaustralia.com.au> or phone +61 (7) 5531 3103.
