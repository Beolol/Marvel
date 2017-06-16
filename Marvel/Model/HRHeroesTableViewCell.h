//
//  HRHeroesTableViewCell.h
//  Marvel
//
//  Created by user on 10.06.17.
//  Copyright © 2017 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRHeroesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *heroImageView;
@property (weak, nonatomic) IBOutlet UILabel *heroNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *heroDescriptionLabel;

@end
