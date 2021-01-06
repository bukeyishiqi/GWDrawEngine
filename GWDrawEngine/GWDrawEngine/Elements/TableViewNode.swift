//
//  TableViewNode.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/22.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation


class TableViewNode: BaseLayoutElement {
    
    var style: String?
    var separatorStyle: String?
    var separatorColor: String?
    var headerHeight: Int?
    
    var templatesReflect: [String: Any]?
       
   /** 需要添加在section的尾部数据 key为分区索引*/
   var sectionsSuffix: [String: Any]?
   
   /** tableView静态分区*/
   var staticSections: [TableSection]?
   var dynamicSections: [TableDynamicSection]?
   
   var refreshControl: RefreshControl?
    
    // 侧滑Action
    var swipeActions: [GWSwipeAction]?
    
    // 空背景
    var emptyConfiguration: GWEmptyBackgroudConfig?
    
    
    override init(nodeInfo: [String : Any]?) {
        super.init(nodeInfo: nodeInfo)

        if let property = nodeInfo?["property"] as? [String: Any] {
          self.style = property["style"] as? String
          self.separatorStyle = property["separatorStyle"] as? String
          self.separatorColor = property["separatorColor"] as? String
          self.headerHeight = property["headerHeight"] as? Int
        }
        
        // 模板映射格式数据
        if let templatesReflect = nodeInfo?["templatesReflect"] as? [String: Any] {
            self.templatesReflect = templatesReflect
        }
        
        // 侧滑事件
        if let swipeActionList = nodeInfo?["swipeActions"] as? [[String: Any]], swipeActionList.count > 0 {
            self.swipeActions = [GWSwipeAction]()
            for info in swipeActionList {
                self.swipeActions?.append(GWSwipeAction.init(actionInfo: info))
            }
        }
        
        // 尾部添加的本地声明数据
        if let sectionSufix = nodeInfo?["sectionsSuffix"] as? [String: Any], sectionSufix.count > 0 {
            self.sectionsSuffix = sectionSufix
        }
    
        /*********** 设置tableView*************/
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
        
        // 刷新控件
        if let refresh = nodeInfo?["refreshControl"] as? [String: Any] {
            if let needRefresh = refresh["needRefresh"] as? Int {
                let style = refresh["style"] as? String ?? "default"
                self.refreshControl = RefreshControl(needRefresh: needRefresh == 1, style: style)
            }
        }
        
        // 空背景配置
        if let emptyConfiguration = nodeInfo?["emptyConfiguration"] as? [String: Any] {
            self.emptyConfiguration = GWEmptyBackgroudConfig.init(configInfo: emptyConfiguration)
        }
    }
    
    override func updateNodePropertyValue(propertyName: String, value: Any) {
        super.updateNodePropertyValue(propertyName: propertyName, value: value)
    }
}


 // MARK: 侧滑Action中Json实体类对象
struct GWSwipeAction {
    var title: String?
    var backgroudColor: UIColor?
    var image: String?
    // 原生方法
    var actionEntry: ActionEntry?
    
    init(actionInfo: [String: Any]?) {
        self.title = actionInfo?["title"] as? String
        self.backgroudColor = UIColor.colorFromHexString(hex: actionInfo?["backgroudColor"] as? String ?? "#ffffff")
        self.image = actionInfo?["image"] as? String
        
        if let action = actionInfo?["action"] as? [String: Any] {
            self.actionEntry = ActionEntry.init(actionInfo: action)
        }
        
    }
}


 // MARK: 空背景数据源配置
struct GWEmptyBackgroudConfig {
    var title: String?
    var titleFontSize: Int = 16
    var titleColor: UIColor = UIColor.white
    
    var description: String?
    var descriptionFontSize: Int = 14
    var descriptionColor: UIColor = UIColor.gray
    
    var emptyImage: String?
    var emptyOffset: Int = 0
    
    init(configInfo: [String: Any]?) {
        self.title = configInfo?["title"] as? String
        self.description = configInfo?["description"] as? String
        self.emptyImage = configInfo?["emptyImage"] as? String
        
        if let titleColor = configInfo?["titleColor"] as? String, titleColor.count > 0 {
            self.titleColor = UIColor.colorFromHexString(hex: titleColor)
        }
        
        if let descriptionColor = configInfo?["descriptionColor"] as? String, descriptionColor.count > 0 {
            self.descriptionColor = UIColor.colorFromHexString(hex: descriptionColor)
        }
        
        if let titleFontSize = configInfo?["titleFontSize"] as? Int {
            self.titleFontSize = titleFontSize
        }
        
        if let descriptionFontSize = configInfo?["descriptionFontSize"] as? Int {
            self.descriptionFontSize = descriptionFontSize
        }
        
        if let emptyOffset = configInfo?["emptyOffset"] as? Int {
            self.emptyOffset = emptyOffset
        }
        
    }
}
