#ifndef ROACH_HSM_H
#define ROACH_HSM_H

#include "ES_Configure.h"
#include "ES_Framework.h"

/*******************************************************************************
 * PUBLIC FUNCTION PROTOTYPES
 ******************************************************************************/

/**
 * @Function InitRoachHSM(uint8_t Priority)
 * @param Priority - internal priority of this state machine
 * @return TRUE on success, FALSE on failure
 * @brief Initializes the top-level HSM and posts ES_INIT to its own queue
 */
uint8_t InitRoachHSM(uint8_t Priority);

/**
 * @Function PostRoachHSM(ES_Event ThisEvent)
 * @param ThisEvent - the event to post to this HSM's queue
 * @return TRUE if successful, FALSE otherwise
 * @brief Wrapper for posting events to this state machine
 */
uint8_t PostRoachHSM(ES_Event ThisEvent);

/**
 * @Function RunRoachHSM(ES_Event ThisEvent)
 * @param ThisEvent - the event (type and param) to be responded.
 * @return Event - return event (type and param), in general should be ES_NO_EVENT
 * @brief This function is where you implement the whole of the hierarchical state
 *        machine for the Roach behavior. It is called whenever a new event is
 *        received via the event queue. This function manages state transitions
 *        following the convention: exit current state ? enter next state, using
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
 *        and internal transitions such as DONE_EVADING or INTO_DARK/LIGHT.
 *
 *        In this HSM, sub-state logic (like Hiding ? AvoidingBump) may also be
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
                case INTO_LIGHT:
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
                case INTO_DARK:
                    MakeTransition = TRUE;
                    NextState = InDark;
                    break;
                case INTO_LIGHT:
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
                case INTO_DARK:
                    MakeTransition = TRUE;
                    NextState = InDark;
                    break;
                case INTO_LIGHT:
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
                case INTO_DARK:
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
                case INTO_DARK:
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
                case INTO_DARK:
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