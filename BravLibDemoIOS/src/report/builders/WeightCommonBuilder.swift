//
//  BmiCommonBuilder.swift
//  BravBleDemo
//
//  Created by 黄敦仁 on 2022/3/15.
//

import BravLib
import Foundation

class WeightCommonBuilder: ReportItemBuilder {
    var scaleData: BravScaleData
    var option: ReportBuilderOption

    var id = "Weight"
    var isValid = true
    var nameKey = "report_item_body_weight"
    var defaultName = "Weight"
    var introKey = "report_desc_weight_1002"
    var standLevelIndex = 1
    var isWeightUnit = true
    var value: Double {
        return scaleData.weight.toTargetWeightUnit(valueUnit, targetUnit)
    }

    var min = 3.0
    var max = 35.0

    var boundaries = [
        18.5, 25.0, 30.0,
    ]
    var levels: [LevelItem]? {
        return [
            LevelItem(
                color: colors.report_lower,
                name: i18n("report_level_low"),
                desc: i18n("report_desc_weight_1003")
            ),
            LevelItem(
                color: colors.report_standard,
                name: i18n("report_level_standard"),
                desc: i18n("report_desc_weight_1004")
            ),
            LevelItem(
                color: colors.report_higher,
                name: i18n("report_level_high"),
                desc: i18n("report_desc_weight_1005")
            ),
            LevelItem(
                color: colors.report_highest,
                name: i18n("report_level_severely_high"),
                desc: i18n("report_desc_weight_1006")
            ),
        ]
    }

    func builder() -> ReportItem {
        var reportItem = initAndInjectFields()

        let bmiBuilder = BmiCommonBuilder(scaleData, option)
        let bmiItem = bmiBuilder.build()
        let height = user.height

        reportItem.levelIndex = bmiItem.levelIndex
        let boundaries =
            bmiItem.boundaries
                .map { val in (Double(height) * Double(height) * val) / 10000.0 }
                .map { val in val.toTargetWeightUnit(self.valueUnit, self.targetUnit) }

        reportItem.boundaries = boundaries
        reportItem.min = boundaries[0] * 0.5
        reportItem.max = boundaries.last! * 1.5

        return reportItem
    }

    init(_ scaleData: BravScaleData, _ option: ReportBuilderOption) {
        self.scaleData = scaleData
        self.option = option
    }
}
