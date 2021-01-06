//
//  GroupManagerAddJson.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/15.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation



let RequestGroupManagerAddJson: [String: Any] = [
    "version": "0",
    "template": [
                        "viewType": "StackView",
                        "property": ["axis":"vertical", "distribution": "fill", "alignment": "fill", "space": 0, "margin":[0, 0, 0, 0], "backgroudColor": "#0F1219"],
            
                        // 声明页面全局初始状态 reducer处理各状态直接关联业务逻辑
                        "state":["selectedlList": [],
                                 "group_id": "",
                                 "list": "${meetingGroupService.list}",
                                 "commitButtonState": "state2",
                                 "commitButtonTitle": "添加",
                                 "loadPage":1, // 加载的页码
                                 "reducer": [
                                     ["connectStateKey": "commitButtonState", "condition": ["operator": ">", "param": ["selectedlList"]], "returnValue": "state1"],
                                    ["connectStateKey": "commitButtonState", "condition": ["operator": "<=", "param": ["selectedlList"]], "returnValue": "state2"],
                                    ["connectStateKey": "commitButtonTitle", "condition": ["operator": "getCount", "param": ["selectedlList"]], "returnValue": "添加(%@)"],
                                    ["connectStateKey": "commitButtonTitle", "condition": ["operator": "<=", "param": ["selectedlList"]], "returnValue": "添加"]
                            ]],
                        
                        // 声明请求列表 initLoad方法只在界面初始加载调用
                        "requests":[
                            "initLoad":["meetingGroupService": ["group_id":"${group_id}", "pageIndex":0, "pageSize": 50, "search_key": "", "updated_at": 0]],
                            "headerLoad":["group_id":"${group_id}", "page": 1],
                            "footerLoad":["group_id":"${group_id}", "page": "${loadPage}"] // 底部上拉加载刷新
                        ],
                        "subViews": [
                            
                            // header
                           [
                            "viewType": "View",
                            "property": ["height":54],
                            "subViews": [
                                ["viewType": "ImageView",
                                 "property":["contentMode":4,"margin":[13, 13, 15], "width": 28, "content":"nav_back_icon.png", "id": "12", "action": ["actionType": "pop"]],
                                ],

                                ["viewType": "Text",
                                 "property":["size": 18, "isBold": 1, "alignment": "center", "color": "#ffffff", "height": 28, "width": 200, "content":"添加管理员", "centerParent":1, "id": "16"]],
                                
                                ["viewType": "Button",
                                
                                "dynamicProperty":[
                                   "currentState": "state1",
                                   "connectState": "commitButtonState", // 关联的状态值获取后替换currentState
                                "stateList":[
                                     "state1": ["viewType": "Button",
                                                "property":["size": 15, "width": 66, "height":28, "centerY": 0,"marginRight":16, "cornerRadius":14, "alignment": "center", "color": "#ffffff", "backgroudColor": "#01CA58", "content":"${commitButtonTitle}", "id": "10", "action": ["actionType": "showPopView", "params": ["popType": "Alter","title": "确认提醒","description": "确定将选中的成员加入管理员？","cancelTitle": "取消","confirmTitle": "添加", "confirmAction": ["actionType": "commit", "params":["method": "POST", "service": "meetingGroupService", "url": "/gcorp/meeting-group/admin/add-admin", "param": [ "user_id_list": "${selectedlList}", "group_id": "${group_id}"]], "subActions":[
                                                    
                                                                ["actionType": "arrayRemove", "params": ["connectState": ["list","selectedlList"], "filterKey":"user_id"]],
                                                                ["actionType": "showToast", "params":[ "template":  "toast_1", "message": "添加成功"]],
                                                                ["actionType": "clear", "params": ["connectState": ["selectedlList"]]]]]]]]],
                                                    // filterKey为List对象中的比较条件key
                                    "state2":["viewType": "Button",
                                              "property":["size": 15,"width": 66, "height":28, "centerY": 0,"marginRight":16, "cornerRadius":14, "alignment": "center", "color": "#5C6981", "backgroudColor": "#1D2431", "content":"${commitButtonTitle}", "id": "10"]]]]
                                ]
                            ]
                            
                           ],
                           
                           // body
                           [
                               "viewType": "TableView",
                               "property": ["style": "plan", "color": "#0C0E13", "separatorStyle": "none"],
                               
                               "refreshControl": ["needRefresh": 1, "style": "default"],
                               
                               // 模板数据映射关系
                                "templatesReflect": [
                                    "templates_4": ["headerIcon": "default_head.png","title": "张三丰", "subTitle": "粉丝：3231","isSelected": "${isSelected}", "actionType": "selected","actionParam": ["selectedElement": "${user_id}", "connectState": ["list","selectedlList"]]]
                                ],
                                
                                "dynamicSections": [
                                    ["header": "", "list": ["rowItems": "${list}", "rowIdentifier": "1", "identifierMap": ["1":"templates_4"]]]
                                ],
//                                // 侧滑Action配置
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
            ["memberHeader": "default_head.png", "memberName": "张三", "subTitle": "浙江省，丽水区"],
            ["memberHeader": "default_head.png", "memberName": "李四", "subTitle": "浙江省，丽水区"],
            ["memberHeader": "default_head.png", "memberName": "王五", "subTitle": "浙江省，丽水区"],
            ["memberHeader": "default_head.png", "memberName": "张三1", "subTitle": "浙江省，丽水区"],
            ["memberHeader": "default_head.png", "memberName": "张三2", "subTitle": "浙江省，丽水区"],
            ["memberHeader": "default_head.png", "memberName": "张三3", "subTitle": "浙江省，丽水区"],
            ["memberHeader": "default_head.png", "memberName": "张三4", "subTitle": "浙江省，丽水区"],
            ["memberHeader": "default_head.png", "memberName": "张三5", "subTitle": "浙江省，丽水区"],
            ["memberHeader": "default_head.png", "memberName": "张三6", "subTitle": "浙江省，丽水区"],
            ["memberHeader": "default_head.png", "memberName": "张三7", "subTitle": "浙江省，丽水区"],
            ["memberHeader": "default_head.png", "memberName": "张三8", "subTitle": "浙江省，丽水区"],
            ["memberHeader": "default_head.png", "memberName": "张三9", "subTitle": "浙江省，丽水区"],
            ["memberHeader": "default_head.png", "memberName": "张三10", "subTitle": "浙江省，丽水区"],
            ["memberHeader": "default_head.png", "memberName": "张三11", "subTitle": "浙江省，丽水区"],
            ["memberHeader": "default_head.png", "memberName": "张三12", "subTitle": "浙江省，丽水区"]
        ]

    ]
]
