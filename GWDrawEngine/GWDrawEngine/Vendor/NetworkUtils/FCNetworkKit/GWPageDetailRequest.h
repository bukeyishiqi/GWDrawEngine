//
//  GWPageDetailRequest.h
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/17.
//  Copyright © 2020 Gworld. All rights reserved.
//

#import "GWApiRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface GWPageDetailRequest : GWApiRequest

//! 页面标识
@property (nonatomic, copy) NSString *page;
//! 页面接口传参Json字符串
@property (nonatomic, copy) NSDictionary *param;
//! 页面版本
@property (nonatomic, assign) NSInteger version;
//! 是否为页面的第一次加载
@property (nonatomic, assign) NSInteger inFirstPage;

@end

NS_ASSUME_NONNULL_END
