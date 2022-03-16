//
//  type.h
//  BravScaleAlgorithm
//
//  Created by 黄敦仁 on 2022/3/2.
//

#ifndef type_h
#define type_h



#define METHOD_DIRECTV1 1
#define METHOD_DIRECTV2 2

#define GENDER_MALE 1
#define GENDER_FEMALE 0

#ifdef jint

typedef jint qint;
typedef jdouble qdouble;

#else

typedef int qint;
typedef double qdouble;
typedef long double BigFloat;

#endif

#ifdef __cplusplus
extern "C" {
#endif


typedef struct {
  qdouble weight;  //体重
  qdouble bmi;
  qdouble bodyfatRate;         //体脂率
  qdouble bodyfatMass;         //脂肪量
  qdouble subfatRate;          //皮下脂肪
  qdouble visfat;              //内脏脂肪
  qdouble waterRate;           //体水分率
  qdouble waterMass;           //体水分量
  qint bmr;                    //基础代谢率
  qdouble skeletalMuscleRate;  //骨骼肌率
  qdouble skeletalMuscleMass;  //骨骼肌量
  qdouble muscleMass;          //肌肉量
  qdouble muscleRate;          //肌肉率
  qdouble lbm;                 //去脂体重
  qdouble bone;                //骨量
  qdouble proteinRate;         //蛋白质率
  qdouble proteinMass;         //蛋白质量
  qdouble score;               //分数
  qint bodyAge;                //体年龄
  qint bodyShape;              //体型

} BravScaleMeasurement;

typedef struct {
  qint gender;
  qint height;
  qint age;
  qint isAthlete;
} BravUser;

typedef struct {
  qdouble weight;
  qint impedance;
  qint impedanceExtend;
} BravOriginScaleData;

#ifdef __cplusplus
}
#endif

#endif /* type_h */
