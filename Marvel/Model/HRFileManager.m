//
//  HRFileManager.m
//  Marvel
//
//  Created by user on 16.06.17.
//  Copyright © 2017 user. All rights reserved.
//

#import "HRFileManager.h"
#import "HRHero.h"

@implementation HRFileManager

+ (HRFileManager*)sharedManager
{
    static HRFileManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HRFileManager alloc] init];
    });
    
    return manager;
}

- (void)saveHeroDataWithHeroArray:(NSArray<HRHero *> *)heroes
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:@"heroes"];
    
    NSMutableArray<NSDictionary<NSString *, NSString *> *>* array = [NSMutableArray array];
    
    for (HRHero *hero in heroes) {
        NSDictionary* dict = @{
                               @"name" : hero.name,
                               @"heroDescription" : hero.heroDescription,
                               @"imageURL" : hero.imageURL,
                               @"wikiURLString;": hero.wikiURLString
                               };
        
        [array addObject:dict];
    }
    
    [userDefaults setObject:array forKey:@"heroes"];
    [userDefaults synchronize];
}

- (NSArray<HRHero *> *)getHeroesArray
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSArray<NSDictionary<NSString *, NSString *> *> *array = [userDefaults objectForKey:@"heroes"];
    if (!array)
        return nil;
    
    NSMutableArray<HRHero *> *heroes = [NSMutableArray array];
    
    for (NSDictionary<NSString *, NSString *> *heroesDict in array)
    {
        HRHero *hero = [[HRHero alloc] init];
        hero.name = heroesDict[@"name"];
        hero.heroDescription = heroesDict[@"heroDescription"];
        hero.imageURL = heroesDict[@"imageURL"];
        hero.wikiURLString = heroesDict[@"wikiURLString"];
        [heroes addObject:hero];
    }
    
    return heroes;
}

@end
