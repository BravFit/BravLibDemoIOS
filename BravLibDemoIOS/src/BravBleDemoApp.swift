//
//  BravBleDemoApp.swift
//  BravBleDemo
//
//  Created by 黄敦仁 on 2022/3/7.
//

import SwiftUI
import BravLib

@main
struct BravBleDemoApp: App {

    var bleModel = BleModel()
    init() {
        BravLogger.log("app", "初始化蓝牙对象")
        BravApiProvider.initSharedBleApi()
        
        BravLogger.loggerLevel = BravLogger.LOG_LEVEL_ALL
        BravLogger.loggerDelegate = bleModel
        
        let bleApi = BravApiProvider.sharedBleApi
        bleApi.bleEventDelegate = bleModel
        
        
    }
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ScannerPage()
            }.environmentObject(bleModel)
            
        }
    }
}
