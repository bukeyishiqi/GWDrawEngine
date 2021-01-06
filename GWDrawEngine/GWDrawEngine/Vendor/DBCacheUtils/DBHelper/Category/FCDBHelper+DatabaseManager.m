//
//  FCDBHelper+DatabaseManager.m
//  FCIMPersistenceLayer
//
//  Created by 陈琪 on 16/4/5.
//  Copyright © 2016年 carisok. All rights reserved.
//

#import "FCDBHelper+DatabaseManager.h"
#import "FCDBUtils.h"
#import "FMDatabaseAdditions.h"

@implementation FCDBHelper (DatabaseManager)

-(BOOL)createTableWithSql:(NSString *)createSql
{
    BOOL isCreated = [self executeUpdateSQL:createSql arguments:nil];
    return isCreated;
}

- (BOOL)dropTableWithTableName:(NSString *)tableName
{
    checkTableNameIsEmpty(tableName);
    
    if ([self tableIsExists:tableName]) {
        NSString* dropTableSQL = [NSString stringWithFormat:@"drop table %@",tableName];
        BOOL isDrop = [self executeUpdateSQL:dropTableSQL arguments:nil];
        return isDrop;
    }
    return YES;
}

- (BOOL)tableIsExists:(NSString *)tableName
{
    checkTableNameIsEmpty(tableName);
    
    __block BOOL execute = NO;
    
    [self executeDB:^(FMDatabase *db) {
        execute = [db tableExists:tableName];
    }];
    
    return execute;
}

@end
