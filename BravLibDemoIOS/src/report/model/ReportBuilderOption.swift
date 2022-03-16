//
//  ReportBuilderOption.swift
//  BravBleDemo
//
//  Created by 黄敦仁 on 2022/3/15.
//

import Foundation
import BravLib
class ReportBuilderOption {
    var targetWeightUnit: BravScaleUnit = .kg
    var i18n: I18n? = nil
    var reportType: ReportType = ReportType.common
    
    init() {
    }
    
    convenience init(targetWeightUnit: BravScaleUnit,i18n: I18n?,reportType: ReportType) {
        self.init()
        self.targetWeightUnit = targetWeightUnit
        self.i18n = i18n
        self.reportType = reportType
    }
    
    
}
