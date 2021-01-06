//
//  NSObject+OTSharedInstance.h
//  FCIMMobile
//
//  Created by 陈琪 on 16/4/5.
//  Copyright © 2016年 carisok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (OTSharedInstance)

@end

@protocol OTSharedInstance <NSObject>
@optional
+ (instancetype)sharedInstance;
+ (void)freeSharedInstance;
@end