//
//  ZZTWritePlayViewController.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/17.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTWritePlayViewController.h"

@interface ZZTWritePlayViewController ()
@property (weak, nonatomic) IBOutlet UIButton *back;
@property (weak, nonatomic) IBOutlet UIButton *commit;
@property (weak, nonatomic) IBOutlet UILabel *viewTitle;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ZZTWritePlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.commit.userInteractionEnabled = NO;
    //监听textfield的输入状态
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidChangeValue:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self.textView];
}

-(void)textFieldDidChangeValue:(NSNotification *)notification{
    UITextView *sender = (UITextView *)[notification object];
    if(sender.text.length != 0){
        self.commit.userInteractionEnabled = YES;
    }else{
        self.commit.userInteractionEnabled = NO;
    }
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)commit:(id)sender {
    NSLog(@"朱晓丹有点帅");
}


@end
