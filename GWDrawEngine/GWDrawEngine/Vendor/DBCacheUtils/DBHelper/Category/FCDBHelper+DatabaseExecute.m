//
//  FCDBHelper+DatabaseExecute.m
//  FCIMPersistenceLayer
//
//  Created by 陈琪 on 16/4/5.
//  Copyright © 2016年 carisok. All rights reserved.
//

#import "FCDBHelper+DatabaseExecute.h"
#import "FCDBUtils.h"
#import "FCDBHelper+DatabaseManager.h"

@implementation FCDBHelper (DatabaseExecute)
-(void)asyncBlock:(void(^)(void))block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),block);
}

-(void)mainBlock:(void(^)(void))block
{
    dispatch_async(dispatch_get_main_queue(),block);
}

- (int)queryRowCount:(NSString *)tableName where:(id)where
{
    return [self queryRowCountBase:tableName where:where];
}

- (void)queryRowCount:(NSString *)tableName where:(id)where callback:(void(^)(int rowCount))callback
{
    [self asyncBlock:^{
        int result = [self queryRowCountBase:tableName where:where];
        if(callback != nil)
        {
            [self mainBlock:^{
                callback(result);
            }];
        }
    }];
}

-(int)queryRowCountBase:(NSString *)tableName where:(id)where
{
    if (tableName == nil) return 0;
    
    NSMutableString* rowCountSql = [NSMutableString stringWithFormat:@"select count(rowid) from %@",tableName];
    
    NSMutableArray* valuesarray = [FCDBUtils extractQuery:rowCountSql where:where];
    int result = [[self executeScalarWithSQL:rowCountSql arguments:valuesarray] intValue];
    
    return result;
}


- (NSMutableArray *)query:(NSString *)tableName where:(id)where orderBy:(NSString*)orderBy offset:(int)offset count:(int)count
{
    return [self queryBase:tableName where:where orderBy:orderBy offset:offset count:count];
}

- (void)query:(NSString *)tableName  where:(id)where orderBy:(NSString*)orderBy offset:(int)offset count:(int)count callback:(void(^)(NSMutableArray* array))block
{
    [self asyncBlock:^{
        NSMutableArray* array = [self queryBase:tableName where:where orderBy:orderBy offset:offset count:count];
        
        if (block != nil)
            [self mainBlock:^{
                block(array);
            }];
    }];
}

-(NSMutableArray *)queryBase:(NSString *)tableName where:(id)where orderBy:(NSString *)orderBy offset:(int)offset count:(int)count
{
    if (tableName == nil) return nil;
    
    NSMutableString* query = [NSMutableString stringWithFormat:@"select rowid,* from %@",tableName];
    NSMutableArray * values = [FCDBUtils extractQuery:query where:where];
    
    [FCDBUtils sqlString:query AddOder:orderBy offset:offset count:count];
    
    NSArray *results = [self executeQuerySQL:query arguments:values];
    NSMutableArray *mtbResults = [NSMutableArray arrayWithArray:results];
    
    return mtbResults;
}

- (BOOL)insert:(NSString *)tableName insertDic:(NSDictionary *)insertDic
{
    return [self insertBase:tableName insertDic:insertDic];
}

- (void)insert:(NSString *)tableName insertDic:(NSDictionary *)insertDic callback:(void(^)(BOOL result))block
{
    [self asyncBlock:^{
        BOOL result = [self insertBase:tableName insertDic:insertDic];
        if(block != nil)
        {
            [self mainBlock:^{
                block(result);
            }];
        }
    }];
}

- (BOOL)insertBase:(NSString *)tableName insertDic:(NSDictionary *)insertDic
{
    if (tableName == nil) return NO;
    if (insertDic.count == 0) return NO;
    
    NSMutableString* insertKeys = [NSMutableString stringWithCapacity:0];
    NSMutableString* insertValuesString = [NSMutableString stringWithCapacity:0];
    
    NSMutableArray* insertValues = [NSMutableArray arrayWithCapacity:0];
    
    for (int i=0; i<insertDic.count; i++) {
        NSString *key = [insertDic allKeys][i];
        NSString *value = [insertDic allValues][i];
        
        if(i>0)
        {
            [insertKeys appendString:@","];
            [insertValuesString appendString:@","];
        }
        
        [insertKeys appendString:key];
        [insertValuesString appendString:@"?"];
        
        [insertValues addObject:[FCDBUtils EscapeSavePointName:value]];
    }
    
    //拼接insertSQL 语句  采用 replace 插入
    NSString* insertSQL = [NSString stringWithFormat:@"replace into %@(%@) values(%@)",tableName,insertKeys,insertValuesString];
    
    BOOL execute = NO;
    if ([self tableIsExists:tableName]) {
        execute = [self executeUpdateSQL:insertSQL arguments:insertValues];
    }
    
    return execute;
}


- (BOOL)update:(NSString *)tableName updateDic:(NSDictionary *)updateDic where:(id)where
{
    return [self updateBase:tableName updateDic:updateDic where:where];
}

- (void)update:(NSString *)tableName updateDic:(NSDictionary *)updateDic where:(id)where callback:(void (^)(BOOL result))block
{
    [self asyncBlock:^{
        BOOL result = [self updateBase:tableName updateDic:updateDic where:where];
        if(block != nil)
        {
            [self mainBlock:^{
                block(result);
            }];
        }
    }];
}

- (BOOL)updateBase:(NSString *)tableName updateDic:(NSDictionary *)updateDic where:(id)where
{
    if (tableName == nil) return NO;
    if (updateDic.count == 0) return NO;
    
    NSMutableString* updateKey = [NSMutableString string];
    NSMutableArray* updateValues = [NSMutableArray arrayWithCapacity:0];
    
    for (int i=0; i<updateDic.count; i++) {
        NSString *key = [updateDic allKeys][i];
        NSString *value = [updateDic allValues][i];
        
        if(i>0)
            [updateKey appendString:@","];
        
        [updateKey appendFormat:@"%@=?",key];
        
        [updateValues addObject:[FCDBUtils EscapeSavePointName:value]];
    }
    
    NSMutableString* updateSQL = [NSMutableString stringWithFormat:@"update %@ set %@",tableName,updateKey];
    
    //添加where 语句
    NSMutableArray * values = [FCDBUtils extractQuery:updateSQL where:where];
    [updateValues addObjectsFromArray:values];
    
    BOOL execute = NO;
    /** 判断表是否存在 */
    if ([self tableIsExists:tableName]) {
        execute = [self executeUpdateSQL:updateSQL arguments:updateValues];
    }
    
    return execute;
}


- (BOOL)deleteToDB:(NSString *)tableName where:(id)where
{
    return [self deleteToDBBase:tableName where:where];
}

- (void)deleteToDB:(NSString *)tableName where:(id)where callback:(void(^)(BOOL result))block
{
    [self asyncBlock:^{
        BOOL result = [self deleteToDBBase:tableName where:where];
        if(block != nil)
        {
            [self mainBlock:^{
                block(result);
            }];
        }
    }];
}

-(BOOL)deleteToDBBase:(NSString *)tableName where:(id)where
{
    if (tableName == nil) return NO;
    
    NSMutableString *deleteSQL = [NSMutableString stringWithFormat:@"delete from %@",tableName];
    NSMutableArray *values = [FCDBUtils extractQuery:deleteSQL where:where];
    
    BOOL execute = NO;
    /** 判断表是否存在 */
    if ([self tableIsExists:tableName]) {
        execute = [self executeUpdateSQL:deleteSQL arguments:values];
    }
    return execute;
}


@end
