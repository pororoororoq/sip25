/*
 * File: TemplateSubHSM.c
 * Author: J. Edward Carryer
 * Modified: Gabriel Elkaim and Soja-Marie Morgens
 *
 * Template file to set up a Heirarchical State Machine to work with the Events and
 * Services Framework (ES_Framework) on the Uno32 for the CMPE-118/L class. Note that
 * this file will need to be modified to fit your exact needs, and most of the names
 * will have to be changed to match your code.
 *
 * There is another template file for the SubHSM's that is slightly differet, and
 * should be used for all of the subordinate state machines (flat or heirarchical)
 *
 * This is provided as an example and a good place to start.
 *
 * History
 * When           Who     What/Why
 * -------------- ---     --------
 * 06/25/25 11:57 jjk      Updated to match new HSM structure and naming conventions
 * 06/25/25 11:57 jjk      Added comments and documentation
 * 06/25/25 11:57 jjk      Renamed to RoachHSM.c
 * 06/25/25 11:57 jjk      Added states for Roach behavior
 * 06/25/25 11:57 jjk      Added state transitions for Roach behavior
 * 06/25/25 11:57 jjk      Added event handling for Roach behavior
 * 06/25/25 11:57 jjk      Added state entry and exit handling for Roach behavior
 * 06/25/25 11:57 jjk      Added timer handling for Roach behavior
 * 
 * 09/13/13 15:17 ghe      added tattletail functionality and recursive calls
 * 01/15/12 11:12 jec      revisions for Gen2 framework
 * 11/07/11 11:26 jec      made the queue static
 * 10/30/11 17:59 jec      fixed references to CurrentEvent in RunTemplateSM()
 * 10/23/11 18:20 jec      began conversion from SMTemplate.c (02/20/07 rev)
 */


/*******************************************************************************
 * MODULE #INCLUDE                                                             *
 ******************************************************************************/

#include "ES_Configure.h"
#include "ES_Framework.h"
// #include "BumperService.h" // <-- Commented out because file is missing or not needed
#include "BOARD.h"
#include "TemplateHSM.h"
#include "TemplateSubHSM.h" //#include all sub state machines called
/*******************************************************************************
 * PRIVATE #DEFINES                                                            *
 ******************************************************************************/
//Include any defines you need to do

/*******************************************************************************
 * MODULE #DEFINES                                                             *
 ******************************************************************************/


typedef enum {
  InDark,
  Hiding,
  AvoidingBump,
  InLight,
  Running,
  Dancing
} RoachStates_t;

static RoachStates_t CurrentState;

static const char *StateNames[] = {
	"InitDark",
	"Hiding",
    "AvoidingBump",
    "InLight",
    "Running",
    "Dancing"
};


/*******************************************************************************
 * PRIVATE FUNCTION PROTOTYPES                                                 *
 ******************************************************************************/
/* Prototypes for private functions for this machine. They should be functions
   relevant to the behavior of this state machine
   Example: char RunAway(uint_8 seconds);*/
/*******************************************************************************
 * PRIVATE MODULE VARIABLES                                                            *
 ******************************************************************************/
/* You will need MyPriority and the state variable; you may need others as well.
 * The type of state variable should match that of enum in header file. */

static RoachStates_t CurrentState = InDark; // <- change enum name to match ENUM
static uint8_t MyPriority;


/*******************************************************************************
 * PUBLIC FUNCTIONS                                                            *
 ******************************************************************************/

/**
 * @Function InitRoachHSM(uint8_t Priority)
 * @param Priority - the priority of this state machine's event queue
 * @return boolean - TRUE if initialization was successful, FALSE otherwise
 * @brief This function initializes the RoachHSM by setting its initial state
 *        (typically `InDark`) and posting an ES_INIT event to its own queue to
 *        kick off state transitions. This function must be called before the HSM
 *        can run or receive any events.
 *
 *        It also assigns the internal priority variable to ensure that posted
 *        events go to the correct queue.
 *
 *        Once initialized, RunRoachHSM() will be called automatically when events
 *        are available.
 *
 * @note This function should be called exactly once as part of the system
 *       initialization phase, typically within ES_Configure().
 *
 * @author J. Edward Carryer, 2011.10.23 19:25
 * @author Gabriel H Elkaim, 2011.10.23 19:25
 * @editor Jake Kim, 2025.06.25
 */
uint8_t InitRoachHSM(uint8_t Priority) {
    CurrentState = InDark;
    ES_Event ThisEvent = { ES_ENTRY, 0 };
    RunRoachHSM(ThisEvent);
    return TRUE;
}


/**
 * @Function PostTemplateHSM(ES_Event ThisEvent)
 * @param ThisEvent - the event (type and param) to be posted to queue
 * @return TRUE or FALSE
 * @brief This function is a wrapper to the queue posting function, and its name
 *        will be used inside ES_Configure to point to which queue events should
 *        be posted to. Remember to rename to something appropriate.
 *        Returns TRUE if successful, FALSE otherwise
 * @author J. Edward Carryer, 2011.10.23 19:25 */
uint8_t PostTemplateHSM(ES_Event ThisEvent)
{
    return ES_PostToService(MyPriority, ThisEvent);
}

/**
 * @Function RunRoachHSM(ES_Event ThisEvent)
 * @param ThisEvent - the event (type and param) to be responded.
 * @return Event - return event (type and param), in general should be ES_NO_EVENT
 * @brief This function is where you implement the whole of the hierarchical state
 *        machine for the Roach behavior. It is called whenever a new event is
 *        received via the event queue. This function manages state transitions
 *        following the convention: exit current state → enter next state, using
 *        ES_EXIT and ES_ENTRY event types. 
 *
 *        The RoachHSM includes the following states:
 *        - InDark
 *        - Hiding
 *        - AvoidingBump
 *        - InLight
 *        - Running
 *        - Dancing
 *
 *        State transitions are based on light detection, bump events, timers,
 *        and internal transitions such as DONE_EVADING or DARK/LIGHT.
 *
 *        In this HSM, sub-state logic (like Hiding → AvoidingBump) may also be
 *        expanded into nested state machines as needed.
 *
 * @note You should make sure any subordinate state machines (if added later)
 *       are run *before* handling events at the current level.
 *       ES_ENTRY and ES_EXIT events should always be passed through for proper
 *       state lifecycle handling.
 *
 * @author J. Edward Carryer, 2011.10.23 19:25
 * @author Gabriel H Elkaim, 2011.10.23 19:25
 * @editor Jake J Kim, 2025.06.25
 */



ES_Event RunRoachHSM(ES_Event ThisEvent) {
    ES_Event ReturnEvent = { ES_NO_EVENT, 0 };
    RoachStates_t NextState = CurrentState;
    uint8_t MakeTransition = FALSE;

    switch(CurrentState) {
        case InDark:
            switch(ThisEvent.EventType) {
                case ES_ENTRY:
                    // Do setup for InDark (e.g., stop motors, turn off LEDs, etc.)
                    break;
                case LIGHT:
                    MakeTransition = TRUE;
                    NextState = InLight;
                    break;
                // case ES_ENTRY_HISTORY:  // Optional
                //     break;
                case ES_INIT:
                    // Start in dark, can transition to Hiding if needed
                    MakeTransition = TRUE;
                    NextState = Hiding;
                    break;
            }
            break;

        case Hiding:
            switch(ThisEvent.EventType) {
                case ES_ENTRY:
                    // Setup for Hiding (e.g., stop, hide behavior)
                    break;
                case BUMPED:
                    MakeTransition = TRUE;
                    NextState = AvoidingBump;
                    break;
                case DARK:
                    MakeTransition = TRUE;
                    NextState = InDark;
                    break;
                case LIGHT:
                    MakeTransition = TRUE;
                    NextState = InLight;
                    break;
            }
            break;

        case AvoidingBump:
            switch(ThisEvent.EventType) {
                case ES_ENTRY:
                    // Setup for AvoidingBump (e.g., back up)
                    break;
                case DONE_EVADING:
                    MakeTransition = TRUE;
                    NextState = Hiding;
                    break;
                case DARK:
                    MakeTransition = TRUE;
                    NextState = InDark;
                    break;
                case LIGHT:
                    MakeTransition = TRUE;
                    NextState = InLight;
                    break;
            }
            break;

        case InLight:
            switch(ThisEvent.EventType) {
                case ES_ENTRY:
                    // Setup for InLight (e.g., turn on LEDs, etc.)
                    break;
                // case ES_ENTRY_HISTORY:
                //     break;
                case TIMER_EXPIRED:
                    MakeTransition = TRUE;
                    NextState = Running;
                    break;
                case DARK:
                    MakeTransition = TRUE;
                    NextState = InDark;
                    break;
            }
            break;

        case Running:
            switch(ThisEvent.EventType) {
                case ES_ENTRY:
                    // Setup for Running (e.g., start timer for dancing)
                    break;
                case TIMER_EXPIRED:
                    MakeTransition = TRUE;
                    NextState = Dancing;
                    break;
                case DARK:
                    MakeTransition = TRUE;
                    NextState = InDark;
                    break;
            }
            break;

        case Dancing:
            switch(ThisEvent.EventType) {
                case ES_ENTRY:
                    // Setup for Dancing (e.g., start timer for running)
                    break;
                case TIMER_EXPIRED:
                    MakeTransition = TRUE;
                    NextState = Running;
                    break;
                case DARK:
                    MakeTransition = TRUE;
                    NextState = InDark;
                    break;
            }
            break;
    }

    if (MakeTransition) {
        RunRoachHSM((ES_Event){ES_EXIT, 0});
        CurrentState = NextState;
        RunRoachHSM((ES_Event){ES_ENTRY, 0});
    }

    return ReturnEvent;
}



/*******************************************************************************
 * PRIVATE FUNCTIONS                                                           *
 ******************************************************************************/
