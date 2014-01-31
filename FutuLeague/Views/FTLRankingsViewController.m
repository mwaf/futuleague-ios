//
//  FTLRankingsViewController.m
//  FutuLeague
//
//  Created by Martin Richter on 31/01/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import "FTLRankingsViewController.h"
#import "FTLRankingsViewModel.h"
#import "FTLPlayer.h"
#import "FTLNewMatchViewController.h"

static NSString * const FTLRankingsTableCellIdentifier = @"FTLRankingsTableCellIdentifier";

@interface FTLRankingsViewController ()

@property (nonatomic, strong) FTLRankingsViewModel *viewModel;

@end

@implementation FTLRankingsViewController

#pragma mark - Setup

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (!self) return nil;

    _viewModel = [[FTLRankingsViewModel alloc] init];

    return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:FTLRankingsTableCellIdentifier];

    @weakify(self);
    [RACObserve(self.viewModel, model) subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    self.navigationItem.rightBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            FTLNewMatchViewController *newMatchViewController = [[FTLNewMatchViewController alloc] init];
            UINavigationController *navigationViewController = [[UINavigationController alloc]
                                                                initWithRootViewController:newMatchViewController];
            [self presentViewController:navigationViewController animated:YES completion:^{
                [subscriber sendCompleted];
            }];

            return nil;
        }];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.viewModel.active = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    self.viewModel.active = NO;
}

#pragma mark - User Interaction

- (void)newMatchButtonTapped
{

}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.model.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FTLRankingsTableCellIdentifier
                                                            forIndexPath:indexPath];
    cell.textLabel.text = [self playerAtIndexPath:indexPath].name;
    return cell;
}

- (FTLPlayer *)playerAtIndexPath:(NSIndexPath *)indexPath
{
    return self.viewModel.model[indexPath.row];
}

@end
