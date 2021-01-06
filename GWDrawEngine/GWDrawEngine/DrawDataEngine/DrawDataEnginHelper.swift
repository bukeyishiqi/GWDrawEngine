//
//  DrawDataEnginHelper.swift
//  GWDrawEngine
//
//  Created by 陈琪 on 2020/6/23.
//  Copyright © 2020 Chen. All rights reserved.
//

import UIKit

/// 设置各层级View相关内容
class DrawDataEnginHelper: NSObject {

    /// 更新变量节点
    /// - Parameters:
    ///   - rootView: 根视图
    ///   - variableNodes: 存在变量的节点
    static func updateContainerView(rootView: UIView, variableNodes: [BaseLayoutElement]) {
        if variableNodes.count == 0 {
            return
        }
        for subView in rootView.subviews {
               updateSubPageViewData(view: subView, variableNodes: variableNodes)
               if subView.subviews.count > 0 {
                   updateContainerView(rootView: subView, variableNodes: variableNodes)
               }
        }
    }

    // 判断是否需要更新子节点
    static func updateSubPageViewData(view: UIView, variableNodes: [BaseLayoutElement]) {
        // 通过节点更新 View
        for node in variableNodes {
            if let updateID = node.id, let oldId = view.node?.id, updateID == oldId {
                updatePageSubViewByNode(element: node, view: view)
            }
        }
    }
    
    
    // 更新子节点
    static private func updatePageSubViewByNode(element: BaseLayoutElement, view: UIView) {

        // 通过新的节点属性刷新view
        view.node = element // 重置
        
        // 重关联状态节点获取关联的状态属性值
        DrawComponentsUtils.setComponentPropertys(view: view, element, parent: view.superview)
    }


}



 // MARK: 更新动态节点
extension DrawDataEnginHelper {
    static func updateDynamicNode(dNodes: [BaseLayoutElement], parent: UIView) {
        for node in dNodes {
           let _ = DrawEngineHelper.drawViewFromDataSource(node, parent: parent)
        }
    }
}


extension DrawDataEnginHelper {
    
    static func updateSingleNodeState(view: UIView, isSelected: Bool) {
        
        // 只要父视图状态切换，子视图状态也需要跟着切换
        updateSubPageViewSelected(view: view, isSelected: isSelected)
        
        for subView in view.subviews {
           updateSingleNodeState(view: subView, isSelected: isSelected)
        }
        
    }

    
    // 判断是否需要更新子节点
    static func updateSubPageViewSelected(view: UIView, isSelected: Bool) {
        if let node = view.node {
            node.isSelected = (isSelected ? 1 : 0)
            updatePageSubViewByNode(element: node, view: view)

        }
    }
}
