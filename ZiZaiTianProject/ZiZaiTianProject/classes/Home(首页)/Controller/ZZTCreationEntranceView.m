//
//  ZZTCreationEntranceView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/20.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTCreationEntranceView.h"
#import "ZZTCreatCartoonViewController.h"
#import "ZZTCreationEntranceModel.h"

@interface ZZTCreationEntranceView()
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *midBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *ture;
@property (weak, nonatomic) IBOutlet UIButton *cancel;
@property (strong,nonatomic) NSMutableArray *btns;
@property (nonatomic,assign) NSInteger typeNum;
@property (nonatomic,assign) BOOL isText;
@property (nonatomic,strong) NSString *cartoonName;
@property (nonatomic,strong) NSString *cartoonTitle;
@property (nonatomic,strong) NSMutableArray *cartoonType;


@end
@implementation ZZTCreationEntranceView

+(instancetype)CreationEntranceViewWithFrame:(CGRect)frame{
    ZZTCreationEntranceView *ceView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
    NSDictionary *dataDic = [NSDictionary dictionaryWithObject:@"YES" forKey:@"info"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"infoNotification" object:nil userInfo:dataDic];
    //赋值位置
    [ceView setFrame:frame];
    return ceView;
}

-(NSMutableArray *)btns{
    if(!_btns){
        _btns = [NSMutableArray arrayWithObjects:_leftBtn,_midBtn,_rightBtn, nil];
    }
    return _btns;
}

-(NSMutableArray *)cartoonType{
    if(!_cartoonType){
        _cartoonType = [NSMutableArray array];
    }
    return _cartoonType;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    //3个按钮加样式
    NSInteger i = 0;
    for (UIButton *btn in self.btns) {
        btn.layer.borderColor = [UIColor blackColor].CGColor;
        btn.layer.cornerRadius = 1;
        btn.layer.borderWidth = 1.0f;
        btn.backgroundColor = [UIColor grayColor];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        //测试
        btn.tag = i;
        i++;
    }
    
    self.ture.layer.borderColor = [UIColor colorWithHexString:@"#005220"].CGColor;
    self.ture.layer.borderWidth = 1.0f;
//    self.ture.userInteractionEnabled = NO;
    [self.ture addTarget:self action:@selector(tureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.cancel.layer.borderColor = [UIColor colorWithHexString:@"#946000"].CGColor;
    self.cancel.layer.borderWidth = 1.0f;
    
    [self.titleText addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    self.titleText.text = @"1";
     [self.nameText addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    self.nameText.text = @"1";

}

-(void)textFieldChange:(UITextField *)TextField{
    if(TextField == self.titleText || TextField == self.nameText){
        //输入键盘时 满足条件
        if(self.titleText.text.length > 0 && self.nameText.text.length > 0 && self.typeNum > 0){
            
            self.ture.backgroundColor = [UIColor colorWithHexString:@"#005220"];
            self.cartoonTitle = self.titleText.text;
            self.cartoonName = self.nameText.text;
        }else{
            self.ture.backgroundColor = [UIColor grayColor];
        }
    }
   
}

-(void)clickBtn:(UIButton *)btn{
    if(btn.selected == YES){
        btn.selected = NO;
        btn.backgroundColor = [UIColor grayColor];
        for (NSString *title in self.cartoonType) {
            if([btn.titleLabel.text isEqualToString:title])
                [self.cartoonType removeObject:title];
        }
    }else{
        btn.selected = YES;
        btn.backgroundColor = [UIColor blueColor];
        [self.cartoonType addObject:btn.titleLabel.text];

    }
    [self isOk];
}
-(void)isOk{
    self.typeNum = 0;
    //每次计算一次有几个被选中
    for (UIButton *btn in _btns) {
        if(btn.selected == YES){
            _typeNum++;
        }
    }
    if(self.titleText.text.length > 0 && self.nameText.text.length > 0 && self.typeNum > 0){
        
        self.ture.backgroundColor = [UIColor colorWithHexString:@"#005220"];
    }else{
        self.ture.backgroundColor = [UIColor grayColor];
    }
}
//不能点击要给个提示才行啊
-(void)tureBtnClick:(UIButton *)btn{

    if (self.typeNum >= 1 && self.nameText.text.length > 0 && self.titleText.text.length > 0) {
        weakself(self);
        
        ZZTCreationEntranceModel *model = [ZZTCreationEntranceModel initWithTpye:self.cartoonType cartoonName:self.cartoonName cartoonTitle:self.cartoonTitle];
        
        if(weakSelf.TureBtnBlock){
            weakSelf.TureBtnBlock(model);
            [self removeFromSuperview];
        }
    }
}
- (IBAction)cancel:(id)sender {
    [self removeFromSuperview];
}
@end
