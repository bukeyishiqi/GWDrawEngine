//
//  ToastComponentHelper.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/23.
//  Copyright © 2020 Gworld. All rights reserved.
//

import UIKit

class ToastComponentHelper: NSObject {

    /// 构建默认风格的Toast组件
    /// - Parameter layoutElement: 绘制元素节点
    /// - Parameter message: 显示信息
    static func showToast(template: String, message: String) {
        let node = TemplateManager.shared.createTemplateNodeTreeForType(type: template)
        ToastUtils.showToastByToastNode(node: node as! ToastNode, message: message)
    }

    
}
