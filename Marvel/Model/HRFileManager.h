//
//  HRFileManager.h
//  Marvel
//
//  Created by user on 16.06.17.
//  Copyright © 2017 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HRHero;

@interface HRFileManager : NSObject

+ (HRFileManager*)sharedManager;

- (void)saveHeroDataWithHeroArray:(NSArray<HRHero *> *)hero;

- (NSArray<HRHero *> *)getHeroesArray;

@end
