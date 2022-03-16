//
//  DeviceItem.swift
//  BravBleDemo
//
//  Created by 黄敦仁 on 2022/3/8.
//

import BravLib
import SwiftUI

struct DeviceItemView: View {
    @Binding var deviceWrap: BravDeviceWrap

    var device: BravDevice {
        deviceWrap.data
    }

    var body: some View {
        HStack {
            Text(device.mac)
            Spacer()
            Text("\(device.rssi)")
            Spacer()
            Text("Click to connect")
        }
        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
    }
}

struct DeviceItem_Previews: PreviewProvider {
    static var bravDevice = {
        () -> BravDevice in
            var device = BravDevice()
            device.mac = "11:22:33:44:55:66"
            return device
    }()

    static var previews: some View {
        DeviceItemView(deviceWrap: .constant(BravDeviceWrap(DeviceItem_Previews.bravDevice)))
    }
}
