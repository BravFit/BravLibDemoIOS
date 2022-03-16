//
//  WaterCommonBuilder.swift
//  BravBleDemo
//
//  Created by 黄敦仁 on 2022/3/15.
//

import BravLib
import Foundation

class VisfatCommonBuilder: ReportItemBuilder {
    var scaleData: BravScaleData
    var option: ReportBuilderOption

    var id = "visfat"
    var nameKey = "report_item_visfat"
    var defaultName = "Visfat"
    var introKey = "report_desc_visfat_1002"
    var standLevelIndex = 1
    var isWeightUnit = false
    var value: Double {
        return scaleData.visfat
    }

    var min = 0.0
    var max = 30.0

    var boundaries: [Double] {
        return [6.0, 11.0, 14.0]
    }

    var levels: [LevelItem]? {
        return [
            LevelItem(
                color: colors.report_sufficient,
                name: i18n("report_level_good"),
                desc: i18n("report_desc_visfat_1003")
            ),
            LevelItem(
                color: colors.report_standard,
                name: i18n("report_level_acceptable"),
                desc: i18n("report_desc_visfat_1004")

            ),
            LevelItem(
                color: colors.report_higher,
                name: i18n("report_level_high"),
                desc: i18n("report_desc_visfat_1005")
            ),
            LevelItem(
                color: colors.report_highest,
                name: i18n("report_level_severely_high"),
                desc: i18n("report_desc_visfat_1006")
            ),
        ]
    }

    init(_ scaleData: BravScaleData, _ option: ReportBuilderOption) {
        self.scaleData = scaleData
        self.option = option
    }
}
