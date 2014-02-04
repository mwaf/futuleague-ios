//
//  FTLNewMatchViewController.m
//  FutuLeague
//
//  Created by Martin Richter on 31/01/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import "FTLNewMatchViewController.h"
#import "FTLNewMatchViewModel.h"
#import "FTLGoalCounter.h"
#import "FTLPlayersSelectionViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface FTLNewMatchViewController ()

@property (nonatomic, strong) FTLNewMatchViewModel *viewModel;

@property (nonatomic, strong) UIButton *homePlayersButton;
@property (nonatomic, strong) UIButton *awayPlayersButton;
@property (nonatomic, strong) FTLGoalCounter *homeGoalCounter;
@property (nonatomic, strong) FTLGoalCounter *awayGoalCounter;

@end

@implementation FTLNewMatchViewController

#pragma mark - Setup

- (instancetype)initWithPlayers:(NSArray *)players
{
    self = [super init];
    if (!self) return nil;

    _viewModel = [[FTLNewMatchViewModel alloc] initWithPlayers:players];

    _homePlayersButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.titleLabel.font = [UIFont systemFontOfSize:FTLFontSizeMedium];
        [button setTitle:@"Home Players" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(homePlayersButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        button;
    });

    _awayPlayersButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.titleLabel.font = [UIFont systemFontOfSize:FTLFontSizeMedium];
        [button setTitle:@"Away Players" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(awayPlayersButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        button;
    });

    _homeGoalCounter = ({
        FTLGoalCounter *counter = [[FTLGoalCounter alloc] init];
        counter;
    });

    _awayGoalCounter = ({
        FTLGoalCounter *counter = [[FTLGoalCounter alloc] init];
        counter;
    });

    return self;
}

#pragma mark - View Lifecycle

- (void)loadView
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];

    [view addSubview:self.homePlayersButton];
    [view addSubview:self.awayPlayersButton];
    [view addSubview:self.homeGoalCounter];
    [view addSubview:self.awayGoalCounter];

    [self.homePlayersButton makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(view.centerX).with.offset(-50);
        make.baseline.equalTo(view.centerY).with.offset(-150);
    }];

    [self.awayPlayersButton makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(view.centerX).with.offset(50);
        make.baseline.equalTo(view.centerY).with.offset(-150);
    }];

    [self.homeGoalCounter makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.homePlayersButton.trailing);
        make.top.equalTo(self.homePlayersButton.bottom).with.offset(20);
    }];

    [self.awayGoalCounter makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.awayPlayersButton.leading);
        make.top.equalTo(self.awayPlayersButton.bottom).with.offset(20);

    }];

    self.view = view;
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    RAC(self.viewModel, homeScore) = RACObserve(self.homeGoalCounter, goalCount);
    RAC(self.viewModel, awayScore) = RACObserve(self.awayGoalCounter, goalCount);

    self.navigationItem.rightBarButtonItem = ({
        UIBarButtonItem *item = [[UIBarButtonItem alloc]
                                 initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:nil action:nil];
        item.rac_command = self.viewModel.submitCommand;
        item;
    });

    @weakify(self);
    [[self.viewModel.submitCommand.executionSignals
        flattenMap:^(RACSignal *execution) {
            return [[execution materialize] filter:^BOOL(RACEvent *event) {
                return event.eventType == RACEventTypeCompleted;
            }];
        }] subscribeNext:^(id _) {
            @strongify(self);
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"hud.status.match.submitSuccess", nil)];
            [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        }];

    [self.viewModel.submitCommand.errors subscribeNext:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"hud.status.match.submitFailure", nil)];
    }];
}

#pragma mark - User Interaction

- (void)homePlayersButtonTapped
{
    FTLPlayersSelectionViewModel *viewModel = [[FTLPlayersSelectionViewModel alloc] initWithPlayers:self.viewModel.players];
    FTLPlayersSelectionViewController *viewController = [[FTLPlayersSelectionViewController alloc] initWithViewModel:viewModel];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)awayPlayersButtonTapped
{

}

@end
