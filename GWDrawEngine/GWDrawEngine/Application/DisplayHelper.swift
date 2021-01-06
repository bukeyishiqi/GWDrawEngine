//
//  DisplayHelper.swift
//  GWDrawEngine
//
//  Created by 陈琪 on 2020/6/24.
//  Copyright © 2020 Chen. All rights reserved.
//

import UIKit


enum DisplayContainerType: String {
    /** 列表页*/
    case listPage = "ListContainer"
    /** 滚动页*/
    case scrollPage = "ScrollContainer"
    /** 静态页*/
    case staticPage = "StaticContainer"
    
    case none
}

class DisplayHelper: NSObject {

    
    @objc static func displayPage(pageId: String, params: [String: Any]?) -> UIViewController? {
//        showPickerViewComponent(dataSource: [["男": "1"], ["女": "0"]],finishComplete: { value in
//            print("\(value)")
//        })
//        return nil
//        print("\(SettingPageJson.toJsonString()!)")
        
        guard let pageElement = PageFileManager.getPageFile(pageId: pageId) else {
            print("**** 错误的页面ID *** \n")
            return nil }
        
        // 测试
//        let pageElement = TemplateConvertHelper.convertTemplateToObj(template: EditNodeJson)
        /******/
        
        return displayLayoutElement(element: pageElement, pageId: pageId, params: params)
    }
    
    static private func displayLayoutElement(element: BaseLayoutElement, pageId: String, params: [String: Any]?) -> UIViewController? {
        
        let vc = BaseViewController(withPageId: pageId)
        vc.setRootNode(rootNode: element, param: params)
        return vc
    }
    
}

 // MARK: Private Methods

extension DisplayHelper {
    static private func getContainerType(desc: String) -> DisplayContainerType {
        if desc == "ListContainer" {
            return .listPage
        } else if desc == "ScrollContainer" {
            return .scrollPage
        } else if desc == "StaticContainer" {
            return .staticPage
        } else {
            print("****: 错误的容器类型**")
        }
        
        return .none
    }
    
    
    
    /// 递归遍历获取tableView模板元素
    /// - Parameter baseElement: 布局元素
//    static func getTableViewTemplateElement(baseElement: BaseLayoutElement) -> [BaseLayoutElement] {
//        if baseElement.viewType == "TableView" {
//            return baseElement.subViews ?? []
//        } else {
//
//            if let subViews = baseElement.subViews, subViews.count > 0 {
//                for element in subViews {
//                    getTableViewTemplateElement(baseElement: element)
//                }
//            }
//
//        }
//
//        return []
//    }
}
