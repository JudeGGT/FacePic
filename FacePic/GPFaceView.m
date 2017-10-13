//
//  GPFaceView.m
//  FacePic
//
//  Created by ggt on 2017/8/8.
//  Copyright © 2017年 ggt. All rights reserved.
//

#import "GPFaceView.h"
#import "GPCollectionViewHorizontalLayout.h"
#import "Masonry.h"
#import "GPFaceCell.h"
#import "GPFaceHandler.h"

static NSString *const kFaceViewCellIdentifier = @"FaceViewCellIdentifier";

@interface GPFaceView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) GPCollectionViewHorizontalLayout *layout;
@property (nonatomic, strong) NSMutableArray *faceArray; /**< 数据源 */

@end

@implementation GPFaceView

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor =  [UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1.0f];
        
        [self setupUI];
        [self setupConstraints];
    }
    
    return self;
}

- (void)dealloc {
    
    NSLog(@"%s", __func__);
}


#pragma mark - UI

- (void)setupUI {
    
    // CollectionView
    _layout = [[GPCollectionViewHorizontalLayout alloc] init];
    _layout.itemSize = CGSizeMake(36, 36);
    _layout.minimumLineSpacing = 12.0f;
    _layout.minimumInteritemSpacing = 12.0f;
    _layout.sectionInset = UIEdgeInsetsMake(14, 18, 0, 18);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
    _collectionView.backgroundColor =  [UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1.0f];;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    [_collectionView registerClass:[GPFaceCell class] forCellWithReuseIdentifier:kFaceViewCellIdentifier];
    [self addSubview:_collectionView];
    
    // PageControl
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.currentPageIndicatorTintColor =  [UIColor colorWithRed:255/255.0f green:192/255.0f blue:0/255.0f alpha:1.0f];
    _pageControl.pageIndicatorTintColor =  [UIColor colorWithRed:192/255.0f green:192/255.0f blue:192/255.0f alpha:1.0f];
    [self addSubview:_pageControl];
    _layout.pageControl = _pageControl;
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-21);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(21);
    }];
}


#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions


#pragma mark - Public


#pragma mark - Private


#pragma mark - Protocol
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.faceArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GPFaceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kFaceViewCellIdentifier forIndexPath:indexPath];
    cell.imageDict = self.faceArray[indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%@", [self.faceArray[indexPath.row] valueForKeyPath:@"name"]);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSInteger pageIndex = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5f;
    self.pageControl.currentPage = pageIndex;
}


#pragma mark - 懒加载

- (NSMutableArray *)faceArray {
    
    if (_faceArray == nil) {
        _faceArray = [NSMutableArray arrayWithArray:[GPFaceHandler sharedGPFaceHandler].faceArray];
        int line = self.layout.line;
        int row = self.layout.row;
        NSUInteger count = _faceArray.count;
        NSUInteger pageNum = self.layout.pageNumber;
        NSUInteger cnt = count + pageNum; // 数组大小
        int pageCount = line * row; // 每页的个数
        pageNum = cnt / pageCount;
        if (cnt % pageCount != 0) {
            // 有多余，新加一页，剩下的用空的填充数组，组成新的一页
            pageNum++;
            cnt = pageNum * pageCount; // 新的数组大小
            
            for (int i = 0; i < cnt - count; i++) {
                NSDictionary *dict = @{@"name" : @"", @"image" : @""};
                [_faceArray addObject:dict];
            }
        }
        
        for (NSUInteger i = 1; i <= pageNum; i++) {
            NSDictionary *deleteDict = @{@"name" : @"delete", @"image" : @"a8_face_delegate"};
            [_faceArray insertObject:deleteDict atIndex:((i * pageCount) - 1)];
        }
        
        [_faceArray removeObjectsInRange:NSMakeRange(cnt, _faceArray.count - cnt)];
    }
    
    return _faceArray;
}

@end
