//
//  FTLNewMatchViewController.m
//  FutuLeague
//
//  Created by Martin Richter on 31/01/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import "FTLNewMatchViewController.h"
#import "FTLNewMatchViewModel.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface FTLNewMatchViewController ()

@property (nonatomic, strong) FTLNewMatchViewModel *viewModel;

@property (nonatomic, strong) UIButton *homePlayersButton;
@property (nonatomic, strong) UIButton *awayPlayersButton;
@property (nonatomic, strong) UITextField *homeScoreField;
@property (nonatomic, strong) UITextField *awayScoreField;

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

    _homeScoreField = ({
        UITextField *field = [[UITextField alloc] init];
        field.keyboardType = UIKeyboardTypeNumberPad;
        field;
    });

    _awayScoreField = ({
        UITextField *field = [[UITextField alloc] init];
        field.keyboardType = UIKeyboardTypeNumberPad;
        field;
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
    [view addSubview:self.homeScoreField];
    [view addSubview:self.awayScoreField];

    self.view = view;
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];

    [self.homeScoreField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
        make.leading.equalTo(self.view.mas_leading).with.offset(30);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-30);
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    RAC(self.viewModel, homeScore) = self.homeScoreField.rac_textSignal;
    RAC(self.viewModel, awayScore) = self.awayScoreField.rac_textSignal;

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
