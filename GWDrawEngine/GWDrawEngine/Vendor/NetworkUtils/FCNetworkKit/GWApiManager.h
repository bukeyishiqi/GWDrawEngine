//
//  GWApiManager.h
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/17.
//  Copyright © 2020 Gworld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GWApiResponse.h"
#import "GWApiRequest.h"
#import "GWApiError.h"

NS_ASSUME_NONNULL_BEGIN

@interface GWApiManager : NSObject

/** 发起请求*/
+ (void)sendRequest:(GWApiRequest *)apiRequest complete:(void(^)(GWApiResponse *response))completeBlock failure:(void(^)(GWApiError *erro))failureError;

@end

NS_ASSUME_NONNULL_END
