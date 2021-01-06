//
//  Utility.swift
//  FCMallMobile
//
//  Created by 陈琪 on 16/5/31.
//  Copyright © 2016年 carisok. All rights reserved.
//

import Foundation

public class OYUtils {

    // 根据时间戳创建唯一标识
    class func getOnlyIdentify() -> String {
        let timeInterval = NSDate().timeIntervalSince1970 * 1000
        return "\(timeInterval)"
    }
    
    //获取UUID
    class func getUUIDIdentify() -> String {
        let uuidRef = CFUUIDCreate(nil)
        let uuidStringRef = CFUUIDCreateString(nil,uuidRef)
        return uuidStringRef! as String
    }
}











