// Copyright (c) 2015-2017, XMOS Ltd, All rights reserved
// XMOS DSP Library - Example to use FFT and inverse FFT

#include <dsp.h>
#include <stdint.h>
#include <stdio.h>
#include <xclib.h>
#include <xs1.h>

#define ONE(N)                           \
  tmr :> t0;                             \
  dsp_fft_bit_reverse(data, N);          \
  dsp_fft_forward(data, N, FFT_SINE(N)); \
  tmr :> t1;                             \
  t1 -= t0;                              \
  printf("%4d %12d %5d %5d %10.2f\n",    \
         N,                              \
         t1,                             \
         t1 * 10 / 625,                  \
         t1 / N,                         \
         t1 / (float) N / (31 - clz(N)));

#define ONI(N)                           \
  tmr :> t0;                             \
  dsp_fft_bit_reverse(data, N);          \
  dsp_fft_inverse(data, N, FFT_SINE(N)); \
  tmr :> t1;                             \
  t1 -= t0;                              \
  printf("%4d %12d %5d %5d %10.2f\n",    \
         N,                              \
         t1,                             \
         t1 * 10 / 625,                  \
         t1 / N,                         \
         t1 / (float) N / (31 - clz(N)));

extern int dsp_fft_bit_reverse_xs2(dsp_complex_t a[], unsigned N);

dsp_complex_t data[8192];
dsp_complex_t data2[8192];

int main(void) {
  timer tmr;
  int   t0, t1;
  printf(
      "Forward FFT instruction count and timings @ 62.5 MIPS, includes " "bit-" "rever" "se " "opera" "tion" "\n");
  printf("   N instructions    us ins/N  ins/NlogN\n");
  ONE(4);
  ONE(8);
  ONE(16);
  ONE(32);
  ONE(64);
  ONE(128);
  ONE(256);
  ONE(512);
  ONE(1024);
  ONE(2048);
  ONE(4096);
  ONE(8192);
  printf(
      "\nInverse FFT instruction count and timings @ 62.5 MIPS, includes " "bit" "-re" "ver" "se " "ope" "rat" "ion" "\n");
  printf("   N instructions    us ins/N  ins/NlogN\n");
  ONI(4);
  ONI(8);
  ONI(16);
  ONI(32);
  ONI(64);
  ONI(128);
  ONI(256);
  ONI(512);
  ONI(1024);
  ONI(2048);
  ONI(4096);
  ONI(8192);
  return 0;
}
