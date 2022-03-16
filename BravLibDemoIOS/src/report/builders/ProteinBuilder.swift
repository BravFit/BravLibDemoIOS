//
//  ProteinBuilder.swift
//  BravBleDemo
//
//  Created by 黄敦仁 on 2022/3/15.
//

import BravLib
import Foundation

class ProteinBuilder: ReportItemBuilder {
    var scaleData: BravScaleData
    var option: ReportBuilderOption

    var id = "protein"
    var nameKey = "report_item_bodyfat_rate"
    var defaultName = "Protein percentage"
    var introKey = "report_desc_protein_1002"
    var standLevelIndex = 1
    var isWeightUnit = false
    var value: Double {
        return scaleData.proteinRate
    }

    var unit = "%"

    var min = 5.0
    var max = 45.0

    var boundaries: [Double] {
        return user.gender == .Male ? [16.0, 18.0] : [14.0, 16.0]
    }

    var levels: [LevelItem]? {
        return [
            LevelItem(
                color: colors.report_lower,
                name: i18n("report_level_low"),
                desc: i18n("report_desc_protein_1003")
            ),
            LevelItem(
                color: colors.report_standard,
                name: i18n("report_level_standard"),
                desc: i18n("report_desc_protein_1004")

            ),
            LevelItem(
                color: colors.report_higher,
                name: i18n("report_level_adequate"),
                desc: i18n("report_desc_protein_1005")
            ),
        ]
    }

    init(_ scaleData: BravScaleData, _ option: ReportBuilderOption) {
        self.scaleData = scaleData
        self.option = option
    }
}
