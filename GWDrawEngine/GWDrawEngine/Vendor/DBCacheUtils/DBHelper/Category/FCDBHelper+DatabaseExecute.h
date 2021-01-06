//
//  FCDBHelper+DatabaseExecute.h
//  FCIMPersistenceLayer
//
//  Created by 陈琪 on 16/4/5.
//  Copyright © 2016年 carisok. All rights reserved.
//

#import "FCDBHelper.h"

@interface FCDBHelper (DatabaseExecute)

/** 同步查询条数－tableName:表名 where:类型NSString或NSDictionary或nil */
- (int)queryRowCount:(NSString *)tableName where:(id)where;
/** 异步查询条数－tableName:表名 where:类型NSString或NSDictionary或nil */
- (void)queryRowCount:(NSString *)tableName where:(id)where callback:(void(^)(int rowCount))callback;


/** 同步查询－tableName:表名 where:类型NSString或NSDictionary或nil orderBy:字段排序(name desc) offset:从第n条开始 count:查询结果数量*/
- (NSMutableArray *)query:(NSString *)tableName where:(id)where orderBy:(NSString*)orderBy offset:(int)offset count:(int)count;
/** 异步查询－tableName:表名 where:类型NSString或NSDictionary或nil orderBy:字段排序(name desc) offset:从第n条开始 count:查询结果数量*/
- (void)query:(NSString *)tableName where:(id)where orderBy:(NSString*)orderBy offset:(int)offset count:(int)count callback:(void(^)(NSMutableArray* array))block;


/** 同步新增－model:数据表对应的model(字段内容) */
- (BOOL)insert:(NSString *)tableName insertDic:(NSDictionary *)insertDic;
/** 异步新增－model:数据表对应的model(字段内容) */
- (void)insert:(NSString *)tableName insertDic:(NSDictionary *)insertDic callback:(void(^)(BOOL result))block;


/** 同步更新－model:数据表对应的model(字段内容) where:类型NSString或NSDictionary或nil */
- (BOOL)update:(NSString *)tableName updateDic:(NSDictionary *)updateDic where:(id)where;
/** 异步更新－model:数据表对应的model(字段内容) where:类型NSString或NSDictionary或nil */
- (void)update:(NSString *)tableName updateDic:(NSDictionary *)updateDic where:(id)where callback:(void (^)(BOOL result))block;


/** 同步删除－tableName:表名 where:类型NSString或NSDictionary或nil */
- (BOOL)deleteToDB:(NSString *)tableName where:(id)where;
/** 异步删除－tableName:表名 where:类型NSString或NSDictionary或nil */
- (void)deleteToDB:(NSString *)tableName where:(id)where callback:(void(^)(BOOL result))block;



@end
