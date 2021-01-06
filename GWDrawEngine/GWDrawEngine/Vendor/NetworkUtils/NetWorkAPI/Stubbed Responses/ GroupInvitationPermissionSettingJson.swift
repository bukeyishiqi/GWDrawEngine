//
//   GroupInvitationPermissionSettingJson.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/8/1.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation

 // MARK: 会议室邀请权限设置
let GroupInvitationPermissionSettingJson: [String: Any] = [
    "version": "0",
    "template": [
                        "viewType": "StackView",
                        "property": ["axis":"vertical", "distribution": "fill", "alignment": "fill", "space": 0, "margin":[0, 0, 0, 0], "backgroudColor": "#0F1219"],
            
                        // 声明页面全局初始状态 reducer处理各状态直接关联业务逻辑
                        "state":[
                                 "group_id": "",
//                                 "list": "${memberList}",
                                 "invitationType":1, // 邀请权限设置
                            
                            "section0_list": [
                                    ["name": "仅管理员可邀请", "identifier": "templates_0", "image": "sign_selected.png", "isSelected":1, "invitationType":1, "actionType": "showPage", "actionParam": ["pageId": "groupManagerSetting", "group_id": "${group_id}"]],
                                    
                                    ["name": "全员可邀请", "identifier": "templates_0", "image": "sign_selected.png", "isSelected":0,  "invitationType":2, "actionType": "showPage", "actionParam": ["pageId": "groupInvitationPermission"]],
                                    
                                    ["name": "部分成员可邀请", "identifier": "templates_0", "image": "sign_selected.png", "isSelected":0,  "invitationType":3, "actionType": "showPage", "actionParam": ["pageId": "Blacklist"]]]
                                 ],
                        
                        // 声明请求列表 initLoad方法只在界面初始加载调用
                        "requests":[
                            "initLoad":["meetingGroupService": ["group_id":"${group_id}", "pageIndex":0, "pageSize": 50, "search_key": "", "updated_at": 0]],
//                            "headerLoad":["group_id":"${group_id}", "page": 1],
//                            "footerLoad":["group_id":"${group_id}", "page": "${loadPage}"] // 底部上拉加载刷新
                        ],
                        "subViews": [
                            
                            // header
                           ["templateType": "navHeader_1",
                            "property": ["title": "会议室邀请权限"]
                           ],
                           
                           // body
                           [
                               "viewType": "TableView",
                               "property": ["headerHeight": 54, "style": "plan", "color": "#0C0E13", "separatorStyle": "none"],
                               
//                               "refreshControl": ["needRefresh": 1, "style": "default"],
                               
                               // 模板数据映射关系
                                "templatesReflect": [
                                    "templates_0": ["title": "${name}", "image": "${image}", "isSelected": "${isSelected}",  "actionType": "signSelected","actionParam": ["selectedElement": "${invitationType}", "connectState": ["section0_list", "invitationType"]]],
                                    
                                    "templates_4": ["headerIcon": "default_head.png","title": "${name}", "subTitle": "粉丝：3231"]
                                ],
                                
                                "dynamicSections": [
//                                    ["header": "", "list": [
//                                        ["name": "仅管理员可邀请", "identifier": "templates_0", "image": "sign_selected.png", "isSelected":1, "invitationType":1, "actionType": "showPage", "actionParam": ["pageId": "groupManagerSetting", "group_id": "${group_id}"]],
//
//                                        ["name": "全员可邀请", "identifier": "templates_0", "image": "sign_selected.png", "isSelected":0,  "invitationType":2, "actionType": "showPage", "actionParam": ["pageId": "groupInvitationPermission"]],
//
//                                        ["name": "部分成员可邀请", "identifier": "templates_0", "image": "sign_selected.png", "isSelected":0,  "invitationType":3, "actionType": "showPage", "actionParam": ["pageId": "Blacklist"]]]],
                                    ["header": "", "list": ["rowItems": "${section0_list}", "rowIdentifier": "1", "identifierMap": ["1":"templates_0"]]]


//                                    ["header": "添加可邀请成员", "list": ["rowItems": "${list}", "rowIdentifier": "1", "identifierMap": ["1":"templates_4"]]]
                                ],
                                
                                // 侧滑Action配置
//                            "swipeActions": [
//                                ["title": "删除", "backgroudColor": "#FF5454","image": "login_exit_icon.png", "action": ["actionType": "objRemove", "params": ["connectState": ["list"], "rmvObj":"${memberName}", "filterKey":"memberName"]]],
//                                ["title": "标记已读", "backgroudColor": "#01CA58"],
//                                ["title": "标记未读", "backgroudColor": "#FFA100"]],
//
//                               "dynamicSections": [
//                                ["header": "", "list": ["rowItems": "${list}", "rowIdentifier": "1", "identifierMap": ["1":"templates_4"]]]
//                               ],
                               
                               "subViews": [
                                   
                               ]
                           ]
                        ]
    ],
    "serviceData": [
        "memberList": [
            ["memberHeader": "default_head.png", "name": "张三", "subTitle": "浙江省，丽水区"],
            ["memberHeader": "default_head.png", "name": "李四", "subTitle": "浙江省，丽水区"],
            ["memberHeader": "default_head.png", "name": "王五", "subTitle": "浙江省，丽水区"],
            ["memberHeader": "default_head.png", "name": "张三1", "subTitle": "浙江省，丽水区"]
        ]

    ]
]
