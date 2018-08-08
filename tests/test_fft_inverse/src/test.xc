// Copyright (c) 2016-2017, XMOS Ltd, All rights reserved
#include <xs1.h>
#include <xclib.h>
#include <stdio.h>
#include <stdlib.h>

#include "dsp_fft.h"
#include "generated.h"

int random(unsigned &x) {
  crc32(x, -1, 0xEB31D82E);
  return (int)x;
}

void test_inverse_fft() {
  unsigned x             = SEED;
  unsigned test_count    = 2;
  unsigned max_error     = 0;
  unsigned average_error = 0;
  for (unsigned t = 0; t < test_count; t++) {

    dsp_complex_t f[FFT_LENGTH];
    for (unsigned i = 0; i < FFT_LENGTH; i++) {
      f[i].re = output[t][i].re;
      f[i].im = output[t][i].im;
    }
    dsp_fft_bit_reverse(f, FFT_LENGTH);
    dsp_fft_inverse(f, FFT_LENGTH, FFT_SINE_LUT);

    for (unsigned i = 0; i < FFT_LENGTH; i++) {

      int re = random(x) >> DATA_SHIFT;
      int im = random(x) >> DATA_SHIFT;

      int e = f[i].re - re;
      if (e < 0)
        e = -e;
      if (e > FFT_LENGTH * 4) {
        printf("Error: error in inverse FFT (real)\n");
        _Exit(1);
      }
      average_error += e;
      if (e > max_error)
        max_error = e;
      e = f[i].im - im;
      if (e < 0)
        e = -e;
      if (e > FFT_LENGTH * 4) {
        printf("Error: error in inverse FFT (imaginary)\n");
        _Exit(1);
      }
      average_error += e;
      if (e > max_error)
        max_error = e;
    }
  }
  printf("Inverse FFT: Pass.\n");
}


unsafe int main() {
  test_inverse_fft();
  _Exit(0);
  return 0;
}
