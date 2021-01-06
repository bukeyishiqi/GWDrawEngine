//
//  NavigatorHeaderTemplate.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/24.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation



let navigatorHeaderTemplate: [String: Any] = [
 "viewType": "View",
 "property": ["height":54],
 "subViews": [
     ["viewType": "ImageView",
      "property":["contentMode":4,"margin":[13, 13, 15], "width": 28, "content":"nav_back_icon.png", "action": ["actionType": "pop"]],
     ],

     ["viewType": "Text",
      "property":["size": 18, "isBold": 1, "alignment": "center", "color": "#ffffff", "height": 28, "width": 200, "content":"${title}", "centerParent":1]],
     
     ["viewType": "StackView",
      "property": ["axis":"horizontal", "distribution": "fill", "alignment": "fill", "space": 10, "marginRight":16, "height":28, "centerY": 0]
        ,
      "subViews": [
             ["viewType": "Button",
             "property":["size": 15,"width": 66, "cornerRadius":14, "alignment": "center", "color": "#ffffff", "content":"${item1}","action": ["actionType": "${actionType1}", "expressionParams": "${actionParam1}"]]],
             ["viewType": "Button",
             "property":["size": 15,"width": 66, "cornerRadius":14, "alignment": "center", "color": "#5C6981", "backgroudColor": "#1D2431", "content":"${item2}","action": ["actionType": "${actionType2}", "expressionParams": "${actionParam2}"]]]
         ]
     ]
 ]
 
]
