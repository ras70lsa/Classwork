  /*********************** dSPACE target specific file *************************

   Header file MakeNoise_trc_ptr.h:

   Declaration of function that initializes the global TRC pointers

   RTI1104 6.6 (29-Nov-2010)
   Wed Oct 04 10:24:12 2017

   (c) Copyright 2008, dSPACE GmbH. All rights reserved.

  *****************************************************************************/
  #ifndef RTI_HEADER_MakeNoise_trc_ptr_h_
  #define RTI_HEADER_MakeNoise_trc_ptr_h_
  /* Include the model header file. */
  #include "MakeNoise.h"
  #include "MakeNoise_private.h"

  #ifdef EXTERN_C
  #undef EXTERN_C
  #endif

  #ifdef __cplusplus
  #define EXTERN_C                       extern "C"
  #else
  #define EXTERN_C                       extern
  #endif

  /*
   *  Declare the global TRC pointers
   */
              EXTERN_C volatile  real_T *p_MakeNoise_B_real_T_0;
              EXTERN_C volatile  real_T *p_MakeNoise_P_real_T_0;
              EXTERN_C volatile  real_T *p_MakeNoise_DWork_real_T_0;
              EXTERN_C volatile  uint32_T *p_MakeNoise_DWork_uint32_T_1;
              EXTERN_C volatile  real_T *p_MakeNoise_Y_real_T_0;

   #define RTI_INIT_TRC_POINTERS() \
              p_MakeNoise_B_real_T_0 = &MakeNoise_B.SFunction[0];\
              p_MakeNoise_P_real_T_0 = &MakeNoise_P.GainADC1_Gain;\
              p_MakeNoise_DWork_real_T_0 = &MakeNoise_DWork.WhiteNoise_NextOutput;\
              p_MakeNoise_DWork_uint32_T_1 = &MakeNoise_DWork.RandSeed;\
              p_MakeNoise_Y_real_T_0 = &MakeNoise_Y.ADC1;\

   #endif                       /* RTI_HEADER_MakeNoise_trc_ptr_h_ */
