//
//  PopPickerViewComponentJson.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/8.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation
// ratioW 值为浮点型，不能为整型
//let PopPickerViewComponentJson: [String: Any] = [
//    "viewType": "View",
//    "property": ["ratioW":1.0,"height": 200, "margin":[0, 0, 0, 0], "backgroudColor": "#ffffff",  "popupCustomAlignment": 0, "radiusLoction": [15, 15, 0, 0], "popupAnimationType": 2],
//     // ratoW 为宽度相对屏幕宽度的比率。ratio 为宽/高 值 由父视图获取
//    "subViews": [
//
//        [
//            "viewType": "View",
//            "property": ["height": 50, "marginRight": 0, "marginTop": 0, "marginLeft": 0],
//            "subViews": [
//                ["viewType": "Text",
//                 "property":["size": 16, "id":"1", "alignment": "center", "isBold": 1, "color": "#141922", "height": 30, "width": 200, "content":"${title}", "centerParent": 1]],
//                ["viewType": "Button",
//                 "property":["size": 15, "width": 60, "height": 30, "cornerRadius": 15, "id":"4","backgroudColor": "#333333", "alignment": "center", "color": "#ffffff", "content":"完成", "marginRight": 10, "marginTop": 10, "marginBottom": 10, "action":["actionType": "pickerSelected"]]],
//                // 线条
//                ["viewType": "View",
//                 "property": ["height": 1, "backgroudColor": "#EEEEEE","marginRight": 0, "marginBottom": 0, "marginLeft": 0]]
//            ]
//        ],
//        [
//            "viewType": "PickerView",
//            "property":["backgroudColor":"#ffffff","margin":[50,0,0,0], "rowHeight": 50]
//        ]
//    ]
//
//
//]


let RequestPopPickerViewComponentJson: [String: Any] = [
    "version": "0",
    "template": [
        "viewType": "View",
        "property": ["ratioW":1.0,"height": 200, "margin":[0, 0, 0, 0], "backgroudColor": "#ffffff",  "popupCustomAlignment": 3, "radiusLoction": [15, 5, 0, 10], "popupAnimationType": 0],
         // ratoW 为宽度相对屏幕宽度的比率。ratio 为宽/高 值 由父视图获取
        "subViews": [
            
            [
                "viewType": "View",
                "property": ["height": 50, "marginRight": 0, "marginTop": 0, "marginLeft": 0],
                "subViews": [
                    ["viewType": "Text",
                     "property":["size": 16, "id":"1", "alignment": "center", "isBold": 1, "color": "#141922", "height": 30, "width": 200, "content":"${title}", "centerParent": 1]],
                    ["viewType": "Button",
                     "property":["size": 15, "width": 60, "height": 30, "cornerRadius": 15, "id":"4","backgroudColor": "#333333", "alignment": "center", "color": "#ffffff", "content":"完成", "marginRight": 10, "marginTop": 10, "marginBottom": 10, "action":["actionType": "pickerSelected"]]],
                    // 线条
                    ["viewType": "View",
                     "property": ["height": 1, "backgroudColor": "#EEEEEE","marginRight": 0, "marginBottom": 0, "marginLeft": 0]]
                ]
            ],
            [
                "viewType": "PickerView",
                "property":["backgroudColor":"#ffffff","margin":[50,0,0,0], "rowHeight": 50]
            ]
        ]

        
    ]
]
