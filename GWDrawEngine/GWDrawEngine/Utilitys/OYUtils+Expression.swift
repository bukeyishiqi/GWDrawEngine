//
//  OYUtils+Expression.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/8.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation


 // MARK: 处理表达式值替换
extension OYUtils {
    
    
    /// 替换单个变量
    /// - Parameters:
    ///   - expresion: 单变量
    ///   - sourceData: 替换源
    class func replaceSignExpressionValue(expresion: Any, sourceData: Data) -> Any {
        var newE = expresion
        // 判断value是否为表达式
        if let valueString = expresion as? String {
            // 验证是否为表达式
            if valueString.hasPrefix("${") && valueString.hasSuffix("}") {
                let path = (valueString as NSString).substring(with: NSRange.init(location: 2, length: valueString.count - 3))
                
                // 通过path查找对应的值
                 if let newValue = (OYUtils.getValueFromJsonData(data: sourceData, path: path) as? JSON)?.object {
                   // 替换当前值
                   newE = newValue
                }
            }
        }
        return newE
    }
    
    
    /// 替换map中的变量
    /// - Parameters:
    ///   - originMap: 被替换的map
    ///   - sourceData: 变量来源数据
    class func replaceExpressionValue(originMap: [String: Any], sourceData: Data) -> [String: Any] {
        var newMap = originMap
        
        // 通过当前页面状态容器设置对应状态值
        for (key, value) in originMap {
            // 判断value是否为表达式
            if let valueString = value as? String {
                // 验证是否为表达式
                if let path = OYUtils.verifyExpressionSetters(expression: valueString) {
                    // 通过path查找对应的值
                     if let newValue = (OYUtils.getValueFromJsonData(data: sourceData, path: path) as? JSON)?.object {
                       // 替换当前值
                       newMap[key] = newValue
                     } else {
                        newMap[key] = nil
                    }
                }
            } else if let valueMap = value as? [String: Any] { // value 为字典，查询里面是否包含表达式
                let newSubMap = replaceExpressionValue(originMap: valueMap, sourceData: sourceData)
                newMap[key] = newSubMap
                
            } else if var valueArray = value as? [[String: Any]] { // value为数组，查询数组下元素的变量
                for index in 0..<valueArray.count {
                    let item = valueArray[index]
                    valueArray[index] = replaceExpressionValue(originMap: item, sourceData: sourceData)
                }
                newMap[key] = valueArray
            }
        }
        
        return newMap
    }
    
//    "@sex": ["stateKey": "${accountService.sex}", "stateValue": ["":""], "replaceSource": ["1": ["sex": "男"], "0": ["sex": "女"]]],

    class func relaceStateExpressionValue(originMap: [String: Any], sourceData: Data) -> [String: Any] {
        var newMap = originMap

        for (key, value) in originMap {
            if key.hasPrefix("@") { // 为多状态变量
                if var stateInfoValue = value as? [String: Any] {
                   stateInfoValue = replaceExpressionValue(originMap: stateInfoValue, sourceData: sourceData)
                    
                    // 获取 stateKey 的值
                    if let sateKey = OYUtils.convertAnyValueToString(value: stateInfoValue["stateKey"]) {
                        
                        // 从replaceSource中获取对应的状态值 替换 stateValue 对应的value
                        if let replaceSource = stateInfoValue["replaceSource"] as? [String: Any] {
                            stateInfoValue["stateValue"] = replaceSource[sateKey]
                        } else {
                            
                        }
                    }
                    
                    newMap[key] = stateInfoValue
                }
                
                
            }
        }
        return newMap
    }
    
    
    
    /// 替换格式表达式中的值
    /// - Parameters:
    ///   - format: 表达式
    ///   - value: 替换值
    class func replaceFormatExpressValue(format: String, value: Any) -> String {
        if let intValue = value as? Int {
            return (format as NSString).replacingOccurrences(of: "%@", with: "\(intValue)")
        } else if let stringValue = value as? String {
            return (format as NSString).replacingOccurrences(of: "%@", with: stringValue)
        }
        return format
    }
    
    
    /// 验证是否包含表达式
    /// - Parameter string: 验证的字符串
    class func verifyContainerFormat(string: String) -> Bool {
        if string.contains("%@") {
            return true
        }
        return false
    }
    
    
    /// 验证是否为变量表达式
    /// - Parameter string: 字符串
    /// - Returns:
    class func verifyExpression(string: String) -> Bool {
        return string.hasPrefix("${") && string.hasSuffix("}")
    }
    
    
    /// 获取变量表达式路径
    /// - Parameter expression: 变量表达式
    /// - Returns: 路径
    class func verifyExpressionSetters(expression: Any?) -> String? {
       // 验证是否为字符串类型
       if let valueString = expression as? String {
           // 验证是否为表达式
           if verifyExpression(string: valueString) {
               let path = (valueString as NSString).substring(with: NSRange.init(location: 2, length: valueString.count - 3))
               return path
           }
       }
       return nil
    }
}


extension OYUtils {
    class func convertAnyValueToString(value: Any?) -> String? {
        if let stringValue = value as? String {
            return stringValue
        }
        
        if let intValue = value as? Int {
            return "\(intValue)"
        }
        return nil
    }
    
    
    /// 验证两个包含字典的数组是否相等
    /// - Parameters:
    ///   - orignDic: 源数组
    ///   - otherDic: 比较数组
    class func verifyDicEqual(orignDic: [[String: Any]], otherDic: [[String: Any]]) -> Bool {

        if orignDic.count != otherDic.count {
            return false
        }
        
        for index in 0..<orignDic.count {
            
            let o: NSDictionary = (orignDic[index] as? NSDictionary)!
            let t = otherDic[index]
            if !o.isEqual(to: t) {
                return false
            }
        }
        
        return true
    }
}
