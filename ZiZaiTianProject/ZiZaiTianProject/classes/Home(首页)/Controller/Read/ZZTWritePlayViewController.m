//
//  ZZTWritePlayViewController.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/17.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTWritePlayViewController.h"

@interface ZZTWritePlayViewController ()<UITextViewDelegate>

@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UILabel *count;
@end

@implementation ZZTWritePlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"剧本";
    
    self.view.backgroundColor = [UIColor whiteColor];
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 50, SCREEN_WIDTH - 20, 400)];
    textView.returnKeyType = UIReturnKeySearch; //设置按键类型
    textView.textAlignment = NSTextAlignmentLeft;
    textView.layer.borderColor = [UIColor redColor].CGColor;
    textView.layer.borderWidth = 1;
    textView.layer.cornerRadius = 5;
    textView.scrollEnabled = YES;
    textView.delegate = self;
    textView.font = [UIFont systemFontOfSize:16];
    
    UILabel *count = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 150, CGRectGetMaxY(textView.frame) +5, 150, 20)];
    count.text = @"0/100";
    self.count = count;
    count.textAlignment = NSTextAlignmentRight;
    count.font = [UIFont fontWithName:@"Arial" size:15.0f];
    count.backgroundColor = [UIColor clearColor];
    count.textColor = [UIColor redColor];
    count.enabled = NO;
    [self.view addSubview:count];
    [self.view addSubview:textView];
    
    UIButton *leftbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    
    [leftbutton setTitle:@"发布" forState:UIControlStateNormal];
    [leftbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftbutton addTarget:self action:@selector(publish) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    
    self.navigationItem.rightBarButtonItem = rightitem;
}

-(void)publish{
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"请开始你的创作"]) {
        textView.text = @"";
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length <1) {
        textView.text = @"请开始你的创作";
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.count.text = [NSString stringWithFormat:@"您已经输入%lu字", textView.text.length  ];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (range.location < 100) {
        return YES;
        
    } else if ([textView.text isEqualToString:@"\n"]) {
        //这里写按了ReturnKey 按钮后的代码
        return NO;
        
    } if (textView.text.length == 100) {
        return NO;
    } return YES;
}

@end
