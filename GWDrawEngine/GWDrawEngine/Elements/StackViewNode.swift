//
//  StackViewNode.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/22.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation


class StackViewNode: BaseLayoutElement {

    // StackView容器属性
    var axis: String?
    var distribution: String?
    var alignment: String?
    var space: Int?
    
    override init(nodeInfo: [String : Any]?) {
        super.init(nodeInfo: nodeInfo)

        if let property = nodeInfo?["property"] as? [String: Any] {
            // StackView容器属性
            self.axis = property["axis"] as? String
            self.distribution = property["distribution"] as? String
            self.alignment = property["alignment"] as? String
            self.space = property["space"] as? Int
        }
    }
    
    override func updateNodePropertyValue(propertyName: String, value: Any) {
        super.updateNodePropertyValue(propertyName: propertyName, value: value)
        if propertyName == "axis", let axis = (value as? JSON)?.string {
            self.axis = axis
        }
        if propertyName == "distribution", let distribution = (value as? JSON)?.string {
            self.distribution = distribution
        }
        if propertyName == "alignment", let alignment = (value as? JSON)?.string {
            self.alignment = alignment
        }
        
        if propertyName == "space", let space = (value as? JSON)?.int {
            self.space = space
        }
    }
}
