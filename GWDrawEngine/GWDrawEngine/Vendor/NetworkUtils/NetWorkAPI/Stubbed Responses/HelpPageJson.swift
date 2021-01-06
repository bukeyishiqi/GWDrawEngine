//
//  AboutPageJson.swift
//  GWDrawEngine
//
//  Created by CQ on 2020/6/28.
//  Copyright © 2020 Chen. All rights reserved.
//

import Foundation


let HelpPageJson: [String: Any] = [
                    "viewType": "StackView",
                    "property": ["axis":"vertical", "distribution": "fill", "alignment": "fill", "space": 0, "height":-1, "width": -1, "margin":[0, 0, 0, 0], "color": "#0C0E13"],
                    
                    "templates": [
                       "templates_1": ["viewType": "View",
                         "property": ["height":-1,"margin":[0, 0, 0, 0], "backgroundColor": "#20222E", "action": ["name": "showPage", "params": ["pageId": "0"]], "expressionSetters": ["action": "params"]],
                         
                         // actionParams 为需要参数对应的  state 节点状态 选中、未选中、隐藏
                         "subViews": [
                                [
                                           "viewType": "StackView",
                                           "property": ["axis":"horizontal", "distribution": "fill", "alignment": "center", "space": 10, "margin":[10, 10, 16, 16]],
                                           "subViews": [
                                                ["viewType": "ImageView",
                                                "property":["height": 60,"width": 60, "id": "1",
                                                            "content": "icon_myhome_qiye.png", "expressionSetters": ["content": "headerIcon", "height": "height", "width": "width"]]],
                                                ["viewType": "Text",
                                                 "property":["size": 16, "alignment": "left", "color": "#ffffff", "height": 20, "content":"我的超级企业", "id": "2",  "expressionSetters": ["content": "name", "isBold": "isBold"]]],
                                                
                                                ["viewType": "Text",
                                                 "property":["size": 16, "alignment": "left", "color": "#ffffff", "height": 20, "content":"3", "id": "3", "expressionSetters": ["content": "subTitle", "size": "minSize"]]],
                                               
                                               ["viewType": "ImageView",
                                                "property":["size": 16, "alignment": "left", "color": "#97A0B4", "height": 24,"width": 24, "id": "4", "content": "iocn_my_home_back.png"]]
                                           ]
                                       ]
                            
                            ]
                        ]
            
                    ],
                    "subViews": [
                        // header
                        ["viewType": "View",
                         "subViews": [
                            ["viewType": "Text",
                            "property":["size": 26, "isBold": 1, "alignment": "left", "color": "#ffffff", "height": 60, "content":" 我的", "margin":[0, 0, 10, 10], "id": "10", "expressionSetters": ["content": "header.title"]]]
                            ]
                        ],
                        // body
                        [
                            "viewType": "TableView",
                            "property": ["style": "group", "color": "#0C0E13", "separatorColor": "#333333", "separatorStyle": "singleLine"],
                            "subViews": [
                                
                            ]
                        ],
                        
                        // bootom
                       [
                        "viewType": "View",
                        "property": ["height":44],
                        "subViews": [
                            ["viewType": "StackView",
                                "property": ["axis":"horizontal", "distribution": "equalSpacing", "alignment": "center", "space": 0,  "margin":[0, 0, 10, 10], "width": -1],
                                "subViews": [
                                   ["viewType": "ImageView",
                                    "property":["size": 13, "alignment": "center", "color": "#ffffff", "height": 20, "width": 40, "content":"arrow_left.png", "id": "12", "action": ["name": "pop", "params": ["key": "value"]]],
                                    
                                   ],
                                   
                                   ["viewType": "Button",
                                   "property":["size": 16, "alignment": "center", "color": "#FF5454", "height": 20, "width": 40, "content":"", "id": "13"]]
                                ]

                           ]
                        ]
                        
                       ]
                    ]
]


let HelpPageDataSource2: [String : Any] = [

"header": ["title": "帮助"],
"sections": [
    ["header": "", "list": [
        ["headerIcon":"bz_rgfw_icon.png","name": "人工客服", "subTitle": "", "4": "iocn_my_home_back.png", "params":["pageId": "1"], "identifier": "templates_1"],
        ["headerIcon":"bz_appjc_icon.png", "name": "APP检测", "subTitle": "", "4": "iocn_my_home_back.png", "identifier": "templates_1"],
        ["headerIcon":"bz_appjc_icon.png", "name": "用户指南", "subTitle": "", "4": "iocn_my_home_back.png", "identifier": "templates_1"]
        ] ]
    ]
]
