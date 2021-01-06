//
//  GWApiManager.m
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/17.
//  Copyright © 2020 Gworld. All rights reserved.
//

#import "GWApiManager.h"

@implementation GWApiManager

/** 发起请求*/
+ (void)sendRequest:(GWApiRequest *)apiRequest complete:(void(^)(GWApiResponse *response))completeBlock failure:(void(^)(GWApiError *erro))failureError
{
    
//    [GWLNetworkModule sendRequest:apiRequest receiveResponse:^(id<GWLNetworkTaskProtocol>  _Nonnull task) {
//        GWApiResponse *response = (GWApiResponse *)task.sessionResponse;
//
//        if (completeBlock) {
//            completeBlock(response);
//        }
//    } error:^(id<GWLNetworkErrorProtocol>  _Nullable error) {
//        NSLog(@"****DrawEngine Request Error:%@", [error description]);
//        GWApiError *err = (GWApiError *)error.error;
//        if (failureError) {
//            failureError(err);
//        }
//    }];
}
@end
