//
//  FTLNewMatchViewController.m
//  FutuLeague
//
//  Created by Martin Richter on 31/01/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import "FTLNewMatchViewController.h"
#import "FTLNewMatchViewModel.h"

@interface FTLNewMatchViewController ()

@property (nonatomic, strong) FTLNewMatchViewModel *viewModel;

@end

@implementation FTLNewMatchViewController

#pragma mark - Setup

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;

    _viewModel = [[FTLNewMatchViewModel alloc] init];

    return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:nil action:nil];

    @weakify(self);
    self.navigationItem.rightBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
                [subscriber sendCompleted];
            }];

            return nil;
        }];
    }];
}

@end
