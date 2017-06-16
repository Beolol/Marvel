//
//  HRHeroCollectionViewController.h
//  Marvel
//
//  Created by user on 15.06.17.
//  Copyright © 2017 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRHeroCollectionViewController : UIViewController

@property (strong, nonatomic) NSMutableArray* heroesArray;
@property (assign, nonatomic) NSUInteger selectedHeroIndex;

@end
