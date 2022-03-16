//
//  Utils.swift
//  BravBleDemo
//
//  Created by 黄敦仁 on 2022/3/15.
//

import Foundation
import BravLib

extension Double{
    func toTargetWeightUnit(_ valueUnit: BravScaleUnit,_ targetUnit: BravScaleUnit)->Double {
        if (valueUnit == targetUnit) {
            return self
        }
        if (valueUnit == BravScaleUnit.kg && targetUnit == BravScaleUnit.jin) {
            return BravUtils.kg2jin(self)
        } else if (valueUnit == BravScaleUnit.kg && targetUnit == BravScaleUnit.lb) {
            return BravUtils.kg2lb(self)
        } else if (valueUnit == BravScaleUnit.jin && targetUnit == BravScaleUnit.kg) {
            return BravUtils.jin2kg(self)
        } else if (valueUnit == BravScaleUnit.jin && targetUnit == BravScaleUnit.lb) {
            return BravUtils.jin2kg(self)
        } else if (valueUnit == BravScaleUnit.lb && targetUnit == BravScaleUnit.kg) {
            return BravUtils.lb2kg(self)
        } else if (valueUnit == BravScaleUnit.lb && targetUnit == BravScaleUnit.jin) {
            return BravUtils.lb2jin(self)
        } else {
            return self
        }
    }
}
