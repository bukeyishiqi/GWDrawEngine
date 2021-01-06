//
//  RunUpdateVersion.m
//  imall
//
//  Created by 陈琪 on 16/5/6.
//  Copyright © 2016年 QJM. All rights reserved.
//

#import "RunUpdateVersion.h"
#import "DBHelperDAO.h"

FOUNDATION_EXPORT SEL ReplaceVersionFile(NSString *text)
{
    NSString *selectorName = [NSString stringWithFormat:@"execute_%@", [text stringByReplacingOccurrencesOfString:@"." withString:@"_"]];
    return NSSelectorFromString(selectorName);
}

@implementation RunUpdateVersion
/**
 *  版本号为发布版本，非当前版本， 直接在数组后面添加
 */
+ (NSArray *)getUpdateVersions
{
    return  [NSArray arrayWithObjects:@"1.400", nil];
}


#pragma mark - 各版本执行方法
- (void)execute_1_400
{
    /** 执行该版本下数据库需要更新的内容*/
    [DBHelperDAO createTable:SQL_DATABASEVERSION];
}
@end
