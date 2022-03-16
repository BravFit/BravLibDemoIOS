//
//  algorithm.h
//  BravScaleAlgorithm
//
//  Created by 黄敦仁 on 2022/3/2.
//

#ifndef algorithm_h
#define algorithm_h

#include "typing.h"

#ifdef __cplusplus
extern "C" {
#endif

//生成新的测量数据对象
BravScaleMeasurement *newScaleCompleteData();

/**
 * @brief 创建用户对象
 *
 * @param gender 性别 0女 1男
 * @param height 身高 单位cm
 * @param age 年龄
 * @param isAthlete 是否为运动员体质 非0 则是
 * @return BravUser*
 */
BravUser *newUser(qint gender, qint height, qint age, qint isAthlete);

/**
 * @brief 创建秤端原始对象
 *
 * @param weight 重量，单位kg
 * @param impedance 阻抗值
 * @param impedanceExtend 扩展阻抗值，如果有额外的阻抗值可以传进来
 * @return BravOriginScaleData*
 */
BravOriginScaleData *newOriginScaleData(qdouble weight, qint impedance,
                                        qint impedanceExtend);

/**
 * @brief 算法库入口
 *
 */
BravScaleMeasurement *algorithm(qint method, BravUser *user,
                                BravOriginScaleData *scaleData);
#ifdef __cplusplus
}
#endif

#endif /* algorithm_h */
