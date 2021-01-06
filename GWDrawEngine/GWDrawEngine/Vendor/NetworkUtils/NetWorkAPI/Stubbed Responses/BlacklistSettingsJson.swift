//
//  BlacklistSettingsJson.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/13.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation


let RequestBlacklistSettingsJson: [String: Any] = [
    "version": "0",
    "template": [
                        "viewType": "StackView",
                        "property": ["axis":"vertical", "distribution": "fill", "alignment": "fill", "space": 0, "margin":[0, 0, 0, 0], "backgroudColor": "#0F1219"],
            
                        // 声明页面初始状态 reducer处理各状态直接关联业务逻辑
                        "state":["list": "${memberList}"],
                        "subViews": [
                            
                            // header
                            ["templateType": "navHeader_1",
                             "property": ["title": "黑名单设置"]
                            ],
//                           [
//                            "viewType": "View",
//                            "property": ["height":54],
//                            "subViews": [
//                                ["viewType": "ImageView",
//                                 "property":["contentMode":4,"margin":[13, 13, 15], "width": 28, "content":"arrow_left.png", "id": "12", "action": ["actionType": "pop"]],
//                                ],
//
//                                ["viewType": "Text",
//                                 "property":["size": 18, "isBold": 1, "alignment": "center", "color": "#ffffff", "height": 28, "width": 200, "content":"黑名单设置", "centerParent":1, "id": "16"]]
//                            ]
//                           ],
                           
                           // body
                           [
                               "viewType": "TableView",
                               "property": ["style": "plan", "color": "#0C0E13", "separatorStyle": "none"],

                                  // 模板数据映射关系
                               "templatesReflect": [
                                "templates_3": ["headerIcon": "${memberHeader}","title": "${memberName}", "subTitle": "${subTitle}"],
                               ],

                               "dynamicSections": [
                                   ["header": "", "list": ["rowItems": "${list}", "rowIdentifier": "1", "identifierMap": ["1":"templates_3"]]]
                               ],
                               "subViews": [
                                   
                               ]
                           ]
                        ]
    ],
    "serviceData": [
        "memberList": [
            ["memberHeader": "default_head.png", "memberName": "张三", "subTitle": "浙江省，丽水区"],
            ["memberHeader": "default_head.png", "memberName": "李四", "subTitle": "浙江省，丽水区"],
            ["memberHeader": "default_head.png", "memberName": "王五", "subTitle": "浙江省，丽水区"],
            ["memberHeader": "default_head.png", "memberName": "张三1", "subTitle": "浙江省，丽水区"],
            ["memberHeader": "default_head.png", "memberName": "张三2", "subTitle": "浙江省，丽水区"],
            ["memberHeader": "default_head.png", "memberName": "张三3", "subTitle": "浙江省，丽水区"],
            ["memberHeader": "default_head.png", "memberName": "张三4", "subTitle": "浙江省，丽水区"],
            ["memberHeader": "default_head.png", "memberName": "张三5", "subTitle": "浙江省，丽水区"],
            ["memberHeader": "default_head.png", "memberName": "张三6", "subTitle": "浙江省，丽水区"],
            ["memberHeader": "default_head.png", "memberName": "张三7", "subTitle": "浙江省，丽水区"]
        ]

    ]
]
