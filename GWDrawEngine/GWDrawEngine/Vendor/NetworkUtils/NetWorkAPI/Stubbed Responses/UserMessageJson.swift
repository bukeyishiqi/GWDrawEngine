//
//  UserMessageJson.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/1.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation



let UserMessageJson: [String: Any] = [
                    "viewType": "StackView",
                    "property": ["axis":"vertical", "distribution": "fill", "alignment": "fill", "space": 0, "height":-1, "width": -1, "margin":[0, 0, 0, 0], "color": "#0C0E13"],
                    
                    "templates": [
                        "templates_1": ["viewType": "View",
                         "property": ["margin":[10, 10, 10, 10],  "cornerRadius": 15, "backgroundColor": "#20222E", "action": ["name": "showPage", "params": ["pageId": "0"]], "expressionSetters": ["action": "params"]],
                         
                         // actionParams 为需要参数对应的  state 节点状态 选中、未选中、隐藏
                         "subViews": [
                                [
                                           "viewType": "StackView",
                                           "property": ["axis":"horizontal", "distribution": "fill", "alignment": "center", "space": 10, "margin":[22, 22, 22, 16]],
                                           "subViews": [
                                               ["viewType": "Text",
                                                "property":["size": 16,"alpha": 0.5, "alignment": "left", "color": "#C7D2EC", "height": 20, "content":"头像", "id": "2"]],
                                               
                                               ["viewType": "ImageView",
                                                "property":["height": 47,"width": 47, "id": "1",
                                                            "content": "default_head.png", "expressionSetters": ["content": "headerIcon"]]],
                                               
                                               ["viewType": "ImageView",
                                                "property":["height": 11,"width": 7, "id": "4", "content": "iocn_my_home_back.png"]]
                                           ]
                                       ]
                            
                            ]
                        ],
                        
                        "templates_2": ["viewType": "View",
                         "property": ["margin":[10, 10, 10, 10],  "cornerRadius": 15, "backgroundColor": "#20222E", "action": ["name": "showPage", "params": ["pageId": "0"]], "expressionSetters": ["action": "params"]],
                         
                         // actionParams 为需要参数对应的  state 节点状态 选中、未选中、隐藏
                         "subViews": [
                                [
                                           "viewType": "StackView",
                                           "property": ["axis":"horizontal", "distribution": "fill", "alignment": "center", "space": 10, "margin":[22, 22, 22, 22]],
                                           "subViews": [
                                               ["viewType": "Text",
                                                   "property":["size": 16,"alpha": 0.5, "alignment": "left", "color": "#C7D2EC", "height": 16, "content":"所在地区", "id": "2"]],
                                               
                                               ["viewType": "ImageView",
                                                "property":["height": 16,"width": 16, "id": "1",
                                                            "content": "personal_icon_local.png"]],
                                               
                                               ["viewType": "Text",
                                               "property":["size": 16, "alignment": "left", "color": "#C7D2EC", "height": 16, "content":"广东省广州市", "id": "3", "expressionSetters": ["content": "cityName"]]]
                                           ]
                                       ]
                            
                            ]
                        ],
                        
                        "templates_3": ["viewType": "View",
                                        "property": ["margin":[0, 0, 10, 10], "radiusLoction": [0, 0, 0, 0], "backgroundColor": "#20222E", "action": ["name": "showPage", "params": ["pageId": "0"]], "expressionSetters": ["action": "params", "radiusLoction": "radius"]],
                         
                         // actionParams 为需要参数对应的  state 节点状态 选中、未选中、隐藏
                         "subViews": [
                                [
                                           "viewType": "StackView",
                                           "property": ["axis":"horizontal", "distribution": "fill", "alignment": "center", "space": 10, "margin":[22, 22, 22, 16]],
                                           "subViews": [
                                               ["viewType": "Text",
                                                "property":["size": 16,"alpha": 0.5, "alignment": "left", "color": "#C7D2EC", "height": 20, "content":"头像", "id": "2", "expressionSetters": ["content": "name"]]],
                                               
                                               ["viewType": "Text",
                                               "property":["size": 16, "alignment": "left", "color": "#C7D2EC", "height": 20, "content":"张三", "id": "3", "expressionSetters": ["content": "description"]]],
                                               
                                               ["viewType": "ImageView",
                                                "property":["height": 11,"width": 7, "id": "4", "content": "iocn_my_home_back.png"]]
                                           ]
                                       ]
                            
                            ]
                        ]
                        
                                    ],
                    "subViews": [
                        
                        // header
                       [
                        "viewType": "View",
                        "property": ["height":54],
                        "subViews": [
                            ["viewType": "ImageView",
                             "property":["margin":[10, 10, 15], "size": 13, "width": 28, "content":"arrow_left.png", "id": "12", "action": ["name": "pop", "params": ["key": "value"]]],
                            ],

                            ["viewType": "Text",
                             "property":["size": 16, "isBold": 1, "alignment": "center", "color": "#ffffff", "height": 28, "width": 200, "content":" 个人资料", "centerParent":1, "id": "16", "expressionSetters": ["content": "header.title"]]]
                        ]
                        
                       ],
                       
                       // body
                       [
                           "viewType": "TableView",
                           "property": ["style": "group", "color": "#0C0E13", "separatorStyle": "none"],
                           "subViews": [
                               // footer
                               ["viewType": "View",
                                "property": ["width": -1, "height": 100, "layoutType": "absolute"],
                                    "subViews": [
                                       
                                       ["viewType": "Button",
                                        "property":["size": 16, "alignment": "center", "color": "#FF5454", "backgroundColor": "#1E232D", "content":"退出登录", "id": "13", "margin":[16, 0, 10, 10], "cornerRadius": 15]]
                                    ]
                               ]
                           ]
                       ],
                    ]
]



let UserMessageDataSource2: [String : Any] = [

"header": ["title": "个人资料"],
"sections": [
    ["header": "", "list": [
        ["headerIcon": "default_head.png", "4": "iocn_my_home_back.png", "params":["pageId": "3"], "identifier": "templates_1"]
        ]],
    
    ["header": "", "list": [
        ["name":"姓名","description": "陈琪", "params":["pageId": "3"], "identifier": "templates_3", "radius":[15,15,0,0]],
        ["name":"性别","description": "男", "params":["pageId": "4"], "identifier": "templates_3", "radius":[0,0,15,15]]
        ]],
    ["header": "", "list": [
        ["4": "iocn_my_home_back.png", "params":["pageId": "1"],"cityName":"湖南省郴州市", "identifier": "templates_2"]
    ]],
    ["header": "", "list": [
    ["name":"微信账号","description": "未绑定", "params":["pageId": "2"], "identifier": "templates_3", "radius":[15,15,0,0]],
    ["name":"登录手机号","description": "137*****123", "params":["pageId": "3"], "identifier": "templates_3", "radius":[0,0,15,15]]
    ]]
    ]
]
