//
//  BodyfatCommonBuilder.swift
//  BravBleDemo
//
//  Created by 黄敦仁 on 2022/3/15.
//

import BravLib
import Foundation

class BodyfatCommonBuilder: ReportItemBuilder {
    var scaleData: BravScaleData
    var option: ReportBuilderOption

    var id = "bodyfat"
    var nameKey = "report_item_bodyfat_rate"
    var defaultName = "Bodyfat percentage"
    var introKey = "report_desc_bodyfat_1002"
    var standLevelIndex = 2
    var isWeightUnit = false
    var value: Double {
        return scaleData.bodyfatRate
    }

    var unit = "%"

    var min = 5.0
    var max = 45.0

    var boundaries: [Double] {
        return user.gender == .Male ? [2.0, 6.0, 13.0, 17.0, 25.0] : [10.0, 14.0, 21.0, 25.0, 32.0]
    }

    var levels: [LevelItem]? {
        return [
            LevelItem(
                color: colors.report_lowest,
                name: i18n("report_level_extremely_low"),
                desc: i18n("report_desc_bodyfat_1003")
            ),
            LevelItem(
                color: colors.report_lower,
                name: i18n("report_level_thin"),
                desc: i18n("report_desc_bodyfat_1004")
            ),
            LevelItem(
                color: colors.report_sufficient,
                name: i18n("report_level_athletes"),
                desc: i18n("report_desc_bodyfat_1005")
            ),
            LevelItem(
                color: colors.report_standard,
                name: i18n("report_level_fitness"),
                desc: i18n("report_desc_bodyfat_1006")

            ),
            LevelItem(
                color: colors.report_higher,
                name: i18n("report_level_acceptable"),
                desc: i18n("report_desc_bodyfat_1007")
            ),
            LevelItem(
                color: colors.report_highest,
                name: i18n("report_level_obesity"),
                desc: i18n("report_desc_bodyfat_1008")
            ),
        ]
    }

    init(_ scaleData: BravScaleData, _ option: ReportBuilderOption) {
        self.scaleData = scaleData
        self.option = option
    }
}
