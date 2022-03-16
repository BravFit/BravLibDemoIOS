//
//  BoneCommonBuilder.swift
//  BravBleDemo
//
//  Created by 黄敦仁 on 2022/3/15.
//

import BravLib
import Foundation

class BoneCommonBuilder: ReportItemBuilder {
    var scaleData: BravScaleData
    var option: ReportBuilderOption

    var id = "bone"
    var nameKey = "brav_report_item_name_bone"
    var defaultName = "Bone mass"
    var introKey = "brav_report_item_intro_bone"
    var standLevelIndex = 1
    var isWeightUnit = true
    var value: Double {
        return scaleData.bone.toTargetWeightUnit(valueUnit, targetUnit)
    }

    var min = 5.0
    var max = 45.0

    var boundaries: [Double] {
        return (user.gender == .Male ? [3.0, 5.0] : [2.5, 4.0])
            .map { val in val.toTargetWeightUnit(self.valueUnit, self.targetUnit) }
    }

    var levels: [LevelItem]? {
        return [
            LevelItem(
                color: colors.report_lower,
                name: i18n("report_level_below_average"),
                desc: i18n("report_desc_bone_1003")
            ),
            LevelItem(
                color: colors.report_standard,
                name: i18n("report_level_average"),
                desc: i18n("report_desc_bone_1004")

            ),
            LevelItem(
                color: colors.report_higher,
                name: i18n("report_level_above_average"),
                desc: i18n("report_desc_bone_1005")
            ),
        ]
    }

    init(_ scaleData: BravScaleData, _ option: ReportBuilderOption) {
        self.scaleData = scaleData
        self.option = option
    }
}
