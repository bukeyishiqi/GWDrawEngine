//
//  UpdateApp.m
//  imall
//
//  Created by 陈琪 on 16/5/6.
//  Copyright © 2016年 QJM. All rights reserved.
//

#import "UpdateApp.h"
#import "RunUpdateVersion.h"

#import "DBHelperDAO+UpdateDB.h"

@interface UpdateApp ()
{
    BOOL end;

    /** 当前数据库版本*/
    NSString *_DBVersion;
    /** 是否需要更新 */
    BOOL _isUpdate;

}

@property (nonatomic, strong) NSMutableArray *updateList;

@end

@implementation UpdateApp

static UpdateApp  *updateApp;

- (instancetype)init
{
    if (self = [super init]) {
        [self customInit];
    }
    return self;
}

#pragma mark - 自定义初始化
- (void)customInit
{
    _updateList = [NSMutableArray array];
    /** 查询当前数据库版本*/
    _DBVersion = [DBHelperDAO queryUpdateTable];
    
    _isUpdate = NO;
    NSArray *updateVersionList = [RunUpdateVersion getUpdateVersions];
    for (NSString *updateVersion in updateVersionList) {
        
        if ([updateVersion compare:_DBVersion options:NSNumericSearch] == NSOrderedDescending) {
            [_updateList addObject:updateVersion];
        }
    }
    if (_updateList.count > 0) {
        _isUpdate = YES;
    }
}

#pragma mark - /** 开始更新 */
+ (void)update
{
    if (updateApp == nil) {
        updateApp = [[UpdateApp alloc] init];
        /** 创建线程阻塞 */
        [updateApp thread];
    }
}


#pragma mark - 阻塞主线程更新数据库
- (void)thread
{
    if (_isUpdate) {
        NSLog(@"更新数据库－－开始");
        [NSThread detachNewThreadSelector:@selector(runOnNewThread) toTarget:self withObject:nil];
        while (!end) { /** 阻塞主线程*/
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        NSLog(@"更新数据库－－结束");
    }
    
    /** 更新数据库版本 */
    NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
    if (![_DBVersion isEqualToString:currentVersion]) {
        [DBHelperDAO insertOrUpdateTableWithVersion:currentVersion];
    }
    
    /** 执行完销毁对象 */
    updateApp = nil;
}

-(void)runOnNewThread{
    sleep(1);
    [updateApp executeUpdate];
    [self performSelectorOnMainThread:@selector(setEnd) withObject:nil waitUntilDone:NO];
}

-(void)setEnd{
    end=YES;
}


#pragma mark ------- Private Methods

/** 执行更新 */
- (void)executeUpdate
{
    RunUpdateVersion *runVersion = [[RunUpdateVersion alloc] init];
    for (NSString *updateVersion in _updateList) {

        SEL selector = ReplaceVersionFile(updateVersion);
        if ([runVersion respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [runVersion performSelector:selector];
#pragma clang diagnostic pop
        }
    }
    runVersion = nil;
}

@end
