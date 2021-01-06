//
//  GWApiResponse.h
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/17.
//  Copyright © 2020 Gworld. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, GWResponseStatusType) {
    GWResponseStatusBSerror = -1,
    GWResponseStatusTypeSuccess = 0, //操作成功
    /** Token失效*/
    GWResponseStatusTypeExpiryToken = 106,
    GWResponseStatusTypeArgsError = 99, // 参数错误
};


@interface GWApiResponse : NSObject

@property (nonatomic, assign, readonly) GWResponseStatusType responseStatusType;

@property (nonatomic, assign, readonly) NSInteger serverResponseStatusCode; // 服务端返回的status code

@property (nonatomic, strong, readonly) id responseDataObject; // 接口返回Data字段对应数据

@property (nonatomic, strong, readonly) NSData *responseData; // 接口返回Data数据

@property (nonatomic, copy, readonly) NSString *responseMessage; // 接口返回字符串消息，如果是错误消息也在此属性

@property (nonatomic, assign, readonly) BOOL success;


- (instancetype)initWithResponseData:(NSDictionary *)response;

#pragma mark - 测试数据接口
+ (GWApiResponse *)stubbingResponseWidthSampleData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
