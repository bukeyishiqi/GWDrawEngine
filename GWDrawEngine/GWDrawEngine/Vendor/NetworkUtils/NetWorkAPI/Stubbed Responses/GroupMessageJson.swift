//
//  GroupMessageJson.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/10.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation


let RequestGroupMessageJson: [String: Any] = [
    "version": "0",
    "template": [
                        "viewType": "StackView",
                        "needCallBack":1, // 是否需要回调
                        "property": ["axis":"vertical", "distribution": "fill", "alignment": "fill", "space": 0, "height":-1, "width": -1, "margin":[0, 0, 0, 0], "backgroudColor": "#0F1219"],
            
                        // 声明页面初始状态 reducer处理各状态直接关联业务逻辑
                        "state":[
                                 "memberCount":"${meetingGroupService.total_member}",
                                 "memberTitle":"查看所有成员",
                                 
                                 "groupName": "${meetingGroupService.title}",
                                 "number": "${groupNumber}",
                                 "headerIcon": "${meetingGroupService.img_face}",
                                 "isTop":"${meetingGroupService.is_top}",
                                 "group_id": 97,
                                 "reducer": [
                                         ["connectStateKey": "memberTitle", "condition": ["operator": "getValue", "param": ["memberCount"]], "returnValue": "查看所有成员(%@)"]
                                 ]
                        ],
                        
                        // 声明请求列表 initLoad方法只在界面初始加载调用
                        "requests":[
                            "initLoad":["meetingGroupService": ["group_id":"${group_id}"]]
                        ],
                        
                        "subViews": [
                            
                            ["templateType": "navHeader_1",
                             "property": ["title": "会议室资料", "item1": "会议预告", "actionType1": "showPage", "actionParam1": ["pageId": "MeetingPreview"]]
                            ],
                            
                           // body
                           [
                           "viewType": "TableView",
                           "property": ["style": "group", "headerHeight": 16, "color": "#0F1219", "separatorStyle": "none"],
                               
                               // 模板数据映射关系
                            "templatesReflect": [
                                "templates_1": ["title": "${name}", "subTitle": "${subTitle}", "actionType": "${actionType}","actionParam": "${actionParam}"],
                                "templates_2": ["name": "${name}", "off": "${off}"],
                                "templates_8": ["title": "${name}", "headerIcon": "${header}"],
                            ],
                            
                               // 静态页面布局
                               "staticSections": [
                                   ["header": "", "list": [
                                    ["name": "${memberTitle}", "identifier": "templates_1", "actionType": "showPage", "actionParam": ["pageId": "groupMemberList", "group_id": "${group_id}"]]]],
                                   
                                   ["header": "", "list": [
                                    ["name": "会议室头像", "identifier": "templates_8", "actionType": "showPage", "header": "${headerIcon}", "actionParam": ["pageId": "groupMemberList"]]]],
                                   
                                   ["header": "", "list": [
                                    ["name": "管理员设置", "identifier": "templates_1",  "actionType": "showPage", "actionParam": ["pageId": "groupManagerSetting", "group_id": "${group_id}"]],
                                    
                                    ["name": "会议室邀请权限", "identifier": "templates_1",  "actionType": "showPage", "actionParam": ["pageId": "groupInvitationPermission"]],
                                    ["name": "黑名单设置", "identifier": "templates_1", "actionType": "showPage", "actionParam": ["pageId": "Blacklist"]]]],
                                  
                                   
                                   ["header": "", "list": [
                                    ["name": "会议室名称", "subTitle": "${groupName}", "identifier": "templates_1", "actionType": "showPage", "actionParam": ["pageId": "modifyGroupName", "groupName": "${groupName}", "group_id": "${group_id}"]],
                                   
                                   ["name": "会议室置顶", "off": "${isTop}", "identifier": "templates_2", "actionType": "showPage", "actionParam": ["pageId": ""]]]],
                                   
                                   ["header": "", "list": [
                                    ["name": "举报", "identifier": "templates_1", "actionType": "showPage", "actionParam": ["pageId": "modifyGroupName", "groupName": "${groupName}"]]
                                    ]],
                                   
                                   
                               ],
                               
                               "subViews": [
                                    // header
//                                ["viewType": "CollectionView",
//                                 "property":["width": -1, "height": 320, "layoutType": "absolute", "backgroudColor": "#141922", "scrollDirection": "vertical", "minLineSpacing":0, "minInteritemSpacing": 0,"sectionInset": [18,10,16,10], "itemRatio": 1.33, "column": 5, "isScrollEnabled": 0],
//
//                                    // 模板数据映射关系
//                                 "templatesReflect": [
//                                    "collection_templates_1": ["headerIcon": "${memberHeader}","title": "${memberName}", "actionType": "${actionType}","actionParam": "${actionParam}"]
//                                 ],
//
//                                 "dynamicSections": [
//
//                                     ["header": "", "list": ["rowItems": "${list}", "rowIdentifier": "1", "identifierMap": ["1":"collection_templates_1"]]]
//                                     // rowItems 为接口返回的行数，${item.type}为区别单行的标识，通过identifier中映射需要的模板类型
//                                 ],
//
//                                 // 每个分区内容需要添加的后缀
//                                 "sectionsSuffix":[
//                                    "0": [
//                                            ["identifier": "collection_templates_1","memberHeader": "icon_add.png", "name": "", "actionType": "showPage", "actionParam": ["pageId": "groupManagerAdd", "groupId": "${groupName}"]],
//
//                                        ]
//                                    ]
//                                ],
                                   // footer
//                                   ["viewType": "View",
//                                    "property": ["width": -1, "height": 70, "layoutType": "absolute"],
//                                        "subViews": [
//
//                                           ["viewType": "Button",
//                                            "property":["size": 16, "alignment": "center", "color": "#FF3939", "backgroudColor": "#141922", "content":"解散会议室", "id": "13", "margin":[16, 0, 0, 0]]]
//                                        ]
//                                   ]
                               ]
                           ],
                        ]
    ],
    
    "serviceData": [
        "groupName": "大区总裁会议室",
        "groupNumber": "851247",
        "groupPwd": "111111",
        "toTop": "1",
        "headerIcon": "default_head.png",
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


