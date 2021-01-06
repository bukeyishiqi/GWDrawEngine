//
//  ImageViewNode.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/22.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation


class ImageViewNode: BaseLayoutElement {
    
    var content: String?
    var selectedContent: String?
    var contentMode: Int? // 内容加载方式

    
    override init(nodeInfo: [String : Any]?) {
        super.init(nodeInfo: nodeInfo)

        if let property = nodeInfo?["property"] as? [String: Any] {
            // 样式通用属性
           self.content = verifyExpressionSetters(key: "content", value: property["content"]) as? String
           self.selectedContent = verifyExpressionSetters(key: "selectedContent", value: property["selectedContent"]) as? String
            self.contentMode = property["contentMode"] as? Int
        }
    }
    
    
    override func updateNodePropertyValue(propertyName: String, value: Any) {
        super.updateNodePropertyValue(propertyName: propertyName, value: value)

       if propertyName == "content"  {
           if let content = (value as? JSON)?.string {
               self.content = content
           }
       }
        
        if propertyName == "selectedContent" {
            if let sContent = (value as? JSON)?.string {
                self.selectedContent = sContent
            }
        }
        
        if propertyName == "contentMode" {
            if let mode = (value as? JSON)?.int {
                self.contentMode = mode
            }
        }
    }
}
