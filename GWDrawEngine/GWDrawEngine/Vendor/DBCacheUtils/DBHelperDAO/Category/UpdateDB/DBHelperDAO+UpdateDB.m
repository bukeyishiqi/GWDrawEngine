//
//  DBHelperDAO+UpdateDB.m
//  imall
//
//  Created by 陈琪 on 16/5/6.
//  Copyright © 2016年 QJM. All rights reserved.
//

#import "DBHelperDAO+UpdateDB.h"

@implementation DBHelperDAO (UpdateDB)

#pragma mark /**---------- 查询 -----------*/
#pragma mark /** 查询当前更新文件版本 */
+ (NSString *)queryUpdateTable{
    __block NSArray *array = nil;
    [DBHelperDAO queryTableAsynchronous:NO tableName:SQL_DATABASEVERSION where:nil orderBy:nil offset:0 count:-1 complete:^(NSArray *resultArr) {
        array = resultArr;
    }];
    return array.firstObject[DatabaseVersion_Version];
}

#pragma mark /**--------------- 增加 ------------*/
#pragma mark /** 插入数据库 */
+ (BOOL)insertOrUpdateTableWithVersion:(NSString *)version{
    __block int count = 0;
    [DBHelperDAO queryCountFromTableAsynchronous:NO tableName:SQL_DATABASEVERSION where:nil complete:^(int number) {
        count = number;
    }];

    NSDictionary *dic = [DBUtility dictionaryWithKeyFormat:@[DatabaseVersion_Version] ValueFormat:version, nil];
    if (count) {/** 更新 */
        __block BOOL isExsite = NO;
        [DBHelperDAO updateTableAsynchronous:NO tableName:SQL_DATABASEVERSION dic:dic where:nil complete:^(BOOL result) {
            isExsite = result;
        }];
        return isExsite;
    } else {/** 插入 */
        __block BOOL isExsite = NO;
        [DBHelperDAO insertTableAsynchronous:NO tableName:SQL_DATABASEVERSION dic:dic complete:^(BOOL result) {
            isExsite = result;
        }];
        return isExsite;
    }
    return NO;
}


@end
