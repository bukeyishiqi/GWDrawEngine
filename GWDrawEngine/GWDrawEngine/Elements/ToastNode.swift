//
//  ToastNode.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/23.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation



class ToastNode: BaseLayoutElement {
    
    var titleColor: String?
    var messageColor: String?
    var titleFont: Int?
    
    var position: Int? // 0 上 1、中 2、下
    
    override init(nodeInfo: [String : Any]?) {
        super.init(nodeInfo: nodeInfo)

        if let property = nodeInfo?["property"] as? [String: Any] {
//            self.backgroudColor = property["backgroundColor"] as? String
            self.titleColor = property["titleColor"] as? String
            self.messageColor = property["messageColor"] as? String
            self.titleFont = property["titleFont"] as? Int
            self.position = property["position"] as? Int
        }
    }
    
    
    
    func getPosition() -> ToastPosition {
        if self.position == 0 {
            return .top
        }
        
        if self.position == 1 {
            return .center
        }
        
        if self.position == 2 {
            return .bottom
        }
        return .bottom
    }
}
