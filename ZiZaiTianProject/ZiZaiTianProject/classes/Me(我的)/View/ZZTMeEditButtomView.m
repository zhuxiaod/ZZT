//
//  ZZTMeEditButtomView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/4.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTMeEditButtomView.h"
#import "TypeButton.h"

@interface ZZTMeEditButtomView()
@property (weak, nonatomic) IBOutlet UITextField *userName;

@property (weak, nonatomic) IBOutlet TypeButton *manBtn;
@property (weak, nonatomic) IBOutlet TypeButton *womanBtn;

@property (weak, nonatomic) IBOutlet UITextField *userDetail;
@property (weak, nonatomic) IBOutlet UIButton *userBirthday;

@end

@implementation ZZTMeEditButtomView

+(instancetype)ZZTMeEditButtomView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self.userName addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.userBirthday addTarget:self action:@selector(textFieldDidBegin:) forControlEvents:UIControlEventTouchUpInside];
    [self.userDetail addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    _userName.tag = 0;
    _userDetail.tag = 2;
    _userBirthday.tag = 3;
    
    //男
    [self.manBtn setImage:[UIImage imageNamed:@"编辑资料-图标-未选"] forState:UIControlStateNormal];
    [self.manBtn setImage:[UIImage imageNamed:@"编辑资料-图标-女性"] forState:UIControlStateSelected];
    [self.manBtn setTitle:@"男" forState:UIControlStateNormal];
    [self.manBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.manBtn addTarget:self action:@selector(textFieldDidBegin:) forControlEvents:UIControlEventTouchUpInside];
    self.manBtn.tag = 1;
    
    //女
    [self.womanBtn setImage:[UIImage imageNamed:@"编辑资料-图标-未选"] forState:UIControlStateNormal];
    [self.womanBtn setImage:[UIImage imageNamed:@"编辑资料-图标-女性"] forState:UIControlStateSelected];
    [self.womanBtn setTitle:@"女" forState:UIControlStateNormal];
    [self.womanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.womanBtn addTarget:self action:@selector(textFieldDidBegin:) forControlEvents:UIControlEventTouchUpInside];
    self.womanBtn.tag = 4;
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

-(void)setModel:(ZZTUserModel *)model{
    _model = model;
    self.userName.text = model.nickName;
    if([model.sex isEqualToString:@"0"]){
        //男
        self.manBtn.selected = YES;
        self.womanBtn.selected = NO;
    }else{
        //女
        self.womanBtn.selected = YES;
        self.manBtn.selected = NO;
    }
    NSString *time = [NSString timeWithStr:model.birthday];
    
    [self.userBirthday setTitle:time forState:UIControlStateNormal];
    [self.userBirthday setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.userDetail.text = model.intro;
}
@end
