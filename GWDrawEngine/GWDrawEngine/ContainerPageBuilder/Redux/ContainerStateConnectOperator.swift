//
//  ContainerStateConnectOperator.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/14.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation


/// 处理当前页面状态容器的状态直接的关联关系
/// - Parameter currentPageState: 当前页面容器z状态
func handleStateConnectOperator(currentPageState: [String: Any]?) -> [String: Any]? {
    var newState = currentPageState
    // 处理关联的各状态值直接的关系
    if  let conditionList = currentPageState?["reducer"] as? [[String: Any]] {
    
            for conditionHandle in conditionList {
                // 获取condition
                if let condition = conditionHandle["condition"] as? [String: Any] {
                    
                    // 获取需要变更的属性
                    let changeStateProperty = conditionHandle["connectStateKey"] as? String

                    // 获取操作符 < >= <=
                    let operatorString = condition["operator"] as? String
                    
                    // 从param中获取关联的状态值
                    var argList: [Any] = [Any]()
                    if let paramList = condition["param"] as? [String] {
                        for paramItem in paramList {
                            // 获取参数列表, 如果当前状态没有则从全局状态中取
                            if let arg = newState?[paramItem] {
                                argList.append(arg as Any)
                            } else {
//                                let arg = containerStore.state[]
                                
                            }
                        }
                    }
                    
                    if let operatorResult = handleOperator(operatorDesc: operatorString, args: argList) {
                        // 获取需要的返回值
                        var returnValue = conditionHandle["returnValue"]

                        if let result = operatorResult as? Bool ,result == true { // 结果是bool
                            newState?[changeStateProperty ?? ""] = returnValue
                        } 
                        
                        // 验证returnValue是否有替换符，存在则那函数返回结果替换
                        if let returnStringValue = returnValue as? String, OYUtils.verifyContainerFormat(string: returnStringValue) {
                            
                            returnValue = OYUtils.replaceFormatExpressValue(format: returnStringValue, value: operatorResult)
                            newState?[changeStateProperty ?? ""] = returnValue
                        }

                    }
                    
                }
         }
    }
    
    return newState
}

