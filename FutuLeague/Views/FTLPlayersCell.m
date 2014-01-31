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

    _nameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_nameLabel];
    
    _ratingLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_ratingLabel];
    
    [_nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(50);
        make.top.equalTo(self.contentView).offset(10);
    }];
    
    [_ratingLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-50);
        make.top.equalTo(self.contentView).offset(10);
    }];
    
    
    return self;
}

@end
