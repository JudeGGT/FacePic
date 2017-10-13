//
//  GPFaceCell.m
//  FacePic
//
//  Created by ggt on 2017/8/8.
//  Copyright © 2017年 ggt. All rights reserved.
//

#import "GPFaceCell.h"
#import "Masonry.h"

@interface GPFaceCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation GPFaceCell

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
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
    
    _imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_imageView];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}


#pragma mark - Custom Accessors (Setter 方法)

- (void)setImageDict:(NSDictionary *)imageDict {
    
    _imageDict = imageDict;
    NSString *imageName = [imageDict valueForKeyPath:@"image"];
    self.imageView.image = [UIImage imageNamed:imageName];
}


#pragma mark - IBActions


#pragma mark - Public


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - 懒加载

@end
