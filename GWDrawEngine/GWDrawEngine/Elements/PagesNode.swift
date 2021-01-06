//
//  PagesNode.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/28.
//  Copyright © 2020 Gworld. All rights reserved.
//

import UIKit

class PagesNode: BaseLayoutElement {

    // 页面间距
    var interitemSpacing: Int = 10
    var leadingSpacing: Int = 0 // 边距
    
    // 是否可以无限翻页
    var isInfinite: Bool = true
    // 自动翻页间隔时间
    var automaticSlidingInterval: Int?
    // 页面转场效果
    var transformer: Int = 1
    // 缩放比例
    var scaleX: Double = 0.8
    var scaleY: Double = 1.0
    
    var decelerationDistance: Int = 1
    
    
    var staticSections: [TableSection]?
    var dynamicSections: [TableDynamicSection]?
    var templatesReflect: [String: Any]?

    var didScrollAction: ActionEntry? // 滚动选择Item事件 "value"为对应参数key
    
    override init(nodeInfo: [String : Any]?) {
        super.init(nodeInfo: nodeInfo)

        if let property = nodeInfo?["property"] as? [String: Any] {
            // StackView容器属性
            if let space = property["interitemSpacing"] as? Int {
                self.interitemSpacing = space
            }
            
            if let leadingSpacing = property["leadingSpacing"] as? Int {
                self.leadingSpacing = leadingSpacing
            }
            
            self.isInfinite = (property["isInfinite"] as? Int) == 1
            
            self.automaticSlidingInterval = property["automaticSlidingInterval"] as? Int
            
            if let transFormer = property["transformer"] as? Int {
                self.transformer = transFormer
            }
            
            if let scaleX = property["scaleX"] as? Double {
                self.scaleX = scaleX
            }
            
            if let scaleX = property["scaleY"] as? Double {
                self.scaleY = scaleX
            }
        }
        
        // 模板映射格式数据
        if let templatesReflect = nodeInfo?["templatesReflect"] as? [String: Any] {
            self.templatesReflect = templatesReflect
        }
        
        if let sections = nodeInfo?["staticSections"] as? [[String: Any]] {
            self.staticSections = [TableSection]()
            for section in sections {
                self.staticSections?.append(TableSection.init(sectionInfo: section))
            }
        }
        
        if let sections = nodeInfo?["dynamicSections"] as? [[String: Any]] {
            self.dynamicSections = [TableDynamicSection]()
            for section in sections {
                self.dynamicSections?.append(TableDynamicSection.init(sectionInfo: section))
            }
        }
        
        if let action = nodeInfo?["didScrollAction"] as? [String: Any] {
            self.didScrollAction = ActionEntry(actionInfo: action)
        }
    }
    
    override func updateNodePropertyValue(propertyName: String, value: Any) {
        super.updateNodePropertyValue(propertyName: propertyName, value: value)
    
    }
    
    
}
