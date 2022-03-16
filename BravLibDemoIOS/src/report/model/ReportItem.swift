//
//  ReportItem.swift
//  BravBleDemo
//
//  Created by 黄敦仁 on 2022/3/15.
//

import Foundation

struct ReportItem {
    let id: String

    /**
     * 指标的名称，已经国际化了
     */
    var name: String = ""
    var value: Double = 0.0
    var valueString: String = ""
    /**
     * 各级别之前的边界值
     */
    var boundaries: [Double] = []
    var min: Double = 0.0
    var max: Double = 0.0
    var levels: [LevelItem]?
    var levelIndex: Int = 0
    var isStandard = false
    var unit: String = ""
    var desc: String = ""

    var intro: String = ""
    var isWeightUnit = false
    var icon: String = ""

    init(id: String) {
        self.id = id
    }

    var isBarVisible: Bool {
        levels != nil
    }

    var targetLevel: LevelItem? {
        levels?[levelIndex]
    }
}
