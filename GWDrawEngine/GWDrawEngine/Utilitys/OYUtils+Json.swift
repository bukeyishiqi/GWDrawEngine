//
//  OYUtils+Json.swift
//  iboss
//
//  Created by 陈琪 on 2018/6/25.
//  Copyright © 2018年 Carisok. All rights reserved.
//

import Foundation

//import SwiftyJSON

/**
 *  扩展字典：字典转json字符串，json字符串转字典
 */
extension Dictionary {
    // MARK: 字典转json字符串
    func toJsonString() -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions(rawValue: 0)) else {
            return nil
        }
        return String.init(data: data, encoding: .utf8)
    }
    
    
    func toData() -> Data? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else {
            return nil
        }
        
        return data
    }
}

extension NSArray {
    func toJsonString() -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) else {
            return nil
        }
        return String.init(data: data, encoding: .utf8)
    }
}

extension Array {
    func toJsonString() -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: .fragmentsAllowed) else {
            return nil
        }
        return String.init(data: data, encoding: .utf8)
    }
}

extension String {
    // MARK: json字符串转字典
    func jsonDictionary() -> [String:Any]? {
        
        let json = JSON.init(stringLiteral: self)
        return json.dictionaryObject
    }
    
    func toDictionary() -> [String: Any]? {
        guard let dic = try? JSONSerialization.jsonObject(with: self.data(using: .utf8)!, options: JSONSerialization.ReadingOptions(rawValue: JSONSerialization.ReadingOptions.RawValue(0))) else {
            return nil
        }
        return dic as? [String: Any]
    }
}

extension OYUtils {
    
    class func json(data: Any) -> JSON {
        return JSON(data)
    }
    
   class func jsonDctionary(data: Any) ->  [String: JSON]?  {
        
        let json = JSON(data)
        
        return json.dictionary
    }
    
    class func dictionary(data: Any) -> [String: Any]? {
        let json = JSON(data)
        
        return json.dictionaryObject
    }
}


extension OYUtils {
    /// 通过路径重JsonData获取对应的值
    /// - Parameters:
    ///   - data: 数据源
    ///   - path: 路径
    class func getValueFromJsonData(data: Data, path: String) -> Any? {
        // 解析路径层级
        let levels = path.components(separatedBy: ".")
        
        if let dataJson = try? JSON.init(data: data), levels.count > 0 {
                        
            var tempJson: JSON? = dataJson.dictionary?[levels[0]]
            for index in 1..<levels.count {
                tempJson = tempJson?.dictionary?[levels[index]]
            }
            return tempJson
            
        } else {
            print("**** 生成解析数据失败 ****")
        }
        
        return nil
    }
    
    
    /// 插入一个字典到另一个字典
    /// - Parameters:
    ///   - insertMap: 插入的字典
    ///   - map: 被插入的字典
    class func insertMapToMap(insertMap: [String: Any]?, map: [String: Any]?) -> [String: Any]? {
        var newMap = map
        if let iMap = insertMap {
            if newMap == nil {
                newMap = [String: Any]()
            }
            for (key, value) in iMap {
                newMap![key] = value
            }
            return newMap
        } else {
            return newMap
        }
    }
}
