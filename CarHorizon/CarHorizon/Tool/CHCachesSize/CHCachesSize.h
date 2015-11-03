//
//  CHCachesSize.h
//  CarHorizon
//
//  Created by dllo on 15/10/22.
//  Copyright © 2015年 luo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHCachesSize : NSObject

//类方法
+ (instancetype)defaultCalculateFileSize;

// 计算单个文件大小
- (float)fileSizeAtPath:(NSString*)path;
// 计算目录大小
- (float)folderSizeAtPath:(NSString*)path;

// 清除文件按
+ (void)clearCache:(NSString *)path;


@end
