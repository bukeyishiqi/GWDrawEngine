//
//  GroupMemberListPageJson.swift
//  GWDrawEngine
//
//  Created by 陈琪 on 2020/6/24.
//  Copyright © 2020 Chen. All rights reserved.
//

import Foundation



let GroupMemberListPageJson: [String: Any] = [
                    "viewType": "StackView",
                    "property": ["axis":"vertical", "distribution": "fill", "alignment": "fill", "space": 0, "height":-1, "width": -1, "margin":[0, 0, 10, 10], "color": "#0C0E13"],
                    
    
                    "state":["selectedlList": [], "commitButtonState": "state2", "reducer": [
                        "selected": [
                        ["commitButtonState", "selectedlList", ">", "state1"],
                        ["commitButtonState", "selectedlList", "<=", "state2"]]
                    ]],

                    "templates": [
                       "templates_1": ["viewType": "View",
                                       "property":["height":72,"margin":[0, 0, 0, 0], "isSelected": 0, "action": ["name": "selected", "params": ["selectedElement": "${cityId}", "connectState": "selectedlList"]]],
                                        
                        
                         "subViews": [
                                [
                                           "viewType": "StackView",
                                           "property": ["axis":"horizontal", "distribution": "fill", "alignment": "center", "space": 10, "margin":[0, 0, 0, 0]],
                                           "subViews": [
                                               
                                               ["viewType": "ImageView",
                                                "property":["size": 16, "alignment": "left", "color": "#97A0B4", "height": 48,"width": 48, "id": "1", "content": "${headerIcon}"]],
                                               [
                                                   "viewType": "StackView",
                                                   "property": ["axis":"vertical", "distribution": "fill", "space": 10, "height":0, "width": 0],
                                
                                                    "subViews": [
                                                       ["viewType": "Text",
                                                        "property":["size": 16, "alignment": "left", "color": "#97A0B4", "height": 20, "content":"${name}", "id": "2"]],
                                                       ["viewType": "Text",
                                                       "property":["size": 16, "alignment": "left", "color": "#4E586E", "height": 20, "content":"${subTitle}", "id": "3"]]
                                                    ]
                                               ],
                                               
                                               ["viewType": "ImageView",
                                                
                                                "dynamicProperty":[
                                                    "currentState": "state1",
//                                                "connectState": [["connectState": "selectedlList"]],
                                                "stateList":[
                                                    "state1": ["viewType": "ImageView",
                                                               "property":["size": 16, "alignment": "left", "color": "#97A0B4", "height": 24,"width": 24, "id": "4", "content": "icon_xz_normat.png"]],
                                                    
                                                    "state2":["viewType": "ImageView",
                                                              "property":["size": 16, "alignment": "left", "color": "#97A0B4", "height": 24,"width": 24, "id": "4", "content": "default_selected_icon.png"]
                                                    ]]],
                                                
                                                "property":["size": 16, "alignment": "left", "color": "#97A0B4", "height": 24,"width": 24, "id": "4", "content": "icon_xz_normat.png", "selectedContent": "default_selected_icon.png"]]
                                           ]
                                       ]
                            
                            ]
                        ]
                            
    
                    ],
                    "subViews": [
                        // header
                        [
                            "viewType": "StackView",
                            "property": ["axis":"vertical", "distribution": "fill", "alignment": "fill", "space": 0, "height":44, "width": -1],
                            "subViews": [
                               ["viewType": "Text",
                                "property":["size": 13, "alignment": "center", "color": "#ffffff", "height": 20, "content":"超级播学院1111", "id": "10", "expressionSetters": ["content": "header.title"]]],
                               
                               ["viewType": "Text",
                                "property":["size": 13, "alignment": "center", "color": "#FF5454", "height": 20, "content":"移除学员11111", "id": "11", "expressionSetters": ["content": "header.tips"]]]
//                                "expressionSetters": ["propertyKey", "取值Data路径"]
                            ]

                        ],
                        // body
                        [
                            "viewType": "TableView",
                            "property": ["style": "group", "color": "#0C0E13", "separatorStyle": "none"],
                            
                            "dynamicSections": [

                                ["header": "", "list": ["rowItems": "${sections.list}", "rowIdentifier": "1", "identifierMap": ["1":"templates_1"]]]
                                // rowItems 为接口返回的行数，${item.type}为区别单行的标识，通过identifier中映射需要的模板类型
                            ],
                            "subViews": [
                                
                            ]
                        ],
                        
                        
                        // bootom
                       [
                           "viewType": "StackView",
                           "property": ["axis":"horizontal", "distribution": "equalSpacing", "alignment": "center", "space": 0, "height":44, "width": -1],
                           "subViews": [
                              ["viewType": "ImageView",
                               "property":["size": 13, "alignment": "center", "color": "#ffffff", "height": 40, "width": 40, "content":"arrow_left.png", "id": "12", "action": ["name": "pop", "params": ["key": "value"]]],
                               
                              ],
                              
                              ["viewType": "Button",
                               
                               "dynamicProperty":["currentState": "state2",
                                                  // 监听当前当前状态容器下的相关状态属性 commitButtonState
                                       "connectState": [["connectState": "commitButtonState"]],
                                       "stateList":[
                                        "state1": ["viewType": "Button",
                                                   "property":["size": 16, "alignment": "center", "color": "#FF5454", "height": 20, "content":"确定", "action": ["name": "commit", "params": ["connectState": "selectedlList"]]]
                                        ],
                                           
                                           "state2":["viewType": "ImageView",
                                            "property":["size": 13, "alignment": "center", "color": "#ffffff", "height": 40, "width": 40, "content":"arrow_left.png"],
                                            
                                           ]]]
                               
                               ]
                           ]  // 当前节点状态可能会关联多个根节点状态

                       ]
                    ]
]


let RequestGroupMemberListPageJson: [String: Any] = [
    "version": "1",
    "template": [
                        "container":"ListContainer",
                        "viewType": "StackView",
                        "property": ["axis":"vertical", "distribution": "fill", "alignment": "fill", "space": 0, "height":-1, "width": -1, "margin":[0, 0, 10, 10], "color": "#0C0E13"],
                        
                        // 声明页面初始状态 reducer处理各状态直接关联业务逻辑
                        "state":["selectedlList": [], "commitButtonState": "state1", "reducer": [
                                                                                            ["commitButtonState", "selectedlList", ">", "state1"],
                                                                                            ["commitButtonState", "selectedlList", "<=", "state2"]]],
        
                        "templates": [
                           "templates_1": ["viewType": "View",
                                           "property":["height":72,"margin":[0, 0, 0, 0], "isSelected": 0, "action": ["actionType": "selected", "params": ["selectedElement": "${cityId}", "connectState": "selectedlList"]]],
                                            
                            
                             "subViews": [
                                    [
                                               "viewType": "StackView",
                                               "property": ["axis":"horizontal", "distribution": "fill", "alignment": "center", "space": 10, "margin":[0, 0, 0, 0]],
                                               "subViews": [
                                                   
                                                   ["viewType": "ImageView",
                                                    "property":["size": 16, "alignment": "left", "color": "#97A0B4", "height": 48,"width": 48, "id": "1", "content": "${headerIcon}"]],
                                                   [
                                                       "viewType": "StackView",
                                                       "property": ["axis":"vertical", "distribution": "fill", "space": 10, "height":0, "width": 0],
                                    
                                                        "subViews": [
                                                           ["viewType": "Text",
                                                            "property":["size": 16, "alignment": "left", "color": "#97A0B4", "height": 20, "content":"${name}", "id": "2"]],
                                                           ["viewType": "Text",
                                                           "property":["size": 16, "alignment": "left", "color": "#4E586E", "height": 20, "content":"${subTitle}", "id": "3"]]
                                                        ]
                                                   ],
                                                   
                                                   ["viewType": "ImageView",
                                                    
                                                    "dynamicProperty":[
                                                        "currentState": "state1",
    //                                                "connectState": [["connectState": "selectedlList"]],
                                                    "stateList":[
                                                        "state1": ["viewType": "ImageView",
                                                                   "property":["size": 16, "alignment": "left", "color": "#97A0B4", "height": 24,"width": 24, "id": "4", "content": "icon_xz_normat.png"]],
                                                        
                                                        "state2":["viewType": "ImageView",
                                                                  "property":["size": 16, "alignment": "left", "color": "#97A0B4", "height": 24,"width": 24, "id": "4", "content": "default_selected_icon.png"]
                                                        ]]],
                                                    
                                                    "property":["size": 16, "alignment": "left", "color": "#97A0B4", "height": 24,"width": 24, "id": "4", "content": "icon_xz_normat.png", "selectedContent": "default_selected_icon.png"]]
                                               ]
                                           ]
                                
                                ]
                            ]
                                
        
                        ],
                        "subViews": [
                            // header
                            [
                                "viewType": "StackView",
                                "property": ["axis":"vertical", "distribution": "fill", "alignment": "fill", "space": 0, "height":44, "width": -1],
                                "subViews": [
                                   ["viewType": "Text",
                                    "property":["size": 13, "alignment": "center", "color": "#ffffff", "height": 20, "content":"超级播学院1111", "id": "10", "expressionSetters": ["content": "header.title"]]],
                                   
                                   ["viewType": "Text",
                                    "property":["size": 13, "alignment": "center", "color": "#FF5454", "height": 20, "content":"移除学员11111", "id": "11", "expressionSetters": ["content": "header.tips"]]]
    //                                "expressionSetters": ["propertyKey", "取值Data路径"]
                                ]

                            ],
                            // body
                            [
                                "viewType": "TableView",
                                "property": ["style": "group", "color": "#0C0E13", "separatorStyle": "none"],
                                
                                "dynamicSections": [

                                    ["header": "", "list": ["rowItems": "${sections.list}", "rowIdentifier": "1", "identifierMap": ["1":"templates_1"]]]
                                    // rowItems 为接口返回的行数，${item.type}为区别单行的标识，通过identifier中映射需要的模板类型
                                ],
                                "subViews": [
                                    
                                ]
                            ],
                            
                            
                            // bootom
                           [
                               "viewType": "StackView",
                               "property": ["axis":"horizontal", "distribution": "equalSpacing", "alignment": "center", "space": 0, "height":44, "width": -1],
                               "subViews": [
                                  ["viewType": "ImageView",
                                   "property":["size": 13, "alignment": "center", "color": "#ffffff", "height": 40, "width": 40, "content":"arrow_left.png", "id": "12", "action": ["actionType": "pop", "params": ["key": "value"]]],
                                   
                                  ],
                                  
                                  ["viewType": "Button",
                                   
                                   "dynamicProperty":["currentState": "state2",
                                              // 监听当前当前状态容器下的相关状态属性 commitButtonState
                                   "connectState": [["connectState": "commitButtonState"]],
                                   "stateList":[
                                    "state1": ["viewType": "Button",
                                               "property":["size": 16, "alignment": "center", "color": "#FF5454", "height": 20, "content":"确定", "action": ["actionType": "commit", "params": ["connectState": "selectedlList"]]]
                                    ],
                                       
                                       "state2":["viewType": "ImageView",
                                        "property":["size": 13, "alignment": "center", "color": "#ffffff", "height": 40, "width": 40, "content":"arrow_left.png"],
                                        
                                       ]]]
                                   
                                   ]
                               ]  // 当前节点状态可能会关联多个根节点状态

                           ]
                        ]
    ],
    "serviceData": [
        "sections": [
            "list": [
                ["headerIcon": "default_head", "name": "1", "subTitle": "北京市，密11云县1", "4": "icon_xz_normat.png", "cityId": "11", "identifier": "templates_1", "params": ["selectedElement": "1", "connectState": "selectedlList"]],
                
                   ["headerIcon": "default_head", "name": "2", "subTitle": "北京市，密11云县2", "4": "icon_xz_normat.png", "cityId": "12", "identifier": "templates_1",
                     "params": ["selectedElement": "2", "connectState": "selectedlList"]
                    ],
                   
                   ["headerIcon": "default_head", "name": "3", "subTitle": "北京市，密11云县3", "4": "icon_xz_normat.png", "cityId": "13", "identifier": "templates_1",
                    "params": ["selectedElement": "3", "connectState": "selectedlList"]

                    ]
            ]
        ]
    ]
]









let ModuleDataSource3: [String: Any] = [
    "header": ["title": "超级播商学院", "tips": "移除成员"],
    "sections": [
        ["header": "", "list": [
            ["headerIcon": "default_head", "name": "1", "subTitle": "北京市，密11云县1", "4": "icon_xz_normat.png", "cityId": "11", "identifier": "templates_1", "params": ["selectedElement": "1", "connectState": "selectedlList"]],
            
               ["headerIcon": "default_head", "name": "2", "subTitle": "北京市，密11云县2", "4": "icon_xz_normat.png", "cityId": "11", "identifier": "templates_1",
                 "params": ["selectedElement": "2", "connectState": "selectedlList"]
                ],
               
               ["headerIcon": "default_head", "name": "3", "subTitle": "北京市，密11云县3", "4": "icon_xz_normat.png", "cityId": "11", "identifier": "templates_1",
                "params": ["selectedElement": "3", "connectState": "selectedlList"]

                ]
        ]
        ]
    ]
]
