//
//  FCDBUtils.h
//  FCIMPersistenceLayer
//
//  Created by 陈琪 on 16/4/5.
//  Copyright © 2016年 carisok. All rights reserved.
//

#import <Foundation/Foundation.h>

#define checkTableNameIsEmpty(str) if([FCDBUtils checkStringIsEmpty:str]){\
DLog(@"table name:%@ is empty!",str);\
return NO;}


@interface FCDBUtils : NSObject

/** string是否为空 */
+ (BOOL)checkStringIsEmpty:(NSString *)string;

/** 特殊字符转义 */
+ (NSString *)EscapeSavePointName:(NSString *)pointName;

/** 拼接where语句 */
+ (NSMutableArray *)extractQuery:(NSMutableString *)query where:(id)where;

/** 查询拼接 */
+ (void)sqlString:(NSMutableString*)sql AddOder:(NSString*)orderby offset:(int)offset count:(int)count;

/** 处理查询结果为NULL时转换@"" */
+ (NSDictionary *)checkResultDic:(NSDictionary *)resultDic;

/** 处理字典解析成keys和values */
+ (void)splitDic:(NSDictionary *)dic result:(void(^)(NSString *keys, NSString *values))result;


@end
