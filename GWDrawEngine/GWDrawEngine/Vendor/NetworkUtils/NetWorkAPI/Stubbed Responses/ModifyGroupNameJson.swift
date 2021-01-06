//
//  ModifyGroupNameJson.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/13.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation



let RequestModifyGroupNameJson: [String: Any] = [
    "version": "0",
    "template": [
                        "viewType": "StackView",
                        "property": ["axis":"vertical", "distribution": "fill", "alignment": "fill", "space": 0, "margin":[0, 0, 0, 0], "backgroudColor": "#0F1219"],
            
                        // 声明页面初始状态 reducer处理各状态直接关联业务逻辑
                        "state":["groupName":"", "commitButtonState": "state1",  "reducer": [
                                               ["commitButtonState", "groupName", ">", "state1"],
                                               ["commitButtonState", "groupName", "<=", "state2"]
                                           ]],
                        "subViews": [
                            
                            // header
                            ["templateType": "navHeader_1",
                             "property": ["title": "修改会议室名称"]
                            ],
//                           [
//                            "viewType": "View",
//                            "property": ["height":54],
//                            "subViews": [
//                                ["viewType": "ImageView",
//                                 "property":["contentMode":4,"margin":[13, 13, 15], "width": 28, "content":"arrow_left.png", "id": "1", "action": ["actionType": "pop"]],
//                                ],
//
//                                ["viewType": "Text",
//                                 "property":["size": 18, "isBold": 1, "alignment": "center", "color": "#ffffff", "height": 28, "width": 200, "content":"", "centerParent":1, "id": "2"]]
//                            ]
//                            
//                           ],
                           
                           // body
                            ["viewType": "View",
                             "property": ["action": ["actionType": "endViewEdit"]],
                             "subViews": [
                                ["viewType": "Text",
                                 "property":["size": 20,"marginLeft":10, "marginRight": 10, "marginTop": 48,  "alignment": "center", "color": "#C7D2EC", "height": 28, "content":"修改会议室名称", "id": "3"]],
                                
                                ["viewType": "Text",
                                "property":["size": 15, "marginLeft":10, "marginRight": 10, "marginTop": 82,  "alignment": "center", "color": "#4E586E", "height": 21, "content":"修改会议室名称后，将在会议室内通知其他成员。", "id": "4"]],
                                
                                ["viewType": "View",
                                 "property":["marginLeft":32, "marginRight": 32, "marginTop": 130, "height": 1, "backgroudColor":"#343B4A", "id": "5"]],
                                 [
                                    "viewType": "StackView",
                                    "property": ["axis":"horizontal", "distribution": "fill", "alignment": "center", "space": 10, "marginLeft":32, "marginRight": 32,"height": 40, "marginTop": 141],
                                    "subViews": [
                                        
                                        ["viewType": "ImageView",
                                         "property":["contentMode":1, "width": 40, "id": "6", "content": "banben_info_log_icon.png", "cornerRadius":8]],
                                        
                                        // 输入框
                                        ["viewType": "TextField",
                                         "state":["connectState":"groupName"], // 关联替换状态值，textfield代理结束后获取对应状态值修改
                                         "property": ["size":16, "placeholder": "请输入会议室名称", "content": "${groupName}", "textColor": "#C7D2EC", "placeholderColor": "#333333", "id": "7"]],
                                        
                                        ["viewType": "ImageView",
                                         "property":["contentMode":1, "height": 20,"width": 20, "id": "8", "content": "icon_input_delete.png", "action": ["actionType": "clear", "params": ["connectState": ["groupName"]]]]]
                                    ]
                                ],
                                ["viewType": "View",
                                "property":["marginLeft":32, "marginRight": 32, "marginTop": 191, "height": 1, "backgroudColor":"#343B4A", "id": "9"]],
                                 
                                ["viewType": "Button",
                                 
                                 "dynamicProperty":[
                                    "currentState": "state1",
                                    "connectState": "commitButtonState", // 关联的状态值获取后替换currentState
                                 "stateList":[
                                      "state1": ["viewType": "Button",
                                                 "property":["size": 15,"height": 44,"width": 200, "cornerRadius":22, "alignment": "center", "color": "#ffffff", "backgroudColor": "#01CA58", "content":"确定修改","centerX":0,"marginTop": 266, "id": "10", "action": ["actionType": "commit", "params": ["method": "POST", "service": "meetingGroupService", "url": "/gcorp/meeting-group/room/edit-name", "param": ["title": "${groupName}", "group_id": "${group_id}"]],
                                                                                                                                                                                                                                                                            "subActions":[["actionType": "pop", "params": ["popToVc":"groupMessage", "groupName": "${groupName}"]]]
                                                    ]]],
                                     
                                     "state2":["viewType": "Button",
                                               "property":["alpha":0.5,"size": 15,"height": 44,"width": 200, "cornerRadius":22, "alignment": "center", "color": "#ffffff", "backgroudColor": "#1D2431", "content":"确定修改","centerX":0,"marginTop": 266, "id": "10"]]]]
                                 ]
                                ]
                            ]
                        ]
    ]
]
