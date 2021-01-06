//
//  CollectionViewNode.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/22.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation


class CollectionViewNode: BaseLayoutElement {
    var scrollDirection: String?
    var minimumLineSpacing: Int?
    var minimumInteritemSpacing: Int?
    var sectionInset: [Int]?
    var itemWidth: Int?
    var itemHeight: Int?
    var itemRatio: Double? // 子控件宽高比值
    var column: Int? // 列

    
    var templatesReflect: [String: Any]?
        
    /** 需要添加在section的尾部数据 key为分区索引*/
    var sectionsSuffix: [String: Any]?
    
    /** tableView静态分区*/
    var staticSections: [TableSection]?
    var dynamicSections: [TableDynamicSection]?
    
    var refreshControl: RefreshControl?
     
   override init(nodeInfo: [String: Any]?) {
        super.init(nodeInfo: nodeInfo)
        
        if let property = nodeInfo?["property"] as? [String: Any] {
            self.scrollDirection = property["scrollDirection"] as? String
            self.minimumLineSpacing = property["minLineSpacing"] as? Int
            self.minimumInteritemSpacing = property["minInteritemSpacing"] as? Int
            self.sectionInset = property["sectionInset"] as? [Int]
            self.itemRatio = property["itemRatio"] as? Double
            self.column = property["column"] as? Int
            self.itemWidth = property["itemWidth"] as? Int
            self.itemHeight = property["itemHeight"] as? Int
        }
    
      // 模板映射格式数据
          if let templatesReflect = nodeInfo?["templatesReflect"] as? [String: Any] {
              self.templatesReflect = templatesReflect
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
  }

      
      
}
