/*
 * MakeNoise_data.c
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

#include "MakeNoise.h"
#include "MakeNoise_private.h"

/* Block parameters (auto storage) */
Parameters_MakeNoise MakeNoise_P = {
  10.0,                                /* Expression: 10
                                        * Referenced by: '<Root>/GainADC1'
                                        */
  10.0,                                /* Expression: 10
                                        * Referenced by: '<Root>/GainADC2'
                                        */
  10.0,                                /* Expression: 10
                                        * Referenced by: '<Root>/GainADC3'
                                        */
  10.0,                                /* Expression: 10
                                        * Referenced by: '<Root>/GainADC4'
                                        */
  1.0,                                 /* Expression: 1
                                        * Referenced by: '<Root>/SwitchPos'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<Root>/Zero'
                                        */
  440.0,                               /* Expression: 440
                                        * Referenced by: '<Root>/Freq'
                                        */
  -1.0,                                /* Expression: -1
                                        * Referenced by: '<Root>/WhiteNoise'
                                        */
  1.0,                                 /* Expression: 1
                                        * Referenced by: '<Root>/WhiteNoise'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<Root>/WhiteNoise'
                                        */
  31415.29821736721,                   /* Expression: 2*pi*(f2-f1)
                                        * Referenced by: '<S1>/deltaFreq'
                                        */
  2.0,                                 /* Expression: T
                                        * Referenced by: '<S1>/targetTime'
                                        */
  0.5,                                 /* Expression: 0.5
                                        * Referenced by: '<S1>/Gain'
                                        */
  0.62831853071795862,                 /* Expression: 2*pi*f1
                                        * Referenced by: '<S1>/initialFreq'
                                        */
  0.1                                  /* Expression: 0.1
                                        * Referenced by: '<Root>/GainDAC1'
                                        */
};
