//
//  FCNetWorkService.swift
//  icar
//
//  Created by 陈琪 on 2019/11/11.
//  Copyright © 2019 Carisok. All rights reserved.
//

import Foundation


public class FCNetWorkService {
    static var share = FCNetWorkService()
    
    init() {
//        FCApiManager.configWidthBaseUrl(Configs.Network.environment.baseUrl, debugLogEnabled: Configs.Network.loggingEnabled)
    }
    
    public func request(_ target:TargetType, _ complete: ((_ result: GWApiResponse) -> Void)?, _ failure:((_ error: GWApiError) -> Void)?){
        
        if Configs.Network.useStaging { // 加载本地
            if let complete = complete, let data = target.sampleData {
                let res = GWApiResponse.stubbingResponseWidthSampleData(data)
                 DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { 
                        complete(res)
                    }
            }
        } else {

            guard let request = target.converToGWRequestObj() else {
                print("**** 无效的request创建 ****\n")
                return
            }
            GWApiManager.send(request, complete: { (response) in
                if let complete = complete {
                    complete(response)
                }
            }) { (error) in
                if let fail = failure {
                    fail(error)
                }
            }
        }
 
    }
}

