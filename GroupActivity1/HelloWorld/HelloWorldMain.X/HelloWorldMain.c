/*
 * File:   HelloWorldMain.c
 * Author: hanse
 *
 * Created on June 24, 2025, 11:30 AM
 */


#include <BOARD.h>
#include <stdio.h>

int main(void) {
    BOARD_Init();
    Roach_Init();
    printf("Hello World!");
    while (1) {
        ;
    }
}