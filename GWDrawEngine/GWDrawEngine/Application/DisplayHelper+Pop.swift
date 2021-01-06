//
//  PopHelper.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/6/30.
//  Copyright © 2020 Gworld. All rights reserved.
//

import UIKit


// 弹框显示类型
enum DisplayPopType: String {
    case pickerSelect = "PickerSelect"
    case alter = "Alter"
    case popTemplate = "popTemplate"  // 显示模板弹框
}


typealias CancelAction = () -> Void
typealias ConfirmAction = () -> Void
typealias VerfiyInputFinishAction = (_ code: String) -> Void


extension DisplayHelper {
    
    
    // 系统样式弹框
    @objc static func showSystemAlterComponent(title: String? = nil, description: String? = nil, cancelTitle: String? = nil, confirmTitle: String? = nil, cancel:CancelAction?, confirm: ConfirmAction?) {

        // 获取弹框布局文件
        // 通过页面Id 获取页面布局元素
        guard let alterElement = PageFileManager.getPageFile(pageId: "Alter") else {
            print("**** 错误的页面ID *** \n")
            return }
        
        // 把动态设置数据装换为Data
        var info = [String: Any]()
        insertMessageToDic(key: "title", msg: title, dic: &info)
        insertMessageToDic(key: "description", msg: description, dic: &info)
        insertMessageToDic(key: "cancelTitle", msg: cancelTitle, dic: &info)
        insertMessageToDic(key: "confirmTitle", msg: confirmTitle, dic: &info)
        
        PopComponentHelper.buildSystemAlterComponent(layoutElement: alterElement, updateData: info.toData(), cancelAction: cancel, confirmAction: confirm)
    }
    
    
    /// 输入框验证
    /// - Parameter complete: 验证码输入完成回调
    @objc static func showVerifyComponent(complete: VerfiyInputFinishAction?) {
        // 获取弹框布局文件
        // 通过页面Id 获取页面布局元素
        guard let verifyElement = PageFileManager.getPageFile(pageId: "Verfiy") else {
            print("**** 错误的页面ID *** \n")
            return }
        
        PopComponentHelper.buildVerifyComponent(layoutElement: verifyElement, updateData: nil, inputFinishAction: complete)
    }
    
    
    /// picker选择器
    /// - Parameters:
    ///   - title: 标题
    ///   - dataSource: 数据源
    ///   - finishComplete: 选择完成回调
    class func showPickerViewComponent(title: String? = nil, height: Int?, dataSource: Any, finishComplete:((_ selectedValue: Any) -> Void)? = nil) {
        
        guard let pickerElement = PageFileManager.getPageFile(pageId: "PickerSelect") else {
        print("**** 错误的页面ID *** \n")
        return }
        
        // 把动态设置数据装换为Data
        var info = [String: Any]()
        insertMessageToDic(key: "title", msg: title, dic: &info)
        insertMessageToDic(key: "height", msg: height, dic: &info)

        PopComponentHelper.buildPickerViewComponent(layoutElement: pickerElement, updateData: info.toData(), updateHeight: height, dataSource: dataSource, finishComplete: finishComplete)
    }
    
    /// 显示模板弹框
    class func showTemplateView(tempalteType: String, updateData: [String: Any]?) {
        if let templateNode = TemplateManager.shared.createTemplateNodeTreeForType(type: tempalteType, updateArgs: updateData) {
            PopComponentHelper.buildTemplateViewComponent(node: templateNode, udapteDta: updateData?.toData())
        }
    }
}


 // MARK: Private Methods
extension DisplayHelper {
    
    /// 插入数据到字典，并过滤空数据
    /// - Parameters:
    ///   - msg: 要插入的数据
    ///   - dic: 要改变的字段
   private static func insertMessageToDic(key: String, msg: Any?, dic: inout [String: Any]) {
        if let s = msg {
            dic[key] = s
        }
    }
}
