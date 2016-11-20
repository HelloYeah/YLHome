//
//  CarouselView.m
//
//  Created by 叶良 on 16/3/17.
//  Copyright © 2016年 叶良. All rights reserved.
//

#import "CarouselView.h"
#import "HomeTableView.h"
#import "UIView+Frame.h"
#import "ScrollToolBar.h"
#import "CustomCollectionView.h"
#import "CustomCollectionViewCell.h"
#import "HomeModel.h"
#import "HomeTableInfoTool.h"


@interface CarouselView()<UIScrollViewDelegate,UIGestureRecognizerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) CustomCollectionView *collectionView;
@property (nonatomic,strong) HomeTableView * currTableView;
@property (nonatomic,strong) UIView   * snapshotView;
@property (nonatomic, strong) UIImageView *headerCover;
@end

@implementation CarouselView

- (instancetype)initWithTitles:(NSArray *)titles{
    if (self = [super init]) {
        [self initSubView];
    }
    return self;
}

#pragma mark 代码创建
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubView];
    }
    return self;
}
#pragma mark nib创建
- (void)awakeFromNib {
    [super awakeFromNib];
    [self initSubView];
}

#pragma mark 初始化控件
- (void)initSubView {
    [self addSubview:self.collectionView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSelectIndex:) name:kScrollToolBarNotificationKey object:nil];
}

- (void)changeSelectIndex:(NSNotification *)notification{
    
    NSInteger index = [notification.userInfo[@"selectedIndex"] integerValue];
    [self.collectionView setContentOffset:CGPointMake(index * SCREEN_WIDTH, 0)];
}


- (CustomCollectionView *)collectionView {
    
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = self.bounds.size;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _collectionView = [[CustomCollectionView alloc] initWithFrame:CGRectZero
                                                   collectionViewLayout:layout];
        
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:@"CustomCollectionViewCell"];
        WEAKSELF

        _collectionView.shouldReceiveGesture = ^(UIGestureRecognizer * gesture){
        
            CGPoint point = [gesture locationInView:weakSelf];
            CustomCollectionViewCell * currtCell = [weakSelf.collectionView visibleCells].firstObject;
            CGRect rect = CGRectMake(0, 0, weakSelf.width, currtCell.homeTableView.tableOriginalY - 64 - 40);
            BOOL shouldReceive = !CGRectContainsPoint(rect, point);
            return shouldReceive;
        };
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.dataSouce.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCollectionViewCell" forIndexPath:indexPath];
   
    HomeTableInfoTool * dataTool = [HomeTableInfoTool shareInstance];
    [cell.homeTableView setTableDatasouce:dataTool.dataSouceArray[indexPath.item]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(CustomCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{

    HomeTableInfoTool * dataTool = [HomeTableInfoTool shareInstance];
    [cell.homeTableView setTableDatasouce:dataTool.dataSouceArray[indexPath.item]];
    CGFloat preOffsetY = [dataTool.offsetYArray[dataTool.selectedIndex] floatValue];
    CGFloat offsetY = [dataTool.offsetYArray[indexPath.item] floatValue];
    
    if (preOffsetY >= 400) {
        [cell.homeTableView setTableOffsetY:offsetY > 400 ? offsetY : 400];
        [dataTool.offsetYArray replaceObjectAtIndex:indexPath.item withObject:@(offsetY > 400 ? offsetY : 400)];
        
    }else{
        [cell.homeTableView setTableOffsetY:preOffsetY];
        [dataTool.offsetYArray replaceObjectAtIndex:indexPath.item withObject:@(preOffsetY)];
        
    }
    
    dataTool.selectedIndex = indexPath.item;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    ScrollToolBar * bar = [ScrollToolBar appearance];
    bar.selectedIndex = scrollView.contentOffset.x/SCREEN_WIDTH;
}

#pragma mark- --------设置相关方法--------

- (void)removeHeaderCover{
    
    if (self.headerCover.superview != nil) {
        [self.headerCover removeFromSuperview];
    }
}

#pragma mark- -----------其它-----------
#pragma mark 布局子控件
- (void)layoutSubviews {
    [super layoutSubviews];

    _collectionView.frame = CGRectMake(0, 0, self.width, self.height);
    _collectionView.contentOffset = CGPointZero;
}

- (UIImageView *)headerCover
{
    if (!_headerCover) {
        _headerCover = [[UIImageView alloc] init];
        [_headerCover addSubview:self.snapshotView];
        [_headerCover clipsToBounds];
    }
    return _headerCover;
}




- (UIView *)snapshotView{
    UIViewController * vc = [self getViewController];
    _snapshotView = [vc.tabBarController.view snapshotViewAfterScreenUpdates:YES];
    return _snapshotView;
}

- (UIViewController *)getViewController{

    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}



#pragma mark- -------- UIScrollViewDelegate --------
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    if (self.headerCover.superview) {
        return;
    }
    UIViewController * vc = [self getViewController];
    self.headerCover.frame = CGRectMake(0, 0, SCREEN_WIDTH,self.currTableView.tableOriginalY);
    [vc.navigationController.view addSubview:self.headerCover];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    self.currTableView.scrollToolBar.selectedIndex = scrollView.contentOffset.x / SCREEN_WIDTH;
    [self removeHeaderCover];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (!decelerate) {
        self.currTableView.scrollToolBar.selectedIndex = scrollView.contentOffset.x / SCREEN_WIDTH;
        [self removeHeaderCover];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [self removeHeaderCover];
}

- (NSMutableArray *)dataSouce{
    
    if (_dataSouce == nil) {
        _dataSouce = [NSMutableArray array];
        
        HomeTableInfoTool * dataTool = [HomeTableInfoTool shareInstance];
        dataTool.selectedIndex = 0;
        for (int i = 0; i < 10 ; i ++) {
            NSMutableArray * tempArray = [NSMutableArray array];

            for (int j = 0 ; j < 30; j ++) {
                HomeModel * model = [[HomeModel alloc]init];
                model.name = [NSString stringWithFormat:@"%d-%d",i,j];
                [tempArray addObject:model];
            }
            [dataTool.titleArray addObject:[NSString stringWithFormat:@"%d group",i]];
            [dataTool.offsetYArray addObject:@(0)];
            [dataTool.dataSouceArray addObject:tempArray];
        }
        _dataSouce = dataTool.dataSouceArray;
    }
    return _dataSouce;
}

- (HomeTableView *)currTableView{
    
    NSIndexPath * indexPath = self.collectionView.indexPathsForVisibleItems.firstObject;
    CustomCollectionViewCell * cell = (CustomCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    _currTableView = cell.homeTableView;
    return _currTableView;
    
}

@end







