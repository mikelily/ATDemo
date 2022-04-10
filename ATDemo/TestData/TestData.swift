//
//  TestData.swift
//  ATDemo
//
//  Created by 林華淵 on 2022/3/16.
//

import Foundation
import SwiftyJSON

func testGetDatas(weekIndex: Int)->JSON{
    switch weekIndex {
    case 0:
        return JSON(
            [
                "available": [
                    [
                        "start": "2022-03-14T01:00:00Z",
                        "end": "2022-03-14T07:30:00Z"
                    ],
                    [
                        "start": "2022-03-18T01:00:00Z",
                        "end": "2022-03-18T07:30:00Z"
                    ],
                    [
                        "start": "2022-03-19T01:00:00Z",
                        "end": "2022-03-19T07:30:00Z"
                    ]
                ],
                "booked": [
                    [
                        "start": "2022-03-14T01:00:00Z",
                        "end": "2022-03-14T03:30:00Z"
                    ],
                    [
                        "start": "2022-03-18T01:00:00Z",
                        "end": "2022-03-18T02:30:00Z"
                    ],
                    [
                        "start": "2022-03-18T03:30:00Z",
                        "end": "2022-03-18T05:30:00Z"
                    ],
                    [
                        "start": "2022-03-19T06:00:00Z",
                        "end": "2022-03-19T06:30:00Z"
                    ]
                ]
            ]
        )
    case 1:
        return JSON(
            [
                "available": [
                    [
                        "start": "2022-03-20T01:00:00Z",
                        "end": "2022-03-20T07:30:00Z"
                    ],
                    [
                        "start": "2022-03-21T01:00:00Z",
                        "end": "2022-03-21T07:30:00Z"
                    ],
                    [
                        "start": "2022-03-23T01:00:00Z",
                        "end": "2022-03-23T05:30:00Z"
                    ]
                ],
                "booked": [
                    [
                        "start": "2022-03-20T01:30:00Z",
                        "end": "2022-03-20T03:30:00Z"
                    ],
                    [
                        "start": "2022-03-20T06:30:00Z",
                        "end": "2022-03-20T07:30:00Z"
                    ],
                    [
                        "start": "2022-03-21T02:00:00Z",
                        "end": "2022-03-21T03:30:00Z"
                    ],
                    [
                        "start": "2022-03-23T04:00:00Z",
                        "end": "2022-03-23T04:30:00Z"
                    ]
                ]
            ]
        )
    case 2:
        return JSON(
            [
                "available": [
                    [
                        "start": "2022-03-28T01:00:00Z",
                        "end": "2022-03-28T07:30:00Z"
                    ],
                    [
                        "start": "2022-03-29T01:00:00Z",
                        "end": "2022-03-29T07:30:00Z"
                    ],
                    [
                        "start": "2022-04-01T01:00:00Z",
                        "end": "2022-04-01T05:30:00Z"
                    ]
                ],
                "booked": [
                ]
            ]
        )
    default:
        print("testAPIGetDeviceInfo caseID Error")
        return JSON()
    }
}
