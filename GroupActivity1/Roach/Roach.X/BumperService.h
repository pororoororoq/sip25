/*
 * File:   BumperService.h
 * Author: Your Name
 * 
 * Description:
 * Bumper polling service for Roach robot using the ES_Framework.
 * Checks bumper inputs every 5ms and posts directional bump events to the HSM.
 */

#ifndef BumperService_H
#define BumperService_H

#include "ES_Configure.h"

/*******************************************************************************
 * PUBLIC FUNCTION PROTOTYPES
 ******************************************************************************/

/**
 * @Function InitBumperService(uint8_t Priority)
 * @param Priority - priority of this service's event queue
 * @return TRUE if initialized successfully, FALSE otherwise
 * @brief Initializes the service and starts the bumper polling timer
 */
uint8_t InitBumperService(uint8_t Priority);

/**
 * @Function PostBumperService(ES_Event ThisEvent)
 * @param ThisEvent - the event (type and param) to be posted to the service
 * @return TRUE if successful, FALSE otherwise
 * @brief Wrapper to post events to this service's queue
 */
uint8_t PostBumperService(ES_Event ThisEvent);

/**
 * @Function RunBumperService(ES_Event ThisEvent)
 * @param ThisEvent - the event (type and param) to be processed
 * @return ES_NO_EVENT normally, or the event if forwarded
 * @brief Processes polling timer expirations and posts bump events
 */
ES_Event RunBumperService(ES_Event ThisEvent);

#endif /* BumperService_H */
