//
//  DBUtility.h
//  FCIMMobile
//
//  Created by 陈琪 on 16/4/5.
//  Copyright © 2016年 carisok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBUtility : NSObject
/** 根据tableName返回创建表语句 */
+ (NSString *)getCreateTableSqlWithTableName:(NSString *)tableName;
/** 获取所有表名 */
+ (NSArray *)getTableNames;



#pragma mark - 创建json字典
+ (NSDictionary *)dictionaryWithKeyFormat:(NSArray *)keys ValueFormat:(id)value, ...;

@end
