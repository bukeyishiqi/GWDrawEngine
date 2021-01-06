//
//  SwitchNode.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/23.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation


class SwitchNode: BaseLayoutElement {
    
    var value: String?
    
    override init(nodeInfo: [String : Any]?) {
        super.init(nodeInfo: nodeInfo)
        if let property = nodeInfo?["property"] as? [String: Any] {
            self.value = self.verifyExpressionSetters(key: "content", value: property["content"]) as? String
        }
    }
    
    override func updateNodePropertyValue(propertyName: String, value: Any) {
        super.updateNodePropertyValue(propertyName: propertyName, value: value)
     
        if propertyName == "content"  {
            if let content = (value as? JSON)?.string {
               self.value = content
           } else if let c = (value as? JSON)?.int {
            self.value = "\(c)"
           }
        }
    }
}
