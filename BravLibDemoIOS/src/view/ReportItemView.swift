//
//  ReportItemView.swift
//  BravBleDemo
//
//  Created by 黄敦仁 on 2022/3/15.
//

import BravLib
import SwiftUI

struct ReportItemView: View {
    @Binding var reportItem: ReportItem

    var body: some View {
        VStack {
            HStack {
                Text(reportItem.name)
                
                Spacer(minLength: 5)
                
                Text("\(reportItem.valueString) \(reportItem.unit)")
                Spacer()
                if let targetLevel = reportItem.targetLevel {
                    Text(targetLevel.name)
                }
            }
            
            if let levels = reportItem.levels {
                Text(levels.map({level in level.name}).joined(separator: ","))
                Spacer(minLength: 5)

            }
            
            if reportItem.desc.count > 0 {
                Spacer(minLength: 7)
                Text(reportItem.desc)
            }

            Text(reportItem.intro)
                
        }.padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
    }
}

extension NSDictionary: I18n {
    subscript(key: String) -> String? {
        return value(forKey: key) as? String
    }
}

struct ReportItemView_Previews: PreviewProvider {
    static var report = {
        () -> BravScaleReport in
            let user = BravScaleUser(gender: .Female, height: 180, age: 30)
            let mac = "11:22:33:44:55:66"
            let originData = BravScaleOriginData(60, 500, mac)

            let scaleData = BravScaleData(user: user, originData: originData)

            let localJson = loadLocalJson()

            let option = ReportBuilderOption()
            option.i18n = localJson
        option.targetWeightUnit = .lb

            let report = ReportBuilder(scaleData, option).build()

            return report
    }()

    static var previews: some View {
        VStack{
            List(report.reportItemList,id:\.id){
                reportItem in
                ReportItemView(reportItem: .constant(reportItem))

                
            }
        }
        
        
    }
}
