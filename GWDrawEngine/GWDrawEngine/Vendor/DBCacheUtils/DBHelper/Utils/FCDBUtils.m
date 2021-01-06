//
//  FCDBUtils.m
//  FCIMPersistenceLayer
//
//  Created by 陈琪 on 16/4/5.
//  Copyright © 2016年 carisok. All rights reserved.
//

#import "FCDBUtils.h"

@implementation FCDBUtils

+ (BOOL)checkStringIsEmpty:(NSString *)string
{
    if(string == nil)
    {
        return YES;
    }
    if([string isKindOfClass:[NSString class]] == NO)
    {
        return YES;
    }
    
    return [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""];
}

/** 特殊字符转义 */
+ (NSString *)EscapeSavePointName:(NSString *)pointName
{
    if ([pointName isKindOfClass:[NSString class]]) {
        return [pointName stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
    }
    return pointName;
}

//splice 'where' 拼接where语句
+ (NSMutableArray *)extractQuery:(NSMutableString *)query where:(id)where
{
    NSMutableArray* values = nil;
    if([where isKindOfClass:[NSString class]] && [FCDBUtils checkStringIsEmpty:where]==NO)
    {
        [query appendFormat:@" where %@",where];
    }
    else if ([where isKindOfClass:[NSDictionary class]] && [where count] > 0)
    {
        values = [NSMutableArray arrayWithCapacity:[where count]];
        NSString* wherekey = [FCDBUtils dictionaryToSqlWhere:where andValues:values];
        [query appendFormat:@" where %@",wherekey];
    }
    return values;
}

//dic where parse
+ (NSString*)dictionaryToSqlWhere:(NSDictionary*)dic andValues:(NSMutableArray*)values
{
    NSMutableString* wherekey = [NSMutableString stringWithCapacity:0];
    if(dic != nil && dic.count >0 )
    {
        NSArray* keys = dic.allKeys;
        for (int i=0; i< keys.count;i++) {
            
            NSString* key = [keys objectAtIndex:i];
            id va = [dic objectForKey:key];
            if([va isKindOfClass:[NSArray class]])
            {
                NSArray* vlist = va;
                if(vlist.count==0)
                    continue;
                
                if(wherekey.length > 0)
                    [wherekey appendString:@" and"];
                
                [wherekey appendFormat:@" %@ in(",key];
                
                for (int j=0; j<vlist.count; j++) {
                    
                    [wherekey appendString:@"?"];
                    if(j== vlist.count-1)
                        [wherekey appendString:@")"];
                    else
                        [wherekey appendString:@","];
                    
                    id value = [vlist objectAtIndex:j];
                    [values addObject:[self EscapeSavePointName:value]];
                }
            }
            else
            {
                if(wherekey.length > 0)
                    [wherekey appendFormat:@" and %@=?",key];
                else
                    [wherekey appendFormat:@" %@=?",key];
                
                [values addObject:[self EscapeSavePointName:va]];
            }
            
        }
    }
    return wherekey;
}

/** 查询拼接 */
+ (void)sqlString:(NSMutableString*)sql AddOder:(NSString*)orderby offset:(int)offset count:(int)count
{
    if([FCDBUtils checkStringIsEmpty:orderby] == NO)
    {
        [sql appendFormat:@" order by %@",orderby];
    }
    [sql appendFormat:@" limit %d offset %d",count,offset];
}

/** 处理查询结果为NULL时转换@"" */
+ (NSDictionary *)checkResultDic:(NSDictionary *)resultDic
{
    NSMutableDictionary *mutableResultDic = [NSMutableDictionary dictionaryWithCapacity:resultDic.count];
    for (NSString *keys in resultDic) {
        id value = resultDic[keys];
        if ([value isKindOfClass:[NSNull class]]) {
            value = @"";
        }
        [mutableResultDic setObject:value forKey:keys];
    }
    return mutableResultDic;
}

/** 处理字典解析成keys和values */
+ (void)splitDic:(NSDictionary *)dic result:(void(^)(NSString *keys, NSString *values))result
{
    NSMutableString* insertKeys = [NSMutableString stringWithCapacity:0];
    NSMutableString* insertValues = [NSMutableString stringWithCapacity:0];
    
    for (int i=0; i<dic.count; i++) {
        NSString *key = [dic allKeys][i];
        id val = [dic allValues][i];
        
        if(i>0)
        {
            [insertKeys appendString:@","];
            [insertValues appendString:@","];
        }
        
        NSString *value;
        if ([val isKindOfClass:NSString.class]) {
            value = val;
            [insertValues appendString:@"'"];
        } else {
            value = [val stringValue];
        }
        
        [insertKeys appendString:key];
        [insertValues appendString:[self EscapeSavePointName:value]];
        
        if ([val isKindOfClass:NSString.class]) {
            [insertValues appendString:@"'"];
        }
    }
    if (insertKeys.length && insertValues.length) {
        result(insertKeys, insertValues);
    }
}
@end
