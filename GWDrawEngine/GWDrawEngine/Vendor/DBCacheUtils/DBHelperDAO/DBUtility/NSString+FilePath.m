//
//  NSString+FilePath.m
//  FCIMMobile
//
//  Created by 陈琪 on 16/4/5.
//  Copyright © 2016年 carisok. All rights reserved.
//

#import "NSString+FilePath.h"
#import "FileUtility.h"

@implementation NSString (FilePath)

/** 获取DB路径 */
- (NSString *)getDBPath
{
    /** 用户文件夹路径*/
    NSString *userHomeFolder = [self getHomeFolderPath];
    /** 数据库文件夹路径*/
    NSString *dbPath = [userHomeFolder stringByAppendingPathComponent:@"DB"];
    
    BOOL isSuccess = [FileUtility createFolder:dbPath errStr:nil];
    if (isSuccess) {
        return [dbPath stringByAppendingPathComponent:self];
    }
    return nil;
}


#pragma mark - 用户文件夹路径
- (NSString *)getHomeFolderPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
}
@end
