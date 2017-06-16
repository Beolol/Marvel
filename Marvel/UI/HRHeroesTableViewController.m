//
//  HRHeroesTableViewController.m
//  Marvel
//
//  Created by user on 10.06.17.
//  Copyright © 2017 user. All rights reserved.
//

#import "HRHeroesTableViewController.h"
#import "HRServerManager.h"
#import "HRHero.h"
#import "HRHeroesTableViewCell.h"
#import "HRHeroCollectionViewController.h"
#import "HRFileManager.h"
#import <UIImageView+AFNetworking.h>

@interface HRHeroesTableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray* heroesArray;

@property (assign, nonatomic) NSUInteger selectedIndex;

@end

static NSInteger heroesInRequest = 20;

static CGFloat heroesCellHeight = 100.0;
static CGFloat loadCellHeight = 30.0;

@implementation HRHeroesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _heroesArray = [NSMutableArray array];
    
    [self getFriendsFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API

- (void)getFriendsFromServer {
    
    [[HRServerManager sharedManager]
     getHeroesWithOffset:[self.heroesArray count]
     limit:heroesInRequest
     onSuccess:^(NSArray *heroes) {
         
         [self.heroesArray addObjectsFromArray:heroes];
         
         NSMutableArray* newPaths = [NSMutableArray array];
         for (int i = (int)[self.heroesArray count] - (int)[heroes count]; i < [self.heroesArray count]; i++) {
             [newPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
         }
         
         [self.tableView beginUpdates];
         [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationTop];
         [self.tableView endUpdates];
         
         [[HRFileManager sharedManager] saveHeroDataWithHeroArray:self.heroesArray];
         
     }
     onFailure:^(NSError *error, NSInteger statusCode) {
         NSLog(@"error = %@, code = %ld", [error localizedDescription], (long)statusCode);
         
         if (self.heroesArray.count == 0) {
             self.heroesArray = [[[HRFileManager sharedManager] getHeroesArray] copy];
             [self.tableView reloadData];
         }
         
     }];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.heroesArray count] + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == [self.heroesArray count]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoadMoreCell" forIndexPath:indexPath];
        cell.imageView.image = nil;
        cell.textLabel.text = @"LOAD MORE";
        return cell;
    }
    
    HRHeroesTableViewCell *cell = (HRHeroesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"HeroCell" forIndexPath:indexPath];
    HRHero* hero = self.heroesArray[indexPath.row];
    
    cell.heroNameLabel.text = hero.name;
    cell.heroDescriptionLabel.text = hero.heroDescription;
    
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:hero.imageURL]];
    
    __weak HRHeroesTableViewCell* weakCell = cell;
    
    cell.heroImageView.image = nil;
    
    [cell.imageView
     setImageWithURLRequest:request
     placeholderImage:nil
     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
         weakCell.heroImageView.image = image;
         [weakCell layoutSubviews];
     }
     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
         
     }];
    
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.heroesArray.count)
        return loadCellHeight;
    return heroesCellHeight;
}

- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self.heroesArray count])
        [self getFriendsFromServer];
    else
        self.selectedIndex = indexPath.row;
    
    return indexPath;
}




#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"selectHero"])
    {
        HRHeroCollectionViewController *descriptionHeroVC = [segue destinationViewController];
        
        descriptionHeroVC.heroesArray = [self.heroesArray copy];
        descriptionHeroVC.selectedHeroIndex = self.selectedIndex;
        NSLog(@"%ld",descriptionHeroVC.selectedHeroIndex);
        
    }
}


@end
