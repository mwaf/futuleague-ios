//
//  FTLPlayerSelectionCell.m
//  FutuLeague
//
//  Created by Martin Richter on 04/02/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import "FTLPlayerSelectionCell.h"

CGSize const FTLPlayerSelectionCellSize = {150, 150};
NSInteger const FTLPlayerSelectionCellBackgroundColor = 0xEEEEEE;
NSInteger const FTLPlayerSelectionCellBackgroundColorSelected = 0xEEFFEE;

static CGFloat const FTLPlayerSelectionCellPadding = 20.0;

@interface FTLPlayerSelectionCell ()

@end

@implementation FTLPlayerSelectionCell

#pragma mark - Setup

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;

    self.backgroundColor = COLOR_HEX(FTLPlayerSelectionCellBackgroundColor);

    _nameLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:FTLFontSizeSmall];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        [self.contentView addSubview:label];
        label;
    });

    [self addLayoutConstraints];

    return self;
}

#pragma mark - Auto Layout

- (void)addLayoutConstraints
{
    UIEdgeInsets insets = UIEdgeInsetsMake(FTLPlayerSelectionCellPadding,
                                           FTLPlayerSelectionCellPadding,
                                           FTLPlayerSelectionCellPadding,
                                           FTLPlayerSelectionCellPadding);

    [self.nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(insets);
    }];
}

@end
