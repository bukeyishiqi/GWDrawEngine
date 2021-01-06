//
//  FCDBHelper.h
//  FCIMPersistenceLayer
//
//  Created by 陈琪 on 16/4/5.
//  Copyright © 2016年 carisok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersistenceHeader.h"

#ifdef DEBUG
#define showDBLogs /** 不需要打印数据库日志,请将此行注释 */
#endif

@class  FMDatabase;
@interface FCDBHelper : NSObject

/** 初始化数据库 全路径 */
- (id)initWithDBNameWithPath:(NSString *)dbname;
/** 断开数据库 */
- (void)disconnectDB;
/** 获取数据库 全路径 */
- (NSString *)getDBNameWithPath;
/** 更换数据库 全路径 （改变当前实例指向的数据库） */
- (void)setDBNameWithPath:(NSString *)fileName;
/** 同步执行sql语句 适用于：查询 */
- (NSArray *)executeQuerySQL:(NSString *)sql arguments:(NSArray *)args;
/** 同步执行sql语句 适用于：增、删、改 */
- (BOOL)executeUpdateSQL:(NSString *)sql arguments:(NSArray *)args;
/** 同步执行数据库操作 可递归调用 不建议直接使用 */
- (void)executeDB:(void (^)(FMDatabase *db))block;

/** 同步查询第一条，返回条数 适用于：count(1) 不建议直接使用 */
- (NSString *)executeScalarWithSQL:(NSString *)sql arguments:(NSArray *)args;

/** 批量执行sql语句 */
- (BOOL)executeStatements:(NSString *)sql callBackBlock:(int (^)(NSDictionary *resultsDictionary))callBackBlock;

@end
