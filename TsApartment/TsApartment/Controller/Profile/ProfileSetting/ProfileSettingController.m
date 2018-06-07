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
#import "UIImageView+EasyInOut.h"
#import "UserNameViewController.h"
#import "EnsurePsdViewController.h"

@interface ProfileSettingController ()
//头像
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
//用户名
@property (weak, nonatomic) IBOutlet UILabel *nickName;
//手机号
@property (weak, nonatomic) IBOutlet UILabel *mobile;
//登录密码
@property (weak, nonatomic) IBOutlet UILabel *password;
//缓存
@property (weak, nonatomic) IBOutlet UILabel *cacheLabel;
//更换头像的图片
@property (nonatomic, strong)UIImage *iconImage;
//照片和相机访问
@property (nonatomic, strong)UseCameraOrPhoto *cameraOrPhoto;

@end

static NSString *const defaultNickName = @"请填写您喜欢的用户名";
static NSString *const defaultPassword = @"填写您登录的密码";

@implementation ProfileSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self getData];
}

#pragma mark - 获取数据
- (void)getData{

    WEAKSELF;
    [NetworkTool getUserInfoWithSucceedBlock:^(NSDictionary * _Nullable result) {
        [weakSelf presentData:[result objectForKey:kData]];
    } failedBlock:^(id  _Nullable errorInfo) {
        [WTAlertView showMessage:[errorInfo objectForKey:kMessage]];
    }];
}

- (void)presentData:(NSDictionary *)dict{
    
    if (StringIsNull([dict objectForKey:kHeadimage])) {
        _iconImageView.image = [UIImage imageNamed:@"profile_user"];
    }else{
        [_iconImageView wt_setImageWithURL:[dict objectForKey:kHeadimage] placeholderImage:[UIImage imageNamed:@"profile_user"] completed:nil];
    }
    
    _mobile.text = [CommonTools getStringWithDict:dict key:kMobile];
    
    NSString *nickName = @"";
    if (StringIsNull([dict objectForKey:kNickName])) {
        nickName = defaultNickName;
    }else{
        nickName = [dict objectForKey:kNickName];
    }
    _nickName.text = nickName;
    
    NSString *password = @"";
    if (StringIsNull([dict objectForKey:kPassword])) {
        password = defaultPassword;
    }else{
        password = [dict objectForKey:kPassword];
    }
    _password.text = password;
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
        case 101://修改用户名
        {
            UserNameViewController *userNameVc = [[UserNameViewController alloc]init];
            userNameVc.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:userNameVc animated:true];
        }
            break;
        case 103://设置密码
        {
            EnsurePsdViewController *psd = [[EnsurePsdViewController alloc]init];
            psd.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:psd animated:true];
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
            
        case 106://退出登录
        {
            [CommonTools alertWithTitle:@"" message:@"确定退出登录吗？" style:UIAlertControllerStyleAlert leftBtnTitle:@"取消" rightBtnTitle:@"确定" rootVc:self leftClick:^{
                
            } rightClick:^{
                [[UserStatus shareInstance]destoryUserStatus];
                [CommonTools removeLocalWithKey:kSaveUserInfo];
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
    [self uploadImage];
                 
}

#pragma mark - 上传头像
- (void)uploadImage{
    [NetworkTool editUserInfoWithNickName:@"" sex:0 imageArray:@[_iconImageView.image] password:@"" SucceedBlock:^(NSDictionary * _Nullable result) {
        
    } failedBlock:^(id  _Nullable errorInfo) {
        
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
