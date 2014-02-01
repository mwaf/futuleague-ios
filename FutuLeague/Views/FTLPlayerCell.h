//
//  FTLPlayerCell.h
//  FutuLeague
//
//  Created by Evangelos Sismanidis on 31/01/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

extern CGFloat const FTLPlayerCellHeight;
extern NSInteger const FTLPlayerCellBackgroundColorEven;
extern NSInteger const FTLPlayerCellBackgroundColorOdd;

@interface FTLPlayerCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *ratingLabel;

@end
