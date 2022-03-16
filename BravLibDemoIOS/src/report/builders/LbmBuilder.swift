//
//  LbmBuilder.swift
//  BravBleDemo
//
//  Created by 黄敦仁 on 2022/3/15.
//

import BravLib
import Foundation

class LbmBuilder: ReportItemBuilder {

    var levels: [LevelItem]?
    
    var scaleData: BravScaleData
    var option: ReportBuilderOption

    var id = "lbm"
    var nameKey = "report_item_lbm"
    var defaultName = "Lean fat body mass"
    var introKey = "report_desc_lbm_1002"
    var isWeightUnit = true
    var value: Double {
        return scaleData.lbm.toTargetWeightUnit(valueUnit, targetUnit)
    }

    init(_ scaleData: BravScaleData, _ option: ReportBuilderOption) {
        self.scaleData = scaleData
        self.option = option
    }
}
