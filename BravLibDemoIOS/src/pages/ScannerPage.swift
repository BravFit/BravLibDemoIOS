//
//  ScannerVC.swift
//  BravBleDemo
//
//  Created by 黄敦仁 on 2022/3/7.
//

import BravLib
import Foundation
import SwiftUI

struct ScannerPage: View {
    var bleApi: BravBleApi

    @EnvironmentObject var bleModel: BleModel

    @State var currentDevice: BravDeviceWrap? = nil
    @State var isNavigateToMeasure = false

    init() {
        bleApi = BravApiProvider.sharedBleApi

        let user = BravScaleUser(gender: .Female, height: 180, age: 30)
//        let options = ScaleDataOptions(user:user ,unit: .kg)
        let originData = BravScaleOriginData(60, 500, "")

        let scaleData = BravScaleData(user: user, originData: originData)

        BravLogger.log("measurePage", "mock的数据为：", scaleData.bodyfatRate)
    }

    var body: some View {
        VStack {
            if self.currentDevice != nil {
                NavigationLink(
                    destination: MeasurePage(deviceWrap: .constant(self.currentDevice!)),
                    isActive: self.$isNavigateToMeasure,
                    label: {
                        Text("")
                    }
                )
            }
            HStack {
                Text(bleModel.discovering ? "Scanning" : "Idle")
                Spacer()
                Text(bleModel.bleEnableStateString)
                Spacer()
                Button(!bleModel.discovering ? "Start scan" : "Stop scan") {
                    if bleModel.discovering {
                        self.bleApi.stopScan()
                        self.bleModel.discovering = false
                    } else {
                        let result = self.bleApi.startScan(options: nil)
                        if result.isSuccess {
                            self.bleModel.discovering = true
                        }
                    }
                }

            }.padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))

            List(self.bleModel.deviceList) {
                deviceWrap in
                DeviceItemView(deviceWrap: .constant(deviceWrap))
                    .onTapGesture {
                        self.currentDevice = deviceWrap
                        self.isNavigateToMeasure = true
                    }
            }
        }.navigationBarTitle("Scanning")
    }
}

#if DEBUG
    struct ScannerPage_Previews: PreviewProvider {
        static var previews: some View {
            ScannerPage()
                .environmentObject(BleModel())
        }
    }
#endif
