//
//  MuscleMassCommonBuilder.swift
//  BravBleDemo
//
//  Created by 黄敦仁 on 2022/3/15.
//

import BravLib
import Foundation

class MuscleMassCommonBuilder: ReportItemBuilder {
    var scaleData: BravScaleData
    var option: ReportBuilderOption

    var id = "muscle_mass"
    var nameKey = "report_item_muscle_mass"
    var defaultName = "Muscle Mass"
    var introKey = "report_desc_muscle_mass_1004"
    var standLevelIndex = 1
    var isWeightUnit = true
    var value: Double {
        return scaleData.muscleMass.toTargetWeightUnit(valueUnit, targetUnit)
    }


    var boundaries: [Double] {
        var _boundaries:[Double]
        let gender = user.gender
        let height = user.height

        if gender == .Male {
            if height < 160 {
                _boundaries = [38.5, 46.5]
            } else if height <= 170 {
                _boundaries = [44, 52.4]
            } else {
                _boundaries = [49.4, 59.4]
            }
        } else if height < 150 {
            _boundaries = [29.1, 34.7]
        } else if height <= 160 {
            _boundaries = [32.9, 37.5]
        } else {
            _boundaries = [36.5, 42.5]
        }

        return _boundaries.map({val in val.toTargetWeightUnit(valueUnit, targetUnit)})
    }

    var levels: [LevelItem]? {
        return [
            LevelItem(
                color: colors.report_lower,
                name: i18n("report_level_low"),
                desc: i18n("report_desc_muscle_mass_1002")
            ),
            LevelItem(
                color: colors.report_standard,
                name: i18n("report_level_normal"),
                desc: i18n("report_desc_muscle_mass_1003")

            ),
            LevelItem(
                color: colors.report_higher,
                name: i18n("report_level_adequate"),
                desc: i18n("report_desc_muscle_mass_1003")
            ),
        ]
    }

    init(_ scaleData: BravScaleData, _ option: ReportBuilderOption) {
        self.scaleData = scaleData
        self.option = option
    }
    
    func builder() -> ReportItem {
        var reportItem = initAndInjectFields()

        reportItem.min = boundaries[0] * 0.5
        reportItem.max = boundaries.last! * 1.5

        return reportItem
    }
}
