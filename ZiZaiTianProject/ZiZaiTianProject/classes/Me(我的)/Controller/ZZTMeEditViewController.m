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
#import "TypeButton.h"
@interface ZZTMeEditViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>


@property (nonatomic,assign) NSInteger btnTag;

@property (nonatomic,strong) UIImage *resultImage;

@property (nonatomic,strong) UIImagePickerController *picker;

@property (nonatomic,strong) ZZTMeEditButtomView *meButtomView;

@property (nonatomic,strong) UIButton *doneButton;

@property(nonatomic, strong) BAKit_PickerView *pickView;

@property(nonatomic, strong) ZZTMeEditTopView *topView;


//背景图
@property (nonatomic,strong) NSString *backImg;

@property (nonatomic,strong) UIImage *backImage;
//头像图
@property (nonatomic,strong) NSString *headImg;
@property (nonatomic,strong) UIImage *headImage;
//昵称
@property (nonatomic,strong) NSString *userName;

//性别
@property (nonatomic,assign) NSString *sex;

//生日
@property (nonatomic,strong) NSString *birthday;

//签名
@property (nonatomic,strong) NSString *signature;

@end

@implementation ZZTMeEditViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //进来的时候要有资料  有资料的话  赋值一波
    //头像
    //昵称
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"编辑资料";
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    [self.view addSubview:scrollView];
    
    
    //添加topView
    ZZTMeEditTopView *topView = [ZZTMeEditTopView ZZTMeEditTopView];
    _topView = topView;
    //假如现在有数据  添加进去
    topView.backImage = self.backImg;
    topView.headImage = self.headImg;
    
    topView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300);
    topView.buttonAction = ^(UIButton *sender) {
        [self clickBtn:sender];
    };
    [scrollView addSubview:topView];

    //添加buttomView
    __block ZZTMeEditViewController *  blockSelf = self;
    ZZTMeEditButtomView *meButtomView = [ZZTMeEditButtomView ZZTMeEditButtomView];
    _meButtomView = meButtomView;
    meButtomView.model = self.model;
    _meButtomView.TextChange = ^(UITextField *texyField) {
        [blockSelf textChange:texyField];
    };
    meButtomView.frame = CGRectMake(0, 300, SCREEN_WIDTH, 400);

    _meButtomView.BtnInside = ^(UIButton *btn) {
        [blockSelf clickPickBtn:btn];
    };
    [scrollView addSubview:_meButtomView];

    //初始化图像选择控制器
    _picker = [[UIImagePickerController alloc]init];
    _picker.allowsEditing = YES;  //重点是这两句

    //遵守代理
    _picker.delegate =self;

    //注册观察键盘的变化
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(transformView:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //保存按钮
    UIButton *leftbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    [leftbutton setTitle:@"保存" forState:UIControlStateNormal];
    [leftbutton addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    self.navigationItem.rightBarButtonItem = rightitem;
    
}
//保存
-(void)save{
    //将七牛云上传头像
    if(self.headImage){
        //文件名
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = [formatter stringFromDate:[NSDate date]];
        NSString *imgName = [formatter stringFromDate:[NSDate date]];
        NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        NSMutableString *randomString = [NSMutableString stringWithCapacity:32];
        for (NSInteger i = 0; i < 32; i++) {
            [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((uint32_t)letters.length)]];
        }
        imgName = [NSString stringWithFormat:@"%@%@.png",imgName,randomString];
        //写入本地
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imgName];
        BOOL result = [UIImagePNGRepresentation(self.headImage) writeToFile:filePath atomically:YES];
        
        if (result == YES) {
            NSLog(@"保存成功");
            
            AFNHttpTool *tool = [[AFNHttpTool alloc] init];
            NSString *toke = [tool makeToken:ZZTAccessKey secretKey:ZZTSecretKey];
            
            [AFNHttpTool putImagePath:filePath key:imgName token:toke complete:^(id objc) {
                NSLog(@"%@",objc); //  上传成功并获取七牛云的图片地址
                self.headImg = objc;
                [self successUp];
            }];
            
        }else{
            NSLog(@"保存失败");
        }
    }else{
        self.headImg = @"";
        [self successUp];
    }
    //判断不为空
   
}
-(void)successUp{
    NSDictionary *dic = @{
                          @"userId":self.model.userId,
                          @"nickName":self.userName,
                          @"intro":self.signature,
                          @"sex":self.sex,
                          @"birthday":self.birthday,
                          @"headimg":self.headImg
                          };
    
    [AFNHttpTool POST:[ZZTAPI stringByAppendingString:@"login/upUser"] parameters:dic success:^(id responseObject) {
        NSLog(@"ok");
    } failure:^(NSError *error) {
        
    }];
}
//走了
-(void)textChange:(UITextField *)tf{
    if(tf.tag == 0){
        //名字
        self.userName = tf.text;
    }else if(tf.tag == 2){
        //签名
        self.signature = tf.text;
    }
}

-(void)clickPickBtn:(UIButton *)btn{
    //男
    if(btn.tag == 1){
        [self pickView2:btn];
        //生日
    }else if(btn.tag == 3){
        [self pickView4:btn];
    }else if(btn.tag == 4){
        [self pickView2:btn];
    }
}

#pragma mark - topView
-(void)clickBtn:(UIButton *)btn{
    //背景
    if (btn.tag == 1) {
         [self pushPhotoAlbum:btn];
    }else if (btn.tag == 2){
        //头像
        [self alert:btn];
    }
}

#pragma mark - 相册代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSLog(@"%@",info);
    UIButton *button = (UIButton *)[self.view viewWithTag:_btnTag];
    UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    //改变后的图片
    if(_btnTag == 1){
        _backImage = resultImage;
    }else{
        _headImage = resultImage;
    }
    [button setImage:[resultImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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

//调用相机
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

- (void)pickView2:(TypeButton *)btn
{
    //如果是男生
    if(btn.tag == 1){
        if(btn.selected == NO){
            btn.selected = YES;
            //设置值
            TypeButton *button = (TypeButton *)[self.meButtomView viewWithTag:4];
            button.selected = NO;
            self.sex = @"1";
        }
    }else{
        //如果是女生
        if(btn.selected == NO){
            btn.selected = YES;
            //设置值
            TypeButton *button = (TypeButton *)[self.meButtomView viewWithTag:1];
            button.selected = NO;
            self.sex = @"2";
        }
        //图片七牛云上传
    }
}

- (void)pickView4:(UIButton *)tf
{
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
        [tf setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [tf setTitle:[NSString stringWithFormat:@"%@",resultString] forState:UIControlStateNormal];
        self.birthday = resultString;
    }];
}

-(void)setModel:(ZZTUserModel *)model{
    _model = model;
    //背景图
    self.backImg = model.cover;

    //头像
    self.headImg = model.headimg;
    
    self.userName = model.nickName;
    
    self.signature = model.intro;
    
    self.sex = model.sex;
    
    self.birthday = [NSString timeWithStr:model.birthday];
    
    self.headImg = model.headimg;
    
}

@end
