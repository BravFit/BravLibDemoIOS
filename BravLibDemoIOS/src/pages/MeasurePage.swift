//
//  MeasureView.swift
//  BravBleDemo
//
//  Created by 黄敦仁 on 2022/3/7.
//

import BravLib
import SwiftUI

struct MeasurePage: View {
    let tag = "MeasurePage"
    let deviceId = "测量界面"

    @Binding var deviceWrap: BravDeviceWrap

    @StateObject var measureModel = MeasureModel()
    
    

    let bleApi = BravApiProvider.sharedBleApi

    var device: BravDevice {
        deviceWrap.data
    }

    var body: some View {
        VStack {
            
            Text("mac \(self.device.mac)")

            Text("measure state：\(self.measureModel.measureState.rawValue)")

            Text("weight：\(String(format: "%.2f", self.measureModel.unsteadyWeight))")
                .font(.title)

            Button(self.measureModel.connectionState == .Connected ? "Disconnect" : "Connect") {
                if self.measureModel.connectionState == .Disconnected {
                    self.doConnect()
                } else {
                    self.doDisconnect()
                }
            }
            
            List(self.measureModel.reportItems,id:\.id) {
                reportItem in
                ReportItemView(reportItem: .constant(reportItem))
            }

        }.onDisappear {
            if self.measureModel.connectionState == .Connected {
                self.doDisconnect()
            }

        }.onAppear {
            if self.measureModel.connectionState == .Disconnected, self.device.deviceId.count > 0 {
                self.doConnect()
            }
//            self.measureModel.mockReportItems()
        }
    }

    func doConnect() {
        let user = BravScaleUser(gender: .Female, height: 180, age: 30)
        let options = BravScaleDataOptions(user: user, unit: .kg)

        _ = bleApi.connectDevice(deviceId: device.deviceId,
                                 options: options,
                                 listener: measureModel,
                                 connectionChangeListener: measureModel)
    }

    func doDisconnect() {
        bleApi.disconnectDevice(deviceId: device.deviceId)
    }
}

struct MeasureView_Previews: PreviewProvider {
    static var previews: some View {
        let bravDevice = {
            () -> BravDevice in
                let device = BravDevice()
                device.mac = "11:22:33:44:55:66"
                return device
        }()
        MeasurePage(deviceWrap: .constant(BravDeviceWrap(bravDevice)))
    }
}


