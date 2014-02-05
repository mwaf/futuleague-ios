//
//  FTLPlayersSelectionViewController.m
//  FutuLeague
//
//  Created by Martin Richter on 04/02/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import "FTLPlayersSelectionViewController.h"
#import "FTLPlayerSelectionCell+FTLPlayer.h"

static NSString * const FTLPlayerSelectionCellIdentifier = @"FTLPlayerSelectionCell";

@interface FTLPlayersSelectionViewController ()

@property (nonatomic, strong) FTLPlayersSelectionViewModel *viewModel;

@end

@implementation FTLPlayersSelectionViewController

- (instancetype)initWithViewModel:(FTLPlayersSelectionViewModel *)viewModel
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = FTLPlayerSelectionCellSize;

    self = [super initWithCollectionViewLayout:flowLayout];
    if (!self) return nil;

    _viewModel = viewModel;

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.allowsMultipleSelection = YES;
    [self.collectionView registerClass:FTLPlayerSelectionCell.class
            forCellWithReuseIdentifier:FTLPlayerSelectionCellIdentifier];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                              target:self
                                              action:@selector(doneButtonTapped)];
}

#pragma mark - User Interaction

- (void)doneButtonTapped
{

}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.viewModel.players.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FTLPlayerSelectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FTLPlayerSelectionCellIdentifier
                                                                             forIndexPath:indexPath];
    [cell updateWithPlayer:[self.viewModel playerAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FTLPlayerSelectionCell *cell = (FTLPlayerSelectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = COLOR_HEX(FTLPlayerSelectionCellBackgroundColorSelected);
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FTLPlayerSelectionCell *cell = (FTLPlayerSelectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = COLOR_HEX(FTLPlayerSelectionCellBackgroundColor);
}

@end
