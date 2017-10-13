//
//  ViewController.m
//  FacePic
//
//  Created by ggt on 2017/8/8.
//  Copyright © 2017年 ggt. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "GPFaceHandler.h"
#import "GPFaceView.h"
#import "RTLabel.h"
#import "GPLabel.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView; /**< TableView */
@property (nonatomic, strong) UIView *bottomView; /**< 底部视图 */
@property (nonatomic, strong) UITextView *textView; /**< 输入框 */
@property (nonatomic, strong) UIButton *sendButton; /**< 发送按钮 */
@property (nonatomic, strong) NSMutableArray *dataSource; /**< 数据源 */
@property (nonatomic, strong) UIButton *faceButton; /**< 表情按钮 */
@property (nonatomic, strong) NSArray *faceArray; /**< 表情数组 */
@property (nonatomic, strong) GPFaceView *faceView;

@end

@implementation ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [NSMutableArray array];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self setupUI];
    [self setupConstraints];
    
//    GPLabel *label = [[GPLabel alloc] initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, 200)];
//    label.backgroundColor = [UIColor orangeColor];
//    [self.view addSubview:label];
}


#pragma mark - UI

- (void)setupUI {
    
    // TableVIew
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_tableView];
    
    // 底部视图
    _bottomView = [[UIView alloc] init];
    _bottomView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:_bottomView];
    
    // 输入框
    _textView = [[UITextView alloc] init];
    _textView.layer.borderWidth = 0.5f;
    _textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _textView.font = [UIFont systemFontOfSize:20.0f];
    [_bottomView addSubview:_textView];
    
    // 发送按钮
    _sendButton = [[UIButton alloc] init];
    [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
    _sendButton.backgroundColor = [UIColor orangeColor];
    [_sendButton addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_sendButton];
    
    // 表情按钮
    _faceButton = [[UIButton alloc] init];
    _faceButton.backgroundColor = [UIColor redColor];
    [_faceButton addTarget:self action:@selector(faceButtonCliced) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_faceButton];
    
    // 表情键盘
    _faceView = [[GPFaceView alloc] init];
    [self.view addSubview:_faceView];
    [_faceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(50);
        make.height.mas_equalTo(167);
    }];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    // TableView
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
    // 底部视图
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    
    // 输入框
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView).offset(12);
        make.top.equalTo(self.bottomView).offset(4);
        make.bottom.equalTo(self.bottomView).offset(-4);
        make.right.equalTo(self.faceButton.mas_left).offset(-12);
    }];
    
    // 表情按钮
    [self.faceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.sendButton);
        make.right.equalTo(self.sendButton.mas_left).offset(-12);
        make.width.height.mas_equalTo(30);
    }];
    
    // 发送按钮
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bottomView).offset(-12);
        make.top.equalTo(self.bottomView).offset(4);
        make.bottom.equalTo(self.bottomView).offset(-4);
        make.width.mas_equalTo(50);
    }];
}


#pragma mark - Custom Accessors (Setter 方法)


#pragma mark - IBActions

/**
 发送消息
 */
- (void)sendMessage {
    
    
}

/**
 选择表情
 */
- (void)faceButtonCliced {
    
    [self.textView resignFirstResponder];
    
}

/**
 键盘将要显示
 */
- (void)keyboardWillShow:(NSNotification *)sender {
    
    NSDictionary *dict = [sender valueForKeyPath:@"userInfo"];
    CGFloat duration = [[dict valueForKeyPath:@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    CGFloat keyboardHeight = CGRectGetHeight([[dict valueForKeyPath:@"UIKeyboardFrameEndUserInfoKey"] CGRectValue]);
    
    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-keyboardHeight);
    }];
    
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

/**
 键盘将要消失
 */
- (void)keyboardWillHide:(NSNotification *)sender {
    
    NSDictionary *dict = [sender valueForKeyPath:@"userInfo"];
    CGFloat duration = [[dict valueForKeyPath:@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    
    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
    }];
    
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - Public


#pragma mark - Private


#pragma mark - Protocol

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellIdentifier"];
    }
    
    return cell;
}


#pragma mark - UITableViewDelegate



#pragma mark - 懒加载




@end
