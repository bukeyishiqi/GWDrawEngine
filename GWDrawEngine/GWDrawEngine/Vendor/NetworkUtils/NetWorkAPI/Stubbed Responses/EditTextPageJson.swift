//
//  EditTextPageJson.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/7.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation


let RequestEditTextPageJson: [String: Any] = [
    "version": "0",
    "template": [
                        "viewType": "StackView",
                        "property": ["axis":"vertical", "distribution": "fill", "alignment": "fill", "space": 0, "height":-1, "width": -1, "margin":[0, 0, 0, 0], "backgroudColor": "#141922"],
                        
//                        "state":["name": "${name}"],
                        
                        "subViews": [
                            // header
                            ["viewType": "View",
                             "subViews": [
                                ["viewType": "Text",
                                "property":["size": 26, "isBold": 1, "alignment": "left", "color": "#ffffff", "height": 60, "content":" 修改姓名", "margin":[0, 0, 10, 10], "id": "10"]]
                                ]
                            ],
                            // body
                            [
                                "viewType": "View",
                                "property": ["style": "group", "color": "#0C0E13", "action": ["actionType": "endViewEdit"]],
                                "subViews": [
                                    
                                    // 输入框
                                    ["viewType": "TextField",
                                     "state":["connectState":"name"],
                                     "property": ["height": 50, "marginTop":20, "marginLeft": 0,"marginRight": 0, "backgroudColor": "#20222E", "placeholder": "请输入姓名", "content": "${name}", "textColor": "#ffffff", "placeholderColor": "#333333", "id": "1"]
                                    ]
                                ]
                            ],
                            
                            // bootom
                           [
                            "viewType": "View",
                            "property": ["height":50],
                            "subViews": [
                                ["viewType": "StackView",
                                    "property": ["axis":"horizontal", "distribution": "equalSpacing", "alignment": "center", "space": 0,  "margin":[0, 0, 10, 10], "width": -1],
                                    "subViews": [
                                       ["viewType": "ImageView",
                                        "property":["size": 13, "alignment": "center", "color": "#ffffff", "height": 20, "width": 40, "content":"arrow_left.png", "id": "12", "action": ["actionType": "pop", "params": ["key": "value"]]],
                                        
                                       ],
                                       
                                       ["viewType": "Button",
                                        "property":["size": 16, "alignment": "center", "color": "#FF5454", "height": 20, "width": 40, "content":"保存", "id": "13", "action": ["actionType": "commit", "params": ["method": "POST", "service": "accountService", "url": "/gcorp/account/user/setUserInfo", "param": ["updataType": 1, "nickname": "${name}"], "popToVc":"setting"]]]]
                                        // popToVc参数关联是否需要返回界面，此参数必须存在才能返回界面
                                    ]

                               ]
                            ]
                            
                           ]
                        ]
    ]
]
