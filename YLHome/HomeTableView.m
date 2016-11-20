//
//  HomeTableView.m
//  HelloYeah
//
//  Created by Sekorm on 16/10/31.
//  Copyright © 2016年 yeliang. All rights reserved.
//

#import "HomeTableView.h"
#import "UIView+Frame.h"
#import "ScrollToolBar.h"
#import "HomeTableInfoTool.h"
#import "HomeModel.h"


@interface HomeTableView ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSArray * dataSouce;


@end

@implementation HomeTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];
        [self scrollToolBar];
    }
    return self;
}

#pragma mark - ************** UITableView Datasource & Delegate  **************
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSouce.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    HomeModel * model = self.dataSouce[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if(_scrollToolBar.itemArray.count == 0){
        _scrollToolBar.itemArray = [HomeTableInfoTool shareInstance].titleArray;
    }
    return self.scrollToolBar;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}

#pragma mark - ************** scrollView Datasource   **************

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (!decelerate) {
        CGFloat offsetY = self.tableView.contentOffset.y;
        NSInteger index =  [HomeTableInfoTool shareInstance].selectedIndex;
        [[HomeTableInfoTool shareInstance].offsetYArray replaceObjectAtIndex:index withObject:@(offsetY)];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat offsetY = self.tableView.contentOffset.y;
    NSInteger index =  [HomeTableInfoTool shareInstance].selectedIndex;
    [[HomeTableInfoTool shareInstance].offsetYArray replaceObjectAtIndex:index withObject:@(offsetY)];
}

- (CGFloat)tableOriginalY{
    
    if ( self.tableView.contentOffset.y > 400) {
        return 64 + 40;
    }else{
        return 400 - self.tableView.contentOffset.y + 40 + 64;
    }
}


- (void)setTableDatasouce:(NSArray *)datasouce{
    _dataSouce = datasouce;
    [self.tableView reloadData];
}

- (void)setTableOffsetY:(CGFloat)offsetY{
    
    self.tableView.contentOffset = CGPointMake(0, offsetY);
    [self.tableView reloadData];
}


- (ScrollToolBar *)scrollToolBar{
    
    if (!_scrollToolBar) {
        _scrollToolBar = [[ScrollToolBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    }
    return _scrollToolBar;
}


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableHeaderView = self.headerView;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (UIView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 400)];
        _headerView.backgroundColor = _headerColor;
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = _headerView.bounds;
        btn.backgroundColor = [UIColor redColor];
        [_headerView addSubview:btn];
        
        
        UISwitch * swt = [[UISwitch alloc]init];
        [_headerView addSubview:swt];
        swt.centerX = _headerView.width * 0.5;
        swt.centerY = _headerView.height * 0.75;
    }
    return _headerView;
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.tableView.frame = self.bounds;
  
}
@end
