//
//  ReportBuilder.swift
//  BravBleDemo
//
//  Created by 黄敦仁 on 2022/3/15.
//

import Foundation
import BravLib

class ReportBuilder{
    var scaleData: BravScaleData
    var option: ReportBuilderOption
    
    init(_ scaleData: BravScaleData, _ option: ReportBuilderOption) {
        self.scaleData = scaleData
        self.option = option
    }
    
    func build()-> BravScaleReport {
            let report = BravScaleReport(scaleData);
        let builders = self.fetchBuilders(scaleData, option).filter({item in item.isValid})
            report.reportItemList = builders.map {builder in builder.build() }
            return report
        }

        private func fetchBuilders(
            _ scaleData: BravScaleData,
            _ option: ReportBuilderOption
        )-> [ReportItemBuilder] {
//            if (option.reportType == ReportType.asia) {
//                return [
//                    WeightBuilder(scaleData, option),
//                    BmiBuilder(scaleData, option),
//                    BodyfatBuilder(scaleData, option),
//                    BoneBuilder(scaleData, option),
//                    LbmBuilder(scaleData, option),
//                    MuscleMassBuilder(scaleData, option),
//                    ProteinBuilder(scaleData, option),
//                    SkeletalMuscleBuilder(scaleData, option),
//                    SubfatBuilder(scaleData, option),
//                    VisfatBuilder(scaleData, option),
//                    WaterBuilder(scaleData, option),
//
//                    ]
//            } else {
                return [
                    WeightCommonBuilder(scaleData, option),
                    BmiCommonBuilder(scaleData, option),
                    BodyfatCommonBuilder(scaleData, option),
                    BoneCommonBuilder(scaleData, option),
                    LbmBuilder(scaleData, option),
                    MuscleMassCommonBuilder(scaleData, option),
                    ProteinBuilder(scaleData, option),
                    SkeletalMuscleBuilder(scaleData, option),
                    SubfatBuilder(scaleData, option),
                    VisfatCommonBuilder(scaleData, option),
                    WaterCommonBuilder(scaleData, option),
                    BmrBuilder(scaleData, option),
                    BodyAgeBuilder(scaleData, option)
                    ]
//            }

        }
    
}
