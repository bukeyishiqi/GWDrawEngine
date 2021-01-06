//
//  DBHelperDAO+Session.h
//  imall
//
//  Created by 陈琪 on 16/4/12.
//  Copyright © 2016年 QJM. All rights reserved.
//

#import "DBHelperDAO.h"

@interface DBHelperDAO (PageSource)

/** 查询页面Id是否存在*/
+ (BOOL)queryPageExist:(NSString *)pageId;

/** 查询单页面数据 */
+ (NSDictionary *)queryPageSourceWithPageId:(NSString *)pageId;

/** 插入数据*/
+ (BOOL)insertPageSource:(NSString *)pageId layoutData:(NSString *)layoutData pageData:(NSString *)pageData version:(NSString *)version;

/** 删除数据*/
+ (BOOL)deletePageSourceWithPageId:(NSString *)pageId;

/** 更新页面资源数据*/
+ (BOOL)updatePageSource:(NSString *)pageId layoutData:(NSString *)layoutData pageData:(NSString *)pageData version:(NSString *)version;

@end

