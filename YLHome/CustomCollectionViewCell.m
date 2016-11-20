//
//  CustomCollectionViewCell.m
//  HelloYeah
//
//  Created by Sekorm on 16/11/11.
//  Copyright © 2016年 yeliang. All rights reserved.
//

#import "CustomCollectionViewCell.h"
#import "UIView+Frame.h"
#import "HomeTableView.h"

@implementation CustomCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    
    _homeTableView = [[HomeTableView alloc]init];
    [self.contentView addSubview:_homeTableView];
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    _homeTableView.frame = CGRectMake(0, 0, self.width, self.height);
}

@end
