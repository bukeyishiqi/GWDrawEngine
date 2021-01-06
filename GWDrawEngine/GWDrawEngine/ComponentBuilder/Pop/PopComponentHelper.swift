//
//  PopComponentBuilder.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/6/30.
//  Copyright © 2020 Gworld. All rights reserved.
//

import UIKit


/// 弹框组件构造
class PopComponentHelper: NSObject {

    
    /// 构造系统弹框显示
    /// - Parameters:
    ///   - layoutElement: 布局元素
    ///   - updateData: 动态更新数据
    ///   - cancelAction: 取消回调
    ///   - confirmAction: 确认回调
    static func buildSystemAlterComponent(layoutElement: BaseLayoutElement,updateData: Data?, cancelAction:(()->Void)? = nil, confirmAction: (()->Void)? = nil) {
        
        DispatchQueue.main.async {
            let popView = PopComponentContainer.init(layoutElement: layoutElement, updateData: updateData, cancelAction: cancelAction, confirmAction: confirmAction)
            popView.show()
        }
    }
    
    
    /// 构造验证码输入弹框
    /// - Parameters:
    ///   - layoutElement: 布局元素
    ///   - updateData: 动态更新数据
    ///   - inputFinishAction: 验证码输入完成回调
    static func buildVerifyComponent(layoutElement: BaseLayoutElement, updateData: Data?, inputFinishAction: VerfiyInputFinishAction?) {
        let popView = PopComponentContainer.init(layoutElement: layoutElement, updateData: updateData, inputVerifyFinishAction: inputFinishAction)
        popView.show()

    }
    
    /// picker选择弹框
    static func buildPickerViewComponent(layoutElement: BaseLayoutElement, updateData: Data?, updateHeight: Int?, dataSource: Any, finishComplete:((_ selectedValue: Any) -> Void)?) {
        let popView = PopComponentContainer.init(layoutElement: layoutElement, dataSource: dataSource, updateData: updateData,updateHeight: updateHeight, finishComplete: finishComplete)
        popView.show()
    }
    
    /// Template弹框
    static func buildTemplateViewComponent(node: BaseLayoutElement, udapteDta: Data?) {
        let popV = PopComponentContainer.init(layoutElement: node, updateData: udapteDta)
        popV.show()
    }
}
