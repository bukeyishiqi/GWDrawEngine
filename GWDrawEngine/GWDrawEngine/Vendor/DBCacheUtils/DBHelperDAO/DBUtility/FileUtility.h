//
//  FileUtility.h
//  SocketClientDemo
//
//  Created by AnsonLo on 13-7-26.
//  Copyright (c) 2013年 ansonkid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileUtility : NSObject

+ (BOOL)createFile:(NSString *)path;
+ (BOOL)createFolder:(NSString *)path errStr:(NSString **)errStr;
+ (BOOL)fileExist:(NSString *)path;
+ (BOOL)directoryExist:(NSString *)path;
+ (BOOL)moveFileAtPath:(NSString *)atPath toPath:(NSString *)toPath;
+ (BOOL)copyFileAtPath:(NSString *)atPath toPath:(NSString *)toPath;
+ (BOOL)removeFile:(NSString *)path;
+ (void)writeLogToFile:(NSString *)filePath appendTxt:(NSString *)txt;
+ (u_int64_t)fileSizeForPath:(NSString *)path;
+ (NSArray *)findFile:(NSString *)path;

@end
