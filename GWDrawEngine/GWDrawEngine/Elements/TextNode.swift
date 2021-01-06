//
//  TextNode.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/22.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation


class TextNode: BaseLayoutElement {
    
    var size: Int?
    var content: String?
    var color: String?
    var fontName: String?
    var numberOfLines: Int?
    var isBold: Int? // 是否加粗
    var alignment: String?
    
    var textGradientColors: [String]?
    
    override init(nodeInfo: [String : Any]?) {
        super.init(nodeInfo: nodeInfo)

        if let property = nodeInfo?["property"] as? [String: Any] {
            // 样式通用属性
           self.size = property["size"] as? Int
            self.content = verifyExpressionSetters(key: "content", value: property["content"]) as? String
           self.color = property["color"] as? String
           self.fontName = property["fontName"] as? String
           self.numberOfLines = property["numberOfLines"] as? Int
           self.isBold = property["isBold"] as? Int // 是否加粗
            self.alignment = property["alignment"] as? String
            self.textGradientColors = property["textGradientColors"] as? [String]
        }
    }
    
    override func updateNodePropertyValue(propertyName: String, value: Any) {
        super.updateNodePropertyValue(propertyName: propertyName, value: value)
        
        if propertyName == "color", let color = (value as? JSON)?.string {
           self.color = color
        }
               
        if propertyName == "content"  {
           if let content = (value as? JSON)?.string {
               self.content = content
           } else if let c = (value as? JSON)?.int {
            self.content = "\(c)"
           }
        }
        
        if propertyName == "isBold", let isBold = (value as? JSON)?.int {
            self.isBold = isBold
        }
        
        if propertyName == "size", let size = (value as? JSON)?.int {
            self.size = size
        }
    }
}
