//
//  DateData.swift
//  ATDemo
//
//  Created by 林華淵 on 2022/3/16.
//

import Foundation

struct DateData {
    var availableDatas: [StartEndTime] = []
    var bookedDatas: [StartEndTime] = []
}

struct StartEndTime {
    var startTime: Date = Date()
    var endTime: Date = Date()
}
