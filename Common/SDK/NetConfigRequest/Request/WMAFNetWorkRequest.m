//
//  WMAFNetWorkRequest.m
//  NetConfigRequest
//
//  Created by summer.zhu on 4/2/15.
//  Copyright (c) 2015年 summer.zhu. All rights reserved.
//

#import "WMAFNetWorkRequest.h"
#import <AFNetworking.h>

@implementation WMAFNetWorkRequest

- (void)request:(NSString *)url method:(NSString *)method requestParmers:(NSDictionary *)request response:(ResponseBlock)res{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
    if ([method isEqualToString:@"POST"]) {
        [manager POST:url parameters:request  success:^(AFHTTPRequestOperation *operation, id responseObject) {
            res([responseObject[@"code"] intValue], responseObject[@"msg"], responseObject[@"data"], nil);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            res(0, nil, nil, error);
        }];
    }else if ([method isEqualToString:@"PUT"]){
        [manager PUT:url parameters:request  success:^(AFHTTPRequestOperation *operation, id responseObject) {
            res([responseObject[@"code"] intValue], responseObject[@"msg"], responseObject[@"data"], nil);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            res(0, nil, nil, error);
        }];
    }else{
        [manager GET:url parameters:request  success:^(AFHTTPRequestOperation *operation, id responseObject) {
            res([responseObject[@"code"] intValue], responseObject[@"msg"], responseObject[@"data"], nil);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            res(0, nil, nil, error);
        }];
    }
}

- (void)request:(NSString *)url sign:(NSString *)sign method:(NSString *)method requestParmers:(NSDictionary *)request response:(ResponseBlock)res{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
    NSString *result = [NSString stringWithFormat:@"OAuth apiSign=%@",sign];
    [manager.requestSerializer setValue:result forHTTPHeaderField:@"Authorization"];
    
    if ([method isEqualToString:@"POST"]) {
        [manager POST:url parameters:request  success:^(AFHTTPRequestOperation *operation, id responseObject) {
            res([responseObject[@"code"] intValue], responseObject[@"msg"], responseObject[@"data"], nil);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            res(0, nil, nil, error);
        }];
    }else if ([method isEqualToString:@"PUT"]){
        [manager PUT:url parameters:request  success:^(AFHTTPRequestOperation *operation, id responseObject) {
            res([responseObject[@"code"] intValue], responseObject[@"msg"], responseObject[@"data"], nil);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            res(0, nil, nil, error);
        }];
    }else{
        [manager GET:url parameters:request  success:^(AFHTTPRequestOperation *operation, id responseObject) {
            res([responseObject[@"code"] intValue], responseObject[@"msg"], responseObject[@"data"], nil);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            res(0, nil, nil, error);
        }];
    }
}

- (void)request:(NSString *)url sign:(NSString *)sign ssl:(BOOL)ssl method:(NSString *)method requestParmers:(NSDictionary *)request response:(ResponseBlock)res{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
    [manager.requestSerializer setValue:sign forHTTPHeaderField:@"Authorization"];
    
    AFHTTPRequestOperation *afRequest;
    if ([method isEqualToString:@"POST"]) {
        afRequest = [manager POST:url parameters:request  success:^(AFHTTPRequestOperation *operation, id responseObject) {
            res([responseObject[@"code"] intValue], responseObject[@"msg"], responseObject[@"data"], nil);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            res(0, nil, nil, error);
        }];
    }else if ([method isEqualToString:@"PUT"]){
        afRequest = [manager PUT:url parameters:request  success:^(AFHTTPRequestOperation *operation, id responseObject) {
            res([responseObject[@"code"] intValue], responseObject[@"msg"], responseObject[@"data"], nil);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            res(0, nil, nil, error);
        }];
    }else{
        afRequest = [manager GET:url parameters:request  success:^(AFHTTPRequestOperation *operation, id responseObject) {
            res([responseObject[@"code"] intValue], responseObject[@"msg"], responseObject[@"data"], nil);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            res(0, nil, nil, error);
        }];
    }
    
    if(ssl){
        afRequest.shouldUseCredentialStorage = NO;
        [afRequest setWillSendRequestForAuthenticationChallengeBlock:^(NSURLConnection *connection, NSURLAuthenticationChallenge *challenge) {
            if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
                [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
            }
        }];
    }
}

@end
