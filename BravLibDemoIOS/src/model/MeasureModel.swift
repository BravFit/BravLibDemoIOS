//
//  MeasureModel.swift
//  BravBleDemo
//
//  Created by 黄敦仁 on 2022/3/8.
//

import Foundation
import BravLib

enum MeasureState:String {
    case unsteady,idle,complete
}

class MeasureModel:ObservableObject,BravScaleEventDelegate,BravBleConnectionChangeDelegate{
  
    
    let tag = "MeasureModel"
    
    @Published var unsteadyWeight:Double = 0
    @Published var measureState:MeasureState = .idle
    @Published var connectionState:BravDeviceConnectionState = .Disconnected
    @Published var reportItems = [ReportItem]()
    
    var localJson:NSDictionary? = nil
    
    func onGetUnsteadyWeight(_ deviceId: String, _ weight: Double) {
        BravLogger.log(tag,"onGetUnsteadyWeight：\(weight) %")

        self.unsteadyWeight = weight
        self.measureState = .unsteady
    }
    
    func onMeasureComplete(_ deviceId: String, _ scaleData: BravScaleData) {
        self.unsteadyWeight = scaleData.weight
        self.measureState = .complete
        BravLogger.log(tag,"Measure compliete bodyfat percentage：\(scaleData.bodyfatRate) %")
        self.turnToReport(scaleData)
    }
    
    func onGetOfflineData(_ deviceId: String, _ scaleDataList: [BravScaleOriginData]) {
        BravLogger.log(tag, "Received： \(scaleDataList.count)")
    }
    
    func onConnectionChange(deviceId: String, state: BravDeviceConnectionState) {
        BravLogger.log(tag,"connection state change：\(deviceId) \(state)")

        self.connectionState = state
    }
    
    private func turnToReport(_ scaleData:BravScaleData){
        if self.localJson == nil {
            self.localJson = loadLocalJson()
        }
        
        let localJson = loadLocalJson()

        let option = ReportBuilderOption()
        option.i18n = localJson

        let report = ReportBuilder(scaleData, option).build()
        
        self.reportItems = report.reportItemList
    }
    
    func mockReportItems(){
        let user = BravScaleUser(gender: .Female, height: 180, age: 30)
        let mac = "11:22:33:44:55:66"
        let originData = BravScaleOriginData(60, 500, mac)

        let scaleData = BravScaleData(user: user, originData: originData)

        let localJson = loadLocalJson()

        let option = ReportBuilderOption()
        option.i18n = localJson

        let report = ReportBuilder(scaleData, option).build()
        
        self.reportItems = report.reportItemList
    }
}

func loadLocalJson() -> NSDictionary? {
    let path = Bundle.main.path(forResource: "en", ofType: "json")
    let url = URL(fileURLWithPath: path!)
    
    do {
        let data = try Data(contentsOf: url)
        var jsonData: Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
        let jsonDict = jsonData as! NSDictionary

        return jsonDict
    } catch let error as Error? {
        print("load json error", error)
        return nil
    }
}
