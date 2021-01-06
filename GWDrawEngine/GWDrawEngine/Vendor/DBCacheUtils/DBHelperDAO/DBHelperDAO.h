//
//  DBHelperDAO.h
//  FCIMMobile
//
//  Created by 陈琪 on 16/4/5.
//  Copyright © 2016年 carisok. All rights reserved.
//

#import "BaseDAO.h"
#import "DBIdentifier.h"
#import "DBUtility.h"

#define kDBHelperDAO [DBHelperDAO sharedInstance]

@interface DBHelperDAO : BaseDAO
/** 连接数据库 */
+ (void)connectToDB:(void(^)())block;

/** 断开数据库 */
+ (void)disconnectDB;

/** 返回当前数据库路径 */
- (NSString *)MMSqlitePath;

/** 返回所有表名 */
- (NSArray *)tableNames;

/** 处理字典解析成keys和values */
- (void)splitDic:(NSDictionary *)dic result:(void(^)(NSString *keys, NSString *values))result;

/** 自定义查询SQL */
- (NSArray *)executeSQL:(NSString *)sql;

/** 自定义增、删、改SQL*/
- (BOOL)executeUpdateSQL:(NSString *)sql;


/** 批量执行SQL */
+ (BOOL)executeStatements:(NSString *)sql;

/** 批量执行SQL 带回调 */
- (BOOL)executeStatements:(NSString *)sql callBackBlock:(int (^)(NSDictionary *resultsDictionary))callBackBlock;

/** 判断表是否存在 */
- (BOOL)tableIsExists:(NSString *)tableName;

/** 创建表 */
+ (BOOL)createTable:(NSString *)tableName;

/** 重建表 */
- (BOOL)reCreateTable:(NSString *)tableName;

/** 删除表*/
- (BOOL)dropTableWithTableName:(NSString *)tableName;



/** 增加表数据 isAsynchronous(YES:异步 NO:同步)*/
+ (void)insertTableAsynchronous:(BOOL)isAsynchronous tableName:(NSString *)tableName dic:(NSDictionary *)dic complete:(void(^)(BOOL result))completeBlock;

/** 查询表个数 isAsynchronous(YES:异步 NO:同步)*/
+(void)queryCountFromTableAsynchronous:(BOOL)isAsynchronous tableName:(NSString *)tableName where:(id)where complete:(void(^)(int number))completeBlock;

/** 查询表数据 isAsynchronous(YES:异步 NO:同步)*/
+(void)queryTableAsynchronous:(BOOL)isAsynchronous tableName:(NSString *)tableName where:(id)where orderBy:(NSString *)orderBy  offset:(int)offset count:(int)count complete:(void(^)(NSArray *resultArr))completeBlock;

/** 删除表数据 isAsynchronous(YES:异步 NO:同步)*/
+ (void)deleteTableAsynchronous:(BOOL)isAsynchronous tableName:(NSString *)tableName where:(id)where complete:(void(^)(BOOL result))completeBlock;

/**
 更新表数据 isAsynchronous(YES:异步 NO:同步)
 */
+ (void)updateTableAsynchronous:(BOOL)isAsynchronous tableName:(NSString *)tableName dic:(NSDictionary *)dic where:(id)where complete:(void(^)(BOOL result))completeBlock;

@end
