//
//  DBHelperDAO+Session.m
//  imall
//
//  Created by 陈琪 on 16/4/12.
//  Copyright © 2016年 QJM. All rights reserved.
//

#import "DBHelperDAO+PageSource.h"

@implementation DBHelperDAO (PageSource)

/** 查询页面Id是否存在*/
+ (BOOL)queryPageExist:(NSString *)pageId
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * from %@ where %@ = '%@'", SQL_PAGE, Page_Id, pageId];
    NSArray *arr = [kDBHelperDAO executeSQL:sql];
    if (arr.count > 0) {
        return YES;
    }
    return NO;
    
}

/** 查询单页面数据 */
+ (NSDictionary *)queryPageSourceWithPageId:(NSString *)pageId
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * from %@ where %@ = '%@'", SQL_PAGE, Page_Id, pageId];
    NSArray *arr = [kDBHelperDAO executeSQL:sql];
    if (arr.count > 0) {
        NSDictionary *info = arr[0];
        return info;
    }
    return nil;
}

/** 插入数据*/
+ (BOOL)insertPageSource:(NSString *)pageId layoutData:(NSString *)layoutData pageData:(NSString *)pageData version:(NSString *)version
{
    // 构建数据库信息需要对应字典
    NSMutableDictionary *dbInfo =  [NSMutableDictionary new];
    [dbInfo setValue:pageId forKey:Page_Id];
    
    if (layoutData.length > 0) {
        [dbInfo setValue:layoutData forKey:Page_layoutData];
    }
    
    if (pageData.length > 0) {
        [dbInfo setValue:pageData forKey:Page_pageData];
    }
    
    if (version.length > 0) {
        [dbInfo setValue:version forKey:Page_version];
    }
    
    __block BOOL isExsite = NO;
    [DBHelperDAO insertTableAsynchronous:NO tableName:SQL_PAGE dic:dbInfo complete:^(BOOL result) {
        isExsite = result;
    }];
    return isExsite;
}

/** 删除数据*/
+ (BOOL)deletePageSourceWithPageId:(NSString *)pageId
{
    NSString *tableName = SQL_PAGE;
    NSDictionary *where = [DBUtility dictionaryWithKeyFormat:@[Page_Id] ValueFormat:pageId, nil];
    __block BOOL isExsite = NO;
    [DBHelperDAO deleteTableAsynchronous:NO tableName:tableName where:where complete:^(BOOL result) {
        isExsite = result;
    }];
    return isExsite;
}

/** 更新页面资源数据*/
+ (BOOL)updatePageSource:(NSString *)pageId layoutData:(NSString *)layoutData pageData:(NSString *)pageData version:(NSString *)version
{
    NSString *tableName = SQL_PAGE;
    NSDictionary *where = [DBUtility dictionaryWithKeyFormat:@[Page_Id] ValueFormat:pageId, nil];
    
    // 构建数据库信息需要对应字典
    NSMutableDictionary *dbInfo =  [NSMutableDictionary new];
    if (layoutData.length > 0) {
        [dbInfo setValue:layoutData forKey:Page_layoutData];
    }
    
    if (pageData.length > 0) {
        [dbInfo setValue:pageData forKey:Page_pageData];
    }
    
    if (version.length > 0) {
        [dbInfo setValue:version forKey:Page_version];
    }

    __block BOOL isExsite = NO;
    [DBHelperDAO updateTableAsynchronous:NO tableName:tableName dic:dbInfo where:where complete:^(BOOL result) {
        isExsite = result;
    }];
    return isExsite;
}

@end
