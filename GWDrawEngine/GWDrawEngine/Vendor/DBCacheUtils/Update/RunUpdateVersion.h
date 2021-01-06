//
//  RunUpdateVersion.h
//  imall
//
//  Created by 陈琪 on 16/5/6.
//  Copyright © 2016年 QJM. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 执行方法*/
FOUNDATION_EXPORT SEL ReplaceVersionFile(NSString *text);

@interface RunUpdateVersion : NSObject
/** 获取版本号*/
+ (NSArray *)getUpdateVersions;

@end
