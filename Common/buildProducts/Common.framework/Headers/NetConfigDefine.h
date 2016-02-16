//
//  NetConfigDefine.h
//  NetConfigRequest
//
//  Created by zbq on 15-1-3.
//  Copyright (c) 2015年 summer.zhu. All rights reserved.
//

#ifndef NetConfigRequest_NetConfigDefine_h
#define NetConfigRequest_NetConfigDefine_h

#define UserDefault YES
#define NetConfigDebug YES

#define Debug

#ifdef Debug
#define NCLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define NCLog(xx, ...) ((void)0)
#endif

#endif
