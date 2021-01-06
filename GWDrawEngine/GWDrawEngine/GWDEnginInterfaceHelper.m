//
//  GWDEnginInterfaceHelper.m
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/6/30.
//  Copyright © 2020 Gworld. All rights reserved.
//

#import "GWDEnginInterfaceHelper.h"
#import "DBHelperDAO.h"
#import "UpdateApp.h"

/**
 Swift混编
 */
#import "GWDrawEngine-Swift.h"

@implementation GWDEnginInterfaceHelper


/// 配置引擎数据 待扩展参数
+ (void)configuration
{
    
}

/// 开启服务
+ (void)startService
{
    /** 建立数据库表*/
    [DBHelperDAO connectToDB:^{
        [UpdateApp update]; /** 更新数据库*/
    }];
}


/// 获取渲染界面
/// @param pageId 界面id
/// @param params 动态传参
+ (void)displayPageWithPageId:(NSString *)pageId rootNav:(UINavigationController *)rotNav params:(nullable NSDictionary *)params
{
    [[Application sharedInstance] initialScreenWithPageId:pageId rootNav:rotNav params:params];
}















/// 调用系统弹框
/// @param title 标题
/// @param description 描述
/// @param cancel 取消回调
/// @param confirm 确认回调
+ (void)showSystemAlterPopViewWithTitle:(nullable NSString *)title description:(nullable NSString *)description cancelBtnTitle:(nullable NSString *)cancelTitle confirmTitle:(nullable NSString *)confirmTitle cancelAction:(nullable CancelAction)cancel confirmAction:(nullable ConfirmAction)confirm
{
    [DisplayHelper showSystemAlterComponentWithTitle:title description:description cancelTitle:cancelTitle confirmTitle:confirmTitle cancel:cancel confirm:confirm];
}


/// 调用验证样式弹框
/// @param complete 验证码输入完成回调
+ (void)showVerificationPopViewComplete:(VerificationBlock)complete
{
    [DisplayHelper showVerifyComponentWithComplete:complete];
}


@end
