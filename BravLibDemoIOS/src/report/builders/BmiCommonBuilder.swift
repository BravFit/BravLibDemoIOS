//
//  BmiCommonBuilder.swift
//  BravBleDemo
//
//  Created by 黄敦仁 on 2022/3/15.
//

import BravLib
import Foundation

class BmiCommonBuilder: ReportItemBuilder {
    var scaleData: BravScaleData
    var option: ReportBuilderOption

    var id = "bmi"
    var isValid = true
    var nameKey = "brav_report_item_name_bmi"
    var defaultName = "BMI"
    var introKey = "report_desc_bmi_1001"
    var standLevelIndex = 1
    var isWeightUnit = false
    var value: Double {
        return scaleData.bmi
    }

    var unit = ""

    var min = 3.0
    var max = 35.0

    var boundaries = [
        18.5, 25.0, 30.0,
    ]

    var levels: [LevelItem]? {
        return [
            LevelItem(
                color: colors.report_lower,
                name: i18n("report_level_under_weight"),
                desc: i18n("report_desc_bmi_1002")
            ),
            LevelItem(
                color: colors.report_standard,
                name: i18n("report_level_health_weight"),
                desc: user.gender == BravGender.Male ?
                    i18n("report_desc_bmi_1003")
                    :
                    i18n("report_desc_bmi_1004")
            ),
            LevelItem(
                color: colors.report_higher,
                name: i18n("report_level_overweight"),
                desc: i18n("report_desc_bmi_1005")
            ),
            LevelItem(
                color: colors.report_highest,
                name: i18n("report_level_obesity"),
                desc: i18n("report_desc_bmi_1005")
            ),
        ]
    }

    init(_ scaleData: BravScaleData, _ option: ReportBuilderOption) {
        self.scaleData = scaleData
        self.option = option
    }
}
