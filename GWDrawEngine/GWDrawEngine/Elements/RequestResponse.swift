//
//  RequestResponse.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/2.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation


struct RequestResponse {
    
    var version: Int
    
    var layoutElement: BaseLayoutElement?
    
    var updateData: [String: Any]?
    
    
    init(info: [String: Any]?) {
        self.version = info?["version"] as? Int ?? 0
        
        // 布局节点
        if let nodeData = (info?["template"] as? [String: Any]) {
            self.layoutElement = NodeCreater.createLayoutNode(nodeInfo: nodeData)
        }
        
        if let updateD = (info?["serviceData"] as? [String: Any]) {
            self.updateData = updateD
        }
    }
}
