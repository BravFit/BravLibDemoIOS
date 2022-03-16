//
//  SkeletalMuscleBuilder.swift
//  BravBleDemo
//
//  Created by 黄敦仁 on 2022/3/15.
//

import BravLib
import Foundation

class SkeletalMuscleBuilder: ReportItemBuilder {
    var scaleData: BravScaleData
    var option: ReportBuilderOption

    var id = "skeletal_muscle"
    var nameKey = "report_item_skeletal_muscle_rate"
    var defaultName = "Skeletal muscle percentage"
    var introKey = "report_desc_skeletal_muscle_rate_1002"
    var standLevelIndex = 1
    var isWeightUnit = false
    var value: Double {
        return scaleData.skeletalMuscleRate
    }

    var unit = "%"

    var min = 5.0
    var max = 30.0

    var boundaries: [Double] {
        return user.gender == .Male ? [49.0, 59.0] : [40.0, 50.0]
    }

    var levels: [LevelItem]? {
        return [
            LevelItem(
                color: colors.report_lower,
                name: i18n("report_level_low"),
                desc: i18n("report_desc_skeletal_muscle_rate_1003")
            ),
            LevelItem(
                color: colors.report_standard,
                name: i18n("report_level_standard"),
                desc: i18n("report_desc_skeletal_muscle_rate_1004")

            ),
            LevelItem(
                color: colors.report_higher,
                name: i18n("report_level_high"),
                desc: i18n("report_desc_skeletal_muscle_rate_1005")
            ),
        ]
    }

    init(_ scaleData: BravScaleData, _ option: ReportBuilderOption) {
        self.scaleData = scaleData
        self.option = option
    }
}
