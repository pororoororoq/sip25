#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-default.mk)" "nbproject/Makefile-local-default.mk"
include nbproject/Makefile-local-default.mk
endif
endif

# Environment
MKDIR=mkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=elf
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/Roach.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/Roach.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

ifeq ($(COMPARE_BUILD), true)
COMPARISON_BUILD=-mafrlcsj
else
COMPARISON_BUILD=
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=C:/ECE118/src/AD.c C:/ECE118/src/BOARD.c C:/ECE118/src/ES_CheckEvents.c C:/ECE118/src/ES_Framework.c C:/ECE118/src/ES_KeyboardInput.c C:/ECE118/src/ES_PostList.c C:/ECE118/src/ES_Queue.c C:/ECE118/src/ES_TattleTale.c C:/ECE118/src/ES_Timers.c C:/ECE118/src/IO_Ports.c C:/ECE118/src/LED.c C:/ECE118/src/RC_Servo.c C:/ECE118/src/pwm.c C:/ECE118/src/roach.c C:/ECE118/src/serial.c C:/ECE118/src/timers.c C:/Users/hanse/MPLABXProjects/Roach.X/TemplateES_Main.c C:/Users/hanse/MPLABXProjects/Roach.X/TemplateEventChecker.c C:/Users/hanse/MPLABXProjects/Roach.X/TemplateHSM.c C:/Users/hanse/MPLABXProjects/Roach.X/TemplateService.c C:/Users/hanse/MPLABXProjects/Roach.X/TemplateSubHSM.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/C:/ECE118/src/AD.o ${OBJECTDIR}/C:/ECE118/src/BOARD.o ${OBJECTDIR}/C:/ECE118/src/ES_CheckEvents.o ${OBJECTDIR}/C:/ECE118/src/ES_Framework.o ${OBJECTDIR}/C:/ECE118/src/ES_KeyboardInput.o ${OBJECTDIR}/C:/ECE118/src/ES_PostList.o ${OBJECTDIR}/C:/ECE118/src/ES_Queue.o ${OBJECTDIR}/C:/ECE118/src/ES_TattleTale.o ${OBJECTDIR}/C:/ECE118/src/ES_Timers.o ${OBJECTDIR}/C:/ECE118/src/IO_Ports.o ${OBJECTDIR}/C:/ECE118/src/LED.o ${OBJECTDIR}/C:/ECE118/src/RC_Servo.o ${OBJECTDIR}/C:/ECE118/src/pwm.o ${OBJECTDIR}/C:/ECE118/src/roach.o ${OBJECTDIR}/C:/ECE118/src/serial.o ${OBJECTDIR}/C:/ECE118/src/timers.o ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateES_Main.o ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateEventChecker.o ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateHSM.o ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateService.o ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateSubHSM.o
POSSIBLE_DEPFILES=${OBJECTDIR}/C:/ECE118/src/AD.o.d ${OBJECTDIR}/C:/ECE118/src/BOARD.o.d ${OBJECTDIR}/C:/ECE118/src/ES_CheckEvents.o.d ${OBJECTDIR}/C:/ECE118/src/ES_Framework.o.d ${OBJECTDIR}/C:/ECE118/src/ES_KeyboardInput.o.d ${OBJECTDIR}/C:/ECE118/src/ES_PostList.o.d ${OBJECTDIR}/C:/ECE118/src/ES_Queue.o.d ${OBJECTDIR}/C:/ECE118/src/ES_TattleTale.o.d ${OBJECTDIR}/C:/ECE118/src/ES_Timers.o.d ${OBJECTDIR}/C:/ECE118/src/IO_Ports.o.d ${OBJECTDIR}/C:/ECE118/src/LED.o.d ${OBJECTDIR}/C:/ECE118/src/RC_Servo.o.d ${OBJECTDIR}/C:/ECE118/src/pwm.o.d ${OBJECTDIR}/C:/ECE118/src/roach.o.d ${OBJECTDIR}/C:/ECE118/src/serial.o.d ${OBJECTDIR}/C:/ECE118/src/timers.o.d ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateES_Main.o.d ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateEventChecker.o.d ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateHSM.o.d ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateService.o.d ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateSubHSM.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/C:/ECE118/src/AD.o ${OBJECTDIR}/C:/ECE118/src/BOARD.o ${OBJECTDIR}/C:/ECE118/src/ES_CheckEvents.o ${OBJECTDIR}/C:/ECE118/src/ES_Framework.o ${OBJECTDIR}/C:/ECE118/src/ES_KeyboardInput.o ${OBJECTDIR}/C:/ECE118/src/ES_PostList.o ${OBJECTDIR}/C:/ECE118/src/ES_Queue.o ${OBJECTDIR}/C:/ECE118/src/ES_TattleTale.o ${OBJECTDIR}/C:/ECE118/src/ES_Timers.o ${OBJECTDIR}/C:/ECE118/src/IO_Ports.o ${OBJECTDIR}/C:/ECE118/src/LED.o ${OBJECTDIR}/C:/ECE118/src/RC_Servo.o ${OBJECTDIR}/C:/ECE118/src/pwm.o ${OBJECTDIR}/C:/ECE118/src/roach.o ${OBJECTDIR}/C:/ECE118/src/serial.o ${OBJECTDIR}/C:/ECE118/src/timers.o ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateES_Main.o ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateEventChecker.o ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateHSM.o ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateService.o ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateSubHSM.o

# Source Files
SOURCEFILES=C:/ECE118/src/AD.c C:/ECE118/src/BOARD.c C:/ECE118/src/ES_CheckEvents.c C:/ECE118/src/ES_Framework.c C:/ECE118/src/ES_KeyboardInput.c C:/ECE118/src/ES_PostList.c C:/ECE118/src/ES_Queue.c C:/ECE118/src/ES_TattleTale.c C:/ECE118/src/ES_Timers.c C:/ECE118/src/IO_Ports.c C:/ECE118/src/LED.c C:/ECE118/src/RC_Servo.c C:/ECE118/src/pwm.c C:/ECE118/src/roach.c C:/ECE118/src/serial.c C:/ECE118/src/timers.c C:/Users/hanse/MPLABXProjects/Roach.X/TemplateES_Main.c C:/Users/hanse/MPLABXProjects/Roach.X/TemplateEventChecker.c C:/Users/hanse/MPLABXProjects/Roach.X/TemplateHSM.c C:/Users/hanse/MPLABXProjects/Roach.X/TemplateService.c C:/Users/hanse/MPLABXProjects/Roach.X/TemplateSubHSM.c



CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-default.mk ${DISTDIR}/Roach.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=32MX320F128H
MP_LINKER_FILE_OPTION=,--script="C:/ECE118/bootloader320.ld"
# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assembleWithPreprocess
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/C:/ECE118/src/AD.o: C:/ECE118/src/AD.c  .generated_files/flags/default/220f9c99d8e809db6129e4dc001cf27aafd201ee .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/ECE118/src" 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/AD.o.d 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/AD.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/ECE118/src/AD.o.d" -o ${OBJECTDIR}/C:/ECE118/src/AD.o C:/ECE118/src/AD.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/ECE118/src/BOARD.o: C:/ECE118/src/BOARD.c  .generated_files/flags/default/fdde81b70febbb41bb2dcd96f3517eb277bf5586 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/ECE118/src" 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/BOARD.o.d 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/BOARD.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/ECE118/src/BOARD.o.d" -o ${OBJECTDIR}/C:/ECE118/src/BOARD.o C:/ECE118/src/BOARD.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/ECE118/src/ES_CheckEvents.o: C:/ECE118/src/ES_CheckEvents.c  .generated_files/flags/default/e9902c66ff28a92dc15e68f0260134a48fafbe1d .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/ECE118/src" 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/ES_CheckEvents.o.d 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/ES_CheckEvents.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/ECE118/src/ES_CheckEvents.o.d" -o ${OBJECTDIR}/C:/ECE118/src/ES_CheckEvents.o C:/ECE118/src/ES_CheckEvents.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/ECE118/src/ES_Framework.o: C:/ECE118/src/ES_Framework.c  .generated_files/flags/default/927f70b2aed48be5c6ee5ee0c7888788e5ee816b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/ECE118/src" 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/ES_Framework.o.d 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/ES_Framework.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/ECE118/src/ES_Framework.o.d" -o ${OBJECTDIR}/C:/ECE118/src/ES_Framework.o C:/ECE118/src/ES_Framework.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/ECE118/src/ES_KeyboardInput.o: C:/ECE118/src/ES_KeyboardInput.c  .generated_files/flags/default/10be342ca463659403f3a191685800c5b038d5c5 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/ECE118/src" 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/ES_KeyboardInput.o.d 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/ES_KeyboardInput.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/ECE118/src/ES_KeyboardInput.o.d" -o ${OBJECTDIR}/C:/ECE118/src/ES_KeyboardInput.o C:/ECE118/src/ES_KeyboardInput.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/ECE118/src/ES_PostList.o: C:/ECE118/src/ES_PostList.c  .generated_files/flags/default/c01b5053b12a05cece0e4ca331ceddd981606afb .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/ECE118/src" 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/ES_PostList.o.d 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/ES_PostList.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/ECE118/src/ES_PostList.o.d" -o ${OBJECTDIR}/C:/ECE118/src/ES_PostList.o C:/ECE118/src/ES_PostList.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/ECE118/src/ES_Queue.o: C:/ECE118/src/ES_Queue.c  .generated_files/flags/default/85ff531179992bd024172f237ef5caf5c428983a .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/ECE118/src" 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/ES_Queue.o.d 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/ES_Queue.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/ECE118/src/ES_Queue.o.d" -o ${OBJECTDIR}/C:/ECE118/src/ES_Queue.o C:/ECE118/src/ES_Queue.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/ECE118/src/ES_TattleTale.o: C:/ECE118/src/ES_TattleTale.c  .generated_files/flags/default/9985cc051855d03dbe424e41661b569b3e39ec3 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/ECE118/src" 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/ES_TattleTale.o.d 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/ES_TattleTale.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/ECE118/src/ES_TattleTale.o.d" -o ${OBJECTDIR}/C:/ECE118/src/ES_TattleTale.o C:/ECE118/src/ES_TattleTale.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/ECE118/src/ES_Timers.o: C:/ECE118/src/ES_Timers.c  .generated_files/flags/default/94c007e6a0828d3ad1357d13390139d92de456bc .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/ECE118/src" 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/ES_Timers.o.d 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/ES_Timers.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/ECE118/src/ES_Timers.o.d" -o ${OBJECTDIR}/C:/ECE118/src/ES_Timers.o C:/ECE118/src/ES_Timers.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/ECE118/src/IO_Ports.o: C:/ECE118/src/IO_Ports.c  .generated_files/flags/default/deeea2e14ab28fa2ee14e474302b49aab61e466e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/ECE118/src" 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/IO_Ports.o.d 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/IO_Ports.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/ECE118/src/IO_Ports.o.d" -o ${OBJECTDIR}/C:/ECE118/src/IO_Ports.o C:/ECE118/src/IO_Ports.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/ECE118/src/LED.o: C:/ECE118/src/LED.c  .generated_files/flags/default/f2cab87b93ed0c128079846fea6ef3d89ac929c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/ECE118/src" 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/LED.o.d 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/LED.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/ECE118/src/LED.o.d" -o ${OBJECTDIR}/C:/ECE118/src/LED.o C:/ECE118/src/LED.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/ECE118/src/RC_Servo.o: C:/ECE118/src/RC_Servo.c  .generated_files/flags/default/7747720ce94eff927d848711f6e51c4f490a1adf .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/ECE118/src" 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/RC_Servo.o.d 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/RC_Servo.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/ECE118/src/RC_Servo.o.d" -o ${OBJECTDIR}/C:/ECE118/src/RC_Servo.o C:/ECE118/src/RC_Servo.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/ECE118/src/pwm.o: C:/ECE118/src/pwm.c  .generated_files/flags/default/8f6ff04955c88e2afca988c320f00b93d0d05b11 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/ECE118/src" 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/pwm.o.d 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/pwm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/ECE118/src/pwm.o.d" -o ${OBJECTDIR}/C:/ECE118/src/pwm.o C:/ECE118/src/pwm.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/ECE118/src/roach.o: C:/ECE118/src/roach.c  .generated_files/flags/default/7d2fd31a6bc28ade061da9cc804bfac31f72ae4 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/ECE118/src" 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/roach.o.d 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/roach.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/ECE118/src/roach.o.d" -o ${OBJECTDIR}/C:/ECE118/src/roach.o C:/ECE118/src/roach.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/ECE118/src/serial.o: C:/ECE118/src/serial.c  .generated_files/flags/default/250dd205217487267997a79fbd6cc5c127099790 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/ECE118/src" 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/serial.o.d 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/serial.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/ECE118/src/serial.o.d" -o ${OBJECTDIR}/C:/ECE118/src/serial.o C:/ECE118/src/serial.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/ECE118/src/timers.o: C:/ECE118/src/timers.c  .generated_files/flags/default/2cfeb214f5647217f99740f6e34a98666140b57d .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/ECE118/src" 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/timers.o.d 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/timers.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/ECE118/src/timers.o.d" -o ${OBJECTDIR}/C:/ECE118/src/timers.o C:/ECE118/src/timers.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateES_Main.o: C:/Users/hanse/MPLABXProjects/Roach.X/TemplateES_Main.c  .generated_files/flags/default/f02087867d4e276525925ca4d0b4174c2697d79f .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X" 
	@${RM} ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateES_Main.o.d 
	@${RM} ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateES_Main.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateES_Main.o.d" -o ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateES_Main.o C:/Users/hanse/MPLABXProjects/Roach.X/TemplateES_Main.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateEventChecker.o: C:/Users/hanse/MPLABXProjects/Roach.X/TemplateEventChecker.c  .generated_files/flags/default/46af82673e3269167f6b75bcf129dddd561e4412 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X" 
	@${RM} ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateEventChecker.o.d 
	@${RM} ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateEventChecker.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateEventChecker.o.d" -o ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateEventChecker.o C:/Users/hanse/MPLABXProjects/Roach.X/TemplateEventChecker.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateHSM.o: C:/Users/hanse/MPLABXProjects/Roach.X/TemplateHSM.c  .generated_files/flags/default/87902294b782b41fb58d634e1b8af63fbf9f684d .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X" 
	@${RM} ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateHSM.o.d 
	@${RM} ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateHSM.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateHSM.o.d" -o ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateHSM.o C:/Users/hanse/MPLABXProjects/Roach.X/TemplateHSM.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateService.o: C:/Users/hanse/MPLABXProjects/Roach.X/TemplateService.c  .generated_files/flags/default/eae459d01e84db77bf39a72a82993657bb2d3dbd .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X" 
	@${RM} ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateService.o.d 
	@${RM} ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateService.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateService.o.d" -o ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateService.o C:/Users/hanse/MPLABXProjects/Roach.X/TemplateService.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateSubHSM.o: C:/Users/hanse/MPLABXProjects/Roach.X/TemplateSubHSM.c  .generated_files/flags/default/3a2fe22cde3ccc1604480c5efd96085454e6be84 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X" 
	@${RM} ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateSubHSM.o.d 
	@${RM} ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateSubHSM.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateSubHSM.o.d" -o ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateSubHSM.o C:/Users/hanse/MPLABXProjects/Roach.X/TemplateSubHSM.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
else
${OBJECTDIR}/C:/ECE118/src/AD.o: C:/ECE118/src/AD.c  .generated_files/flags/default/17d7a1772cce774af9703f78a40b1a8b1ca86121 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/ECE118/src" 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/AD.o.d 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/AD.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/ECE118/src/AD.o.d" -o ${OBJECTDIR}/C:/ECE118/src/AD.o C:/ECE118/src/AD.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/ECE118/src/BOARD.o: C:/ECE118/src/BOARD.c  .generated_files/flags/default/7c29bbc22db7706b2a32a65fab8a600cd1539fa1 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/ECE118/src" 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/BOARD.o.d 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/BOARD.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/ECE118/src/BOARD.o.d" -o ${OBJECTDIR}/C:/ECE118/src/BOARD.o C:/ECE118/src/BOARD.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/ECE118/src/ES_CheckEvents.o: C:/ECE118/src/ES_CheckEvents.c  .generated_files/flags/default/cce5c2e331548d730666f0b641980db76122095f .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/ECE118/src" 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/ES_CheckEvents.o.d 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/ES_CheckEvents.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/ECE118/src/ES_CheckEvents.o.d" -o ${OBJECTDIR}/C:/ECE118/src/ES_CheckEvents.o C:/ECE118/src/ES_CheckEvents.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/ECE118/src/ES_Framework.o: C:/ECE118/src/ES_Framework.c  .generated_files/flags/default/5d6e6d0d8d8b4e833b1427a01d74e66eacda1b1c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/ECE118/src" 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/ES_Framework.o.d 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/ES_Framework.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/ECE118/src/ES_Framework.o.d" -o ${OBJECTDIR}/C:/ECE118/src/ES_Framework.o C:/ECE118/src/ES_Framework.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/ECE118/src/ES_KeyboardInput.o: C:/ECE118/src/ES_KeyboardInput.c  .generated_files/flags/default/b9122fbc55b96e48e149df6f782624a36be40c18 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/ECE118/src" 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/ES_KeyboardInput.o.d 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/ES_KeyboardInput.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/ECE118/src/ES_KeyboardInput.o.d" -o ${OBJECTDIR}/C:/ECE118/src/ES_KeyboardInput.o C:/ECE118/src/ES_KeyboardInput.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/ECE118/src/ES_PostList.o: C:/ECE118/src/ES_PostList.c  .generated_files/flags/default/d1f604f3103bfd2f197c24dc9b8de76654681ee3 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/ECE118/src" 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/ES_PostList.o.d 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/ES_PostList.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/ECE118/src/ES_PostList.o.d" -o ${OBJECTDIR}/C:/ECE118/src/ES_PostList.o C:/ECE118/src/ES_PostList.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/ECE118/src/ES_Queue.o: C:/ECE118/src/ES_Queue.c  .generated_files/flags/default/960f5326a4711d73f252171a07e1c9295093a31f .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/ECE118/src" 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/ES_Queue.o.d 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/ES_Queue.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/ECE118/src/ES_Queue.o.d" -o ${OBJECTDIR}/C:/ECE118/src/ES_Queue.o C:/ECE118/src/ES_Queue.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/ECE118/src/ES_TattleTale.o: C:/ECE118/src/ES_TattleTale.c  .generated_files/flags/default/2e56afbbe404b6b5be185277eb6fab3caafca203 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/ECE118/src" 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/ES_TattleTale.o.d 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/ES_TattleTale.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/ECE118/src/ES_TattleTale.o.d" -o ${OBJECTDIR}/C:/ECE118/src/ES_TattleTale.o C:/ECE118/src/ES_TattleTale.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/ECE118/src/ES_Timers.o: C:/ECE118/src/ES_Timers.c  .generated_files/flags/default/1a772d322447983e9ce9c73e522161b456120438 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/ECE118/src" 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/ES_Timers.o.d 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/ES_Timers.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/ECE118/src/ES_Timers.o.d" -o ${OBJECTDIR}/C:/ECE118/src/ES_Timers.o C:/ECE118/src/ES_Timers.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/ECE118/src/IO_Ports.o: C:/ECE118/src/IO_Ports.c  .generated_files/flags/default/4d399d0157a0c6728f8c12343c567fbfbb1e0b1c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/ECE118/src" 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/IO_Ports.o.d 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/IO_Ports.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/ECE118/src/IO_Ports.o.d" -o ${OBJECTDIR}/C:/ECE118/src/IO_Ports.o C:/ECE118/src/IO_Ports.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/ECE118/src/LED.o: C:/ECE118/src/LED.c  .generated_files/flags/default/a7e1849e5079aeb96983b3e542fe3649a40f88e6 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/ECE118/src" 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/LED.o.d 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/LED.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/ECE118/src/LED.o.d" -o ${OBJECTDIR}/C:/ECE118/src/LED.o C:/ECE118/src/LED.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/ECE118/src/RC_Servo.o: C:/ECE118/src/RC_Servo.c  .generated_files/flags/default/b7f95e07beab3979eebd9c7ba1ecc16aa1af2dcf .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/ECE118/src" 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/RC_Servo.o.d 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/RC_Servo.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/ECE118/src/RC_Servo.o.d" -o ${OBJECTDIR}/C:/ECE118/src/RC_Servo.o C:/ECE118/src/RC_Servo.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/ECE118/src/pwm.o: C:/ECE118/src/pwm.c  .generated_files/flags/default/424f0a5e57ff3e74ec0737107d52f37384426615 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/ECE118/src" 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/pwm.o.d 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/pwm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/ECE118/src/pwm.o.d" -o ${OBJECTDIR}/C:/ECE118/src/pwm.o C:/ECE118/src/pwm.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/ECE118/src/roach.o: C:/ECE118/src/roach.c  .generated_files/flags/default/24a65d5d5f2ee3c668f61a51ca2d6615358ce83a .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/ECE118/src" 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/roach.o.d 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/roach.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/ECE118/src/roach.o.d" -o ${OBJECTDIR}/C:/ECE118/src/roach.o C:/ECE118/src/roach.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/ECE118/src/serial.o: C:/ECE118/src/serial.c  .generated_files/flags/default/61a181e86999bbdedc34fbcf7c260169ffafd708 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/ECE118/src" 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/serial.o.d 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/serial.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/ECE118/src/serial.o.d" -o ${OBJECTDIR}/C:/ECE118/src/serial.o C:/ECE118/src/serial.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/ECE118/src/timers.o: C:/ECE118/src/timers.c  .generated_files/flags/default/e91f89a6367a901b4c175d0b2bb42b80ea442c2e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/ECE118/src" 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/timers.o.d 
	@${RM} ${OBJECTDIR}/C:/ECE118/src/timers.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/ECE118/src/timers.o.d" -o ${OBJECTDIR}/C:/ECE118/src/timers.o C:/ECE118/src/timers.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateES_Main.o: C:/Users/hanse/MPLABXProjects/Roach.X/TemplateES_Main.c  .generated_files/flags/default/50242d8cd68958fc79a5ee74b4ec0f4068c2609f .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X" 
	@${RM} ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateES_Main.o.d 
	@${RM} ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateES_Main.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateES_Main.o.d" -o ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateES_Main.o C:/Users/hanse/MPLABXProjects/Roach.X/TemplateES_Main.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateEventChecker.o: C:/Users/hanse/MPLABXProjects/Roach.X/TemplateEventChecker.c  .generated_files/flags/default/97351d12d9232077c594140e68bb1b2f8e02be68 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X" 
	@${RM} ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateEventChecker.o.d 
	@${RM} ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateEventChecker.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateEventChecker.o.d" -o ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateEventChecker.o C:/Users/hanse/MPLABXProjects/Roach.X/TemplateEventChecker.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateHSM.o: C:/Users/hanse/MPLABXProjects/Roach.X/TemplateHSM.c  .generated_files/flags/default/60a89aeb73dca949124ed56d96444b5f18f70fd1 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X" 
	@${RM} ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateHSM.o.d 
	@${RM} ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateHSM.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateHSM.o.d" -o ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateHSM.o C:/Users/hanse/MPLABXProjects/Roach.X/TemplateHSM.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateService.o: C:/Users/hanse/MPLABXProjects/Roach.X/TemplateService.c  .generated_files/flags/default/f5eb2792b4f05d9f25875af8025f2f72382aceed .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X" 
	@${RM} ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateService.o.d 
	@${RM} ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateService.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateService.o.d" -o ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateService.o C:/Users/hanse/MPLABXProjects/Roach.X/TemplateService.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateSubHSM.o: C:/Users/hanse/MPLABXProjects/Roach.X/TemplateSubHSM.c  .generated_files/flags/default/6f9e7a7690c52afdaa20e37467c11e46c439977e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X" 
	@${RM} ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateSubHSM.o.d 
	@${RM} ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateSubHSM.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O0 -fno-common -I"C:/Users/hanse/MPLABXProjects/Roach.X" -I"C:/ECE118/include" -MP -MMD -MF "${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateSubHSM.o.d" -o ${OBJECTDIR}/C:/Users/hanse/MPLABXProjects/Roach.X/TemplateSubHSM.o C:/Users/hanse/MPLABXProjects/Roach.X/TemplateSubHSM.c    -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compileCPP
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${DISTDIR}/Roach.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    C:/ECE118/bootloader320.ld
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE) -g   -mprocessor=$(MP_PROCESSOR_OPTION)  -o ${DISTDIR}/Roach.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}          -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)      -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,-D=__DEBUG_D,--defsym=_min_heap_size=10,--no-code-in-dinit,--no-dinit-in-serial-mem,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--memorysummary,${DISTDIR}/memoryfile.xml -mdfp="${DFP_DIR}"
	
else
${DISTDIR}/Roach.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   C:/ECE118/bootloader320.ld
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -mprocessor=$(MP_PROCESSOR_OPTION)  -o ${DISTDIR}/Roach.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}          -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=_min_heap_size=10,--no-code-in-dinit,--no-dinit-in-serial-mem,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--memorysummary,${DISTDIR}/memoryfile.xml -mdfp="${DFP_DIR}"
	${MP_CC_DIR}/xc32-bin2hex ${DISTDIR}/Roach.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} 
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r ${OBJECTDIR}
	${RM} -r ${DISTDIR}

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(wildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
