
//
//  File.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/24.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation


let MeetingPreviewJson: [String: Any] = [
    "version": "0",
    "template": [
                        "viewType": "StackView",
                        "property": ["axis":"vertical", "distribution": "fill", "alignment": "fill", "space": 0, "height":-1, "width": -1, "margin":[0, 0, 0, 0], "backgroudColor": "#0F1219"],
            
                        // 声明页面初始状态 reducer处理各状态直接关联业务逻辑
                        "state":["list": "${meetingList}",
                                 "receiveType":"1"], // 1,我收到的， 2,我发送的
                        
                        // 声明请求列表 initLoad方法只在界面初始加载调用
                        "requests":[
                            "initLoad":["meet_id":"${meet_id}"]
                        ],
                        
                        "subViews": [
                            
                            ["templateType": "navHeader_1",
                             "property": ["title": "会议预告"]
                            ],
                            
                            // 按钮
                            ["viewType": "View",
                             "property": ["height":44],
                             "subViews": [
                                ["viewType": "StackView",
                                 "property": ["axis":"horizontal", "distribution": "fillEqually", "alignment": "fill", "space": 20, "margin":[6, 6, 57, 57]],
                                 "subViews": [
                                    ["viewType": "View",
                                     "dynamicProperty":[
                                        "currentState": "1",
                                        "connectState": "receiveType",
                                     "stateList":[
                                         "1":["viewType": "Button",
                                              "property":["size": 14, "cornerRadius":16, "color": "#FFFFFF", "backgroudColor": "#5C3481", "content":"我收到的","action": ["actionType": "updateState", "params": ["connectState": "receiveType", "value": "1"]]]],
                                         
                                         "2":["viewType": "Button",
                                         "property":["size": 14, "cornerRadius":16, "color": "#FFFFFF", "backgroudColor": "#252D3D", "content":"我收到的","action": ["actionType": "updateState", "params": ["connectState": "receiveType", "value": "1"]]]]
                                         ]
                                     ]
                                    ],
                                    
                                    ["viewType": "View",
                                     "dynamicProperty":[
                                        "currentState": "1",
                                        "connectState": "receiveType",
                                     "stateList":[
                                         "1":["viewType": "Button",
                                         "property":["size": 14, "cornerRadius":16, "color": "#FFFFFF", "backgroudColor": "#252D3D", "content":"我发布的","action": ["actionType": "updateState", "params": ["connectState": "receiveType", "value": "2"], "subActions": [ ["actionType": "clear", "params": ["connectState": ["list"]]]  ]]]],
                                         
                                         "2":["viewType": "Button",
                                         "property":["size": 14, "cornerRadius":16, "color": "#FFFFFF", "backgroudColor": "#5C3481", "content":"我发布的","action": ["actionType": "updateState", "params": ["connectState": "receiveType", "value": "2"]]]]
                                         ]
                                     ]
                                    ]
                                 ]
                                ]
                             ]
                             
                            ],
                            
                           // body
                           [
                           "viewType": "TableView",
                           "property": [ "color": "#0F1219", "separatorStyle": "none"],
                               
                               // 模板数据映射关系
                            "templatesReflect": [
                                "templates_5": ["status": "${status}", "title": "${meetingTitle}", "name":"${memberName}", "subTitle": "${tips}", "actionType": "showPage","actionParam": ["pageId": "HasConfirmMember"]]
                            ],
                            
                            "dynamicSections": [
                             ["header": "", "list": ["rowItems": "${list}", "rowIdentifier": "1", "identifierMap": ["1":"templates_5"]]]
                             ],
                            
                            // 空背景
                            "emptyConfiguration": [
                                "description": "您没有发布会议预告哦", "descriptionColor": "#97A0B4", "descriptionFontSize": 16
                            ]
                            
                            
                           ],
                        ]
    ],
    
    "serviceData": [
        "meetingList": [
            ["memberHeader": "default_head.png", "memberName": "张三", "meetingTitle": "直播带货交流会议直播带货交流会议", "tips": "20分钟后开始", "status": "1"], // 待确认收到
            ["memberHeader": "default_head.png", "memberName": "李四",  "meetingTitle": "如果只有一行字就是这样", "tips": "今天 上午 10:00", "status": "2"], // 已确认
            ["memberHeader": "default_head.png", "memberName": "王五",   "meetingTitle": "如果只有一行字就是这样1", "tips": "2020-05-22  上午10:00", "status": "3"] // 已过期
        ]

    ]
]
