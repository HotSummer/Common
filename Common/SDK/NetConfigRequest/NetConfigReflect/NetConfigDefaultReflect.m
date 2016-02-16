//
//  NetConfigDefaultReflect.m
//  NetConfigRequest
//
//  Created by summer.zhu on 22/1/15.
//  Copyright (c) 2015年 summer.zhu. All rights reserved.
//

#import "NetConfigDefaultReflect.h"
#import "NSObject+Runtime.h"
#import "NetConfigDefine.h"
#import "NetConfigModel.h"
#import <JSONModel.h>

@interface NetConfigDefaultReflect ()

//根据配置的类名获取对应的对象，如果configClassName和obj的类名相同，则返回obj否则使用configClassName的shareInstance的方法返回对象
- (NSObject *)getObjectFromConfig:(NSString *)configClassName object:(NSObject *)obj;

@end

@implementation NetConfigDefaultReflect

//- (BOOL)hasKey:(JSONModel *)obj propertyName:(NSString *)propertyName{
//    NSDictionary *dic = [obj toDictionaryWithKeys:@[propertyName]];
//    if (dic) {
//        return YES;
//    }
//    return NO;
//}

- (NSObject *)getObjectFromConfig:(NSString *)configClassName object:(NSObject *)obj{
    if ([configClassName isEqualToString:NSStringFromClass([obj class])]) {
        return obj;
    }else{//不一致的话，调用shareInstance方法创建该对象
        Class class = NSClassFromString(configClassName);
        NSObject *objShareInstance = (NSObject *)class;
        if ([objShareInstance respondsToSelector:@selector(shareInstance)]) {
            return [objShareInstance performSelector:@selector(shareInstance)];
        }
    }
    return nil;
}

- (NSDictionary *)requestDataFromConfig:(NetConfigModel *)configModel requestObject:(NSObject *)requestObj{
    NSMutableDictionary *paramers = [NSMutableDictionary dictionary];
    [configModel.reqParam enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSArray *array = [(NSString*)obj componentsSeparatedByString:@"."];
        if (array.count == 1) {//直接赋值，无需解析
            [paramers setObject:array[0] forKey:key];
        }else{//解析
            NSString *strClass = array[0];
            //第一步获取对象
            NSObject *object = [self getObjectFromConfig:strClass object:requestObj];
            
            //第二步获取对应的属性值
            if (!object) {
                NCLog(@"未找到该对象%@", strClass);
            }else{
//                BOOL bHasValue = NO;
                NSInteger iLevel = 0;
                for (int i=1; i<array.count; i++) {
                    //该类是否有该属性
                    if ([object hasKey:array[i]]) {
                        iLevel ++;
                        object = [object valueForKey:array[i]];
                    }
                }
                //是一层层递归找到的，则放到dic里面
                if (iLevel == array.count-1) {
                    [paramers setObject:object forKey:key];
                }
            }
        }
    }];
    
    return paramers;
}

- (NSDictionary *)requestDataFromConfig:(NetConfigModel *)configModel requestObjects:(NSArray *)requestObjs{
    NSMutableDictionary *mutableDicRequest = [NSMutableDictionary dictionary];
    for (NSObject *object in requestObjs) {
        NSDictionary *dicRequest = [self requestDataFromConfig:configModel requestObject:object];
        [mutableDicRequest addEntriesFromDictionary:dicRequest];
    }
    return mutableDicRequest;
}

- (void)responseObjectFromConfig:(NetConfigModel *)configModel contentData:(id)contentData responseObject:(NSObject *)responseObject{
    __block NSObject *resObj = responseObject;
    [configModel.resParam enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        //根据路径（key）获取返回数据中的值
        NSArray *keyArr = [(NSString*)key componentsSeparatedByString:@"."];
        id value = contentData;
        
        for (int i=0; i<keyArr.count; i++) {
            value = [value valueForKey:keyArr[i]];
        }
        
        NSArray *valueArr = [(NSString*)obj componentsSeparatedByString:@"."];
        //定位到配置里面设置的对象
        NSString *strClass = valueArr[0];
//        NSObject *object = [self getObjectFromConfig:strClass object:responseObject];
//        JSONModel *jsonModel = (JSONModel *)object;
        Class class = NSClassFromString(strClass);
        if ([contentData isKindOfClass:[NSDictionary class]]) {
            resObj = [[class alloc] initWithDictionary:(NSDictionary *)contentData error:nil];
        }
        
//        NSObject *objSuper;
//        
//        for (int i = 1; i<valueArr.count; i++) {
//            if (/*[ReflectionException hasKey:object.class propertyName:valueArr[i]]*/[object hasKey:valueArr[i]]) {
//                //获取属性的类型
//                NSString *className = [ReflectionProperty type:object.class propertyName:valueArr[i]];
//                //如果基础类型直接赋值
//                if ([ReflectionProperty basicType:className]) {
//                    [object setValue:object forKey:valueArr[i]];
//                    return ;
//                }else{
//                    //保存上层的类对象，用来赋值
//                    objSuper = object;
//                    object = [object valueForKey:valueArr[i]];
//                    if (!object) {
//                        object = [[NSClassFromString(className) alloc] init];
//                        [objSuper setValue:object forKey:valueArr[i]];
//                    }
//                }
//            }
//        }
//        
//        //赋值
//        [Reflection objectFromContent:value object:&object];
//        //有这个属性
//        if (/*[ReflectionException hasKey:objSuper.class propertyName:valueArr.lastObject]*/[object hasKey:valueArr.lastObject]) {
//            [objSuper setValue:object forKey:valueArr.lastObject];
//        }
    }];
}

- (void)responseObjectFromConfig:(NetConfigModel *)configModel contentData:(id)contentData responseObject:(NSObject *)responseObject classNameInArray:(NSString *)className{
    if (![responseObject isKindOfClass:[NSMutableArray class]]) {//通过配置文件赋值
        [self responseObjectFromConfig:configModel contentData:contentData responseObject:responseObject];
    }else{//不经过配置文件赋值，直接反射成数组
        if (![contentData isKindOfClass:[NSArray class]]) {
            NCLog(@"返回的数据并不是数组");
            return;
        }
        NSArray *arrContent = (NSArray *)contentData;
        //parseArrayData
        Class class = NSClassFromString(className);
        NSArray *objects = [class arrayOfModelsFromDictionaries:arrContent error:nil];//[Reflection parseArrayData:arrContent classNameInArray:className];
        NSMutableArray *mutableArray = (NSMutableArray *)responseObject;
        [mutableArray addObjectsFromArray:objects];
    }
}

- (void)responseObjectFromConfig:(NetConfigModel *)configModel contentData:(id)contentData responseObjects:(NSArray *)responseObjects{
    for (NSObject *object in responseObjects) {
        [self responseObjectFromConfig:configModel contentData:contentData responseObject:object];
    }
}


@end
