//
//  GroupManagerSettingJson.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/13.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation


let RequestGroupManagerSettingJson: [String: Any] = [
    "version": "0",
    "template": [
                        "viewType": "StackView",
                        "property": ["axis":"vertical", "distribution": "fill", "alignment": "fill", "space": 0, "margin":[0, 0, 0, 0], "backgroudColor": "#0F1219"],
            
                        // 声明页面初始状态 reducer处理各状态直接关联业务逻辑
                        "state":["list": "${meetingGroupService.list}", "group_id": ""],
                        
                        // 声明请求列表 initLoad方法只在界面初始加载调用
                        "requests":[
                            "initLoad":["meetingGroupService": ["group_id":"${group_id}", "pageIndex":0, "pageSize": 50]]
                        ],
                        
                        "subViews": [
                            
                            // header
                            ["templateType": "navHeader_1",
                             "property": ["title": "管理员设置"]
                            ],
                            
                           // body
                           ["viewType": "CollectionView",
                            "property":["ratioW": 1, "backgroudColor": "#141922", "scrollDirection": "vertical", "minLineSpacing":0, "minInteritemSpacing": 0,"sectionInset": [14,10,16,10], "itemRatio": 1.33, "column": 5, "isScrollEnabled": 0],
                            
                            
                               // 模板数据映射关系
                            "templatesReflect": [
                               "collection_templates_1": ["headerIcon": "${memberHeader}","title": "${memberName}", "actionType": "${actionType}","actionParam": "${actionParam}"]
                            ],
                            "dynamicSections": [

                                ["header": "", "list": ["rowItems": "${list}", "rowIdentifier": "1", "identifierMap": ["1":"collection_templates_1"]]]
                                // rowItems 为接口返回的行数，${item.type}为区别单行的标识，通过identifier中映射需要的模板类型
                            ],
                            
                            // 每个分区内容需要添加的后缀 key为分区索引
                            "sectionsSuffix":[
                                "0": [
                                    ["identifier": "collection_templates_1","memberHeader": "icon_add.png", "memberName": "添加", "actionType": "showPage", "actionParam": ["pageId": "groupManagerAdd", "group_id": "${group_id}"]],
                                    
                                    ["identifier": "collection_templates_1", "memberHeader": "btn_menbers_delete.png", "memberName": "移除"]
                               ]
                            ]
                           ]
                        ]
    ],
    "serviceData": [
        "memberList": [
            ["memberHeader": "default_head.png", "memberName": "张三"],
            ["memberHeader": "default_head.png", "memberName": "李四"],
            ["memberHeader": "default_head.png", "memberName": "王五"],
            ["memberHeader": "default_head.png", "memberName": "张三1"],
            ["memberHeader": "default_head.png", "memberName": "张三2"],
            ["memberHeader": "default_head.png", "memberName": "张三3"],
            ["memberHeader": "default_head.png", "memberName": "张三4"],
            ["memberHeader": "default_head.png", "memberName": "张三5"],
            ["memberHeader": "default_head.png", "memberName": "张三6"],
            ["memberHeader": "default_head.png", "memberName": "张三7"],
            
            ["memberHeader": "default_head.png", "memberName": "张三8"],
            ["memberHeader": "default_head.png", "memberName": "张三9"],
            ["memberHeader": "default_head.png", "memberName": "张三10"],
            ["memberHeader": "default_head.png", "memberName": "张三11"],
        ]

    ]
]
