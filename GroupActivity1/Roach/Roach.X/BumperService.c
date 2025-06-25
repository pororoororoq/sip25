/*
 * File:   BumperService.c
 * Author: Your Name
 * 
 * Description:
 * Debounced bumper polling service. Periodically reads bumpers and
 * posts directional bump events when transitions are detected.
 */

#include "BOARD.h"
#include "ES_Configure.h"
#include "ES_Framework.h"
#include "BumperService.h"
#include "roach.h"
#include "RoachHSM.h" // Needed to post to top-level HSM
#include <stdio.h>

#define BUMPER_TIMER 0        // Make sure this matches ES_Configure.h
#define POLL_INTERVAL 5       // ms
#define BUMPER_MASK 0x0F      // Mask for 4-bit bumper input

static uint8_t MyPriority;
static uint8_t LastBumperState = 0x00;

/*******************************************************************************
 * PUBLIC FUNCTIONS
 ******************************************************************************/

uint8_t InitBumperService(uint8_t Priority) {
    ES_Event ThisEvent;
    MyPriority = Priority;

    ES_Timer_InitTimer(BUMPER_TIMER, POLL_INTERVAL);

    ThisEvent.EventType = ES_INIT;
    if (ES_PostToService(MyPriority, ThisEvent) == TRUE) {
        return TRUE;
    } else {
        return FALSE;
    }
}

uint8_t PostBumperService(ES_Event ThisEvent) {
    return ES_PostToService(MyPriority, ThisEvent);
}

ES_Event RunBumperService(ES_Event ThisEvent) {
    static ES_EventTyp_t lastEvent = NB;
    ES_Event ReturnEvent;
    ReturnEvent.EventType = ES_NO_EVENT;

    switch (ThisEvent.EventType) {
        case ES_INIT:
            // Start polling
            break;

        case ES_TIMEOUT: {
            ES_Timer_InitTimer(BUMPER_TIMER, POLL_INTERVAL);

            uint8_t CurrentBumper = Roach_ReadBumpers() & BUMPER_MASK;
            ES_EventTyp_t curEvent = NB;

            switch (CurrentBumper) {
                case 0x01: curEvent = FL; break;
                case 0x02: curEvent = FR; break;
                case 0x04: curEvent = BL; break;
                case 0x08: curEvent = BR; break;
                case 0x03: curEvent = FRONT; break; // FL + FR
                case 0x0C: curEvent = BACK;  break; // BL + BR
                case 0x00: curEvent = NB;    break;
                default:   curEvent = NB;    break;
            }

            if (curEvent != lastEvent) {
                lastEvent = curEvent;
                ReturnEvent.EventType = curEvent;
                ReturnEvent.EventParam = CurrentBumper;
                PostRoachHSM(ReturnEvent);
            }
            break;
        }

        default:
            break;
    }

    return ReturnEvent;
}
