//
//  CollectionViewCell.h
//  Marvel
//
//  Created by user on 16.06.17.
//  Copyright © 2017 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *heroImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *heroDescriptionTextView;
@property (weak, nonatomic) IBOutlet UITextView *heroLinkTextView;

- (void)resizeCellWithFrame:(CGRect)frame;

@end
