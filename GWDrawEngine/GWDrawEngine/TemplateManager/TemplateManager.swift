//
//  TemplateManager.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/22.
//  Copyright © 2020 Gworld. All rights reserved.
//

import UIKit

class TemplateManager: NSObject {

    static let shared = TemplateManager()

    @objc public static func sharedInstance() -> TemplateManager {
        return TemplateManager.shared
    }
    
    
    /// 创建模板节点
    /// - Parameters:
    ///   - type: 模板类型
    ///   - updateArgs: 需要替换模板Json中参数
    /// - Returns: 模板节点
    func createTemplateNodeTreeForType(type: String, updateArgs: [String:Any]? = nil) -> BaseLayoutElement? {
        if type == "templates_0" {
            return NodeCreater.createLayoutNode(nodeInfo: templates_0)
        } else if type == "templates_1" {
            return NodeCreater.createLayoutNode(nodeInfo: templates_1)
        } else if type == "templates_2" {
            return NodeCreater.createLayoutNode(nodeInfo: templates_2)
        } else if type == "templates_3" {
            return NodeCreater.createLayoutNode(nodeInfo: templates_3)
        } else if type == "templates_4" {
            return NodeCreater.createLayoutNode(nodeInfo: templates_4)
        } else if type == "templates_5" {
            return NodeCreater.createLayoutNode(nodeInfo: templates_5)
        } else if type == "templates_6" {
            return NodeCreater.createLayoutNode(nodeInfo: templates_6)
        } else if type == "templates_7" {
            return NodeCreater.createLayoutNode(nodeInfo: templates_7)
        } else if type == "templates_8" {
            
            return NodeCreater.createLayoutNode(nodeInfo: templates_8)
            
        } else if type == "collection_templates_1" {
            return NodeCreater.createLayoutNode(nodeInfo: collection_templates_1)
        } else if type == "toast_1" {
            return NodeCreater.createLayoutNode(nodeInfo: toastTemplate)
        } else if type == "inAppNotify_templates" { // 弹框
            
            return NodeCreater.createLayoutNode(nodeInfo: inAppNotify_templates)
            
        } else if type == "smsNotify_templates" {
            return NodeCreater.createLayoutNode(nodeInfo: smsNotify_templates)
            
        } else if type == "phoneNotify_templates" {
            return NodeCreater.createLayoutNode(nodeInfo: phoneNotify_templates)
        } else if type == "navHeader_1" {
           
            guard let updateA = updateArgs else {
                return NodeCreater.createLayoutNode(nodeInfo: navigatorHeaderTemplate)
            }
            // 转换源数据为模板格式数据
            let template = OYUtils.replaceExpressionValue(originMap: navigatorHeaderTemplate, sourceData: updateA.toData()!)
            
            return NodeCreater.createLayoutNode(nodeInfo: template)
        }
        return BaseLayoutElement.init(nodeInfo: nil) // 需要设置默认模板
    }
}
