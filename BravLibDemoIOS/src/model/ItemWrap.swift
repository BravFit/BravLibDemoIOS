//
//  ItemWrap.swift
//  BravBleDemo
//
//  Created by 黄敦仁 on 2022/3/8.
//

import Foundation

struct ItemWrap<T> :Identifiable {
    var id = UUID()
    var data:T
    
    init(_ data:T) {
        self.data = data
    }
}
