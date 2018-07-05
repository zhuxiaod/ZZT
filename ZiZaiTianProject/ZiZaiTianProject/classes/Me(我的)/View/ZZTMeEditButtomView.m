//
//  ZZTMeEditButtomView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/4.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTMeEditButtomView.h"
@interface ZZTMeEditButtomView()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UIButton *userSex;

@property (weak, nonatomic) IBOutlet UITextField *userDetail;
@property (weak, nonatomic) IBOutlet UIButton *userBirthday;

@end

@implementation ZZTMeEditButtomView

+(instancetype)ZZTMeEditButtomView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

-(void)awakeFromNib{
    [self.userName addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.userSex addTarget:self action:@selector(textFieldDidBegin:) forControlEvents:UIControlEventTouchUpInside];
    [self.userBirthday addTarget:self action:@selector(textFieldDidBegin:) forControlEvents:UIControlEventTouchUpInside];
    _userName.tag = 0;
    _userSex.tag = 1;
    _userDetail.tag = 2;
    _userBirthday.tag = 3;
}

-(void)textFieldDidChange:(UITextField *)theTextField{
    if(self.TextChange){
        self.TextChange(theTextField);
    }
    NSLog(@"text changed: %@", theTextField.text);
}

-(void)textFieldDidBegin:(UIButton *)btn{
    NSLog(@"点击了");
    if(self.BtnInside){
        self.BtnInside(btn);
    }
}

@end
