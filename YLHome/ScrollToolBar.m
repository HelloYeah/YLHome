//
//  ScrollToolBar.m
//  HelloYeah
//
//  Created by Sekorm on 16/10/31.
//  Copyright © 2016年 yeliang. All rights reserved.
//

#import "ScrollToolBar.h"
#import "UIView+Frame.h"


static CGFloat const topBarItemMargin = 15; ///标题之间的间距
@interface ScrollToolBar ()<UIScrollViewDelegate>
@property (nonatomic,strong) NSMutableArray * btnArray;
@property (nonatomic,weak) UIButton * selectedBtn;
@end
@implementation ScrollToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.backgroundColor = [UIColor lightGrayColor];
        self.showsHorizontalScrollIndicator = NO;
        _selectedIndex = 0;
    }
    return self;
}

- (void)setItemArray:(NSArray<NSString *> *)itemArray{
    
    _itemArray = itemArray;
    for (NSString * title in itemArray) {
        UIButton * btn = [[UIButton alloc]init];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn sizeToFit];
        [btn addTarget:self action:@selector(selectedChange:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [self.btnArray addObject:btn];
    }
    [self setSelectedIndex:0];
    
}

- (void)selectedChange:(UIButton *)btn{
    NSInteger index = [self.btnArray indexOfObject:btn];
    if (_selectedIndex != index) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kScrollToolBarNotificationKey object:self userInfo:@{@"selectedIndex":@(index)}];
    }
    self.selectedIndex = index;
}

- (void)setHightedBtnIndex:(NSInteger)index{
    
    if (self.btnArray.count <= 0) {
        return;
    }
    UIButton * btn = self.btnArray[index];
    if (btn != _selectedBtn) {
        _selectedBtn.selected = NO;
        _selectedBtn = btn;
        _selectedBtn.selected = YES;
    }
    
}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    

    _selectedIndex = selectedIndex;
    [self setHightedBtnIndex:selectedIndex];
    if (self.itemArray.count == 0) {
        return;
    }
    
    UIButton * btn = self.btnArray[selectedIndex];
    
    
    if (self.contentSize.width < SCREEN_WIDTH) {
        return;
    }
    
    // 计算偏移量
    CGFloat offsetX = btn.center.x - SCREEN_WIDTH * 0.5;
    if (offsetX < 0) offsetX = 0;
    // 获取最大滚动范围
    CGFloat maxOffsetX = self.contentSize.width - SCREEN_WIDTH;
    if (offsetX > maxOffsetX) offsetX = maxOffsetX;
    // 滚动标题滚动条
    [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];

}

- (NSMutableArray *)btnArray{
    
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    CGFloat btnX = topBarItemMargin;
    for (int i = 0; i < self.itemArray.count; i ++) {
        UIButton * btn = self.btnArray[i];
        btn.left = btnX;
        btn.centerY = self.height * 0.5;
        btnX += btn.width + topBarItemMargin;
    }
    if (btnX + topBarItemMargin > SCREEN_WIDTH) {
        self.contentSize = CGSizeMake(btnX, 0);
    }
}



@end
