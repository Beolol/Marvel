//
//  CollectionViewCell.m
//  Marvel
//
//  Created by user on 16.06.17.
//  Copyright © 2017 user. All rights reserved.
//

#import "CollectionViewCell.h"

const NSInteger HRIndent = 8;

@interface CollectionViewCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descriptionHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *linkHeightConstraint;


@end

@implementation CollectionViewCell

- (void)resizeCellWithFrame:(CGRect)frame;
{
    if (self.heroImageView.image)
    {
        CGSize imageSize = self.heroImageView.image.size;
        CGFloat imageResolution = imageSize.height / imageSize.width;
        CGFloat newHeight = frame.size.width * imageResolution;
        self.imageHeightConstraint.constant = (newHeight > imageSize.height) ? imageSize.height : newHeight;
    }
    else
    {
        self.imageHeightConstraint.constant = 0;
    }
    
    CGFloat newWidth = frame.size.width - 2 * HRIndent;
    self.nameHeightConstraint.constant = ceilf([self.nameLabel sizeThatFits:CGSizeMake(newWidth, HUGE_VALF)].height);
    if ([self.heroDescriptionTextView.text isEqualToString:@""]) {
        self.descriptionHeightConstraint.constant = 0;
    } else {
    self.descriptionHeightConstraint.constant = ceilf([self.heroDescriptionTextView sizeThatFits:CGSizeMake(newWidth, HUGE_VALF)].height);
    }
    self.linkHeightConstraint.constant = ceilf([self.heroLinkTextView sizeThatFits:CGSizeMake(newWidth, HUGE_VALF)].height);
    
    [self layoutIfNeeded];
}

@end
