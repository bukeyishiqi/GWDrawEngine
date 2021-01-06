//
//  Header.h
//  FCIMPersistenceLayer
//
//  Created by 陈琪 on 16/4/5.
//  Copyright © 2016年 carisok. All rights reserved.
//

#ifndef PersistenceHeader_h
#define PersistenceHeader_h

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(fmt, ...)
#endif

#endif /* PersistenceHeader_h */
