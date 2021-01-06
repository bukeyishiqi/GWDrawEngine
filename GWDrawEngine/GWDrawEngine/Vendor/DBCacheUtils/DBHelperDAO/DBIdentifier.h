//
//  DBIdentifier.h
//  FCIMMobile
//
//  Created by 陈琪 on 16/4/5.
//  Copyright © 2016年 carisok. All rights reserved.
//

#ifndef DBIdentifier_h
#define DBIdentifier_h

#define SQL_DATABASE_MM @"HotFix.sqlite"

#define DB_Value(valueString) valueString != nil ? valueString : @""

/*==============================================================*/
/* Table: virtual        虚表                               */
/*==============================================================*/

#define DUAL_DUMMY @"DUMMY"

#define SQL_DUAL @"dual"
#define SQL_DUAL_CREATE(tableName) [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ TEXT(1,0))", tableName, DUAL_DUMMY]


/*==============================================================*/
/* Table: Page        页面元素表                               */
/*==============================================================*/
/** 
 字段名	类型	约束	备注
 pageId	TEXT NOT NULL	PRIMARY KEY UNIQUE ON CONFLICT REPLACE	页面ID
 version	TEXT NOT NULL		页面版本号
 layoutData	TEXT NOT NULL 布局数据
 pageData	TEXT            页面加载的数据
 */

#define Page_Id @"pageId"
#define Page_version @"version"
#define Page_layoutData @"template"
#define Page_pageData @"serviceData"

#define SQL_PAGE @"Page"
#define SQL_PAGE_CREATE(tableName) [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ TEXT NOT NULL PRIMARY KEY UNIQUE ON CONFLICT REPLACE, %@ TEXT  NOT NULL, %@ TEXT  NOT NULL, %@ TEXT)", tableName, Page_Id, Page_version, Page_layoutData, Page_pageData]


/*==============================================================*/
/* Table: DatabaseVersion       数据库版本                               */
/*==============================================================*/

#define DatabaseVersion_Version @"version"

#define SQL_DATABASEVERSION @"DatabaseVersion"
#define SQL_DATABASEVERSION_CREATE(tableName) [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ TEXT NOT NULL)", tableName, DatabaseVersion_Version]

#endif /* DBIdentifier_h */
