//
//  FCNetworkConfiguration.swift
//  icar
//
//  Created by 陈琪 on 2019/12/3.
//  Copyright © 2019 Carisok. All rights reserved.
//

import Foundation


struct Configs {

    struct Network {
        static let useStaging = true  // 测试模式
        static let loggingEnabled = false // 请求日志输出
        static let environment: Environment = .test
        static let apiversion = "1.0" // API版本
        static let loadPageCount = 20 // 加载数据条数
    }

    struct Path {
        static let Documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        static let Tmp = NSTemporaryDirectory()
    }
}


/**
 * 服务器环境配置信息
 */

enum Environment {
    /** 正式环境*/
    case formal
    /** 灰度*/
    case grey
    /** 测试环境*/
    case test
    
    
    var baseUrl: String {
        switch self {
        case .formal:
            return ""
        case .grey:
            return ""
        case .test:
            return "http://baidu.com"
        }
    }
}
