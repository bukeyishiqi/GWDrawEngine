//
//  DBHelperDAO+UpdateDB.h
//  imall
//
//  Created by 陈琪 on 16/5/6.
//  Copyright © 2016年 QJM. All rights reserved.
//

#import "DBHelperDAO.h"

@interface DBHelperDAO (UpdateDB)

/**---------- 查询 -----------*/
/** 查询当前更新文件版本 */
+ (NSString *)queryUpdateTable;

/**--------------- 增加 ------------*/
/** 插入数据库 */
+ (BOOL)insertOrUpdateTableWithVersion:(NSString *)version;



@end
