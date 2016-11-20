//
//  HomeTableInfoTool.h
//  HelloYeah
//
//  Created by Sekorm on 16/11/17.
//  Copyright © 2016年 yeliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeTableInfoTool : NSObject

@property (nonatomic,strong) NSMutableArray<NSString *> * titleArray; //标题栏的标题数组

@property (nonatomic,strong) NSMutableArray * offsetYArray; //记录每个列表的偏移量

@property (nonatomic,strong) NSMutableArray * dataSouceArray; //列表的数据源数组

@property (nonatomic,assign) NSInteger  selectedIndex; //当前选中的标题序号

+ (instancetype)shareInstance;
@end
