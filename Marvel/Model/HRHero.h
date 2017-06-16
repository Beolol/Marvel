//
//  HRHero.h
//  Marvel
//
//  Created by user on 10.06.17.
//  Copyright © 2017 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HRHero : NSObject

- (id)initWithServerResponse:(NSDictionary*)responseObject;

@property (nonatomic) NSString* name;
@property (nonatomic) NSString* heroDescription;
@property (nonatomic) NSString *imageURL;
@property (nonatomic) NSString* wikiURLString;

@end
