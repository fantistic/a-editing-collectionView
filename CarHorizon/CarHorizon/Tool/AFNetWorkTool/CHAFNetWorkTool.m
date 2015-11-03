//
//  CHAFNetWorkTool.m
//  CarHorizon
//
//  Created by dllo on 15/10/12.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHAFNetWorkTool.h"


@implementation CHAFNetWorkTool


+ (void)getUrl:(NSString *)url
          body:(id)body
        result:(DWResult)result
    headerFile:(NSDictionary *)headerFile
        sucess:(Block )succes
       failure:(ErrorBlock )failure{
    
    NSString *str = [url stringByReplacingOccurrencesOfString:@"/" withString:@""];
    //获取网络请求管理类
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //为网络请求添加请求头
    if (headerFile ) {
        
        for (NSString *key in headerFile) {
            
            [manager.requestSerializer setValue:headerFile[key] forHTTPHeaderField:key];
            
        }
    }
    //设置返回值类型,默认返回的JSON类型数据
    switch (result) {
        case DWData:
            
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        case DWXML:
            
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
            
        case DWJSON:
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        default:
            break;
    }
    
    //设置网络请求值所支持的返回类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", nil]];
    
    //发送网络请求
    [manager GET:url parameters:body success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject) {
            
            NSArray *sandBox = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            
            NSString *sandBoxPath = sandBox[0];
            NSString *caches = [sandBoxPath stringByAppendingPathComponent:str];
            
            [NSKeyedArchiver archiveRootObject:responseObject toFile:caches];
            
            //成功回调
            succes(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (error) {
            //失败回调
            failure(error);
            NSArray *sandBox = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            
            NSString *sandBoxPath = sandBox[0];
            NSString *caches = [sandBoxPath stringByAppendingPathComponent:str];
            
            id responseObject = [NSKeyedUnarchiver unarchiveObjectWithFile:caches];
            
            if (responseObject != nil) {
                
                succes(responseObject);
            }
            
        }
        
    }];
}

+ (void)postUrl:(NSString *)url
           body:(id)body
   requestStyle:(DWRequestStyle)requestStyle
         result:(DWResult)result
     headerFile:(NSDictionary *)headerFile
         sucess:(Block )succes
        failure:(ErrorBlock )failure{
    
    //获取网络请求管理类
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //设置返回值支持的类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", nil]];
    //网络请求体的类型
    switch (requestStyle) {
        case DWRequestJSON:
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
            
        case DWRequestString:
            [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, id parameters, NSError **error) {
                
                return parameters;
            }];
            break;
        default:
            break;
    }
    //设置网络请求头
    if (headerFile ) {
        
        for (NSString *key in headerFile) {
            
            [manager.requestSerializer setValue:headerFile[key] forHTTPHeaderField:key];
            
        }
    }
    //网络请求返回值得数据类型,默认返回的JSON类型数据
    switch (result) {
        case DWData:
            
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        case DWXML:
            
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        default:
            break;
    }
    //发送post请求
    [manager POST:url parameters:body success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject) {
            //成功回调
            succes(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (error) {
            //失败回调
            failure(error);
        }
    }];
    
}


@end
