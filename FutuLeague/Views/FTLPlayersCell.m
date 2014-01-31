//
//  FTLPlayersCell.m
//  FutuLeague
//
//  Created by Evangelos Sismanidis on 31/01/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#import "FTLPlayersCell.h"

@implementation FTLPlayersCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    NSString *nameLabelFontName = @"HelveticaNeue-Light";
    NSString *ratingLabelFontName = @"HelveticaNeue-Bold";
    CGFloat fontSize = 40.0;
    CGFloat cellPadding = 50.0;
    
    
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont fontWithName:nameLabelFontName size:fontSize];
    [self.contentView addSubview:_nameLabel];
    
    _ratingLabel = [[UILabel alloc] init];
    _ratingLabel.font = [UIFont fontWithName:ratingLabelFontName size:fontSize];
    [self.contentView addSubview:_ratingLabel];
    
    
    
    [_nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(cellPadding);
        make.centerY.equalTo(self.contentView);
    }];
    
    [_ratingLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-cellPadding);
        make.centerY.equalTo(self.contentView);
    }];
    
    return self;
}

@end
