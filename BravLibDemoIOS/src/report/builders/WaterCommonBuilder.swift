//
//  WaterCommonBuilder.swift
//  BravBleDemo
//
//  Created by 黄敦仁 on 2022/3/15.
//

import BravLib
import Foundation

class WaterCommonBuilder: ReportItemBuilder {
    var scaleData: BravScaleData
    var option: ReportBuilderOption

    var id = "water"
    var nameKey = "report_item_water_rate"
    var defaultName = "Water percentage"
    var introKey = "report_desc_water_1002"
    var standLevelIndex = 1
    var isWeightUnit = false
    var value: Double {
        return self.scaleData.waterRate
    }
    var unit = "%"


    var min = 5.0
    var max = 45.0

    var boundaries: [Double] {
        return (user.gender == .Male ? [50, 65] : [45, 60])
    }

    var levels: [LevelItem]? {
        return [
            LevelItem(
                color: colors.report_lower,
                name: i18n("report_level_low"),
                desc: i18n("report_desc_water_1003")
            ),
            LevelItem(
                color: colors.report_standard,
                name: i18n("report_level_standard"),
                desc: i18n("report_desc_water_1003")

            ),
            LevelItem(
                color: colors.report_higher,
                name: i18n("report_level_high"),
                desc: i18n("report_desc_water_1004")
            ),
        ]
    }

    init(_ scaleData: BravScaleData, _ option: ReportBuilderOption) {
        self.scaleData = scaleData
        self.option = option
    }
}
