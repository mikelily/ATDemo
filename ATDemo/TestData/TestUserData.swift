//
//  TestUserData.swift
//  ATDemo
//
//  Created by æè¯æ·µ on 2022/3/17.
//

import Foundation
import SwiftyJSON

func testGetUserData(caseID: Int)->JSON{
    switch caseID {
    case 0:
        return JSON(
            [
                "title" : "ð»Mikelilyð» ðåå­¸è~ååæ¥èªåæè©±å°å®¶ð",
                "subTitle" : "ð¤©1000å æ¥æèª²å®æð¤©",
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
