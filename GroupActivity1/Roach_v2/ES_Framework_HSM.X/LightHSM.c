/*
 * File: TemplateSubHSM.c
 * Author: J. Edward Carryer
 * Modified: Gabriel H Elkaim
 *
 * Template file to set up a Heirarchical State Machine to work with the Events and
 * Services Framework (ES_Framework) on the Uno32 for the CMPE-118/L class. Note that
 * this file will need to be modified to fit your exact needs, and most of the names
 * will have to be changed to match your code.
 *
 * There is for a substate machine. Make sure it has a unique name
 *
 * This is provided as an example and a good place to start.
 *
 * History
 * When           Who     What/Why
 * -------------- ---     --------
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
#include "BOARD.h"
#include "roach.h"
#include "TemplateHSM.h"
#include "LightHSM.h"

/*******************************************************************************
 * MODULE #DEFINES                                                             *
 ******************************************************************************/
#define DANCE_TIMEOUT 5000
#define TURN_TIMEOUT 1000

typedef enum {
    InitPSubState,
    FORWARD,
    BACKWARD,
    TURN1,
    TURN2,
    DANCE,
} TemplateSubHSMState_t;

static const char *StateNames[] = {
	"InitPSubState",
	"FORWARD",
	"BACKWARD",
	"TURN1",
	"TURN2",
	"DANCE",
};



/*******************************************************************************
 * PRIVATE FUNCTION PROTOTYPES                                                 *
 ******************************************************************************/
/* Prototypes for private functions for this machine. They should be functions
   relevant to the behavior of this state machine */

/*******************************************************************************
 * PRIVATE MODULE VARIABLES                                                            *
 ******************************************************************************/
/* You will need MyPriority and the state variable; you may need others as well.
 * The type of state variable should match that of enum in header file. */

static TemplateSubHSMState_t CurrentState = InitPSubState; // <- change name to match ENUM
static uint8_t MyPriority;


/*******************************************************************************
 * PUBLIC FUNCTIONS                                                            *
 ******************************************************************************/

/**
 * @Function InitTemplateSubHSM(uint8_t Priority)
 * @param Priority - internal variable to track which event queue to use
 * @return TRUE or FALSE
 * @brief This will get called by the framework at the beginning of the code
 *        execution. It will post an ES_INIT event to the appropriate event
 *        queue, which will be handled inside RunTemplateFSM function. Remember
 *        to rename this to something appropriate.
 *        Returns TRUE if successful, FALSE otherwise
 * @author J. Edward Carryer, 2011.10.23 19:25 */
uint8_t InitLightHSM(void) {
    ES_Event returnEvent;

    CurrentState = InitPSubState;
    returnEvent = RunLightHSM(INIT_EVENT);
    if (returnEvent.EventType == ES_NO_EVENT) {
        return TRUE;
    }
    return FALSE;
}

/**
 * @Function RunTemplateSubHSM(ES_Event ThisEvent)
 * @param ThisEvent - the event (type and param) to be responded.
 * @return Event - return event (type and param), in general should be ES_NO_EVENT
 * @brief This function is where you implement the whole of the heirarchical state
 *        machine, as this is called any time a new event is passed to the event
 *        queue. This function will be called recursively to implement the correct
 *        order for a state transition to be: exit current state -> enter next state
 *        using the ES_EXIT and ES_ENTRY events.
 * @note Remember to rename to something appropriate.
 *       The lower level state machines are run first, to see if the event is dealt
 *       with there rather than at the current level. ES_EXIT and ES_ENTRY events are
 *       not consumed as these need to pass pack to the higher level state machine.
 * @author J. Edward Carryer, 2011.10.23 19:25
 * @author Gabriel H Elkaim, 2011.10.23 19:25 */
ES_Event RunLightHSM(ES_Event ThisEvent) {
    uint8_t makeTransition = FALSE; // use to flag transition
    TemplateSubHSMState_t nextState; // <- change type to correct enum

    ES_Tattle(); // trace call stack

    switch (CurrentState) {
        case InitPSubState: // If current state is initial Psedudo State
            if (ThisEvent.EventType == ES_INIT)// only respond to ES_Init
            {
                // this is where you would put any actions associated with the
                // transition from the initial pseudo-state into the actual
                // initial state

                // now put the machine into the actual initial state
                nextState = FORWARD;
                makeTransition = TRUE;
                ES_Timer_InitTimer(DANCE_TIMER, DANCE_TIMEOUT);
                ThisEvent.EventType = ES_NO_EVENT;
            }
            break;

        case FORWARD: // in the first state, replace this with correct names
            Roach_LeftMtrSpeed(-80);
            Roach_RightMtrSpeed(-70);

            if (ThisEvent.EventType == ES_TIMEOUT && ThisEvent.EventParam == 2) {
                ES_Timer_InitTimer(DANCE_TIMER, 2000);
                nextState = DANCE;
                makeTransition = TRUE;
            }

            if (ThisEvent.EventType == FR || ThisEvent.EventType == FL) {
                ES_Timer_InitTimer(BUMPED_TIMER, TURN_TIMEOUT);
                nextState = TURN1;
                makeTransition = TRUE;
            }

            if (ThisEvent.EventType == BR || ThisEvent.EventType == BL) {
                ES_Timer_InitTimer(BUMPED_TIMER, TURN_TIMEOUT);
                nextState = TURN2;
                makeTransition = TRUE;
            }

            break;
        case TURN1:
            Roach_LeftMtrSpeed(80);
            Roach_RightMtrSpeed(10);
            if (ThisEvent.EventType == ES_TIMEOUT && ThisEvent.EventParam == 3) {
                nextState = FORWARD;
                makeTransition = TRUE;
            }
            break;
        case TURN2:
            Roach_LeftMtrSpeed(-80);
            Roach_RightMtrSpeed(-10);
            if (ThisEvent.EventType == ES_TIMEOUT && ThisEvent.EventParam == 3) {
                nextState = FORWARD;
                makeTransition = TRUE;
            }
            break;
        case DANCE:
            Roach_LeftMtrSpeed(80);
            Roach_RightMtrSpeed(-80);
            if (ThisEvent.EventType == ES_TIMEOUT) {
                ES_Timer_InitTimer(DANCE_TIMER, DANCE_TIMEOUT);
                nextState = FORWARD;
                makeTransition = TRUE;
            }
        default: // all unhandled states fall into here
            if (ThisEvent.EventType == LIGHT) {
                nextState = FORWARD;
                makeTransition = TRUE;
            }
            break;
    } // end switch on Current State

    if (makeTransition == TRUE) { // making a state transition, send EXIT and ENTRY
        // recursively call the current state with an exit event
        RunLightHSM(EXIT_EVENT); // <- rename to your own Run function
        CurrentState = nextState;
        RunLightHSM(ENTRY_EVENT); // <- rename to your own Run function
    }

    ES_Tail(); // trace call stack end
    return ThisEvent;
}


/*******************************************************************************
 * PRIVATE FUNCTIONS                                                           *
 ******************************************************************************/

