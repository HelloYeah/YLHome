//
//  CustomScrollView.h
//  HelloYeah
//
//  Created by Sekorm on 16/11/2.
//  Copyright © 2016年 yeliang. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef BOOL(^ShouldReceiveGesture)(UIGestureRecognizer *);

@interface CustomCollectionView : UICollectionView
@property (nonatomic,copy) ShouldReceiveGesture shouldReceiveGesture;
@end
