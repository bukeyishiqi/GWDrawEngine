//
//  TargetType.swift
//  icar
//
//  Created by 陈琪 on 2019/12/12.
//  Copyright © 2019 Carisok. All rights reserved.
//

import Foundation


public typealias Parameters = [String: Any]

public protocol TargetType {
    
    var path: String { get }
    
//    var method: FCRequestMethod { get }
    
    var parameters: Parameters? { get }
    
    var headers: [String: String] { get }
    
    var sampleData: Data? { get }
}



// MARK: 添加额外参数
extension TargetType {
    
    public var headers: [String: String] {
        let params = ["Authorization":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1OTQ0MzMyNDAsImp0aSI6IjEwMDMyOSIsImlhdCI6MTU5NDM0Njg0MH0.MVRRF2v8mBzW9ECbzQ2Gq1GX-84izsGv52uDSPM-VTs",
                              "hashId":"2AD0B85C-7A9A-42ED-A185-3E09A8AA1CA0",
                              "gwtoken":"203ac0cdccaaa4bb49541408f9ec6280",
                              "token":"9560643fa0df22f7641ff06dcdc05968d0933ed5e69d0e518216ffebfd74f2d0"]
        
//        params["Accept"] = "application/json"
//        params["Content-Type"] = "application/json"
        // token
//        params["token"] = ""
//        // gwtoken
//        params["gwtoken"] = ""
//
//        // hashId
//        params["hashId"] = ""
//
//        // Authorization
//        params["Authorization"] = ""

        return params
    }
    
    func addExtraParams() -> Parameters {
        guard var params = self.parameters else {
            return ["platform": 1]
        }
        params["platform"] = 1
        return params
    }
}

// MARK: 转换到请求对象fcapirequest
extension TargetType {
//    func converTorequestObj() -> FCApiRequest {
//        return FCApiRequest.init(widthRequestPath: self.path, params: self.addExtraParams(), method: self.method, header: self.headers)
//    }
//    
//    
    func converToGWRequestObj() -> GWApiRequest? {
        guard let api = self as? API else {
            return nil
        }
        switch api {
        case .commitBusiness(method: let method, service: let service, url: let url, param: let p):
            let commitBusRequest = GWCommitBusinessRequest()
            commitBusRequest.method = method
            commitBusRequest.service = service as NSString
            commitBusRequest.url = url as NSString
            commitBusRequest.platform = 1
            if let param = p {
                commitBusRequest.param = param
            }
            
            return commitBusRequest
        case .getPageData(inFirstPage: let first, page: let page, version: let v, param: let p):
            let pageDetailRequest = GWPageDetailRequest()
            pageDetailRequest.inFirstPage = first
            pageDetailRequest.page = page
            pageDetailRequest.version = v
            pageDetailRequest.platform = 1
            if let param = p {
                pageDetailRequest.param = param
            }
            return pageDetailRequest
        }
        
        return nil
    }
}
