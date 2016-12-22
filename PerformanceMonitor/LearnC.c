//
//  LearnC.c
//  PerformanceMonitor
//
//  Created by He yang on 2016/12/22.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#include "LearnC.h"



Student *initStudent(float age,void **skills){
    Student *student = calloc(1, sizeof(Student));
    student->age = age;
    student->skills = skills;
    return student;
}
