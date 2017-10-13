//
//  GPCollectionViewHorizontalLayout.h
//  FacePic
//
//  Created by ggt on 2017/8/8.
//  Copyright © 2017年 ggt. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 自定义横向布局
@interface GPCollectionViewHorizontalLayout : UICollectionViewLayout

#pragma mark - Property

@property (nonatomic) CGFloat minimumLineSpacing; //行间距
@property (nonatomic) CGFloat minimumInteritemSpacing; //item间距
@property (nonatomic) CGSize itemSize; //item大小
@property (nonatomic, assign) int row; /**< 列数 */
@property (nonatomic, assign) int line; /**< 行数 */
@property (nonatomic) UIEdgeInsets sectionInset;
@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, weak) UIPageControl *pageControl;

#pragma mark - Method

@end
