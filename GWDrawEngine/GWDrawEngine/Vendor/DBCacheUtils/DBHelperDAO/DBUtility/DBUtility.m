//
//  DBUtility.m
//  FCIMMobile
//
//  Created by 陈琪 on 16/4/5.
//  Copyright © 2016年 carisok. All rights reserved.
//

#import "DBUtility.h"
#import "DBIdentifier.h"

@implementation DBUtility

/** 根据tableName返回创建表语句 */
+ (NSString *)getCreateTableSqlWithTableName:(NSString *)tableName
{
    NSString *createTableSql = nil;
    if ([tableName isEqualToString:SQL_DUAL]) { /** 虚表 */
        createTableSql = SQL_DUAL_CREATE(SQL_DUAL);
    } else if ([tableName isEqualToString:SQL_PAGE]) { /** 页面表*/
        createTableSql = SQL_PAGE_CREATE(tableName);
    } else if ([tableName isEqualToString:SQL_DATABASEVERSION]) { /** 数据库版本表*/
        createTableSql = SQL_DATABASEVERSION_CREATE(tableName);
    }
    return createTableSql;
}

+ (NSArray *)getTableNames
{
    return @[SQL_DUAL, SQL_PAGE, SQL_DATABASEVERSION];
}



#pragma mark - 创建json字典
+ (NSDictionary *)dictionaryWithKeyFormat:(NSArray *)keys ValueFormat:(id)value, ...
{
    va_list args;
    id arg;
    int index=0;
    int count = (int)keys.count;
    if (value) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        va_start(args, value);
        arg = value;
        do {
            [dic setValue:arg forKey:keys[index]];
            index++;
        } while ((arg = va_arg(args,id)) && index < count);
        va_end(args);
        return dic;
    }
    return nil;
}
@end
