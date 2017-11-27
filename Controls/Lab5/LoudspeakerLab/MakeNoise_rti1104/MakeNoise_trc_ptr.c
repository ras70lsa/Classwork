/***************************************************************************

   Source file MakeNoise_trc_ptr.c:

   Definition of function that initializes the global TRC pointers

   RTI1104 6.6 (29-Nov-2010)
   Wed Oct 04 10:24:12 2017

   (c) Copyright 2008, dSPACE GmbH. All rights reserved.

 *****************************************************************************/

/* Include header file. */
#include "MakeNoise_trc_ptr.h"

/* Definition of Global pointers to data type transitions (for TRC-file access) */
volatile real_T *p_MakeNoise_B_real_T_0 = 0;
volatile real_T *p_MakeNoise_P_real_T_0 = 0;
volatile real_T *p_MakeNoise_DWork_real_T_0 = 0;
volatile uint32_T *p_MakeNoise_DWork_uint32_T_1 = 0;
volatile real_T *p_MakeNoise_Y_real_T_0 = 0;
