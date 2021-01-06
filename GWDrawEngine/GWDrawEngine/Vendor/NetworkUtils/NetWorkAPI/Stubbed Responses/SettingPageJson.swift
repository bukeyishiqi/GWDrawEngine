//
//  SettingPageJson.swift
//  GWDrawEngine
//
//  Created by CQ on 2020/6/28.
//  Copyright © 2020 Chen. All rights reserved.
//

import Foundation

// 通过sateKey的值从 replaceSource获取对应状态值替换stateValue
// 取值方式 ${sex.statevalue.sex}  ${sex.statevalue.templates_1}
//["sex":["stateKey": "${accountService.sex}", "stateValue": ["":""], "replaceSource": ["1": ["sex": "男", "identifier": "templates_1"], "0": ["sex": "女", "identifier": "templates_2"]]]]


let RequestSettingPageJson: [String: Any] = [
    "version": "0",
    "template": [
                        "viewType": "StackView",
                        "needCallBack":1, // 是否需要回调
                        "property": ["axis":"vertical", "distribution": "fill", "alignment": "fill", "space": 0, "height":-1, "width": -1, "margin":[0, 0, 0, 0], "backgroudColor": "#0C0E13"],
                        
                        // 声明页面初始状态 reducer处理各状态直接关联业务逻辑
                        "state":["img_face": "${accountService.img_face}",
                                 "@sex": ["stateKey": "${accountService.sex}", "stateValue": ["":""],          "replaceSource": ["1": ["sex": "男"], "0": ["sex": "女"]],
                                          "popSelectSource": [["1": "男"], ["0": "女"]]
                                    ],
                                 "nickname": "${accountService.nickname}",
                                 
                                 "@age":["stateValue": "${accountService.age}",
                                     "popSelectSource": ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
                                 ],
                                 
                                 "address": "${accountService.home}"],
                        
                        "templates": [
                            "templates_1": ["viewType": "View",
                                            "property": ["height":50,"margin":[0, 0, 0, 0], "backgroundColor": "#20222E", "action": ["actionType": "${actionType}", "expressionParams": "${actionParam}"]],
                             
                             // expressionParams 参数变量，替换后复制给Action.params
                             "subViews": [
                                    [
                                               "viewType": "StackView",
                                               "property": ["axis":"horizontal", "distribution": "fill", "alignment": "center", "space": 10, "margin":[10, 10, 16, 16]],
                                               "subViews": [
                                                    ["viewType": "Text",
                                                     "property":["size": 16, "alignment": "left", "color": "#ffffff", "height": 20, "content":"${name}", "id": "2"]],
                                                    
                                                    ["viewType": "Text",
                                                     "property":["size": 16, "alpha": 0.5, "alignment": "left", "color": "#ffffff", "height": 20, "content":"${subTitle}", "id": "3"]],
                                                   
                                                   ["viewType": "ImageView",
                                                    "property":["size": 16, "alignment": "left", "color": "#97A0B4", "height": 24,"width": 24, "id": "4", "content": "iocn_my_home_back.png"]]
                                               ]
                                           ]
                                
                                ]
                            ],
                              
                            "templates_2": ["viewType": "View",
                             "property": ["height":50,"margin":[0, 0, 0, 0], "backgroundColor": "#20222E", "action": ["actionType": "showPage", "params": ["pageId": "${pageId}"]]],
                             
                             "subViews": [
                                    [
                                               "viewType": "StackView",
                                               "property": ["axis":"horizontal", "distribution": "fill", "alignment": "center", "space": 10, "margin":[10, 10, 16, 16]],
                                               "subViews": [
                                                   ["viewType": "Text",
                                                       "property":["size": 16, "alignment": "left", "color": "#ffffff", "height": 20, "content":"${name}", "id": "2"]],
                                                   
                                                   ["viewType": "ImageView",
                                                    "property":["height": 30,"width": 30, "cornerRadius": 15, "id": "1",
                                                                "content": "${headerIcon}"]],
                                                   
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
                                "property":["size": 26, "isBold": 1, "alignment": "left", "color": "#ffffff", "height": 60, "content":" 设置", "margin":[0, 0, 10, 10], "id": "10"]]
                                ]
                            ],
                            // body
                            [
                                "viewType": "TableView",
                                "property": ["style": "group", "color": "#0C0E13", "separatorColor": "#333333", "separatorStyle": "singleLine"],
                                // 静态页面布局
                                "staticSections": [
                                    ["header": "", "list": [
                                        
                                        ["name": "头像", "headerIcon": "${img_face}", "identifier": "templates_2", "actionType": ""],
                                        
                                        ["name": "姓名", "subTitle": "${nickname}", "identifier": "templates_1", "pageId": "editText", "actionType": "showPage", "actionParam": ["pageId": "editText", "name": "${nickname}"]],
                                        
                                        ["name": "性别", "subTitle": "${@sex.stateValue.sex}", "pageId": "PickerSelect", "identifier": "templates_1", "actionType": "showPopView",  "actionParam": ["popType": "PickerSelect", "title": "选择性别", "connectState": "@sex", "dataSource": "${@sex.popSelectSource}", "height": 200]],
                                        
                                            ["name": "年龄", "subTitle": "${@age.stateValue}","pageId": "PickerSelect", "identifier": "templates_1", "actionType": "showPopView",   "actionParam": ["popType": "PickerSelect", "title": "选择年龄", "connectState": "@age", "dataSource": "${@age.popSelectSource}", "height": 300]],
                                            
                                            
                                            ["name": "所在地区", "subTitle": "${address}", "identifier": "templates_1", "actionType": "showPopView"]
                                        
                                        ]]
                                ],
                                
                                "subViews": [
                                    
                                    // footer
                                    ["viewType": "View",
                                     "property": ["width": -1, "height": 100, "layoutType": "absolute"],
                                         "subViews": [
                                            
                                            ["viewType": "Button",
                                             "property":["size": 16, "alignment": "center", "color": "#ffffff", "backgroudColor": "#F54B64", "height": -1, "width": -1, "content":"退出登录", "id": "13", "margin":[30, 30, 30, 30], "cornerRadius": 8]]
                                         ]
                                    ]
                                ]
                            ],
                            
                            // bootom
                           [
                            "viewType": "View",
                            "property": ["height":50],
                            "subViews": [
                                ["viewType": "StackView",
                                    "property": ["axis":"horizontal", "distribution": "equalSpacing", "alignment": "center", "space": 0,  "margin":[0, 0, 10, 10], "width": -1],
                                    "subViews": [
                                       ["viewType": "ImageView",
                                        "property":["size": 13, "alignment": "center", "color": "#ffffff", "height": 20, "width": 40, "content":"arrow_left.png", "id": "12", "action": ["actionType": "pop", "params": ["key": "value"]]],
                                        
                                       ],
                                       
                                       ["viewType": "Button",
                                       "property":["size": 16, "alignment": "center", "color": "#FF5454", "height": 20, "width": 40, "content":"", "id": "13"]]
                                    ]

                               ]
                            ]
                            
                           ]
                        ]
    ]
]
