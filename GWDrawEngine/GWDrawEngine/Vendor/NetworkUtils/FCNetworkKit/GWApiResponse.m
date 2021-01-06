//
//  GWApiResponse.m
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/17.
//  Copyright © 2020 Gworld. All rights reserved.
//

#import "GWApiResponse.h"

@interface GWApiResponse ()

@property (nonatomic, assign) GWResponseStatusType responseStatusType;

@property (nonatomic, assign) NSInteger serverResponseStatusCode; // 服务端返回的status code

@property (nonatomic, strong) id responseDataObject; // 接口返回Data字段对应数据

@property (nonatomic, strong) NSData *responseData; // 接口返回Data数据

@property (nonatomic, copy) NSString *responseMessage; // 接口返回字符串消息，如果是错误消息也在此属性

@property (nonatomic, assign) BOOL success;

@end


@implementation GWApiResponse


- (instancetype)initWithResponseData:(NSDictionary *)response
{
    if (self = [super init]) {
        [self updateStatusCodesWithData:response];

    }
    return self;
}

#pragma mark - private
- (void)updateStatusCodesWithData:(NSDictionary *)response {
    
    self.responseDataObject = response[@"data"];
    self.serverResponseStatusCode = [response[@"code"] integerValue];
    self.responseMessage = response[@"message"];
    self.success = [response[@"success"] intValue] == 1 ? YES : NO;

    if (self.success == YES) {
        self.responseStatusType = GWResponseStatusTypeSuccess;
    } else {
        self.responseStatusType = GWResponseStatusBSerror;
    }
}



#pragma mark - 测试数据接口
+ (GWApiResponse *)stubbingResponseWidthSampleData:(NSData *)data;
{
    GWApiResponse *response = [GWApiResponse new];
    
    response.responseDataObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    response.serverResponseStatusCode = 0;
    response.success = YES;
    response.responseMessage = @"测试数据";
    response.responseData = data;
    response.responseStatusType = GWResponseStatusTypeSuccess;

    return response;
}
@end
