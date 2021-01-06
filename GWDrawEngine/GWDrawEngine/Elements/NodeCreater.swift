//
//  NodeCreater.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/22.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation


/// 构建节点元素
class NodeCreater {

    /// 根据类型创建节点
    /// - Parameter nodeInfo: 节点参数
    class func createLayoutNode(nodeInfo: [String: Any]) -> BaseLayoutElement? {
        // 是否为模板
        if let templateType = nodeInfo["templateType"] as? String {
            
            let updateArgs = nodeInfo["property"] as? [String: Any]
            return TemplateManager.shared.createTemplateNodeTreeForType(type: templateType,updateArgs: updateArgs)
        }
        
        // 是否为View节点
        // 获取类型
        guard let typeS = nodeInfo["viewType"] as? String else {
            print("**** 组件类型不能为空！\n ***")
            return nil
        }

        switch CommponentType.init(rawValue: typeS) {
        case .view:
            return BaseLayoutElement.init(nodeInfo: nodeInfo)
        case .stackView:
            return StackViewNode.init(nodeInfo: nodeInfo)
        case .text:
            return TextNode.init(nodeInfo: nodeInfo)
        case .button:
            return ButtonNode.init(nodeInfo: nodeInfo)
        case .imageView:
            return ImageViewNode.init(nodeInfo: nodeInfo)
        case .gwSwitch:
            return SwitchNode.init(nodeInfo: nodeInfo)
        case .tableView:
            return TableViewNode.init(nodeInfo: nodeInfo)
        case .textField:
            return TextFieldNode.init(nodeInfo: nodeInfo)
        case .pickerView:
            return PickerViewNode.init(nodeInfo: nodeInfo)
        case .collectionView:
            return CollectionViewNode.init(nodeInfo: nodeInfo)
        case .toast:
            return ToastNode.init(nodeInfo: nodeInfo)
        case .pageView:
            return PagesNode.init(nodeInfo: nodeInfo)
        default:
            print("**** 不存在的未知类型:\(typeS) **** \n")
            return BaseLayoutElement.init(nodeInfo: nodeInfo)
        }
    }
    
}
