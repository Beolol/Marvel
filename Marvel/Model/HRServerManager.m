//
//  HRServerManager.m
//  Marvel
//
//  Created by user on 10.06.17.
//  Copyright © 2017 user. All rights reserved.
//

#import "HRServerManager.h"
#import "HRHero.h"
#import <AFNetworking.h>

@interface HRServerManager ()

@property (nonatomic) NSString *urlString;

@end

@implementation HRServerManager

+ (HRServerManager*)sharedManager
{
    static HRServerManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HRServerManager alloc] init];
    });
    
    return manager;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        _urlString = @"https://gateway.marvel.com/v1/public/characters";
        
    }
    return self;
}

- (void)getHeroesWithOffset:(NSInteger)offset limit:(NSInteger)limit onSuccess:(void(^)(NSArray* friends))success onFailure:(void(^)(NSError* error, NSInteger statusCode))failure
{
    NSDictionary *parameters = @{
                                 @"ts" : @1,
                                 @"orderBy" : @"name",
                                 @"limit" : @(limit),
                                 @"offset" : @(offset),
                                 @"apikey" : @"b36408dd32f17cab2cb74207b0aca0e3",
                                 @"hash" : @"aa9f13541d0f9885ec11cfffb3a29852"
                                 };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:self.urlString parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSDictionary* dicts = responseObject[@"data"];
        
        NSLog(@"%@", dicts);
        
        NSArray* dictsArray = dicts[@"results"];
        
        NSMutableArray* objectsArray = [NSMutableArray array];
        
        for (NSDictionary* dict in dictsArray) {
            HRHero* user = [[HRHero alloc] initWithServerResponse:dict];
            [objectsArray addObject:user];
        }
        
        if (success) {
            success(objectsArray);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@",operation);
        
        if (failure) {
            NSHTTPURLResponse *code = (NSHTTPURLResponse *)operation.response;
            failure(error, code.statusCode);
        }
    }];

}

@end
