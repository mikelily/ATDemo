//
//  TestUserData.swift
//  ATDemo
//
//  Created by 林華淵 on 2022/3/17.
//

import Foundation
import SwiftyJSON

func testGetUserData(caseID: Int)->JSON{
    switch caseID {
    case 0:
        return JSON(
            [
                "title" : "😻Mikelily😻 🍀初學者~商務日語和會話專家🍀",
                "subTitle" : "🤩1000堂日文課完成🤩",
                "totalClass" : 1063,
                "avatar" : "avatar"
            ]
        )
    case 1:
        return JSON(
            [
                "status": 400,
                "message": "Fail",
            ]
        )
    default:
        print("testAPIGetDeviceInfo caseID Error")
        return JSON()
    }
    
}
