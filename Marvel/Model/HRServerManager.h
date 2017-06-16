//
//  HRServerManager.h
//  Marvel
//
//  Created by user on 10.06.17.
//  Copyright © 2017 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HRServerManager : NSObject

+ (HRServerManager*)sharedManager;

- (void)getHeroesWithOffset:(NSInteger)offset limit:(NSInteger)limit onSuccess:(void(^)(NSArray* friends))success onFailure:(void(^)(NSError* error, NSInteger statusCode))failure;

@end
