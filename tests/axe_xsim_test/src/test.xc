// Copyright (c) 2016-2018, XMOS Ltd, All rights reserved
#include <xs1.h>
#include <xclib.h>
#include <stdio.h>
#include <stdlib.h>

#include "dsp_vector.h"

#ifndef SEED
#define SEED 255
#endif

#define DATA_SHIFT 1

#define MAX_VECTOR_LENGTH 10
#define RSHIFT 16

int random(unsigned &x){
    crc32(x, -1, 0xEB31D82E);
    return (int)x;
}

void generate_vector(int32_t vec[], unsigned length, unsigned &seed,
                     unsigned rshift) {
    for (int i=0; i<length; i++) {
        vec[i] = random(seed) >> rshift;
    }
}

void print_vector(int32_t vec[], unsigned length) {
    for (int i=0; i<length; ++i) {
        printf("%d,", vec[i]);
    }
    printf("\n");
}

void copy_vector(int32_t src[], int32_t dst[], unsigned length) {
    for (int i=0; i<length; ++i) {
        dst[i] = src[i];
    }
}

void test_vector(){
    int32_t vec1[9];
    int32_t vec2[9];
    int32_t vec3[9];
    int32_t vec_result[9];

    for (int i=0; i<8; i++) {
        vec1[i] = 1197415036;
        vec2[i] = 1048319082;
        vec3[i] = 165000577;
    }
    //vec1[0] = 1197415036;
    //vec2[0] = 1048319082;
    //vec3[0] = 165000577;
    int i = 0;
    vec1[i] = -22534;
    vec2[i] = -9463;
    vec3[i] = -29291;
i++;
vec1[i] = 5681; vec2[i] = -21733; vec3[i] = -5270;
i++;
vec1[i] = 4216; vec2[i] = -27573; vec3[i] = 15057;
i++;
vec1[i] = 13708; vec2[i] = -11670; vec3[i] = 2208;
i++;
vec1[i] = 6802; vec2[i] = -926; vec3[i] = 1735;
i++;
vec1[i] = 2531; vec2[i] = -29312; vec3[i] = -21188;
i++;
vec1[i] = 198; vec2[i] = -29330; vec3[i] = -3012;
i++;
vec1[i] = 24154; vec2[i] = 30988; vec3[i] = 23135;
i++;
vec1[i] = -17790; vec2[i] = 31384; vec3[i] = -11413;

    dsp_vector_mulv_subv(vec1, vec2, vec3, vec_result, 8, 24);

    for (int i=0; i<9; i++) {
        printf("%d\n", vec_result[i]);
    }

    //dsp_vector_mulv_complex(vec1_re, vec1_im, vec2_re, vec2_im, vec_res_re, vec_res_im, length, 24);
}

unsafe int main(){
    test_vector();
    _Exit(0);
    return 0;
}


