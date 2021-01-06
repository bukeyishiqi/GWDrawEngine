//
//  DrawEngineHelper.swift
//  GWDrawEngine
//
//  Created by 陈琪 on 2020/6/23.
//  Copyright © 2020 Chen. All rights reserved.
//

import UIKit

class DrawEngineHelper: NSObject {

    /// 生成视图渲染树
    /// - Parameters:
    ///   - baseElement: 渲染元素
    ///   - parent: 父视图
    static func drawViewFromDataSource(_ baseElement: BaseLayoutElement, parent: UIView?) -> UIView? {
        var newElement = baseElement
        // 验证是否需要通过状态节点生成
        // 判断动态属性是否存在，存在则优先通过动态属性渲染
        var needObserver = false
        if let dynamicPropertys = baseElement.dynamicProperty, let newStateElement = dynamicPropertys.stateList?[dynamicPropertys.currentState ?? ""] {
            newElement = newStateElement
            needObserver = true
        }
        
        let root = drawPageSubViewFromDataSource(newElement, parent: parent)
        // 关联节点
        root?.node = baseElement
        
        if needObserver {
            // 添加动态属性变化通知
            root?.addGlobalStateChangeNotify()
        }
        
        if  newElement.subViews.count > 0 {
            drawListView(newElement.subViews, parent: root)
        }
        
        return root
    }
    
    
    /// 遍历子视图渲染
    /// - Parameters:
    ///   - list: 子视图列表
    ///   - parent: s父视图
    static func drawListView(_ list: [BaseLayoutElement], parent: UIView?) {
        if  list.count > 0 {
            for item in list {
                drawViewFromDataSource(item, parent: parent)
            }
        }
    }
    
}


 // MARK: 生成各类型View
extension DrawEngineHelper {
    
    /// 通过View信息绘制View
    /// - Parameters:
    ///   - baseElement: 渲染元素
    ///   - parent: 父视图
    static private func drawPageSubViewFromDataSource(_ baseElement: BaseLayoutElement, parent: UIView?) -> UIView? {
        
        // 获取View类型
        let viewTypeString = baseElement.viewType
        guard let view = DrawComponentsUtils.getComponentType(viewTypeString, element: baseElement) else {
            print("**** 错误的View类型 ****")
            return nil
        }
        
        // 关联节点
        view.node = baseElement
        
        // 添加到父视图
        if let stackParent = parent as? UIStackView {
            stackParent.addArrangedSubview(view)
            
        } else if let tableView = parent as? UITableView {
            // 从header开始设置
            if tableView.tableHeaderView == nil {
                tableView.tableHeaderView = view
            } else {
                tableView.tableFooterView = view
            }
        } else {
            parent?.addSubview(view)
        }
        
        
//        // 判断动态属性是否存在，存在则优先通过动态属性渲染
//        if let dynamicPropertys = baseElement.dynamicProperty, let dProperty = dynamicPropertys.stateList?[dynamicPropertys.currentState ?? ""] {
//            DrawComponentsUtils.setComponentPropertys(view: view, dProperty, parent: parent)
//            // 添加动态属性变化通知
//            view.addGlobalStateChangeNotify()
//        } else {
//            // 通过静态属性设置View属性
//            if let propertys = baseElement.property {
//                DrawComponentsUtils.setComponentPropertys(view: view, propertys, parent: parent)
//            }
//        }
        
        // 通过静态属性设置View属性
        DrawComponentsUtils.setComponentPropertys(view: view, baseElement, parent: parent)

//        if let propertys = baseElement.property {
//        }
       
        
        return view
    }
}
