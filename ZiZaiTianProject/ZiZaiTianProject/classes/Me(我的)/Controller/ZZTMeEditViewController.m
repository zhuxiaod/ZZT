//
//  ZZTMeEditViewController.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/4.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTMeEditViewController.h"
#import "ZZTMeEditTopView.h"
#import "ZZTMeEditButtomView.h"

@interface ZZTMeEditViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UIView *buttomView;

@property (nonatomic,assign) NSInteger btnTag;

@property (nonatomic,strong) UIImage *resultImage;

@property (nonatomic,strong) UIImagePickerController *picker;

@property (nonatomic,strong) ZZTMeEditButtomView *meButtomView;

@property (nonatomic,strong) UIButton *doneButton;

@property(nonatomic, strong) BAKit_PickerView *pickView;

@end

@implementation ZZTMeEditViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //添加topView
    ZZTMeEditTopView *topView = [ZZTMeEditTopView ZZTMeEditTopView];
    topView.buttonAction = ^(UIButton *sender) {
        [self clickBtn:sender];
    };
    [self.topView addSubview:topView];
    
    //添加buttomView
    __block ZZTMeEditViewController *  blockSelf = self;
    _meButtomView = [ZZTMeEditButtomView ZZTMeEditButtomView];
    _meButtomView.TextChange = ^(UITextField *texyField) {
        [blockSelf textChange:texyField];
    };
    _meButtomView.BtnInside = ^(UIButton *btn) {
        [self clickPickBtn:btn];
    };
    [self.buttomView addSubview:_meButtomView];
    
    //初始化图像选择控制器
    _picker = [[UIImagePickerController alloc]init];
    _picker.allowsEditing = YES;  //重点是这两句
    
    //遵守代理
    _picker.delegate =self;
    
    //注册观察键盘的变化
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(transformView:) name:UIKeyboardWillChangeFrameNotification object:nil];

}
//走了
-(void)textChange:(UITextField *)tf{
  
}

-(void)clickPickBtn:(UIButton *)btn{
    if(btn.tag == 1){
        [self pickView2:btn];
    }else if(btn.tag == 3){
        [self pickView4:btn];
    }
}
#pragma mark - topView
-(void)clickBtn:(UIButton *)btn{
    if (btn.tag == 0) {
        //取消
        [self.navigationController popViewControllerAnimated:YES];
    }else if (btn.tag == 1){
        //保存
    }else if (btn.tag == 2){
        //背景
        [self alert:btn];
    }else if (btn.tag == 3){
        //头像
        [self alert:btn];
    }
}

#pragma mark - 相册代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSLog(@"%@",info);
    UIButton *button = (UIButton *)[self.view viewWithTag:_btnTag];
    UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    [button setImage:[resultImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
    
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

//调用相册
-(void)pushPhotoAlbum:(UIButton *)btn{
    //告诉是哪一个btn
    _btnTag = btn.tag;
    //调用系统相册的类
//    _picker = [[UIImagePickerController alloc]init];
    //设置选取的照片是否可编辑
    _picker.allowsEditing = YES;
    //设置相册呈现的样式
    _picker.sourceType =  UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    //选择完成图片或者点击取消按钮都是通过代理来操作我们所需要的逻辑过程
//    _picker.delegate = self;
    [self.navigationController presentViewController:_picker animated:YES completion:^{
        
    }];
}

//调用相册
-(void)pushCamera:(UIButton *)btn{
    //告诉是哪一个btn
    _btnTag = btn.tag;
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        // 将sourceType设为UIImagePickerControllerSourceTypeCamera代表拍照或拍视频
        _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        // 设置拍摄照片
        _picker.cameraCaptureMode =UIImagePickerControllerCameraCaptureModePhoto;
        // 设置使用手机的后置摄像头（默认使用后置摄像头）
        _picker.cameraDevice =UIImagePickerControllerCameraDeviceRear;
        // 设置使用手机的前置摄像头。
        //picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        // 设置拍摄的照片允许编辑
        _picker.allowsEditing =YES;
    }else{
        NSLog(@"模拟器无法打开摄像头");
    }
    // 显示picker视图控制器
    [self presentViewController:_picker animated:YES completion:nil];
}

-(void)alert:(UIButton *)btn{
    //标题
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"请选择打开方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //相机
    UIAlertAction * camera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pushCamera:btn];
    }];
    //相册
    UIAlertAction * photo = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pushPhotoAlbum:btn];
    }];
    
    //取消按钮
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    //添加各个按钮事件
    [alert addAction:camera];
    [alert addAction:photo];
    [alert addAction:cancel];
    //弹出sheet提示框
    [self presentViewController:alert animated:YES completion:nil];
}

//移动UIView
-(void)transformView:(NSNotification *)aNSNotification
{
    //获取键盘弹出前的Rect
    NSValue *keyBoardBeginBounds=[[aNSNotification userInfo]objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect beginRect=[keyBoardBeginBounds CGRectValue];
    
    //获取键盘弹出后的Rect
    NSValue *keyBoardEndBounds=[[aNSNotification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect  endRect=[keyBoardEndBounds CGRectValue];
    
    //获取键盘位置变化前后纵坐标Y的变化值
    CGFloat deltaY=endRect.origin.y-beginRect.origin.y;
//    NSLog(@"看看这个变化的Y值:%f",deltaY);
    
    //在0.25s内完成self.view的Frame的变化，等于是给self.view添加一个向上移动deltaY的动画
    [UIView animateWithDuration:0.25f animations:^{
        [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+deltaY, self.view.frame.size.width, self.view.frame.size.height)];
    }];
}
- (void)pickView2:(UIButton *)tf
{
    NSArray *array = @[@"男", @"女"];
    
    BAKit_WeakSelf
    [BAKit_PickerView ba_creatCustomPickerViewWithDataArray:array configuration:^(BAKit_PickerView *tempView) {
        BAKit_StrongSelf
        // 可以自由定制 toolBar 和 pickView 的背景颜色
        tempView.ba_backgroundColor_toolBar = [UIColor colorWithHexString:@"#58006E"];
        tempView.ba_backgroundColor_pickView = [UIColor whiteColor];
        tempView.animationType = BAKit_PickerViewAnimationTypeBottom;
        tempView.ba_pickViewTitleColor = [UIColor whiteColor];
        // 自定义 pickview title 的字体
        tempView.ba_pickViewTitleFont = [UIFont boldSystemFontOfSize:15];
//        tempView.pickerViewPositionType = BAKit_PickerViewPositionTypeCenter;
        // 可以自由定制按钮颜色
        tempView.ba_buttonTitleColor_sure = [UIColor whiteColor];
        tempView.ba_buttonTitleColor_cancle = [UIColor whiteColor];
        self.pickView = tempView;
    } block:^(NSString *resultString) {
        BAKit_StrongSelf
        [tf setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        tf.titleLabel.textColor = [UIColor blackColor];
        tf.titleLabel.text = [NSString stringWithFormat:@"%@",resultString];
    }];
}

- (void)pickView4:(UIButton *)tf
{
    BAKit_WeakSelf
    [BAKit_DatePicker ba_creatPickerViewWithType:BAKit_CustomDatePickerDateTypeYMD configuration:^(BAKit_DatePicker *tempView) {
        NSDate *maxdDate;
        NSDate *mindDate;
        NSDateFormatter *format = [NSDateFormatter ba_setupDateFormatterWithYMD];
        NSDate *today = [[NSDate alloc]init];
        [format setDateFormat:@"yyyy-MM-dd"];
        
        // 最小时间，当前时间
        mindDate = [format dateFromString:[format stringFromDate:today]];
        
        NSTimeInterval oneDay = 24 * 60 * 60;
        // 最大时间，当前时间+180天
        NSDate *theDay = [today initWithTimeIntervalSinceNow:oneDay * 180];
        maxdDate = [format dateFromString:[format stringFromDate:theDay]];
        tempView.isShowBackgroundYearLabel = YES;
        
        // 自定义 pickview title 的字体颜色
        tempView.ba_pickViewTitleColor = [UIColor whiteColor];
        // 自定义 pickview title 的字体
        tempView.ba_pickViewTitleFont = [UIFont boldSystemFontOfSize:15];
        // 自定义 pickview背景 title 的字体颜色
        // 自定义：动画样式
        tempView.animationType = BAKit_PickerViewAnimationTypeBottom;
 
        // 自定义：pickView 文字颜色
        tempView.ba_pickViewTextColor = [UIColor blackColor];
        // 自定义：pickView 文字字体
        tempView.ba_pickViewFont = [UIFont systemFontOfSize:13];
        
        // 可以自由定制按钮颜色
        tempView.ba_buttonTitleColor_sure = [UIColor whiteColor];
        tempView.ba_buttonTitleColor_cancle = [UIColor whiteColor];
        
        // 可以自由定制 toolBar 和 pickView 的背景颜色
        tempView.ba_backgroundColor_toolBar = [UIColor colorWithHexString:@"#58006E"];
    } block:^(NSString *resultString) {
        BAKit_StrongSelf
        [tf setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [tf setTitle:[NSString stringWithFormat:@"%@",resultString] forState:UIControlStateNormal];
    }];

}


@end
