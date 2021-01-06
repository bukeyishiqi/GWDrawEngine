//
//  CustomRefreshFooter.h
//  icar
//
//  Created by 陈琪 on 2020/3/11.
//  Copyright © 2020 Carisok. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomRefreshFooter : MJRefreshAutoNormalFooter

/** 创建footer */
+ (instancetype)footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock lineBgColor:(UIColor *)bgColor;
/** 创建footer */
+ (instancetype)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action lineBgColor:(UIColor *)bgColor;

@end

NS_ASSUME_NONNULL_END
