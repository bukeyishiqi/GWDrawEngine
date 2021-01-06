//
//  ButtonNode.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/22.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation


class ButtonNode: BaseLayoutElement {

    var content: String?
    var color: String?
    var size: Int?
    var image: String?
    
    override init(nodeInfo: [String : Any]?) {
        super.init(nodeInfo: nodeInfo)

        if let property = nodeInfo?["property"] as? [String: Any] {
            // 样式通用属性
           self.content = verifyExpressionSetters(key: "content", value: property["content"]) as? String
           self.color = property["color"] as? String
            self.size = property["size"] as? Int
            self.image = property["image"] as? String
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
        
        if propertyName == "size", let size = (value as? JSON)?.int {
            self.size = size
        }
   }
}
