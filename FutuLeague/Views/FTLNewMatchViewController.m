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
        [button setTitle:@"Home Players" forState:UIControlStateNormal];
        button;
    });

    _awayPlayersButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:@"Away Players" forState:UIControlStateNormal];
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

    [self.homeGoalCounter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(view.mas_centerX).with.offset(-50);
        make.centerY.equalTo(view.centerY);
    }];

    [self.awayGoalCounter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(view.mas_centerX).with.offset(50);
        make.centerY.equalTo(view.centerY);
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

@end
