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
 * @param ThisEvent - the event to process
 * @return ES_Event - return event (usually ES_NO_EVENT)
 * @brief Main state machine function for Roach behavior
 */
ES_Event RunRoachHSM(ES_Event ThisEvent);

#endif /* ROACH_HSM_H */