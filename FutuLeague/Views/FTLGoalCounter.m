//
//  FTLGoalCounter.m
//  FutuLeague
//
//  Created by Martin Richter on 03/02/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import "FTLGoalCounter.h"

static CGFloat const FTLGoalCounterFontSize = 70.0;
static CGFloat const FTLGoalCounterLabelMargin = 10.0;

@interface FTLGoalCounter ()

@property (nonatomic, assign) NSUInteger goalCount;

@property (nonatomic, strong) UILabel *goalCountLabel;
@property (nonatomic, strong) UIButton *increaseButton;
@property (nonatomic, strong) UIButton *decreaseButton;

@end

@implementation FTLGoalCounter

#pragma mark - Setup

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;

    _goalCount = 0;

    _goalCountLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:FTLGoalCounterFontSize];
        RAC(label, text) = [RACObserve(self, goalCount) map:^id(NSNumber *goalCount) {
            return [NSString stringWithFormat:@"%u", goalCount.unsignedIntegerValue];
        }];
        [self addSubview:label];
        label;
    });

    _increaseButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.titleLabel.font = [UIFont systemFontOfSize:FTLGoalCounterFontSize];
        [button setTitle:@"+" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(increaseButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        button;
    });

    RACSignal *canDecreaseSignal = [RACObserve(self, goalCount)
        map:^id(NSNumber *goalCount) {
            return @(goalCount.unsignedIntegerValue > 0);
        }];

    _decreaseButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.titleLabel.font = [UIFont systemFontOfSize:FTLGoalCounterFontSize];
        [button setTitle:@"-" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(decreaseButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        RAC(button, enabled) = canDecreaseSignal;
        [self addSubview:button];
        button;
    });

    return self;
}

#pragma mark - Auto Layout

- (void)updateConstraints
{
    [super updateConstraints];

    [self.goalCountLabel updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];

    [self.increaseButton updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.bottom.equalTo(self.goalCountLabel.top).with.offset(-FTLGoalCounterLabelMargin);
    }];

    [self.decreaseButton updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.top.equalTo(self.goalCountLabel.bottom).with.offset(FTLGoalCounterLabelMargin);
    }];
}

- (CGSize)intrinsicContentSize
{
    CGFloat intrinsicContentHeight = (self.goalCountLabel.intrinsicContentSize.height
                                      + self.increaseButton.intrinsicContentSize.height
                                      + self.decreaseButton.intrinsicContentSize.height
                                      + 2 * FTLGoalCounterLabelMargin);

    return CGSizeMake(self.goalCountLabel.intrinsicContentSize.width,
                      intrinsicContentHeight);
}

#pragma mark - User Interaction

- (void)increaseButtonTapped
{
    self.goalCount++;
}

- (void)decreaseButtonTapped
{
    self.goalCount--;
}

@end
