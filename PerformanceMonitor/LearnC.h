//
//  LearnC.h
//  PerformanceMonitor
//
//  Created by He yang on 2016/12/22.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#ifndef LearnC_h
#define LearnC_h
#include <math.h>
#include <stdarg.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#include <stdio.h>

typedef struct Student{
    float age;
    void **skills;
}Student;

Student *initStudent(float age,void **skills);
#endif /* LearnC_h */
