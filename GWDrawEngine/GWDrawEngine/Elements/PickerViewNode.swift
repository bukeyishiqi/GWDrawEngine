//
//  PickerViewNode.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/22.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation


class PickerViewNode: BaseLayoutElement {
    
    var rowHeight: Int?

    override init(nodeInfo: [String : Any]?) {
        super.init(nodeInfo: nodeInfo)

        if let property = nodeInfo?["property"] as? [String: Any] {
            self.rowHeight = property["rowHeight"] as? Int
        }
    }
}
