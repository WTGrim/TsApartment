//
//  ProfileSettingController.m
//  TsApartment
//
//  Created by 董文涛 on 2018/5/29.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "ProfileSettingController.h"
#import "UseCameraOrPhoto.h"
#import "NetworkTool.h"

@interface ProfileSettingController ()
//头像
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
//缓存
@property (weak, nonatomic) IBOutlet UILabel *cacheLabel;
//更换头像的图片
@property (nonatomic, strong)UIImage *iconImage;
//照片和相机访问
@property (nonatomic, strong)UseCameraOrPhoto *cameraOrPhoto;

@end

@implementation ProfileSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupUI];
}

#pragma mark - initView
- (void)setupUI{
    self.title = @"个人设置";
}

#pragma mark - 手势点击
- (IBAction)tapClick:(UITapGestureRecognizer *)sender {
    
    switch (sender.view.tag) {
        case 100://修改头像
        {
            WEAKSELF;
            [CommonTools alertWithTitle:@"设置头像" message:@"" style:UIAlertControllerStyleActionSheet leftBtnTitle:@"拍照" rightBtnTitle:@"从相册中选择" rootVc:self leftClick:^{
                [weakSelf.cameraOrPhoto useSystemWith:kUseSystemTypeCamera root:self block:^(UIImage *image,NSString *file) {
                    if (image) {
                        [weakSelf saveImage:image];
                    }
                }];
            } rightClick:^{
                [weakSelf.cameraOrPhoto useSystemWith:kUseSystemTypePhoto root:self block:^(UIImage *image, NSString *file) {
                    if (image) {
                        [weakSelf saveImage:image];
                    }
                }];
            }];
        }
            break;
            
        case 103://设置密码
        {
            
        }
            break;
        case 104://关于我们
        {
            
        }
            break;
        case 105://清楚缓存
        {
            WEAKSELF;
            [[SDImageCache sharedImageCache] clearMemory];
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                [AlertView showProgress];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [AlertView dismiss];
                    [WTAlertView showMessage:@"清理完成"];
                    weakSelf.cacheLabel.text = @"0.00M";
                });
            }];
        }
            break;
        default:
            break;
    }
}
             
#pragma mark - 保存image
- (void)saveImage:(UIImage *)image{
                 
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveClick)];
    _iconImageView.image = image;
                 
}

#pragma mark - 保存操作
- (void)saveClick{
    
//    [NetworkTool ]
}

#pragma mark - 退出登录
- (IBAction)logoutClick:(UIButton *)sender {
    
    [CommonTools alertWithTitle:@"" message:@"确定退出登录吗？" style:UIAlertControllerStyleAlert leftBtnTitle:@"取消" rightBtnTitle:@"确定" rootVc:self leftClick:^{
        
    } rightClick:^{
        [[UserStatus shareInstance]destoryUserStatus];
        [CommonTools removeLocalWithKey:kSaveUserInfo];
    }];
    
}

- (UseCameraOrPhoto *)cameraOrPhoto{
    if (!_cameraOrPhoto) {
        _cameraOrPhoto = [UseCameraOrPhoto new];
    }
    return _cameraOrPhoto;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
