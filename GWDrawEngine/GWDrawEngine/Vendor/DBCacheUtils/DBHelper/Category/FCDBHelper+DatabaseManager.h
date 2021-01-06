//
//  FCDBHelper+DatabaseManager.h
//  FCIMPersistenceLayer
//
//  Created by 陈琪 on 16/4/5.
//  Copyright © 2016年 carisok. All rights reserved.
//

#import "FCDBHelper.h"

@interface FCDBHelper (DatabaseManager)

/** 创建数据表 */
-(BOOL)createTableWithSql:(NSString *)createSql;

/** 删除数据表 */
- (BOOL)dropTableWithTableName:(NSString *)tableName;

/** 表是否存在 */
- (BOOL)tableIsExists:(NSString *)tableName;


@end
