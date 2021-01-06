//
//  GWCommitBusinessRequest.h
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/17.
//  Copyright © 2020 Gworld. All rights reserved.
//

#import "GWApiRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface GWCommitBusinessRequest : GWApiRequest

/** var params: [String : Any] = ["method": method, "service": service, "url": url]
if let p = param {
    params["param"] = p
} */

//! 转发接口方式
@property (nonatomic, copy) NSString *method;
//! 转发接口传参Json字符串
@property (nonatomic, copy) NSString *param;
//! 转发服务
@property (nonatomic, assign) NSString *service;
//! 转发接口路径
@property (nonatomic, assign) NSString *url;

@end

NS_ASSUME_NONNULL_END
