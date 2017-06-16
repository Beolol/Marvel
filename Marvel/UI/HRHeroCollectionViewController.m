//
//  HRHeroCollectionViewController.m
//  Marvel
//
//  Created by user on 15.06.17.
//  Copyright © 2017 user. All rights reserved.
//

#import "HRHeroCollectionViewController.h"
#import "HRHero.h"
#import "CollectionViewCell.h"
#import <UIImageView+AFNetworking.h>

@interface HRHeroCollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation HRHeroCollectionViewController

static NSString * const reuseIdentifier = @"HeroDescriptionCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.selectedHeroIndex <= self.heroesArray.count)
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.selectedHeroIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.heroesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    CollectionViewCell *heroCell = (CollectionViewCell *)cell;

    if (indexPath.row <= self.heroesArray.count) {
        
        HRHero* hero = self.heroesArray[indexPath.row];
        
        heroCell.nameLabel.text = hero.name;
        heroCell.heroDescriptionTextView.text = hero.heroDescription;
        heroCell.heroLinkTextView.text = hero.wikiURLString;
        
        NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:hero.imageURL]];
        
        __weak CollectionViewCell* weakCell = heroCell;
        
        heroCell.heroImageView.image = nil;
        
        [heroCell.heroImageView
         setImageWithURLRequest:request
         placeholderImage:nil
         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
             weakCell.heroImageView.image = image;
             [weakCell resizeCellWithFrame:weakCell.frame];
         }
         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
             [weakCell resizeCellWithFrame:weakCell.frame];
         }];
    
        [heroCell resizeCellWithFrame:heroCell.frame];
    }
    return heroCell;
}


@end
