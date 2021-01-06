//
//  FCDBHelper.m
//  FCIMPersistenceLayer
//
//  Created by 陈琪 on 16/4/5.
//  Copyright © 2016年 carisok. All rights reserved.
//

#import "FCDBHelper.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "FCDBUtils.h"

@interface FCDBHelper ()
@property (unsafe_unretained, nonatomic) FMDatabase* usingdb;
@property (strong, nonatomic) FMDatabaseQueue* bindingQueue;
@property (copy, nonatomic) NSString* dbname;

@property (strong, nonatomic) NSRecursiveLock* threadLock;

@end

@implementation FCDBHelper

- (id)initWithDBNameWithPath:(NSString *)dbname
{
    if (dbname == nil) {
        return nil;
    }
    self = [super init];
    if (self) {
        _threadLock = [[NSRecursiveLock alloc] init];
        [self setDBNameWithPath:dbname];
    }
    return self;
}

- (void)setDBNameWithPath:(NSString *)fileName
{
    if([self.dbname isEqualToString:fileName] == NO)
    {
        [self.bindingQueue close];
        
        self.bindingQueue = [FMDatabaseQueue databaseQueueWithPath:fileName];
        
        if (_bindingQueue) {
            self.dbname = fileName;
        }
        
#ifdef DEBUG
        //debug 模式下  打印错误日志
        [_bindingQueue inDatabase:^(FMDatabase *db) {
            db.logsErrors = YES;
        }];
#endif
    }
}

- (NSString *)getDBNameWithPath
{
    return self.dbname;
}

#pragma mark- core
- (void)executeDB:(void (^)(FMDatabase *db))block
{
    [_threadLock lock];
    if(self.usingdb != nil)
    {
        block(self.usingdb);
    }
    else
    {
        [_bindingQueue inDatabase:^(FMDatabase *db) {
            self.usingdb = db;
            block(db);
            self.usingdb = nil;
        }];
    }
    [_threadLock unlock];
}

- (NSArray *)executeQuerySQL:(NSString *)sql arguments:(NSArray *)args
{
#ifdef showDBLogs
    DLog(@"database sql:%@ args:%@", sql, args);
#endif
    __block NSMutableArray *models = [NSMutableArray arrayWithCapacity:10];
    [self executeDB:^(FMDatabase *db) {
        FMResultSet* set = nil;
        if(args.count>0)
            set = [db executeQuery:sql withArgumentsInArray:args];
        else
            set = [db executeQuery:sql];
        
        while ([set next]) {
            NSDictionary *resultDic = [set resultDictionary];
            NSDictionary *finallyDic = [FCDBUtils checkResultDic:resultDic];
            [models addObject:finallyDic];
        }
        [set close];
    }];
    return models;
}

- (BOOL)executeUpdateSQL:(NSString *)sql arguments:(NSArray *)args
{
#ifdef showDBLogs
    DLog(@"database sql:%@ args:%@", sql, args);
#endif
    __block BOOL execute = NO;
    [self executeDB:^(FMDatabase *db) {
        if(args.count>0)
            execute = [db executeUpdate:sql withArgumentsInArray:args];
        else
            execute = [db executeUpdate:sql];
    }];
#ifdef showDBLogs
    if (execute == NO) {
        DLog(@"database fail sql:%@ args:%@", sql, args);
    }
#endif
    return execute;
}

- (NSString *)executeScalarWithSQL:(NSString *)sql arguments:(NSArray *)args
{
#ifdef showDBLogs
    DLog(@"database sql:%@ args:%@", sql, args);
#endif
    __block NSString* scalar = @"0";
    [self executeDB:^(FMDatabase *db) {
        FMResultSet* set = nil;
        if(args.count>0)
            set = [db executeQuery:sql withArgumentsInArray:args];
        else
            set = [db executeQuery:sql];
        
        if([set columnCount]>0 && [set next])
        {
            scalar = [set stringForColumnIndex:0];
        }
        [set close];
    }];
    return scalar;
}

- (BOOL)executeStatements:(NSString *)sql callBackBlock:(int (^)(NSDictionary *resultsDictionary))callBackBlock
{
#ifdef showDBLogs
    DLog(@"database sql:%@", sql);
#endif
    __block BOOL execute = NO;
    [self executeDB:^(FMDatabase *db) {
        execute = [db executeStatements:sql withResultBlock:callBackBlock];
    }];
#ifdef showDBLogs
    if (execute == NO) {
        DLog(@"database fail sql:%@", sql);
    }
#endif
    return execute;
}

/** 断开数据库 */
- (void)disconnectDB
{
    [self.bindingQueue close];
    self.usingdb = nil;
    self.bindingQueue = nil;
    self.dbname = nil;
    if ([self.threadLock tryLock]) {
        [self.threadLock unlock];
    }
    self.threadLock = nil;
}

#pragma mark- dealloc
- (void)dealloc
{
    [self disconnectDB];
}


@end
