//
//  SubfatBuilder.swift
//  BravBleDemo
//
//  Created by 黄敦仁 on 2022/3/15.
//

import BravLib
import Foundation

class SubfatBuilder: ReportItemBuilder {
    var scaleData: BravScaleData
    var option: ReportBuilderOption

    var id = "subfat"
    var nameKey = "report_item_subfat"
    var defaultName = "Subfat percentage"
    var introKey = "report_desc_subfat_1002"
    var standLevelIndex = 1
    var isWeightUnit = false
    var value: Double {
        return scaleData.subfatRate
    }

    var unit = "%"

    var min = 5.0
    var max = 45.0

    var boundaries: [Double] {
        return user.gender == .Male ? [8.6, 16.7] : [18.5, 26.7]
    }

    var levels: [LevelItem]? {
        return [
            LevelItem(
                color: colors.report_lower,
                name: i18n("report_level_low"),
                desc: i18n("report_desc_subfat_1003")
            ),
            LevelItem(
                color: colors.report_standard,
                name: i18n("report_level_standard"),
                desc: i18n("report_desc_subfat_1004")

            ),
            LevelItem(
                color: colors.report_higher,
                name: i18n("report_level_high"),
                desc: i18n("report_desc_subfat_1005")
            ),
        ]
    }

    init(_ scaleData: BravScaleData, _ option: ReportBuilderOption) {
        self.scaleData = scaleData
        self.option = option
    }
}
