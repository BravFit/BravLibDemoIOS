//
//  BmrBuilder.swift
//  BravBleDemo
//
//  Created by 黄敦仁 on 2022/3/15.
//

import BravLib
import Foundation

class BmrBuilder: ReportItemBuilder {
    var scaleData: BravScaleData
    var option: ReportBuilderOption

    var id = "bmr"
    var nameKey = "report_item_bmr"
    var defaultName = "BMR"
    var introKey = "report_desc_bmr_1001"
    var standLevelIndex = 1
    var isWeightUnit = false
    var value: Double {
        return Double(scaleData.bmr)
    }

    var unit = "kcal"

    var min = 0
    var max = 2000

    var boundaries: [Double] {
        return [self.value]
    }

    var levels: [LevelItem]? {
        return [
            LevelItem(
                color: colors.report_lower,
                name: i18n("report_level_not_standard"),
                desc: i18n("report_desc_bmr_1002", nil, "\(scaleData.bmr)")
            ),
            LevelItem(
                color: colors.report_standard,
                name: i18n("report_level_standard"),
                desc: i18n("report_desc_bmr_1003", nil, "\(scaleData.bmr)")

            ),
        ]
    }

    init(_ scaleData: BravScaleData, _ option: ReportBuilderOption) {
        self.scaleData = scaleData
        self.option = option
    }
}
