//
//  HasConfirmMemberJson.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/25.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation


let HasConfirmMemberJson: [String: Any] = [
    "version": "0",
    "template": [
                        "viewType": "StackView",
                        "property": ["axis":"vertical", "distribution": "fill", "alignment": "fill", "space": 0, "margin":[0, 0, 0, 0], "backgroudColor": "#0F1219"],
            
                        // 声明页面初始状态 reducer处理各状态直接关联业务逻辑
                        "state":["list": "${memberList}",
                                 "navTitle": "已确认(0)",
                                 "bottomType": "1", // 底部状态，1显示未确认文案人事，2 操作
                                 "reducer":[
                                    ["connectStateKey": "navTitle", "condition": ["operator": "getCount", "param": ["list"]], "returnValue": "已确认(%@)"]
                            ]],
                        "subViews": [
                            
                            // header
//                            ["templateType": "navHeader_1",
//                             "property": ["title": "${navTitle}"]
//                            ],
                           
                            ["templateType": "navHeader_1",
                             "property": ["title": "${navTitle}", "item1": "预告2", "actionType1": "showPage", "actionParam1": ["pageId": "MeetingPreviewPage"]]
                            ],
                            
                           // body
                           [
                               "viewType": "TableView",
                               "property": ["style": "plan", "color": "#0C0E13", "separatorStyle": "none"],

                                  // 模板数据映射关系
                               "templatesReflect": [
                                "templates_6": ["headerIcon": "${memberHeader}","title": "${memberName}", "subTitle": "${subTitle}", "status": "${status}", "level": "${level}"],
                               ],

                               "dynamicSections": [
                                   ["header": "", "list": ["rowItems": "${list}", "rowIdentifier": "1", "identifierMap": ["1":"templates_6"]]]
                               ],
                               "subViews": [
                                   
                               ]
                           ],
  
                           ["viewType": "View",
                            "dynamicProperty":[
                                "currentState": "1",
                                "connectState": "bottomType", // 关联的状态值获取后替换currentState

                                "stateList": [
                                    "1": ["viewType": "View",
                                          "property": ["height":98, "action": ["actionType": "updateState", "params": ["connectState": "bottomType", "value": "2"]]],
                                       
                                       "subViews": [
                                            ["viewType": "View",
                                                "property": ["margin":[8, 8, 15, 15],  "cornerRadius": 16,  "backgroudColor": "#272F3E"],
                                                
                                                "subViews": [
                                                    ["viewType": "Text",
                                                     "property":["size": 17, "numberOfLines":2, "alignment": "left", "color": "#FFFFFF", "marginLeft": 18, "centerY": 0, "height": 48, "width": 130, "content":"还有96位成员未确认会议通知"]],
                                                    
                                                    ["viewType": "ImageView",
                                                    "property":["contentMode":1, "height": 16,"width": 12, "marginRight": 15, "centerY": 0, "content": "list_icon_more_1216.png"]]
                                                ]
                                            ]
                                        
                                        ]
                                    ],
                                    
                                    "2": ["viewType": "View",
                                     "property": ["height":122],
                                       
                                       "subViews": [
                                           ["viewType": "Text",
                                            "property":["size": 17, "alignment": "center", "color": "#FFFFFF", "centerX": 0, "width": 100, "height": 24, "content":"再次通知"]],
                                           
                                           
                                           ["viewType": "StackView",
                                            "property": ["axis":"horizontal", "distribution": "equalSpacing", "alignment": "fill", "marginLeft": 40, "marginRight": 40,"marginTop":37, "marginBottom": 13, "height": 72],
                                            
                                            "subViews": [
                                                [
                                                    "viewType": "StackView",
                                                    "property": ["axis":"vertical", "distribution": "fill", "alignment": "center", "space": 4],
                                                    "subViews": [
                                                        ["viewType": "ImageView",
                                                         "property":["width": 54, "height": 54, "content": "tc_btn_preview_phone.png", "action": ["actionType": "showPopView", "params": ["popType": "popTemplate", "template": "inAppNotify_templates"]]]],
                                                        
                                                        ["viewType": "Text",
                                                        "property":["size": 10, "alignment": "center", "color": "#ffffff", "height": 14,"width": 70, "content":"应用内通知"]]
                                                    ]
                                                ],
                                                
                                                [
                                                    "viewType": "StackView",
                                                    "property": ["axis":"vertical", "distribution": "fill", "alignment": "center", "space": 4],
                                                    "subViews": [
                                                        ["viewType": "ImageView",
                                                         "property":["width": 54, "height": 54,"content": "tc_btn_preview_message.png", "action": ["actionType": "showPopView", "params": ["popType": "popTemplate", "template": "smsNotify_templates"]]]],
                                                        
                                                        ["viewType": "Text",
                                                        "property":["size": 10, "alignment": "center", "color": "#ffffff", "height": 14,"width": 70, "content":"短信通知"]]
                                                    ]
                                                ],
                                                
                                                [
                                                    "viewType": "StackView",
                                                    "property": ["axis":"vertical", "distribution": "fill", "alignment": "center", "space": 4],
                                                    "subViews": [
                                                        ["viewType": "ImageView",
                                                         "property":["width": 54, "height": 54,"content": "tc_btn_preview_call.png", "action": ["actionType": "showPopView", "params": ["popType": "popTemplate", "template": "phoneNotify_templates"]]]],
                                                        
                                                        ["viewType": "Text",
                                                         "property":["size": 10, "alignment": "center", "color": "#ffffff", "height": 14, "width": 70, "content":"智能电话通知"]]
                                                    ]
                                                ]
                                            
                                            ]
                                            
                                           ]
                                       ]
                                    ]
                                ]
                            
                            ]
                            ]
                           
                        ]
    ],
    "serviceData": [
        "memberList": [
            ["memberHeader": "default_head.png", "memberName": "张三", "subTitle": "浙江省，丽水区", "status": "1", "level": "1"],
            ["memberHeader": "default_head.png", "memberName": "李四", "subTitle": "浙江省，丽水区", "status": "2", "level": "20"],
            ["memberHeader": "default_head.png", "memberName": "王五", "subTitle": "浙江省，丽水区","status": "3", "level": "30"],
            ["memberHeader": "default_head.png", "memberName": "张三1", "subTitle": "浙江省，丽水区","status": "4", "level": "50"],
            ["memberHeader": "default_head.png", "memberName": "张三2", "subTitle": "浙江省，丽水区","status": "5", "level": "12"],
            ["memberHeader": "default_head.png", "memberName": "张三3", "subTitle": "浙江省，丽水区","status": "1", "level": "30"],
            ["memberHeader": "default_head.png", "memberName": "张三4", "subTitle": "浙江省，丽水区","status": "3", "level": "40"],
            ["memberHeader": "default_head.png", "memberName": "张三5", "subTitle": "浙江省，丽水区","status": "2", "level": "20"],
            ["memberHeader": "default_head.png", "memberName": "张三6", "subTitle": "浙江省，丽水区","status": "5", "level": "30"],
            ["memberHeader": "default_head.png", "memberName": "张三7", "subTitle": "浙江省，丽水区","status": "1", "level": "25"]
        ]

    ]
]




 // MARK:模板3 水平分布 样式：image (TEXT image)(H)
let templates_6: [String: Any] = ["viewType": "View",
               "property":["height":72,"margin":[0, 0, 0, 0]],
 "subViews": [
            ["viewType": "ImageView",
             "property":["contentMode":1, "height": 48,"width": 48, "marginLeft": 18, "centerY": 0, "content": "${headerIcon}"]],

            [
               "viewType": "StackView",
               "property": ["axis":"horizontal", "distribution": "fill", "alignment": "center", "marginLeft": 80, "centerY": 0, "height": 24, "space": 5],

                "subViews": [
                   ["viewType": "Text",
                    "property":["size": 17, "alignment": "left", "color": "#97A0B4", "height": 24, "content":"${title}"]],
                   
                   ["viewType": "View",
                   "dynamicProperty": [
                       "currentState": "1",
                       "connectState": "status", // 关联的状态值获取后替换currentState

                   "stateList": [
                   "1": ["viewType": "ImageView",
                       "property":["contentMode":1, "height": 17,"width": 36, "id": "1", "content": "icon_lv01.png"],
                       
                        "subViews": [
                            ["viewType": "Text",
                            "property":["size": 10, "height": 12,"width": 16, "marginLeft": 17, "centerY": 0, "alignment": "left", "color": "#FFFFFF", "content":"${level}"]]
                        ]
                    ],
                   "2": ["viewType": "ImageView",
                      "property":["contentMode":1, "height": 17,"width": 36, "id": "1", "content": "icon_lv02.png"],
                      
                       "subViews": [
                           ["viewType": "Text",
                           "property":["size": 10, "height": 12,"width": 16, "marginLeft": 17, "centerY": 0, "alignment": "left", "color": "#FFFFFF", "content":"${level}"]]
                       ]
                   ],
                   
                   "3": ["viewType": "ImageView",
                      "property":["contentMode":1, "height": 17,"width": 36, "id": "1", "content": "icon_lv03.png"],
                      
                       "subViews": [
                           ["viewType": "Text",
                           "property":["size": 10, "height": 12,"width": 16, "marginLeft": 17, "centerY": 0, "alignment": "left", "color": "#FFFFFF", "content":"${level}"]]
                       ]
                   ],
                   "4": ["viewType": "ImageView",
                      "property":["contentMode":1, "height": 17,"width": 36, "id": "1", "content": "icon_lv04.png"],
                      
                       "subViews": [
                           ["viewType": "Text",
                           "property":["size": 10, "height": 12,"width": 16, "marginLeft": 17, "centerY": 0, "alignment": "left", "color": "#FFFFFF", "content":"${level}"]]
                       ]
                   ],
                   "5":["viewType": "ImageView",
                      "property":["contentMode":1, "height": 17,"width": 36, "id": "1", "content": "icon_lv05.png"],
                      
                       "subViews": [
                           ["viewType": "Text",
                           "property":["size": 10, "height": 12,"width": 16, "marginLeft": 17, "centerY": 0, "alignment": "left", "color": "#FFFFFF", "content":"${level}"]]
                       ]
                   ]
                   
                   ]
                   ]
                   ]
                   
                ]
            ]
    
    ]
]






