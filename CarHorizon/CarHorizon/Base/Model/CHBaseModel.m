//
//  CHBaseModel.m
//  CarHorizon
//
//  Created by dllo on 15/10/12.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHBaseModel.h"

@implementation CHBaseModel

+(NSMutableArray *)baseModelByArr:(NSArray *)arr{
    
    NSMutableArray *modelArr = [NSMutableArray array];
    
    for (NSDictionary *dic in arr) {
        
        @autoreleasepool {
            
            id model = [[self class] baseModelByDic:dic];
            
            [modelArr addObject:model];
            
        }
    }
    return modelArr;
}

/**
 *  将传过来的数据解析为model,并返回
 *
 *  @param dic <#dic description#>
 *
 *  @return <#return value description#>
 */
+(instancetype)baseModelByDic:(NSDictionary *)dic{
    
    return [[[self class] alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic{
    
    self  = [super init];
    
    if (self) {
        
        @try {
            
            [self setValuesForKeysWithDictionary:dic];
        }
        @catch (NSException *exception) {
            
            NSLog(@"哈哈,我捕获异常了");
        }
        @finally {
            
            
        }
        
    }
    
    return self;
}

/**
 *  KVC的容错方法
 *
 *  @param value key对应的value的值
 *  @param key   字典中未找到的key
 */
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        self.uId = value;
    }
    
};


+(void)getMessageUrl:(NSString *)url
                body:(id)body
              result:(DWResult)result
          headerFile:(NSDictionary *)headerFile
              result:(Block)block{
    
    [CHAFNetWorkTool getUrl:url body:body result:result headerFile:headerFile sucess:^(id result) {
        
        NSMutableArray *arr = [[self class] baseModelByArr:result];
        
        block(arr);
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
}


@end
