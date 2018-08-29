//
//  ZZTCreationCartoonTypeViewController.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/8/20.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTCreationCartoonTypeViewController.h"
#import "ZZTBookType.h"
#import "ZZTCreatCartoonViewController.h"
#import "TypeButton.h"
#import "ZZTWritePlayViewController.h"
//宽度（自定义）
#define PIC_WIDTH 40

#define PIC_HEIGHT 22

//列数(自定义)
#define COL_COUNT 5

@interface ZZTCreationCartoonTypeViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *tagView;
@property (nonatomic,strong) NSArray *btnTitleArray;
@property (nonatomic,strong) NSMutableArray *btnArray;

@property (nonatomic,strong) NSMutableArray *tagArray;

//多人创作
@property (weak, nonatomic) IBOutlet TypeButton *typeOne;


@property (weak, nonatomic) IBOutlet TypeButton *typeTwo;
//单人创作


@property (weak, nonatomic) IBOutlet UITextField *bookName;
@property (weak, nonatomic) IBOutlet UITextView *introView;

@property (assign, nonatomic)  NSInteger bookType;

@property (nonatomic,strong) UILabel *placeHolderLabel;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end


@implementation ZZTCreationCartoonTypeViewController
//bookType
-(NSArray *)btnTitleArray{
    if(!_btnTitleArray){
        _btnTitleArray = [NSArray array];
    }
    return _btnTitleArray;
}

//btn
-(NSMutableArray *)btnArray{
    if(!_btnArray){
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

//tagID
-(NSMutableArray *)tagArray{
    if(!_tagArray){
        _tagArray = [NSMutableArray array];
    }
    return _tagArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //获得tag
    [self getBookType];
    
    //设置简介
    _introView.delegate = self;
    _introView.textColor = [UIColor blackColor];
    self.introView.layer.borderWidth = 1.0f;
    self.introView.layer.borderColor = [UIColor colorWithHexString:@"#C7C8C9"].CGColor;
    
    //输入一些默认内容
    [self.typeOne setImage:[UIImage imageNamed:@"编辑资料-图标-未选"] forState:UIControlStateNormal];
    [self.typeOne  setImage:[UIImage imageNamed:@"编辑资料-图标-男性"] forState:UIControlStateSelected];
    [self.typeOne setTitle:@"多人创作" forState:UIControlStateNormal];
    [self.typeOne addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.typeTwo setImage:[UIImage imageNamed:@"编辑资料-图标-未选"] forState:UIControlStateNormal];
    [self.typeTwo  setImage:[UIImage imageNamed:@"编辑资料-图标-男性"] forState:UIControlStateSelected];
    [self.typeTwo setTitle:@"独立创作" forState:UIControlStateNormal];
    [self.typeTwo addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];

    [self selectType:self.typeOne];
    
    //默认书的类型
    self.bookType = 1;
    
    //设置简介替换字
    [self setupplaceHolderLabel];
    
    self.sureBtn.userInteractionEnabled = NO;
    self.sureBtn.layer.borderColor = [UIColor blackColor].CGColor;
    self.sureBtn.layer.borderWidth = 1.0f;
    self.sureBtn.backgroundColor = [UIColor grayColor];
}

//设置简介替换字
-(void)setupplaceHolderLabel{
    _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5,100, 20)];
    
    _placeHolderLabel.textAlignment = NSTextAlignmentLeft;
    
    _placeHolderLabel.font = [UIFont systemFontOfSize:17];
    
    _placeHolderLabel.text = @"| 输入作品名称";
    
    _placeHolderLabel.textColor = [UIColor colorWithHexString:@"#C7C8C9"];
    
    [_introView addSubview:_placeHolderLabel];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:17]}];
}

//请求数据
-(void)getBookType{
    weakself(self);
    [AFNHttpTool POST:[ZZTAPI stringByAppendingString:@"cartoon/getBookType"] parameters:nil success:^(id responseObject) {
        NSDictionary *dic = [[EncryptionTools sharedEncryptionTools] decry:responseObject[@"result"]];
        NSMutableArray *array = [ZZTBookType mj_objectArrayWithKeyValuesArray:dic];
        weakSelf.btnTitleArray = array;
        //创建九宫格button
        [self addTagButton];
    } failure:^(NSError *error) {
        
    }];
}
//设置标题
- (void)setViewTitle:(NSString *)viewTitle{
    _viewTitle = viewTitle;
    self.navigationItem.title = viewTitle;
 }
//添加Btn
-(void)addTagButton{
    for (int i = 0; i < self.btnTitleArray.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        ZZTBookType *bookTpye = self.btnTitleArray[i];
        [button setTitle:bookTpye.bookTypeName forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"#C7C8C9"] forState:UIControlStateNormal];
        button.layer.cornerRadius = 10;
        button.tag = bookTpye.id;
        button.layer.borderColor = [UIColor clearColor].CGColor;
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        button.layer.borderWidth = 1.0f;
        [self.tagView addSubview:button];
        [self.btnArray addObject:button];
        
        [button addTarget:self action:@selector(selectTag:) forControlEvents:UIControlEventTouchUpInside];
        
        NSInteger row = i / COL_COUNT;
        
        NSInteger col = i % COL_COUNT;
        
        CGFloat margin = (self.tagView.width - (PIC_WIDTH * COL_COUNT)) / (COL_COUNT + 1);
        
        CGFloat picX = margin + (PIC_WIDTH + margin) * col;
        CGFloat picY = margin + (PIC_HEIGHT + margin) * row;

        button.frame = CGRectMake(picX, picY, PIC_WIDTH, PIC_HEIGHT);
    }
    [self selectTag:self.btnArray[0]];
}
//tag点击状态
-(void)selectTag:(UIButton *)btn{

    //当我点击btn时候状态会变
    if(btn.selected == NO){
        btn.selected = YES;
        [btn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        btn.layer.borderColor = [UIColor purpleColor].CGColor;
        [self.tagArray addObject:[NSString stringWithFormat:@"%ld",btn.tag]];
    }else{
        btn.selected = NO;
        [btn setTitleColor:[UIColor colorWithHexString:@"#C7C8C9"] forState:UIControlStateNormal];
        btn.layer.borderColor = [UIColor clearColor].CGColor;
        [self removeTag:btn];
    }
}

-(void)removeTag:(UIButton *)btn{
    NSString *tagID = [NSString stringWithFormat:@"%ld",btn.tag];
    NSString *str;
    for (str in self.tagArray) {
        if([str isEqualToString:tagID]){
            break;
        }
    }
    [self.tagArray removeObject:str];
}
//type
- (IBAction)selectType:(TypeButton *)sender {
    if([sender.titleLabel.text isEqualToString:@"多人创作"]){
        //没有选中多人创作
        if(sender.selected == NO){
            sender.selected = YES;
            NSLog(@"多人创作被选中了");
            self.typeTwo.selected = NO;
            self.bookType = 1;
        }
    }
    if([sender.titleLabel.text isEqualToString:@"独立创作"]){
        //没有选中多人创作
        if(sender.selected == NO){
            sender.selected = YES;
            //改变样式 获得type
            NSLog(@"独立创作被选中了");
            self.typeOne.selected = NO;
            self.bookType = 2;
        }
    }
}
//完成创建
- (IBAction)doneCreation:(UIButton *)sender {
    NSString *string = [self.tagArray componentsJoinedByString:@","];
    NSLog(@"%@",string);
    NSDictionary *dic = @{
                          @"userId":@"1",
                          @"bookType":string,
                          @"bookName":self.bookName.text,
                          @"intro":self.introView.text,
                          @"cover":@"1",
                          @"cartoonType":[NSString stringWithFormat:@"%ld",self.bookType],
                          @"type":self.type
                          };
    [AFNHttpTool POST:[ZZTAPI stringByAppendingString:@"cartoon/intCartoon"] parameters:dic success:^(id responseObject) {
        NSLog(@"@@@%@",responseObject);
    } failure:^(NSError *error) {
        
    }];
    if([self.type isEqualToString:@"1"]){
        ZZTCreatCartoonViewController *cartoonVC = [[ZZTCreatCartoonViewController alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cartoonVC animated:YES];
    }else{
        ZZTWritePlayViewController *writeVC = [[ZZTWritePlayViewController alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:writeVC animated:YES];
    }
    
}

//取消占位
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0 )
    {
        _placeHolderLabel.text = @"| 输入作品名称";
    }
    else
    {
        _placeHolderLabel.text = @"";
    }
}
- (IBAction)bookName:(UITextField *)sender {
    if(sender.text.length > 0){
        self.sureBtn.userInteractionEnabled = YES;
        self.sureBtn.backgroundColor = [UIColor colorWithHexString:@"#9694FA"];
    }else{
        self.sureBtn.userInteractionEnabled = NO;
        self.sureBtn.backgroundColor = [UIColor grayColor];
    }
}

@end
