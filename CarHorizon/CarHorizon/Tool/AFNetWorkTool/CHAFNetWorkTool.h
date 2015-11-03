//
//  CHAFNetWorkTool.h
//  CarHorizon
//
//  Created by dllo on 15/10/12.
//  Copyright © 2015年 luo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef void (^Block)(id result);

typedef void (^ErrorBlock)(NSError *error);

typedef NS_ENUM(NSInteger, DWResult){
    
    DWData,
    DWJSON,
    DWXML,
};

typedef NS_ENUM(NSUInteger, DWRequestStyle){
    
    DWRequestJSON,
    DWRequestString,
    
};


@interface CHAFNetWorkTool : NSObject

/**
 *  GET请求
 *
 *  @param url        网络请求地址
 *  @param body       请求体
 *  @param result     返回的数据类型
 *  @param headerFile 请求头
 *  @param succes     网络请求成功回调
 *  @param error      网络请求失败回调
 */

+ (void)getUrl:(NSString *)url
          body:(id)body
        result:(DWResult)result
    headerFile:(NSDictionary *)headerFile
        sucess:(Block )succes
       failure:(ErrorBlock )failure;

/**
 *  Post请求
 *
 *  @param url          请求网络地址
 *  @param body         请求体
 *  @param requestStyle 网络请求体body体的类型
 *  @param result       返回值类型
 *  @param headerFile   网络请求头
 *  @param succes       成功回调
 *  @param failure      失败回调
 */
+ (void)postUrl:(NSString *)url
           body:(id)body
   requestStyle:(DWRequestStyle)requestStyle
         result:(DWResult)result
     headerFile:(NSDictionary *)headerFile
         sucess:(Block )succes
        failure:(ErrorBlock )failure;

@end
