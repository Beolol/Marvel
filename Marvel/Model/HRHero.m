//
//  HRHero.m
//  Marvel
//
//  Created by user on 10.06.17.
//  Copyright © 2017 user. All rights reserved.
//

#import "HRHero.h"

@implementation HRHero

- (id)initWithServerResponse:(NSDictionary*)responseObject
{
    self = [super init];
    if (self) {
        
        self.name = responseObject[@"name"];
        self.heroDescription = responseObject[@"description"];
        
        NSDictionary *thumbnail = responseObject[@"thumbnail"];
        
        if (thumbnail) {
            NSMutableString *urlString = [NSMutableString stringWithFormat:@"%@.%@", thumbnail[@"path"], thumbnail[@"extension"]];
            if (urlString.length > 4) {
                [urlString insertString:@"s" atIndex:4];
            }
            
            self.imageURL = urlString;
        }
        
        self.wikiURLString = @"";
        NSArray *urlArray = responseObject[@"urls"];
        
        if(urlArray.count > 2)
        {
            NSDictionary *wikiDict = urlArray[1];
            
            if (wikiDict) {
                self.wikiURLString = wikiDict[@"url"];
            }
        }
        
        
    }
    return self;
}

@end
