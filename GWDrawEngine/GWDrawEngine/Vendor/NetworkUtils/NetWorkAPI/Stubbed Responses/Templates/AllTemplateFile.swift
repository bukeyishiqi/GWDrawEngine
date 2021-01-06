//
//  AllTemplateFile.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/22.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation


 // MARK: 模板0 水平分布 样式：TXT Image
let templates_0: [String: Any] = ["viewType": "View",
                "property": ["margin":[0, 0, 0, 0], "backgroudColor": "#1E232D", "action": ["actionType": "${actionType}", "expressionParams": "${actionParam}"]],
 
 // actionParams 为需要参数对应的  state 节点状态 选中、未选中、隐藏
 "subViews": [
        [
                   "viewType": "StackView",
                   "property": ["axis":"horizontal", "distribution": "fill", "alignment": "center", "space": 10, "margin":[15, 15, 16, 16]],
                   "subViews": [
                       ["viewType": "Text",
                        "property":["size": 16, "alignment": "left", "color": "#97A0B4", "height": 24, "content":"${title}"]],
                       
                       ["viewType": "ImageView",
                        "property":["isSelected": "${isSelected}", "height": 24,"width": 24, "selectedContent": "${image}"]]
                   ]
               ]
    
    ]
]

 // MARK: 模板1 水平分布 样式：TXT TXT Image
let templates_1: [String: Any] = ["viewType": "View",
                "property": ["margin":[0, 0, 0, 0], "backgroudColor": "#141922", "action": ["actionType": "${actionType}", "expressionParams": "${actionParam}"]],
 
 // actionParams 为需要参数对应的  state 节点状态 选中、未选中、隐藏
 "subViews": [
        [
                   "viewType": "StackView",
                   "property": ["axis":"horizontal", "distribution": "fill", "alignment": "center", "space": 10, "margin":[15, 15, 16, 16]],
                   "subViews": [
                       ["viewType": "Text",
                        "property":["size": 16, "alignment": "left", "color": "#97A0B4", "height": 24, "content":"${title}", "id": "2"]],
                       
                       ["viewType": "Text",
                       "property":["size": 16, "alignment": "left", "color": "#C7D2EC", "height": 24, "content":"${subTitle}", "id": "3"]],
                       
                       ["viewType": "ImageView",
                        "property":["height": 16,"width": 16, "id": "4", "content": "icon_right_arrow.png"]]
                   ]
               ]
    
    ]
]

// MARK: 模板2 水平分布 样式：TXT Switch
let templates_2: [String: Any] = ["viewType": "View",
                "property": ["margin":[0, 0, 0, 0], "backgroudColor": "#141922"],
 
 // actionParams 为需要参数对应的  state 节点状态 选中、未选中、隐藏
 "subViews": [
        [
                   "viewType": "StackView",
                   "property": ["axis":"horizontal", "distribution": "fill", "alignment": "center", "space": 10, "margin":[15, 15, 16, 16]],
                   "subViews": [
                       ["viewType": "Text",
                        "property":["size": 16, "alignment": "left", "color": "#97A0B4", "height": 24, "content":"${name}", "id": "2"]],
                       
                       ["viewType": "Switch",
                        "property":["content": "${off}", "height": 24,"width": 41, "id": "4"]]
                   ]
               ]
    
    ]
]


 // MARK:模板3 水平分布 样式：image （TEXT，TEXT）(V)
let templates_3:[String: Any] = ["viewType": "View",
               "property":["height":72,"margin":[0, 0, 0, 0]],
 "subViews": [
        [
                   "viewType": "StackView",
                   "property": ["axis":"horizontal", "distribution": "fill", "alignment": "center", "space": 10, "margin":[12, 12, 16, 16]],
                   "subViews": [
                       
                       ["viewType": "ImageView",
                        "property":["contentMode":1, "height": 48,"width": 48, "id": "1", "content": "${headerIcon}"]],
                       [
                           "viewType": "StackView",
                           "property": ["axis":"vertical", "distribution": "fill", "space": 10],
        
                            "subViews": [
                               ["viewType": "Text",
                                "property":["size": 17, "alignment": "left", "color": "#97A0B4", "height": 24, "content":"${title}", "id": "2"]],
                               ["viewType": "Text",
                               "property":["size": 14, "alignment": "left", "color": "#4E586E", "height": 20, "content":"${subTitle}", "id": "3"]]
                            ]
                       ]
                   ]
               ]
    
    ]
]


 // MARK:模板4 水平分布 样式：Image （TEXT，TEXT）(V) Image
let templates_4: [String: Any] = ["viewType": "View",
              
              "property":["height":72,"margin":[0, 0, 0, 0],  "isSelected": 0,"action": ["actionType": "${actionType}", "expressionParams": "${actionParam}"]],
"subViews": [
       [
                  "viewType": "StackView",
                  "property": ["axis":"horizontal", "distribution": "fill", "alignment": "center", "space": 10, "margin":[12, 12, 16, 16]],
                  "subViews": [
                      
                      ["viewType": "ImageView",
                       "property":["contentMode":1, "height": 48,"width": 48, "id": "1", "content": "${headerIcon}"]],
                      
                      ["viewType": "StackView",
                       "property": ["axis":"vertical", "distribution": "fill", "space": 10],
       
                           "subViews": [
                              ["viewType": "Text",
                               "property":["size": 17, "alignment": "left", "color": "#97A0B4", "height": 24, "content":"${title}", "id": "2"]],
                              ["viewType": "Text",
                              "property":["size": 14, "alignment": "left", "color": "#4E586E", "height": 20, "content":"${subTitle}", "id": "3"]]
                           ]
                      ],
                      
                      ["viewType": "ImageView",
                       
//                                                           "dynamicProperty":[
//                                                              "currentState": "state1",
//                                                              "currentValue": "${memberName}",
//                                                              "connectState": "selectedlList",
//
//                                                              "reducer": [
//                                                                       ["connectStateKey": "currentState", "condition": ["operator": "contain", "param": ["connectState", "currentValue"]], "returnValue": "state1"],
//
//                                                                      ["connectStateKey": "currentState", "condition": ["operator": "unContain", "param": ["connectState", "currentValue"]], "returnValue": "state2"]
//                                                              ],
//
//                                                           "stateList":[
//                                                                "state1": ["size": 16, "alignment": "left", "color": "#97A0B4", "height": 24,"width": 24, "id": "4", "content": "icon_xz_normat.png"],
//
//                                                               "state2":["size": 16, "alignment": "left", "color": "#97A0B4", "height": 24,"width": 24, "id": "4", "content": "default_selected_icon.png"]]],
                       
                       
                       "property":["size": 16, "alignment": "left", "color": "#97A0B4", "height": 24,"width": 24, "id": "4", "content": "icon_xz_normat.png", "selectedContent": "default_selected_icon.png"]
                    ]
                  ]
              ]
   
   ]
]


// MARK:模板4 水平分布 样式：TEXT Image Image
let templates_8: [String: Any] = ["viewType": "View",
 "property": ["height":72, "margin":[0, 0, 0, 0], "backgroudColor": "#141922", "action": ["actionType": "showPage", "params": ["pageId": "${pageId}"]]],
 
 "subViews": [
        [
                   "viewType": "StackView",
                   "property": ["axis":"horizontal", "distribution": "fill", "alignment": "center", "space": 10, "margin":[10, 10, 16, 16]],
                   "subViews": [
                       ["viewType": "Text",
                           "property":["size": 16, "alignment": "left", "color": "#97A0B4", "height": 20, "content":"${title}", "id": "2"]],
                       
                       ["viewType": "ImageView",
                        "property":["height": 44,"width": 44, "cornerRadius": 22, "content": "${headerIcon}"]],
                       
                       ["viewType": "ImageView",
                        "property":["height": 16,"width": 16, "content": "icon_right_arrow.png"]]
                   ]
               ]
    
    ]
]



 // MARK: 会议预告列表样式
let templates_5: [String: Any] = ["viewType": "View",
 "property": ["margin":[4, 4, 15, 15],  "cornerRadius": 10, "backgroudColor": "#1E232D"],
 
 // actionParams 为需要参数对应的  state 节点状态 选中、未选中、隐藏
 "subViews": [
    
        [ // 头像人名
            "viewType": "StackView",
            "property": ["axis":"vertical", "distribution": "fill", "alignment": "fill", "space": 3, "marginTop":16, "marginLeft": 15, "width": 72, "marginBottom": 66],
            "subViews": [
                ["viewType": "ImageView",
                 "property":["content": "default_head.png", "contentMode": 1]],
                
                ["viewType": "Text",
                "property":["size": 14, "alignment": "center", "color": "#FFFFFF", "height": 20, "content":"${name}"]]
            ]
        ],
        [ // text垂直列表
            "viewType": "StackView",
            "property": ["axis":"vertical", "distribution": "fill", "alignment": "fill", "space": 8, "marginTop":16, "marginLeft": 103,"marginRight": 12],
            "subViews": [
                ["viewType": "Text",
                "property":["size": 14, "alignment": "left", "color": "#737D92", "content":"邀请你参加"]],
                
                ["viewType": "Text",
                 "property":["size": 17, "numberOfLines":0, "alignment": "left", "color": "#C7D2EC", "content":"${title}"]],
                
                
                ["viewType": "View",
                 "dynamicProperty": [
                    "currentState": "1",
                    "connectState": "status",
                    "stateList": [
                        "1": ["viewType": "Text",
                        "property":["size": 14, "alignment": "left", "color": "#FF5454", "content":"${subTitle}"]],
                        
                        "2": ["viewType": "Text",
                        "property":["size": 14, "alignment": "left", "color": "#FFC400", "content":"${subTitle}"]],
                        
                        "3":["viewType": "Text",
                        "property":["size": 14, "alignment": "left", "color": "#737D92", "content":"${subTitle}"]]
                     ]
                    ]
                ]
            ]
        ],
        
        ["viewType": "Button",
         "property":["size": 12,"width": 75, "height": 20, "marginBottom":16, "marginLeft": 20, "color": "#737D92", "backgroudColor": "#1D2431", "content":"进入会议室 >","action": ["actionType": "${actionType}", "expressionParams": "${actionParam}"]]],
        
        
        
        ["viewType": "View",
        
            "dynamicProperty":[
               "currentState": "1",
               "connectState": "status", // 关联的状态值获取后替换currentState
            "stateList":[
                "1":["viewType": "Button",
                "property":["size": 14,"width": 92, "height": 36,"cornerRadius": 18, "marginBottom":16, "marginRight": 12, "color": "#ffffff", "backgroudColor": "#FF2750", "content":"收到","action": ["actionType": "${actionType2}", "expressionParams": "${actionParam2}"]]],
                
                "2":["viewType": "Text",
                "property":["size": 14,"width": 50, "height": 20, "marginBottom":16, "marginRight": 37, "color": "#FF2750", "content":"已确认"]],
                "3":["viewType": "Text",
                "property":["size": 14,"width": 50, "height": 20, "marginBottom":16, "marginRight": 37, "color": "#737D92", "content":"已过期"]]
                ]
            ]
        ]
    ]
]
















 // MARK: Collection模板 垂直分布 样式：Image TXT
let collection_templates_1: [String: Any] = [
    "viewType": "StackView",
    "property": ["axis":"vertical", "distribution": "fill", "alignment": "fill", "space": 8, "margin":[10, 10, 10, 10]],
    "subViews": [
        ["viewType": "ImageView",
         "property":["id": "4", "content": "${headerIcon}", "action": ["actionType": "${actionType}", "expressionParams": "${actionParam}"]]],
        
        ["viewType": "Text",
        "property":["size": 12, "alignment": "center", "color": "#C7D2EC", "height": 17, "content":"${title}", "id": "2"]]
    ]
]




 // MARK: 会议成员应用内通知弹框
let inAppNotify_templates: [String: Any] = [
    "viewType": "View",
    "property": ["ratioW":0.8,"ratio": 0.7, "maskViewColor": "#000000", "backgroudColor": "#ffffff", "cornerRadius": 24, "popupCustomAlignment": 0, "popupAnimationType": 2],
     // ratoW 为宽度相对屏幕宽度的比率。ratio 为宽/高 值 由父视图获取
    "subViews": [
        // 关闭按钮
        ["viewType": "Button",
         "property":["marginRight": 10, "marginTop": 16, "width": 25, "height": 25, "content":"icon_tc_close.png"]],
        
        [
            "viewType": "StackView",
            "property": ["axis":"vertical", "distribution": "fill", "alignment": "center", "space": 17, "marginTop":39, "marginLeft": 18, "marginRight": 18],
            "subViews": [
                
                ["viewType": "ImageView",
                "property":["height":64, "width": 64,"content": "tc_icon_preview_phone.png"]],
                
                ["viewType": "Text",
                 "property":["size": 22, "alignment": "center", "isBold": 1, "color": "#141922", "height": 29, "content":"应用内通知"]],
                
                 ["viewType": "Text",
                  "property":["size": 12,"numberOfLines": 0, "id":"2", "alignment": "center", "color": "#4E586E", "content":"将会通过app内系统通知方式通知成员"]],
            ]
        ],
        
        ["viewType": "View",
         "property": ["cornerRadius": 5,  "marginLeft": 18, "marginRight": 18, "marginBottom": 159, "height": 44, "backgroudColor": "#F7F7F7"],
         "subViews": [
                ["viewType": "Text",
                 "property":["size": 14, "alignment": "center","color": "#000000", "centerY": 0, "marginLeft": 12, "height": 20, "width": 60, "content":"通知人数"]],
                ["viewType": "Text",
                "property":["size": 14, "alignment": "center","color": "#000000", "centerY": 0, "marginRight": 12, "height": 20, "width": 60, "content":"95人"]]
            ]
        ],
        
        // 按钮
        ["viewType": "Button",
         "property":["size": 15, "cornerRadius": 26, "height":52, "width": 152, "centerX": 0, "marginBottom": 37, "backgroudColor": "#0082FF", "color": "#ffffff", "content":"立即通知"]]
    
    ]
]


 // MARK: 会议成员应用内通知弹框
let smsNotify_templates: [String: Any] = [
    "viewType": "View",
    "property": ["ratioW":0.8,"ratio": 0.7, "maskViewColor": "#000000", "backgroudColor": "#ffffff", "cornerRadius": 24, "popupCustomAlignment": 0, "popupAnimationType": 2],
     // ratoW 为宽度相对屏幕宽度的比率。ratio 为宽/高 值 由父视图获取
    "subViews": [
        // 关闭按钮
        ["viewType": "Button",
         "property":["marginRight": 10, "marginTop": 16, "width": 25, "height": 25, "content":"icon_tc_close.png"]],
        
        [
            "viewType": "StackView",
            "property": ["axis":"vertical", "distribution": "fill", "alignment": "center", "space": 17, "marginTop":39, "marginLeft": 18, "marginRight": 18],
            "subViews": [
                
                ["viewType": "ImageView",
                "property":["height":64, "width": 64,"content": "tc_icon_preview_message.png"]],
                
                ["viewType": "Text",
                 "property":["size": 22, "alignment": "center", "isBold": 1, "color": "#141922", "height": 29, "content":"短信通知"]],
                
                 ["viewType": "Text",
                  "property":["size": 12,"numberOfLines": 0, "id":"2", "alignment": "center", "color": "#4E586E", "content":"将会通过短信的方式通知成员同时运营商需要收取相当于5G币/人次的费用"]],
            ]
        ],
        
        ["viewType": "View",
         "property": ["cornerRadius": 5,  "marginLeft": 18, "marginRight": 18, "marginTop": 218, "height": 44, "backgroudColor": "#F7F7F7"],
         "subViews": [
                ["viewType": "Text",
                 "property":["size": 14, "alignment": "center","color": "#000000", "centerY": 0, "marginLeft": 12, "height": 20, "width": 60, "content":"通知人数"]],
                ["viewType": "Text",
                "property":["size": 14, "alignment": "center","color": "#000000", "centerY": 0, "marginRight": 12, "height": 20, "width": 60, "content":"95人"]]
            ]
        ],
        
        ["viewType": "View",
         "property": ["cornerRadius": 5,  "marginLeft": 18, "marginRight": 18, "marginTop": 270, "height": 44, "backgroudColor": "#F7F7F7"],
         "subViews": [
                ["viewType": "Text",
                 "property":["size": 14, "alignment": "center","color": "#000000", "centerY": 0, "marginLeft": 12, "height": 20, "width": 60, "content":"收取费用"]],
                ["viewType": "Text",
                "property":["size": 14, "alignment": "center","color": "#FF2750", "centerY": 0, "marginRight": 12, "height": 20, "width": 60, "content":"950G币"]]
            ]
        ],
        
        
        ["viewType": "Text",
         "property":["size": 12, "alignment": "right", "centerX": -56, "width": 56, "marginTop": 332, "color": "#4E586E", "content":"当前余额"]],
        
         ["viewType": "Text",
          "property":["size": 12,"alignment": "left", "centerX": 56, "width": 80, "marginTop": 332, "color": "#000000", "content":"234234G币"]],
        
        // 按钮
        ["viewType": "Button",
         "property":["size": 15, "cornerRadius": 26, "height":52, "width": 152, "centerX": 0, "marginBottom": 36, "backgroudColor": "#00CF52", "color": "#ffffff", "content":"立即通知"]]
    
    ]
]



 // MARK: 会议成员智能电话弹框
let phoneNotify_templates: [String: Any] = [
    "viewType": "View",
    "property": ["ratioW":0.8,"ratio": 0.7, "maskViewColor": "#000000", "backgroudColor": "#ffffff", "cornerRadius": 24, "popupCustomAlignment": 0, "popupAnimationType": 2],
     // ratoW 为宽度相对屏幕宽度的比率。ratio 为宽/高 值 由父视图获取
    "subViews": [
        // 关闭按钮
        ["viewType": "Button",
         "property":["marginRight": 10, "marginTop": 16, "width": 25, "height": 25, "content":"icon_tc_close.png"]],
        
        [
            "viewType": "StackView",
            "property": ["axis":"vertical", "distribution": "fill", "alignment": "center", "space": 17, "marginTop":39, "marginLeft": 18, "marginRight": 18],
            "subViews": [
                
                ["viewType": "ImageView",
                "property":["height":64, "width": 64,"content": "tc_btn_preview_call.png"]],
                
                ["viewType": "Text",
                 "property":["size": 22, "alignment": "center", "isBold": 1, "color": "#141922", "height": 29, "content":"智能电话通知"]],
                
                 ["viewType": "Text",
                  "property":["size": 12,"numberOfLines": 0, "id":"2", "alignment": "center", "color": "#4E586E", "content":"将会通过拨打语音电话的方式通知成同时运营商需要收取相当于10G币/人次的费用"]],
            ]
        ],
        
        ["viewType": "View",
         "property": ["cornerRadius": 5,  "marginLeft": 18, "marginRight": 18, "marginTop": 218, "height": 44, "backgroudColor": "#F7F7F7"],
         "subViews": [
                ["viewType": "Text",
                 "property":["size": 14, "alignment": "center","color": "#000000", "centerY": 0, "marginLeft": 12, "height": 20, "width": 60, "content":"通知人数"]],
                ["viewType": "Text",
                "property":["size": 14, "alignment": "center","color": "#000000", "centerY": 0, "marginRight": 12, "height": 20, "width": 60, "content":"95人"]]
            ]
        ],
        
        ["viewType": "View",
         "property": ["cornerRadius": 5,  "marginLeft": 18, "marginRight": 18, "marginTop": 270, "height": 44, "backgroudColor": "#F7F7F7"],
         "subViews": [
                ["viewType": "Text",
                 "property":["size": 14, "alignment": "center","color": "#000000", "centerY": 0, "marginLeft": 12, "height": 20, "width": 60, "content":"收取费用"]],
                ["viewType": "Text",
                "property":["size": 14, "alignment": "center","color": "#FF2750", "centerY": 0, "marginRight": 12, "height": 20, "width": 60, "content":"950G币"]]
            ]
        ],
        
        
        ["viewType": "Text",
         "property":["size": 12, "alignment": "right", "centerX": -56, "width": 56, "marginTop": 332, "color": "#4E586E", "content":"当前余额"]],
        
         ["viewType": "Text",
          "property":["size": 12,"alignment": "left", "centerX": 56, "width": 80, "marginTop": 332, "color": "#000000", "content":"234234G币"]],
        
        // 按钮
        ["viewType": "Button",
         "property":["size": 15, "cornerRadius": 26, "height":52, "width": 152, "centerX": 0, "marginBottom": 36, "backgroudColor": "#FF2750", "color": "#ffffff", "content":"立即通知"]]
    
    ]
]
