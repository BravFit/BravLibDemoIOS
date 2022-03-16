//
//  BravScaleReport.swift
//  BravBleDemo
//
//  Created by 黄敦仁 on 2022/3/15.
//

import Foundation
import BravLib

class BravScaleReport{
    let scaleData: BravScaleData
    
    var reportItemList: [ReportItem] = []
    
    init(_ scaleData:BravScaleData) {
        self.scaleData = scaleData
    }
}
