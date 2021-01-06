//
//  Serializable.swift
//  iboss
//
//  Created by 陈琪 on 2018/6/21.
//  Copyright © 2018年 Carisok. All rights reserved.
//

import Foundation


public protocol ModelSerializable: Codable {

}



/**
 *  解析通用数据
 */
extension ModelSerializable {
    static func toObject(data: Data) -> Self? {

        let decoder = JSONDecoder()
        do {
           let obj = try decoder.decode(Self.self, from: data)
            
            return obj

        } catch let error {
            print("\(String(describing: error))")
        }
        return nil
    }
}



/**
 * 解析API接口数据
 */
extension ModelSerializable {
    /** API接口数据转对象*/
    static func apiToObj(data: Data) -> Self? {
        
        let decoder = JSONDecoder()
        do {
           let obj = try decoder.decode(ModelService<Self>.self, from: data)
            
            return obj.data

        } catch let error {
            print("\(String(describing: error))")
        }
        return nil
    }
    
    /** API接口数据转对象数组*/
    static func apiToArrayObj(data: Data) -> [Self]? {
        
        let decoder = JSONDecoder()
    
        do {
           let array = try decoder.decode([Self].self, from: data)

            return array
        } catch let error {
            print("\(String(describing: error))")
        }
        return nil
    }
}


/**
 * Model编码与解码
 */
extension ModelSerializable {
    
    /** 编码*/
    func encoding() -> Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }
    
    /** 解码*/
    static func decoding(data: Data) -> Self? {
        let decoder = JSONDecoder()
        let obj = try? decoder.decode(self, from: data)
        return obj
    }
}

/**
 *  网络数据service模型
 */
struct ModelService<T: ModelSerializable>: ModelSerializable {
    
    var errcode: Int
    
    var errmsg: String
    
    var data: T
}

