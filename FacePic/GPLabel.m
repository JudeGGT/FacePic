//
//  GPLabel.m
//  FacePic
//
//  Created by ggt on 2017/8/11.
//  Copyright © 2017年 ggt. All rights reserved.
//

#import "GPLabel.h"
#import "GPFaceHandler.h"
#import <CoreText/CoreText.h>

@interface GPLabel ()

@property (nonatomic, copy) NSString *string; /**< 文本 */
@property (nonatomic, strong) NSDictionary *attributedDictionary; /**< 属性字典 */

@end

@implementation GPLabel
{
    CTFrameRef _frame;
}

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
        [self setupConstraints];
        
        self.string = @"哈哈[001_a8][002_Whistle][003_Yellow_card_warning]";
        self.attributedDictionary = @{
                                      NSFontAttributeName : [UIFont systemFontOfSize:14.0f],
                                      NSForegroundColorAttributeName : [UIColor redColor]
                                      };
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    if (self.string.length == 0) return;
    
    
}

- (void)dealloc {
    
    NSLog(@"%s", __func__);
}


#pragma mark - UI

- (void)setupUI {
    
    
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    
}


#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions


#pragma mark - Public


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - CTRunDelegateCallbacks
void RunDelegateDeallocCallback(void * refCon)
{
}

CGFloat RunDelegateGetAscentCallback(void * refCon)
{
    return 20;
}

CGFloat RunDelegateGetDescentCallback(void * refCon)
{
    return 0;
}

CGFloat RunDelegateGetWidthCallback(void * refCon)
{
    return 20;
}


#pragma mark - 懒加载

@end
