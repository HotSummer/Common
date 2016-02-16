//
//  NetConfigModelDefaultManager.m
//  NetConfigRequest
//
//  Created by zbq on 15-1-4.
//  Copyright (c) 2015年 summer.zhu. All rights reserved.
//

#import "NetConfigModelDefaultManager.h"
#import "NetConfigModel.h"
#import "NetConfigDefine.h"

@interface NetConfigModelDefaultManager ()

@property(nonatomic, strong) NSMutableDictionary *netConfigModels;

@end

@implementation NetConfigModelDefaultManager

- (id)init{
    if (self = [super init]) {
        _netConfigModels = [NSMutableDictionary dictionary];
        [self loadFile];
    }
    return self;
}

//从文件中加载数据
- (void)loadFile
{
    NSString *homeDir = [[NSBundle mainBundle] resourcePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error ;
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:homeDir error:&error];
    
    //放在bundle面
    [fileList enumerateObjectsUsingBlock:^(id obj,NSUInteger index,BOOL *stop){
        NSString *path = (NSString *)obj;
        NSRange rang = [path rangeOfString:@".bundle"];
        if (rang.location != NSNotFound ) {
            NSBundle *bundel = [NSBundle bundleWithPath:[homeDir stringByAppendingPathComponent:path]];
            NSArray *list = [NSBundle pathsForResourcesOfType:@"reqconfig" inDirectory:[bundel resourcePath]];
            if (list && [list count]>0) {
                [list enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    [self setConfigModel:obj];
                }];
            }
        }
    }];
    
    //没有放在bundle里面
    [fileList enumerateObjectsUsingBlock:^(id obj,NSUInteger index,BOOL *stop){
        NSString *path = (NSString *)obj;
        NSRange rang = [path rangeOfString:@".reqconfig"];//放在bundle面
        if (rang.location != NSNotFound ) {
            NSArray *list = [NSBundle pathsForResourcesOfType:@"reqconfig" inDirectory:homeDir];
            if (list && [list count]>0) {
                [list enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    [self setConfigModel:obj];
                }];
            }
        }
    }];
}

//将制定文件映射到内存中的model
-(void)setConfigModel:(NSString*)filePath{
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NCLog(@"file not");
    }
    NSError *error;
    NSDictionary *configs = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NCLog(@"%@",error.description);
    }else{
        if (configs) {
            [configs enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *dic = (NSDictionary *)obj;
                    NetConfigModel *model = [[NetConfigModel alloc] initWithDictionary:dic error:nil];
                    model.configkey = key;
                    [_netConfigModels setObject:model forKey:key];
                }
            }];
        }
    }
}

- (NetConfigModel *)getModel:(NSString *)modelKey{
    return _netConfigModels[modelKey];
}

@end
