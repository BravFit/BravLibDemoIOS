//
//  BmrBuilder.swift
//  BravBleDemo
//
//  Created by 黄敦仁 on 2022/3/15.
//

import BravLib
import Foundation

class BodyAgeBuilder: ReportItemBuilder {
    var scaleData: BravScaleData
    var option: ReportBuilderOption

    var id = "bodyAge"
    var nameKey = "report_item_body_age"
    var defaultName = ""
    var introKey = "report_desc_body_age_1002"
    var isWeightUnit = false
    var value: Double {
        return Double(scaleData.bodyAge)
    }

    init(_ scaleData: BravScaleData, _ option: ReportBuilderOption) {
        self.scaleData = scaleData
        self.option = option
    }
}
