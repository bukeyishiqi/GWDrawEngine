//
//  DBHelperDAO.m
//  FCIMMobile
//
//  Created by 陈琪 on 16/4/5.
//  Copyright © 2016年 carisok. All rights reserved.
//

#import "DBHelperDAO.h"

#import "FCDBHelper.h"
#import "FCDBUtils.h"
#import "FCDBHelper+DatabaseExecute.h"
#import "FCDBHelper+DatabaseManager.h"
#import "NSString+FilePath.h"

@interface DBHelperDAO ()

@property (nonatomic, strong) FCDBHelper *MM_DBHelper;

@end

@implementation DBHelperDAO

/** 连接数据库 */
+ (void)connectToDB:(void(^)(void))block
{
    if (kDBHelperDAO.MM_DBHelper == nil) {
        NSString *MM_SqlPath = [SQL_DATABASE_MM getDBPath];
        DLog(@"创建数据库连接：%@ %@", SQL_DATABASE_MM, MM_SqlPath);
        kDBHelperDAO.MM_DBHelper = [[FCDBHelper alloc] initWithDBNameWithPath:MM_SqlPath];
        [self createAllTable];
        /** 新增更新数据库操作 */
        if (block) {
            block();
        }
    }
}

/** 创建所有表 */
+ (BOOL)createAllTable
{
    BOOL isSuccess = NO;
    for (NSString *tableName in kDBHelperDAO.tableNames) {
        isSuccess = [DBHelperDAO createTable:tableName];
    }
    return isSuccess;
}

/** 断开数据库 */
+ (void)disconnectDB
{
    DBHelperDAO *dao = kDBHelperDAO;
    [dao.MM_DBHelper disconnectDB];
    dao.MM_DBHelper = nil;
    [DBHelperDAO freeSharedInstance];
    dao = nil;
    DLog(@"断开数据库连接");
}

/** 返回当前MM数据库路径 */
- (NSString *)MMSqlitePath
{
    return [_MM_DBHelper getDBNameWithPath];
}

/** 返回所有表名 */
- (NSArray *)tableNames
{
    return [DBUtility getTableNames];
}

/** 处理字典解析成keys和values */
- (void)splitDic:(NSDictionary *)dic result:(void(^)(NSString *keys, NSString *values))result
{
    [FCDBUtils splitDic:dic result:result];
}

/** 自定义查询SQL */
- (NSArray *)executeSQL:(NSString *)sql
{
    if (sql.length > 0) {
        return [_MM_DBHelper executeQuerySQL:sql arguments:nil];
    }
    return nil;
}

/** 自定义增、删、改SQL*/
- (BOOL)executeUpdateSQL:(NSString *)sql
{
    if (sql.length > 0) {
        return [_MM_DBHelper executeUpdateSQL:sql arguments:nil];
    }
    return NO;
}

/** 批量执行SQL */
+ (BOOL)executeStatements:(NSString *)sql
{
    if (sql.length > 0) {
        return [kDBHelperDAO.MM_DBHelper executeStatements:sql callBackBlock:nil];
    }
    return NO;
}

/** 批量执行SQL 带回调 */
- (BOOL)executeStatements:(NSString *)sql callBackBlock:(int (^)(NSDictionary *resultsDictionary))callBackBlock
{
    if (sql.length > 0) {
        return [_MM_DBHelper executeStatements:sql callBackBlock:callBackBlock];
    }
    return NO;
}

/** 判断表是否存在 */
- (BOOL)tableIsExists:(NSString *)tableName
{
    if (tableName) {
        BOOL isExists = [_MM_DBHelper tableIsExists:tableName];
        return isExists;
    }
    return NO;
}

/** 创建表 */
+ (BOOL)createTable:(NSString *)tableName
{
    if ([kDBHelperDAO tableIsExists:tableName]) {
        return YES;
    }
    NSString *createSql = [DBUtility getCreateTableSqlWithTableName:tableName];
    BOOL isCreate = [kDBHelperDAO.MM_DBHelper createTableWithSql:createSql];
    if ([tableName isEqualToString:SQL_DUAL] && isCreate) {
        NSDictionary *insertDic = @{DUAL_DUMMY:@"x"};
        [DBHelperDAO insertTableAsynchronous:NO tableName:tableName dic:insertDic complete:^(BOOL result) {
            
        }];
    }

    return isCreate;
}

/** 重建表 */
- (BOOL)reCreateTable:(NSString *)tableName
{
    if ([self.MM_DBHelper dropTableWithTableName:tableName]) {
        return [DBHelperDAO createTable:tableName];
    }
    return NO;
}

/** 删除表*/
- (BOOL)dropTableWithTableName:(NSString *)tableName
{
    return [self.MM_DBHelper dropTableWithTableName:tableName];
}



/** 增加表数据 */
+ (void)insertTableAsynchronous:(BOOL)isAsynchronous tableName:(NSString *)tableName dic:(NSDictionary *)dic complete:(void (^)(BOOL))completeBlock{
    if ([DBHelperDAO createTable:tableName]) {
        if (isAsynchronous) {
            [kDBHelperDAO.MM_DBHelper insert:tableName insertDic:dic callback:^(BOOL result) {
                if (completeBlock) {
                    completeBlock(result);
                }
            }];
        }else{
            BOOL isSuccess = NO;
            isSuccess = [kDBHelperDAO.MM_DBHelper insert:tableName insertDic:dic];
            if (completeBlock) {
                completeBlock(isSuccess);
            }
        }
    }else{
        if (completeBlock) {
            completeBlock(NO);
        }
    }
}


/** 查询表个数 */
+(void)queryCountFromTableAsynchronous:(BOOL)isAsynchronous tableName:(NSString *)tableName where:(id)where complete:(void(^)(int number))completeBlock{
    int count = 0;
    if ([kDBHelperDAO tableIsExists:tableName]) {
        if (isAsynchronous) {
            [kDBHelperDAO.MM_DBHelper queryRowCount:tableName where:where callback:^(int rowCount) {
                if (completeBlock) {
                    completeBlock(rowCount);
                }
            }];
        }else{
            count = [kDBHelperDAO.MM_DBHelper queryRowCount:tableName where:where];
            if (completeBlock) {
                completeBlock(count);
            }
        }
    }else{
        if (completeBlock) {
            completeBlock(count);
        }
    }
}
/** 查询表数据 */
+(void)queryTableAsynchronous:(BOOL)isAsynchronous tableName:(NSString *)tableName where:(id)where orderBy:(NSString *)orderBy offset:(int)offset count:(int)count complete:(void (^)(NSArray *))completeBlock{
    NSArray *arr = [NSArray array];
    if ([kDBHelperDAO tableIsExists:tableName]) {
        if (isAsynchronous) {
            [kDBHelperDAO.MM_DBHelper query:tableName where:where orderBy:orderBy offset:offset count:count callback:^(NSMutableArray *array) {
                if (completeBlock) {
                    completeBlock(array);
                }
            }];
        }else{
            arr = [kDBHelperDAO.MM_DBHelper query:tableName where:where orderBy:orderBy offset:offset count:count];
            if (completeBlock) {
                completeBlock(arr);
            }
        }
    }else{
        if (completeBlock) {
            completeBlock(arr);
        }
    }
}


/** 删除表数据 */
+ (void)deleteTableAsynchronous:(BOOL)isAsynchronous tableName:(NSString *)tableName where:(id)where complete:(void(^)(BOOL result))completeBlock
{
    if ([kDBHelperDAO tableIsExists:tableName]) {
        if (isAsynchronous) {
            [kDBHelperDAO.MM_DBHelper deleteToDB:tableName where:where callback:^(BOOL result) {
                if (completeBlock) {
                    completeBlock(result);
                }
            }];
        }else{
            BOOL isExsite = NO;
            isExsite = [kDBHelperDAO.MM_DBHelper deleteToDB:tableName where:where];
            if (completeBlock) {
                completeBlock(isExsite);
            }
        }
    }else{
        if (completeBlock) {
            completeBlock(NO);
        }
    }
}


/** 更新表数据 */
+ (void)updateTableAsynchronous:(BOOL)isAsynchronous tableName:(NSString *)tableName dic:(NSDictionary *)dic where:(id)where complete:(void(^)(BOOL result))completeBlock{
    if ([kDBHelperDAO tableIsExists:tableName]) {
        if (isAsynchronous) {
            [kDBHelperDAO.MM_DBHelper update:tableName updateDic:dic where:where callback:^(BOOL result) {
                if (completeBlock) {
                    completeBlock(result);
                }
            }];
            
        }else{
            BOOL exist = [kDBHelperDAO.MM_DBHelper update:tableName updateDic:dic where:where];
            if (completeBlock) {
                completeBlock(exist);
            }
        }
    }else{
        if (completeBlock) {
            completeBlock(NO);
        }
    }
}



@end
