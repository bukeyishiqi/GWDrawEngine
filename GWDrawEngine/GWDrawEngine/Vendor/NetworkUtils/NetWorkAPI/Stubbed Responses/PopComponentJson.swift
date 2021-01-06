//
//  PopComponentJson.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/6/30.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation


 // MARK:  系统弹框
let PopComponentJson: [String: Any] = [
    "version": 0,
    "template": [
        "viewType": "View",
        "property": ["ratioW":0.8,"ratio": 2, "margin":[0, 0, 0, 0], "backgroudColor": "#ffffff", "cornerRadius": 8, "popupCustomAlignment": 0, "popupAnimationType": 2],
         // ratoW 为宽度相对屏幕宽度的比率。ratio 为宽/高 值 由父视图获取
        "subViews": [
            [
                "viewType": "StackView",
                "property": ["axis":"vertical", "distribution": "fill", "alignment": "fill", "space": 0, "margin":[22, 0, 0, 0]],
                "subViews": [
                    ["viewType": "Text",
                     "property":["size": 18,"id":"1", "alignment": "center", "isBold": 1, "color": "#141922", "height": 20, "content":"${title}", "expressionSetters": ["content": "title"]]],
                    
                     ["viewType": "Text",
                      "property":["size": 15,"numberOfLines": 0, "id":"2", "alignment": "center", "color": "#737D92", "content":"${description}", "expressionSetters": ["content": "description"]]],
                    // 线条
                    ["viewType": "View",
                     "property": ["height": 1, "backgroudColor": "#EEEEEE"]],
                    
                    // 按钮
                    ["viewType": "View",
                     "property": ["backgroudColor": "#EEEEEE", "height":44],
                     "subViews": [
                            ["viewType": "StackView",
                             "property": ["axis":"horizontal", "distribution": "fillEqually", "alignment": "fill", "space": 1,  "margin":[0, 0, 0, 0]],
                             "subViews":[
                                    ["viewType": "Button",
                                    "property":["size": 15, "id":"3", "backgroudColor": "#ffffff", "alignment": "center", "color": "#737D92", "content":"${cancelTitle}", "expressionSetters": ["content": "cancelTitle"], "action": ["actionType": "cancel", "params": ["key": "value"]]]],
                                
    //                                   // 线条
    //                                   ["viewType": "View",
    //                                    "property": ["width": 1, "backgroundColor": "#EEEEEE"]],

                                    ["viewType": "Button",
                                    "property":["size": 15, "id":"4","backgroudColor": "#ffffff", "alignment": "center", "color": "#141922", "content":"${confirmTitle}",  "expressionSetters": ["content": "confirmTitle"], "action": ["actionType": "confirm", "params": ["key": "value"]]]]
                                ]
                            ]
                        ]
                    ]
                ]
            ]
        
        ]

        
    ]
]
    
    
    
    
    
    
    
    


 // MARK: 口令输入弹框

let inputPopComponentJson: [String: Any] = [
    "viewType": "View",
    "property": ["ratioW":0.8,"ratio": 1.26, "margin":[0, 0, 0, 0], "backgroudColor": "#ffffff", "cornerRadius": 8, "popupCustomAlignment": 0, "popupAnimationType": 2],
     // ratoW 为宽度相对屏幕宽度的比率。ratio 为宽/高 值 由父视图获取
    "subViews": [
        [
            "viewType": "StackView",
            "property": ["axis":"vertical", "distribution": "fill", "alignment": "center", "space": 32, "margin":[32, 0, 0, 24]],
            "subViews": [
                ["viewType": "ImageView",
                 "property":["id":"1", "height": 72, "width": 72, "content":"icon_tc_srmm.png"]],
                
                 ["viewType": "Text",
                  "property":["size": 24, "isBold": 1,  "id":"2", "alignment": "center", "color": "#2B2B2B", "content":"请输入参会密码", "expressionSetters": ["content": "description"]]],
                // 输入框
                ["viewType": "StackView",
                 "property": ["height": 84, "backgroudColor": "#EEEEEE"],
                 "subViews": [
                    
                    ["viewType": "Text",
                    "property":["size": 13, "fontName": "PingFangSC", "id":"2", "alignment": "center", "color": "#4E586E", "content":"请输入验证口令", "expressionSetters": ["content": "description"]]]
                    
                    ]
                ],
                
            ]
        ]
    
    ]

    
]
