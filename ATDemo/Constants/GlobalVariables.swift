//
//  GlobalVariables.swift
//  ATDemo
//
//  Created by 林華淵 on 2022/3/17.
//

import UIKit
import Foundation

/// 狀態列高度 Mike
let statusBarHeight : CGFloat = UIApplication.shared.statusBarFrame.height

let timeZone: String = TimeZone.current.identifier
let gmt: String = TimeZone.current.abbreviation()!
// 備用
let secondsFromGMT: Int =  TimeZone.current.secondsFromGMT()
