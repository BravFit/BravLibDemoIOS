//
//  BleModel.swift
//  BravBleDemo
//
//  Created by 黄敦仁 on 2022/3/7.
//

import Foundation
import BravLib

class BleModel: ObservableObject, BravBleEventDelegate , BravLoggerDelegate{
  
    let tag = "BleModel"
    
    
    @Published var bleEnableState:BleEnableState = .Unknown
    
    @Published var discovering = false
    
    @Published var deviceList = [BravDeviceWrap]()
    
    var bleEnableStateString:String {
        get{
            switch bleEnableState {
            case .Unknown:
                return "Unknown"
            case .Disable:
                return "Diabled"
            case .Unauthorized:
                return "Unauthorized"
            case .Enable:
                return "Enable"
            }
    
        }
    }
    
    func clearDevice(){
        self.deviceList = [BravDeviceWrap]()
    }
    
    func addDevice(_ device:BravDevice){
        let index = self.deviceList.firstIndex(where: {d in d.data.deviceId == device.deviceId})
        if index != nil {
            self.deviceList[index!] = BravDeviceWrap(device)
        }else{
            self.deviceList.append(BravDeviceWrap(device))
        }
        self.deviceList = [BravDeviceWrap](self.deviceList)
    }
    
    func onBleEnableStateChange(state: BleEnableState) {
        BravLogger.log(tag,"onBleEnableStateChange：",state.rawValue)
        self.bleEnableState = state
    }
    
    func onBravDeviceFound(device: BravDevice) {
        BravLogger.log(tag,"device found \(device.mac)")
        self.addDevice(device)
    }
    
    func onConnectionChange(deviceId: String, state: BravDeviceConnectionState) {
        BravLogger.log(tag,"connection state change：\(deviceId) \(state)")
    }
    
    func onLog(tag: String, text: String) {
        //do save log
    }
    
    func onError(tag: String, text: String) {
        //do save log
    }
    
    
}


typealias BravDeviceWrap = ItemWrap<BravDevice>
