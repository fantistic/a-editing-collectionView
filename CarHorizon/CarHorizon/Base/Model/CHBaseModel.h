//
//  CHBaseModel.h
//  CarHorizon
//
//  Created by dllo on 15/10/12.
//  Copyright © 2015年 luo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHAFNetWorkTool.h"

typedef void (^Block) (id result);

@interface CHBaseModel : NSObject


/**
 *  将传过来的数据解析成一个个model保存在数组里
 *
 *  @param arr 数据
 *
 *  @return
 */
+(NSMutableArray *)baseModelByArr:(NSArray *)arr;



/**
 *  GET请求
 *
 *  @param url        网络请求地址
 *  @param body       请求体
 *  @param result     返回的数据类型
 *  @param headerFile 请求头
 *  @param succes     网络请求成功回调
 *  @param error      网络请求失败回调
 *  @param block      通过block返回数据
 */
+(void)getMessageUrl:(NSString *)url
                body:(id)body
              result:(DWResult)result
          headerFile:(NSDictionary *)headerFile
              result:(Block)block;

@property(nonatomic, copy)NSNumber  *uId;

@end
