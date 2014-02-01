//
//  FTLPlayerCell.m
//  FutuLeague
//
//  Created by Evangelos Sismanidis on 31/01/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import "FTLPlayerCell.h"

static NSString * const FTLPlayerCellNameLabelFontName = @"HelveticaNeue-Light";
static NSString * const FTLPlayerCellRatingLabelFontName = @"HelveticaNeue-Bold";
static CGFloat const FTLPlayerCellFontSize = 40.0;
static CGFloat const FTLPlayerCellPadding = 50.0;

@implementation FTLPlayerCell

#pragma mark - Setup

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    _nameLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont fontWithName:FTLPlayerCellNameLabelFontName size:FTLPlayerCellFontSize];
        [self.contentView addSubview:label];
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(FTLPlayerCellPadding);
            make.centerY.equalTo(self.contentView);
        }];
        label;
    });
    
    _ratingLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont fontWithName:FTLPlayerCellRatingLabelFontName size:FTLPlayerCellFontSize];
        [self.contentView addSubview:label];
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-FTLPlayerCellPadding);
            make.centerY.equalTo(self.contentView);
        }];
        label;
    });
    
    return self;
}

@end
