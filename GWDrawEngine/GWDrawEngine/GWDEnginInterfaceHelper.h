//
//  GWDEnginInterfaceHelper.h
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/6/30.
//  Copyright © 2020 Gworld. All rights reserved.
//

#import <UIKit/UIKit.h>



NS_ASSUME_NONNULL_BEGIN

typedef void(^CancelAction)(void);
typedef void(^ConfirmAction)(void);

/** 验证输入完成回调 */
typedef void(^VerificationBlock)(NSString *code);

@interface GWDEnginInterfaceHelper : NSObject

/// 配置引擎数据 待扩展参数
+ (void)configuration;

/// 开启服务
+ (void)startService;



/// 获取渲染界面
/// @param pageId 界面id
/// @apram rootNav 导航栏
/// @param params 动态传参
+ (void)displayPageWithPageId:(NSString *)pageId rootNav:(UINavigationController *)rotNav params:(nullable NSDictionary *)params;



/// 调用系统样式弹框
/// @param title 标题
/// @param description 描述
/// @param cancel 取消回调
/// @param confirm 确认回调
+ (void)showSystemAlterPopViewWithTitle:(nullable NSString *)title description:(nullable NSString *)description cancelBtnTitle:(nullable NSString *)cancelTitle confirmTitle:(nullable NSString *)confirmTitle cancelAction:(nullable CancelAction)cancel confirmAction:(nullable ConfirmAction)confirm;


/// 调用验证样式弹框
/// @param complete 验证码输入完成回调
+ (void)showVerificationPopViewComplete:(VerificationBlock)complete;

@end

NS_ASSUME_NONNULL_END
