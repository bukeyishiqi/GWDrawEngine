//
//  MyPageJson.swift
//  GWDrawEngine
//
//  Created by CQ on 2020/6/28.
//  Copyright © 2020 Chen. All rights reserved.
//

import Foundation

//let MyPageJson: [String: Any] = [
//                    "container":"ListContainer",
//                    "viewType": "StackView",
//                    "property": ["axis":"vertical", "distribution": "fill", "alignment": "fill", "space": 0, "height":-1, "width": -1, "margin":[0, 0, 0, 0], "color": "#0C0E13"],
//
//                    "templates": [
//                    "templates_1": ["viewType": "View",
//                      "property": ["height":-1,"margin":[0, 0, 0, 0], "backgroundColor": "#20222E", "action": ["name": "showPage", "params": ["pageId": "${pageId}"]]],
//
//                      // actionParams 为需要参数对应的
//                      "subViews": [
//                             [
//                                        "viewType": "StackView",
//                                        "property": ["axis":"horizontal", "distribution": "fill", "alignment": "center", "space": 10, "margin":[10, 10, 16, 16]],
//                                        "subViews": [
//
//                                            ["viewType": "ImageView",
//                                             "property":["height": 20,"width": 20, "id": "1",
//                                                         "content": "${headerIcon}"]],
//                                             ["viewType": "Text",
//                                              "property":["size": 16, "alignment": "left", "color": "#ffffff", "height": 20, "content":"${name}", "id": "2"]],
//
//                                             ["viewType": "Text",
//                                               "property":["size": 16, "alignment": "left", "color": "#ffffff", "height": 20, "content":"${subTitle}", "id": "3"]],
//
//                                            ["viewType": "ImageView",
//                                             "property":["size": 16, "alignment": "left", "color": "#97A0B4", "height": 24,"width": 24, "id": "4", "content": "iocn_my_home_back.png"]]
//                                        ]
//                                    ]
//
//                         ]
//                     ],
//                    "templates_2": ["viewType": "View",
//                      "property": ["height":-1,"margin":[0, 0, 0, 0], "backgroundColor": "#20222E", "action": ["name": "showPage", "params": ["pageId": "${pageId}"]]],
//
//                      // actionParams 为需要参数对应的
//                      "subViews": [
//                             [
//                                        "viewType": "StackView",
//                                        "property": ["axis":"horizontal", "distribution": "fill", "alignment": "center", "space": 10, "margin":[10, 10, 16, 16]],
//                                        "subViews": [
//
//                                            ["viewType": "ImageView",
//                                             "property":["height": 80,"width": 80, "id": "1",
//                                                         "content": "${headerIcon}"]],
//                                             ["viewType": "Text",
//                                              "property":["size": 16, "alignment": "left", "color": "#ffffff", "height": 20, "content":"${name}", "id": "2"]],
//
//                                            ["viewType": "ImageView",
//                                             "property":["size": 16, "alignment": "left", "color": "#97A0B4", "height": 24,"width": 24, "id": "4", "content": "iocn_my_home_back.png"]]
//                                        ]
//                                    ]
//
//                         ]
//                     ]
//                    ],
//
//                    "subViews": [
//                        // header
//                        ["viewType": "View",
//                         "subViews": [
//                            ["viewType": "Text",
//                            "property":["size": 26, "isBold": 1, "alignment": "left", "color": "#ffffff", "height": 60, "content":"我的", "margin":[0, 0, 10, 10], "id": "10"]]
//                            ]
//                        ],
//                        // body
//                        [
//                            "viewType": "TableView",
//                            "property": ["style": "group", "color": "#0C0E13", "separatorColor": "#333333", "separatorStyle": "singleLine"],
//
//                            // 静态页面布局
//                            "staticSections": [
//                                ["header": "", "list": [
//                                    ["headerIcon": "${accountService.img_face}", "name": "${accountService.nickname}", "pageId": "setting", "identifier": "templates_2"]
//                                    ]]
//                                ,
//                                ["header": "", "list": [
//                                    ["headerIcon": "icon_myhome_qianbao", "name": "我的超G企业", "subTitle": "${supergroupService.total}", "4": "iocn_my_home_back.png", "pageId": "myBusiness", "identifier": "templates_1"],
//                                    ["headerIcon": "icon_myhome_qianbao", "name": "关于超G办公", "subTitle": "", "4": "iocn_my_home_back.png", "pageId": "about","identifier": "templates_1"],
//                                    ["headerIcon": "icon_myhome_qianbao", "name": "帮助", "subTitle": "", "4": "iocn_my_home_back.png","pageId": "helper", "identifier": "templates_1"]
//                                    ] ]
//                            ],
//
//                            "subViews": [
//
//                            ]
//                        ],
//
//                        // bootom
//                       [
//                        "viewType": "View",
//                        "property": ["height":44],
//                        "subViews": [
//                            ["viewType": "StackView",
//                                "property": ["axis":"horizontal", "distribution": "equalSpacing", "alignment": "center", "space": 0,  "margin":[0, 0, 10, 10], "width": -1],
//                                "subViews": [
//                                   ["viewType": "ImageView",
//                                    "property":["size": 13, "alignment": "center", "color": "#ffffff", "height": 20, "width": 40, "content":"arrow_left.png", "id": "12", "action": ["name": "pop"]],
//
//                                   ],
//
//                                   ["viewType": "Button",
//                                   "property":["size": 16, "alignment": "center", "color": "#FF5454", "height": 20, "width": 40, "content":"", "id": "13"]]
//                                ]
//
//                           ]
//                        ]
//
//                       ]
//                    ]
//]




let RequestMyPageJson: [String: Any] = [
    "version": "0",
    "template": [
                        "viewType": "StackView",
                        "property": ["axis":"vertical", "distribution": "fill", "alignment": "fill", "space": 0, "height":-1, "width": -1, "margin":[0, 0, 0, 0], "backgroudColor": "#0C0E13"],
                        
                        "templates": [
                        "templates_1": ["viewType": "View",
                          "property": ["height":-1,"margin":[0, 0, 0, 0], "backgroundColor": "#20222E", "action": ["actionType": "showPage", "params": ["pageId": "${pageId}"]]],
                          
                          // actionParams 为需要参数对应的
                          "subViews": [
                                 [
                                            "viewType": "StackView",
                                            "property": ["axis":"horizontal", "distribution": "fill", "alignment": "center", "space": 10, "margin":[10, 10, 16, 16]],
                                            "subViews": [
                                                
                                                ["viewType": "ImageView",
                                                 "property":["height": 20,"width": 20, "id": "1",
                                                             "content": "${headerIcon}"]],
                                                 ["viewType": "Text",
                                                  "property":["size": 16, "alignment": "left", "color": "#ffffff", "height": 20, "content":"${name}", "id": "2"]],
                                                 
                                                 ["viewType": "Text",
                                                   "property":["size": 16, "alignment": "left", "color": "#ffffff", "height": 20, "content":"${subTitle}", "id": "3"]],
                                                
                                                ["viewType": "ImageView",
                                                 "property":["size": 16, "alignment": "left", "color": "#97A0B4", "height": 24,"width": 24, "id": "4", "content": "iocn_my_home_back.png"]]
                                            ]
                                        ]
                             
                             ]
                         ],
                        "templates_2": ["viewType": "View",
                          "property": ["height":-1,"margin":[0, 0, 0, 0], "backgroundColor": "#20222E", "action": ["actionType": "showPage", "params": ["pageId": "${pageId}"]]],
                          
                          // actionParams 为需要参数对应的
                          "subViews": [
                                 [
                                            "viewType": "StackView",
                                            "property": ["axis":"horizontal", "distribution": "fill", "alignment": "center", "space": 10, "margin":[10, 10, 16, 16]],
                                            "subViews": [
                                                
                                                ["viewType": "ImageView",
                                                 "property":["height": 80,"width": 80,"cornerRadius": 40, "id": "1",
                                                             "content": "${headerIcon}"]],
                                                 ["viewType": "Text",
                                                  "property":["size": 16, "alignment": "left", "color": "#ffffff", "height": 20, "content":"${name}", "id": "2"]],
                                                
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
                                "property":["size": 26, "isBold": 1, "alignment": "left", "color": "#ffffff", "height": 60, "content":"我的", "margin":[0, 0, 10, 10], "id": "10"]]
                                ]
                            ],
                            // body
                            [
                                "viewType": "TableView",
                                "property": ["style": "group", "color": "#0C0E13", "separatorColor": "#333333", "separatorStyle": "singleLine"],
                                
                                // 静态页面布局
                                "staticSections": [
                                    ["header": "", "list": [
                                        ["headerIcon": "${accountService.img_face}", "name": "${accountService.nickname}", "pageId": "setting", "identifier": "templates_2"]
                                        ]]
                                    ,
                                    ["header": "", "list": [
                                        ["headerIcon": "icon_myhome_qianbao", "name": "我的超G企业", "subTitle": "${supergroupService.total}", "4": "iocn_my_home_back.png", "pageId": "myBusiness", "identifier": "templates_1"],
                                        ["headerIcon": "icon_myhome_qianbao", "name": "关于超G办公", "subTitle": "", "4": "iocn_my_home_back.png", "pageId": "about","identifier": "templates_1"],
                                        ["headerIcon": "icon_myhome_qianbao", "name": "帮助", "subTitle": "", "4": "iocn_my_home_back.png","pageId": "helper", "identifier": "templates_1"]
                                        ] ]
                                ],
                                
                                "subViews": [
                                    
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
                                        "property":["size": 13, "alignment": "center", "color": "#ffffff", "height": 20, "width": 40, "content":"arrow_left.png", "id": "12", "action": ["actionType": "pop"]],
                                        
                                       ],
                                       
                                       ["viewType": "Button",
                                       "property":["size": 16, "alignment": "center", "color": "#FF5454", "height": 20, "width": 40, "content":"", "id": "13"]]
                                    ]

                               ]
                            ]
                            
                           ]
                        ]
    ],
    "serviceData": ""
]
