//
//  LevelItem.swift
//  BravBleDemo
//
//  Created by 黄敦仁 on 2022/3/15.
//

import Foundation
struct LevelItem {
    var name: String = ""
    var color: String = ""
    var desc: String = ""
    init(color:String,name:String,desc:String) {
        self.color = color
        self.name = name
        self.desc = desc
    }
}
