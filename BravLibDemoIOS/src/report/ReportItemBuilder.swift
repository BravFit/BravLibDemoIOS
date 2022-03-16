//
//  ReportItemBuilder.swift
//  BravBleDemo
//
//  Created by 黄敦仁 on 2022/3/15.
//

import BravLib
import Foundation
protocol ReportItemBuilder {
    var scaleData: BravScaleData { get }
    var option: ReportBuilderOption { get }
    var id: String { get }
    var nameKey: String { get }
    var defaultName: String { get }
    var introKey: String { get }
    var isValid: Bool { get }
    var value: Double { get }
    var valueString: String { get }
    var min: Double { get }
    var max: Double { get }
    var unit: String { get }
    var isWeightUnit: Bool { get }
    var boundaries: [Double] { get }
    var levels: [LevelItem]? { get }
    var standLevelIndex: Int { get }
}

extension ReportItemBuilder {
    var isValid: Bool {
        return scaleData.bodyfatRate > 0
    }

    var valueString: String {
        return "\(value)"
    }

    var min: Double {
        return 0
    }

    var max: Double {
        return 0
    }

    var unit: String {
        return isWeightUnit ? targetUnit.name : ""
    }

    var user: BravScaleUser {
        return scaleData.user
    }

    var valueUnit: BravScaleUnit {
        scaleData.weightUnit
    }

    var targetUnit: BravScaleUnit {
        option.targetWeightUnit
    }
    
    var boundaries: [Double] {
        return []
    }
    var levels:[LevelItem]?{
        return nil
    }

    var standLevelIndex: Int { return 1 }
    
    func initAndInjectFields() -> ReportItem {
        var reportItem = ReportItem(id: id)
        reportItem.name = i18n(nameKey, defaultName)
        reportItem.intro = i18n(introKey, "")
        reportItem.min = min
        reportItem.max = max
        reportItem.unit = unit
        reportItem.isWeightUnit = isWeightUnit
        reportItem.value = value
        reportItem.valueString = valueString
        reportItem.boundaries = boundaries
        reportItem.levels = levels

        if reportItem.levels != nil, !reportItem.boundaries.isEmpty {
            reportItem.levelIndex =
                calcLevelIndex(value, reportItem.boundaries, standLevelIndex)
            reportItem.isStandard = reportItem.levelIndex == standLevelIndex
            reportItem.desc = reportItem.targetLevel!.desc
        }
        return reportItem
    }

    func i18n(_ key: String, _ defValue: String? = nil,_ param:String? = nil) -> String {
        
        var tartValue = option.i18n?[key] ?? defValue ?? "Miss [ ${key} ]"
        if let param = param {
            tartValue = tartValue.replacingOccurrences(of: "XXX", with: param)
        }
        return tartValue
    }

    /**
     * 计算指标的等级索引值
     * @param {number} value - 指标的数值
     * @param {Array<number>} boundaries - 界定等级的边界值
     * @param {number} standLevelIndex - 定义的标准值得索引
     */
    func calcLevelIndex(
        _ value: Double,
        _ boundaries: [Double],
        _ standLevelIndex: Int
    ) -> Int {
        var level = 0
        for b in boundaries {
            if
                value < b ||
                (value == b && level == standLevelIndex)
            {
                break
            }
            level += 1
        }
        return level
    }

    func build() -> ReportItem {
        return initAndInjectFields()
    }
  
}

struct colors {
    static let background = "#f8f8f8"
    static let partLine = "#e5e5e5"
    static let master = "#7370aa"
    static let second = "#8d77df"
    static let report_lowest = "#aa8ee4"
    static let report_lower = "#00c1e4"
    static let report_standard = "#a7cb40"
    static let report_higher = "#fbc13d"
    static let report_highest = "#f74142"
    static let report_sufficient = "#3ea42c"
    static let report_orange_highest = "#ff8c00"
    static let report_claret_sufficient = "#7f1734"
}
