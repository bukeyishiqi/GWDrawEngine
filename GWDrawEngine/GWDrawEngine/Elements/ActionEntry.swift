//
//  ActionEntry.swift
//  GWDrawEngine
//
//  Created by 陈琪 on 2020/6/24.
//  Copyright © 2020 Chen. All rights reserved.
//

import UIKit



enum ActionEntityType {
    /** 多选*/
    case selected
    /** 单选*/
    case signSelected
    /** 页面回退*/
    case pop
    /** 接口转发*/
    case commit
    /** 页面退出*/
    case showPage
    /** 结束界面的编辑状态*/
    case endViewEdit
    /** 弹框 popType区别*/
    case showPopView
    /** 清空关联的状态值*/
    case clear
    /** 数组移除关联数组元素*/
    case arrayRemove
    /** 数组移除对象元素*/
    case objRemove
    /** Toast显示*/
    case showToast
    
    /** 更新全局状态中莫个状态值*/
    case updateState
    
    case none
    
}


struct ActionEntry: Action {

    var actionType: String?
    var params: [String: Any]?
    
    /** 参数变量表达式*/
    var expressionParams: String?
    
    /** 关联的页面 (由事件触发关联)*/
    var pageIdentify: String?
    /** 关联的View*/
    var connectView: UIView?
    /** 当前方法包含的子方法*/
    var subActions: [ActionEntry]?
    
    init(actionInfo: [String: Any]?) {
        self.actionType = actionInfo?["actionType"] as? String
        self.params = actionInfo?["params"] as? [String: Any]
        
        
        if let exparmas = actionInfo?["expressionParams"] as? String, exparmas.hasPrefix("${") && exparmas.hasSuffix("}") {
            self.expressionParams = exparmas
        } else { // 非字符串类型，验证是否为字典，否则格式错误
            
            if let exparamsInfo =  actionInfo?["expressionParams"] as? [String: Any], self.params == nil {
                self.params = exparamsInfo
            }
        }
        
        if let subActions = actionInfo?["subActions"] as? [[String: Any]], subActions.count > 0 {
            self.subActions = [ActionEntry]()
            for info in subActions {
                self.subActions?.append(ActionEntry.init(actionInfo: info))
            }
        }
    }
    
    
    func getType() -> ActionEntityType {
        if self.actionType == "selected" {
            return .selected
        } else if self.actionType == "signSelected" {
            return .signSelected
        } else if self.actionType == "pop" {
            
            return .pop
        } else if self.actionType == "commit" {
            
            return .commit
        } else if self.actionType == "showPage" {
            return .showPage
        } else if self.actionType == "endViewEdit" {
            return .endViewEdit
        } else if self.actionType == "showPopView" {
            return .showPopView
        } else if self.actionType == "clear" {
            return .clear
        } else if self.actionType == "arrayRemove" {
            return .arrayRemove
        } else if self.actionType == "showToast" {
            return .showToast
        } else if self.actionType == "objRemove" {
            return .objRemove
        } else if self.actionType == "updateState" {
            return .updateState
        }
        
        
        return .none
    }
}
