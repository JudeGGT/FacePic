//
//  GPCollectionViewHorizontalLayout.m
//  FacePic
//
//  Created by ggt on 2017/8/8.
//  Copyright © 2017年 ggt. All rights reserved.
//

#import "GPCollectionViewHorizontalLayout.h"

static CGFloat itemSpacing = 10;
static CGFloat lineSpacing = 10;

@interface GPCollectionViewHorizontalLayout ()

@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic, strong) NSMutableArray *leftArray;
@property (nonatomic, strong) NSMutableDictionary *heigthDic;
@property (nonatomic, strong) NSMutableArray *attributes;
@property (nonatomic, strong) NSMutableArray *indexPathsToAnimate;

@end

@implementation GPCollectionViewHorizontalLayout

#pragma mark - Lifecycle

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.leftArray = [NSMutableArray new];
        self.heigthDic = [NSMutableDictionary new];
        self.attributes = [NSMutableArray new];
    }
    
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    CGFloat itemWidth = self.itemSize.width;
    CGFloat itemHeight = self.itemSize.height;
    
    CGFloat width = self.collectionView.frame.size.width;
    CGFloat height = self.collectionView.frame.size.height;
    
    CGFloat contentWidth = (width - self.sectionInset.left - self.sectionInset.right);
    if (contentWidth >= (2 * itemWidth + self.minimumInteritemSpacing)) { //如果列数大于2行
        int m = (contentWidth - itemWidth) / (itemWidth + self.minimumInteritemSpacing);
        _line = m + 1;
        int n = (int)(contentWidth - itemWidth) % (int)(itemWidth + self.minimumInteritemSpacing);
        if (n > 0) {
            double offset = ((contentWidth - itemWidth) - m * (itemWidth + self.minimumInteritemSpacing)) / m;
            itemSpacing = self.minimumInteritemSpacing + offset;
        }else if (n == 0){
            itemSpacing = self.minimumInteritemSpacing;
        }
    }else{ //如果列数为一行
        itemSpacing = 0;
    }
    
    CGFloat contentHeight = (height - self.sectionInset.top - self.sectionInset.bottom);
    if (contentHeight >= (2 * itemHeight + self.minimumLineSpacing)) { //如果行数大于2行
        int m = (contentHeight - itemHeight) / (itemHeight + self.minimumLineSpacing);
        _row = m + 1;
        int n = (int)(contentHeight - itemHeight) % (int)(itemHeight + self.minimumLineSpacing);
        if (n > 0) {
            double offset = ((contentHeight - itemHeight) - m * (itemHeight + self.minimumLineSpacing)) / m;
            lineSpacing = self.minimumLineSpacing + offset;
        }else if (n == 0){
            lineSpacing = self.minimumInteritemSpacing;
        }
    }else{ //如果行数数为一行
        lineSpacing = 0;
    }
    
    
    int itemNumber = 0;
    
    itemNumber = itemNumber + (int)[self.collectionView numberOfItemsInSection:0];
    
    _pageNumber = (itemNumber - 1)/(_row*_line) + 1;
    _pageControl.numberOfPages = _pageNumber;
}

- (BOOL)ShouldinvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return NO;
}

- (CGSize)collectionViewContentSize {
    
    return CGSizeMake(self.collectionView.bounds.size.width * _pageNumber, self.collectionView.bounds.size.height);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    
    CGRect frame;
    frame.size = self.itemSize;
    //下面计算每个cell的frame   可以自己定义
    long number = _row * _line;
    long m = 0;  //初始化 m p
    long p = 0;
    if (indexPath.item >= number) {
        p = indexPath.item / number;  //计算页数不同时的左间距

        m = (indexPath.item % number) / _line;
    }else{
        m = indexPath.item / _line;
    }
    
    long n = indexPath.item % _line;
    frame.origin = CGPointMake(n * self.itemSize.width + (n) * itemSpacing + self.sectionInset.left + (indexPath.section + p) * self.collectionView.frame.size.width, m * self.itemSize.height + (m) * lineSpacing + self.sectionInset.top);
    
    attribute.frame = frame;
    return attribute;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSMutableArray *tmpAttributes = [NSMutableArray new];
    for (int j = 0; j < self.collectionView.numberOfSections; j ++)
    {
        NSInteger count = [self.collectionView numberOfItemsInSection:j];
        for (NSInteger i = 0; i < count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:j];
            [tmpAttributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
        }
    }
    self.attributes = tmpAttributes;
    return self.attributes;
}


- (void)dealloc {
    
    NSLog(@"%s", __func__);
}


#pragma mark - Custom Accessors (Setter 方法)


#pragma mark - Public


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - 懒加载



@end
