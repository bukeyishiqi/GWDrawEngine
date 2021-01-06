//
//  MeetingPreviewPageJson.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/28.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation



let MeetingPreviewPageJson: [String: Any] = [
    "version": "0",
    "template": [
                        "viewType": "StackView",
                        "property": ["axis":"vertical", "distribution": "fill", "alignment": "fill", "space": 0, "height":-1, "width": -1, "margin":[0, 0, 0, 0], "backgroudColor": "#141922"],
            
                        // 声明页面初始状态 reducer处理各状态直接关联业务逻辑
                        "state":["list": "${meetingList}",
                                 "listCount": 0,
                                 
                                 "title":"",
                                 "scrollIndex": 1,
                                 "indexDescription": "", // 索引
                                 "reducer": [
                                         ["connectStateKey": "title", "condition": ["operator": "getCount", "param": ["list"]], "returnValue": "收到%@条会议预告"],
                                         
                                         ["connectStateKey": "listCount", "condition": ["operator": "getCount", "param": ["list"]], "returnValue": "/%@"],
                                         
                                         ["connectStateKey": "indexDescription", "condition": ["operator": "append", "param": ["scrollIndex", "listCount"]], "returnValue": "%@"]
                                         
                                 ]
                                 ],
                        
                        // 声明请求列表 initLoad方法只在界面初始加载调用
                        "requests":[
                            "initLoad":["meet_id":"${meet_id}"]
                        ],
                        
                        "subViews": [

                            // 头部
                            [
                             "viewType": "View",
                             "property": ["height":124],
                             "subViews": [
                                 ["viewType": "StackView",
                                  "property": ["axis":"horizontal", "distribution": "equalSpacing", "alignment": "fill", "space": 10, "marginRight":10, "marginTop":10, "marginLeft": 10, "marginBottom": 10],
                                  "subViews": [
                                         ["viewType": "Text",
                                          "property":["size": 21, "alignment": "left", "textGradientColors": ["#BEF7B3","#25B7FE", "#EB8BF3"], "content":"${title}"]],
                                         ["viewType": "Text",
                                         "property":["size": 21, "alignment": "right", "color": "#4E586E", "content":"${indexDescription}"]]
                                     ]
                                 ]
                             ]
                             
                            ],
                        
                            // page
                            ["viewType": "PageView",
                             "property": ["leadingSpacing": 20, "interitemSpacing": 4, "isInfinite": 0, "transformer": 4, "scaleX": 0.73, "scaleY": 1, "backgroudColor": "#141922"],
                             
                                // 模板数据映射关系
                             "templatesReflect": [
                                 "templates_7": ["status": "${status}", "title": "${meetingTitle}", "name":"${memberName}", "subTitle": "${tips}", "actionType": "showPage","actionParam": ["pageId": "HasConfirmMember"]]
                             ],

                             // 滚动到莫个Index需要代理的事件
                                "didScrollAction":  ["actionType": "updateState", "params": ["connectState": "scrollIndex", "value": 1]],
                             
                             "dynamicSections": [
                                 ["list": ["rowItems": "${list}", "rowIdentifier": "1", "identifierMap": ["1":"templates_7"]]]
                             ]
                             
                            ],
                            
                            // bootom
                           ["viewType": "View",
                            "property": ["height":54],
                            "subViews": [
                               ["viewType": "ImageView",
                                "property":["contentMode":4,"margin":[13, 13, 15], "width": 28, "content":"nav_back_icon.png", "action": ["actionType": "pop"]],
                               ]
                            ]
                           ]
                           
                        ]
    ],
    
    "serviceData": [
        "meetingList": [
            ["memberHeader": "default_head.png", "memberName": "张三", "meetingTitle": "2020年第2届光明顶家族季度线上表彰大会", "tips": "20分钟后开始", "status": "1"], // 待确认收到
            ["memberHeader": "default_head.png", "memberName": "李四",  "meetingTitle": "如果只有一行字就是这样", "tips": "今天 上午 10:00", "status": "2"], // 已确认
            ["memberHeader": "default_head.png", "memberName": "王五",   "meetingTitle": "如果只有一行字就是这样1", "tips": "2020-05-22  上午10:00", "status": "3"] // 已过期
        ]

    ]
]


let templates_7: [String: Any] = ["viewType": "View",
 "property": ["margin":[0, 0, 0, 0]],
 
 // actionParams 为需要参数对应的  state 节点状态 选中、未选中、隐藏
 "subViews": [
    
       // 上部分
        ["viewType": "ImageView",
         "property": ["margin":[0, 85, 0, 0], "content": "card_background.png"],
        
        "subViews": [
            [ // 头像人名
                "viewType": "StackView",
                "property": ["axis":"vertical", "distribution": "fill", "alignment": "center", "space": 4, "marginTop":60, "centerX": 0, "marginLeft": 24, "marginRight": 24],
                "subViews": [
                    ["viewType": "ImageView",
                     "property":["content": "default_head.png", "contentMode": 1, "width": 88, "height": 88]],
                    
                    ["viewType": "Text",
                     "property":["size": 20, "alignment": "center", "isBold":1, "color": "#FFFFFF", "height": 28, "content":"${name}"]],
                    ["viewType": "Text",
                    "property":["size": 13, "alignment": "center", "color": "#FFFFFF", "height": 18, "content":"邀请你参加"]]
                ]
            ],
            
            // 标题、时间
            ["viewType": "StackView",
             "property": ["axis":"vertical", "distribution": "fill", "alignment": "fill", "space": 16, "marginTop":230, "marginLeft": 32, "marginRight": 32],
             "subViews": [
                  ["viewType": "Text",
                  "property":["size": 16, "numberOfLines":0, "alignment": "center", "color": "#FFFFFF", "content":"${title}"]],
                  
                  ["viewType": "View",
                   "dynamicProperty": [
                      "currentState": "1",
                      "connectState": "status",
                      "stateList": [
                          "1": ["viewType": "Text",
                          "property":["size": 17, "alignment": "center", "color": "#FF5454", "content":"${subTitle}"]],
                          
                          "2": ["viewType": "Text",
                          "property":["size": 17, "alignment": "center", "color": "#FFAB00", "content":"${subTitle}"]],
                          
                          "3":["viewType": "Text",
                               "property":["size": 17, "alignment": "center", "color": "#FFFFFF", "alpha":0.5, "content":"${subTitle}"]]
                       ]
                      ]
                  ]
                
              ]
            ],
            
            // 按钮
            ["viewType": "View",
            
                "dynamicProperty":[
                   "currentState": "1",
                   "connectState": "status", // 关联的状态值获取后替换currentState
                "stateList":[
                    "1":["viewType": "Button",
                    "property":["size": 17,"marginLeft": 42, "height": 50,"cornerRadius": 25, "marginBottom":60, "marginRight": 42, "color": "#ffffff", "backgroudColor": "#FF2750", "content":"收到","action": ["actionType": "${actionType2}", "expressionParams": "${actionParam2}"]]],
                    
                    "2":["viewType": "Text",
                    "property":["size": 17,"alignment": "center", "marginLeft": 42, "height": 50, "marginBottom":60, "marginRight": 42, "color": "#FFFFFF", "content":"已确认"]],
                    "3":["viewType": "Text",
                    "property":["size": 17,"alignment": "center", "marginLeft": 42, "height": 50, "marginBottom":60, "marginRight": 42, "color": "#FFFFFF", "content":"已过期"]]
                    ]
                ]
            ],
            
            // 进入会议室
            ["viewType": "Button",
             "property":["size": 14, "height": 20, "marginRight": 20, "marginBottom":20, "marginLeft": 20, "color": "#FFFFFF",  "content":"进入会议室 >","action": ["actionType": "${actionType}", "expressionParams": "${actionParam}"]]]
        ]
      ],
        
        
      // 会员室信息部分
      ["viewType": "View",
       "property":["height":85, "marginLeft": 0, "marginRight": 0, "marginBottom":0],
       "subViews": [
              [
                     "viewType": "StackView",
                     "property": ["axis":"horizontal", "distribution": "fill", "alignment": "center", "space": 12, "margin":[19, 30, 4, 0]],
                     "subViews": [
                         
                         ["viewType": "ImageView",
                          "property":["contentMode":1, "height": 36,"width":36, "content": "default_head.png"]],
                         
                         ["viewType": "StackView",
                          "property": ["axis":"vertical", "distribution": "fill", "space": 2],
                          "subViews": [
                             ["viewType": "Text",
                              "property":["size": 17, "alignment": "left", "color": "#C7D2EC", "height": 24, "content":"大区总裁会议室"]],
                             ["viewType": "Text",
                             "property":["size": 12, "alignment": "left", "color": "#737D92", "height": 17, "content":"成员 2321"]]
                          ]
                         ]
                     ]
                 ]
          
          ]
      ]
    ]
]
    
    
    
    
