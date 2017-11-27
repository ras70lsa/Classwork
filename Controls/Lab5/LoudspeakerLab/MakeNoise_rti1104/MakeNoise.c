/*
 * MakeNoise.c
 *
 * Real-Time Workshop code generation for Simulink model "MakeNoise.mdl".
 *
 * Model version              : 1.15
 * Real-Time Workshop version : 7.6.1  (R2010bSP1)  28-Jan-2011
 * C source code generated on : Wed Oct 04 10:24:12 2017
 *
 * Target selection: rti1104.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Generic->Custom
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "MakeNoise_trc_ptr.h"
#include "MakeNoise.h"
#include "MakeNoise_private.h"

/* Block signals (auto storage) */
BlockIO_MakeNoise MakeNoise_B;

/* Block states (auto storage) */
D_Work_MakeNoise MakeNoise_DWork;

/* External outputs (root outports fed by signals with auto storage) */
ExternalOutputs_MakeNoise MakeNoise_Y;

/* Real-time model */
RT_MODEL_MakeNoise MakeNoise_M_;
RT_MODEL_MakeNoise *MakeNoise_M = &MakeNoise_M_;
real_T rt_urand_Upu32_Yd_f_pw(uint32_T *u)
{
  uint32_T lo;
  uint32_T hi;

  /* Uniform random number generator (random number between 0 and 1)

     #define IA      16807                      magic multiplier = 7^5
     #define IM      2147483647                 modulus = 2^31-1
     #define IQ      127773                     IM div IA
     #define IR      2836                       IM modulo IA
     #define S       4.656612875245797e-10      reciprocal of 2^31-1
     test = IA * (seed % IQ) - IR * (seed/IQ)
     seed = test < 0 ? (test + IM) : test
     return (seed*S)
   */
  lo = *u % 127773U * 16807U;
  hi = *u / 127773U * 2836U;
  if (lo < hi) {
    *u = 2147483647U - (hi - lo);
  } else {
    *u = lo - hi;
  }

  return (real_T)*u * 4.6566128752457969E-10;
}

/* Model output function */
static void MakeNoise_output(int_T tid)
{
  /* S-Function (rti_commonblock): '<S3>/S-Function' */
  /* This comment workarounds a Real-Time Workshop code generation problem */

  /* Gain: '<Root>/GainADC1' */
  MakeNoise_Y.ADC1 = MakeNoise_P.GainADC1_Gain * MakeNoise_B.SFunction[0];

  /* Gain: '<Root>/GainADC2' */
  MakeNoise_Y.ADC2 = MakeNoise_P.GainADC2_Gain * MakeNoise_B.SFunction[1];

  /* Gain: '<Root>/GainADC3' */
  MakeNoise_Y.ADC3 = MakeNoise_P.GainADC3_Gain * MakeNoise_B.SFunction[2];

  /* Gain: '<Root>/GainADC4' */
  MakeNoise_Y.ADC4 = MakeNoise_P.GainADC4_Gain * MakeNoise_B.SFunction[3];

  /* Clock: '<Root>/Clock' */
  MakeNoise_B.Clock = MakeNoise_M->Timing.t[0];

  /* UniformRandomNumber: '<Root>/WhiteNoise' */
  MakeNoise_B.WhiteNoise = MakeNoise_DWork.WhiteNoise_NextOutput;

  /* Clock: '<S1>/Clock1' */
  MakeNoise_B.Clock1 = MakeNoise_M->Timing.t[0];

  /* Product: '<S1>/Product' incorporates:
   *  Constant: '<S1>/deltaFreq'
   *  Constant: '<S1>/targetTime'
   */
  MakeNoise_B.Product = MakeNoise_P.deltaFreq_Value /
    MakeNoise_P.targetTime_Value;

  /* Gain: '<S1>/Gain' */
  MakeNoise_B.Gain = MakeNoise_P.Gain_Gain * MakeNoise_B.Product;

  /* MultiPortSwitch: '<Root>/Multiport Switch' incorporates:
   *  Constant: '<Root>/SwitchPos'
   *  Constant: '<Root>/Zero'
   */
  switch ((int32_T)MakeNoise_P.SwitchPos_Value) {
   case 1:
    MakeNoise_B.MultiportSwitch = MakeNoise_P.Zero_Value;
    break;

   case 2:
    /* Fcn: '<Root>/Fcn' incorporates:
     *  Constant: '<Root>/Freq'
     */
    MakeNoise_B.Fcn = cos(6.2831853071795862 * MakeNoise_B.Clock *
                          MakeNoise_P.Freq_Value);
    MakeNoise_B.MultiportSwitch = MakeNoise_B.Fcn;
    break;

   case 3:
    MakeNoise_B.MultiportSwitch = MakeNoise_B.WhiteNoise;
    break;

   default:
    /* Product: '<S1>/Product1' */
    MakeNoise_B.Product1 = MakeNoise_B.Clock1 * MakeNoise_B.Gain;

    /* Sum: '<S1>/Sum' incorporates:
     *  Constant: '<S1>/initialFreq'
     */
    MakeNoise_B.Sum = MakeNoise_B.Product1 + MakeNoise_P.initialFreq_Value;

    /* Product: '<S1>/Product2' */
    MakeNoise_B.Product2 = MakeNoise_B.Clock1 * MakeNoise_B.Sum;

    /* Trigonometry: '<S1>/Output' */
    MakeNoise_B.Output = sin(MakeNoise_B.Product2);
    MakeNoise_B.MultiportSwitch = MakeNoise_B.Output;
    break;
  }

  /* Outport: '<Root>/DAC1' */
  MakeNoise_Y.DAC1 = MakeNoise_B.MultiportSwitch;

  /* Gain: '<Root>/GainDAC1' */
  MakeNoise_B.GainDAC1 = MakeNoise_P.GainDAC1_Gain * MakeNoise_B.MultiportSwitch;

  /* S-Function (rti_commonblock): '<S2>/S-Function1' */
  /* This comment workarounds a Real-Time Workshop code generation problem */

  /* dSPACE I/O Board DS1104 #1 Unit:DAC */
  ds1104_dac_write(1, MakeNoise_B.GainDAC1);

  /* user code (Output function Trailer) */

  /* dSPACE Data Capture block: (none) */
  /* ... Service number: 1 */
  /* ... Service name:   (default) */
  if (rtmIsContinuousTask(MakeNoise_M, 0) && rtmIsMajorTimeStep(MakeNoise_M)) {
    host_service(1, rtk_current_task_absolute_time_ptr_get());
  }

  /* tid is required for a uniform function interface.
   * Argument tid is not used in the function. */
  UNUSED_PARAMETER(tid);
}

/* Model update function */
static void MakeNoise_update(int_T tid)
{
  real_T tmin;

  /* Update for UniformRandomNumber: '<Root>/WhiteNoise' */
  tmin = MakeNoise_P.WhiteNoise_Minimum;
  MakeNoise_DWork.WhiteNoise_NextOutput = (MakeNoise_P.WhiteNoise_Maximum - tmin)
    * rt_urand_Upu32_Yd_f_pw(&MakeNoise_DWork.RandSeed) + tmin;

  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++MakeNoise_M->Timing.clockTick0)) {
    ++MakeNoise_M->Timing.clockTickH0;
  }

  MakeNoise_M->Timing.t[0] = MakeNoise_M->Timing.clockTick0 *
    MakeNoise_M->Timing.stepSize0 + MakeNoise_M->Timing.clockTickH0 *
    MakeNoise_M->Timing.stepSize0 * 4294967296.0;

  {
    /* Update absolute timer for sample time: [0.0001s, 0.0s] */
    /* The "clockTick1" counts the number of times the code of this task has
     * been executed. The absolute time is the multiplication of "clockTick1"
     * and "Timing.stepSize1". Size of "clockTick1" ensures timer will not
     * overflow during the application lifespan selected.
     * Timer of this task consists of two 32 bit unsigned integers.
     * The two integers represent the low bits Timing.clockTick1 and the high bits
     * Timing.clockTickH1. When the low bit overflows to 0, the high bits increment.
     */
    if (!(++MakeNoise_M->Timing.clockTick1)) {
      ++MakeNoise_M->Timing.clockTickH1;
    }

    MakeNoise_M->Timing.t[1] = MakeNoise_M->Timing.clockTick1 *
      MakeNoise_M->Timing.stepSize1 + MakeNoise_M->Timing.clockTickH1 *
      MakeNoise_M->Timing.stepSize1 * 4294967296.0;
  }

  /* tid is required for a uniform function interface.
   * Argument tid is not used in the function. */
  UNUSED_PARAMETER(tid);
}

/* Model initialize function */
void MakeNoise_initialize(boolean_T firstTime)
{
  (void)firstTime;

  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* initialize real-time model */
  (void) memset((void *)MakeNoise_M, 0,
                sizeof(RT_MODEL_MakeNoise));

  {
    /* Setup solver object */
    rtsiSetSimTimeStepPtr(&MakeNoise_M->solverInfo,
                          &MakeNoise_M->Timing.simTimeStep);
    rtsiSetTPtr(&MakeNoise_M->solverInfo, &rtmGetTPtr(MakeNoise_M));
    rtsiSetStepSizePtr(&MakeNoise_M->solverInfo, &MakeNoise_M->Timing.stepSize0);
    rtsiSetErrorStatusPtr(&MakeNoise_M->solverInfo, (&rtmGetErrorStatus
      (MakeNoise_M)));
    rtsiSetRTModelPtr(&MakeNoise_M->solverInfo, MakeNoise_M);
  }

  rtsiSetSimTimeStep(&MakeNoise_M->solverInfo, MAJOR_TIME_STEP);
  rtsiSetSolverName(&MakeNoise_M->solverInfo,"FixedStepDiscrete");

  /* Initialize timing info */
  {
    int_T *mdlTsMap = MakeNoise_M->Timing.sampleTimeTaskIDArray;
    mdlTsMap[0] = 0;
    mdlTsMap[1] = 1;
    MakeNoise_M->Timing.sampleTimeTaskIDPtr = (&mdlTsMap[0]);
    MakeNoise_M->Timing.sampleTimes = (&MakeNoise_M->Timing.sampleTimesArray[0]);
    MakeNoise_M->Timing.offsetTimes = (&MakeNoise_M->Timing.offsetTimesArray[0]);

    /* task periods */
    MakeNoise_M->Timing.sampleTimes[0] = (0.0);
    MakeNoise_M->Timing.sampleTimes[1] = (0.0001);

    /* task offsets */
    MakeNoise_M->Timing.offsetTimes[0] = (0.0);
    MakeNoise_M->Timing.offsetTimes[1] = (0.0);
  }

  rtmSetTPtr(MakeNoise_M, &MakeNoise_M->Timing.tArray[0]);

  {
    int_T *mdlSampleHits = MakeNoise_M->Timing.sampleHitArray;
    mdlSampleHits[0] = 1;
    mdlSampleHits[1] = 1;
    MakeNoise_M->Timing.sampleHits = (&mdlSampleHits[0]);
  }

  rtmSetTFinal(MakeNoise_M, -1);
  MakeNoise_M->Timing.stepSize0 = 0.0001;
  MakeNoise_M->Timing.stepSize1 = 0.0001;
  MakeNoise_M->solverInfoPtr = (&MakeNoise_M->solverInfo);
  MakeNoise_M->Timing.stepSize = (0.0001);
  rtsiSetFixedStepSize(&MakeNoise_M->solverInfo, 0.0001);
  rtsiSetSolverMode(&MakeNoise_M->solverInfo, SOLVER_MODE_SINGLETASKING);

  /* block I/O */
  MakeNoise_M->ModelData.blockIO = ((void *) &MakeNoise_B);

  {
    MakeNoise_B.SFunction[0] = 0.0;
    MakeNoise_B.SFunction[1] = 0.0;
    MakeNoise_B.SFunction[2] = 0.0;
    MakeNoise_B.SFunction[3] = 0.0;
    MakeNoise_B.Clock = 0.0;
    MakeNoise_B.WhiteNoise = 0.0;
    MakeNoise_B.Clock1 = 0.0;
    MakeNoise_B.Product = 0.0;
    MakeNoise_B.Gain = 0.0;
    MakeNoise_B.MultiportSwitch = 0.0;
    MakeNoise_B.GainDAC1 = 0.0;
    MakeNoise_B.Fcn = 0.0;
    MakeNoise_B.Product1 = 0.0;
    MakeNoise_B.Sum = 0.0;
    MakeNoise_B.Product2 = 0.0;
    MakeNoise_B.Output = 0.0;
  }

  /* parameters */
  MakeNoise_M->ModelData.defaultParam = ((real_T *)&MakeNoise_P);

  /* states (dwork) */
  MakeNoise_M->Work.dwork = ((void *) &MakeNoise_DWork);
  (void) memset((void *)&MakeNoise_DWork, 0,
                sizeof(D_Work_MakeNoise));
  MakeNoise_DWork.WhiteNoise_NextOutput = 0.0;

  /* external outputs */
  MakeNoise_M->ModelData.outputs = (&MakeNoise_Y);
  MakeNoise_Y.ADC1 = 0.0;
  MakeNoise_Y.ADC2 = 0.0;
  MakeNoise_Y.ADC3 = 0.0;
  MakeNoise_Y.ADC4 = 0.0;
  MakeNoise_Y.DAC1 = 0.0;

  {
    /* user code (registration function declaration) */
    /*Call the macro that initializes the global TRC pointers
       inside the model initialization/registration function. */
    RTI_INIT_TRC_POINTERS();
  }
}

/* Model terminate function */
void MakeNoise_terminate(void)
{
  /* (no terminate code required) */
}

/*========================================================================*
 * Start of GRT compatible call interface                                 *
 *========================================================================*/
void MdlOutputs(int_T tid)
{
  MakeNoise_output(tid);
}

void MdlUpdate(int_T tid)
{
  MakeNoise_update(tid);
}

void MdlInitializeSizes(void)
{
  MakeNoise_M->Sizes.numContStates = (0);/* Number of continuous states */
  MakeNoise_M->Sizes.numY = (5);       /* Number of model outputs */
  MakeNoise_M->Sizes.numU = (0);       /* Number of model inputs */
  MakeNoise_M->Sizes.sysDirFeedThru = (0);/* The model is not direct feedthrough */
  MakeNoise_M->Sizes.numSampTimes = (2);/* Number of sample times */
  MakeNoise_M->Sizes.numBlocks = (31); /* Number of blocks */
  MakeNoise_M->Sizes.numBlockIO = (17);/* Number of block outputs */
  MakeNoise_M->Sizes.numBlockPrms = (15);/* Sum of parameter "widths" */
}

void MdlInitializeSampleTimes(void)
{
}

void MdlInitialize(void)
{
}

void MdlStart(void)
{
  {
    uint32_T tseed;
    int32_T r;
    int32_T t;
    real_T tmin;

    /* Start for UniformRandomNumber: '<Root>/WhiteNoise' */
    tmin = MakeNoise_P.WhiteNoise_Seed;
    if (rtIsNaN(tmin) || rtIsInf(tmin)) {
      tmin = 0.0;
    } else {
      tmin = fmod(floor(tmin), 4.294967296E+9);
    }

    tseed = tmin < 0.0 ? (uint32_T)(-((int32_T)(uint32_T)(-tmin))) : (uint32_T)
      tmin;
    r = (int32_T)(tseed >> 16U);
    t = (int32_T)(tseed & 32768U);
    tseed = (((tseed - (((uint32_T)r << 16U) - (uint32_T)t)) << 16U) + (uint32_T)
             t) + (uint32_T)r;
    if (tseed < 1U) {
      tseed = 1144108930U;
    } else {
      if (tseed > 2147483646U) {
        tseed = 2147483646U;
      }
    }

    MakeNoise_DWork.RandSeed = tseed;
    tmin = MakeNoise_P.WhiteNoise_Minimum;
    MakeNoise_DWork.WhiteNoise_NextOutput = (MakeNoise_P.WhiteNoise_Maximum -
      tmin) * rt_urand_Upu32_Yd_f_pw(&MakeNoise_DWork.RandSeed) + tmin;
  }

  MdlInitialize();
}

void MdlTerminate(void)
{
  MakeNoise_terminate();
}

RT_MODEL_MakeNoise *MakeNoise(void)
{
  MakeNoise_initialize(1);
  return MakeNoise_M;
}

/*========================================================================*
 * End of GRT compatible call interface                                   *
 *========================================================================*/
