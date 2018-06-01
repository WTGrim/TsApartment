//
//  SignUpViewController.m
//  TsApartment
//
//  Created by 董文涛 on 2018/5/29.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "SignUpViewController.h"
#import "NetworkTool.h"
#import "EnsurePsdViewController.h"

@interface SignUpViewController ()
//手机号
@property (weak, nonatomic) IBOutlet UITextField *phone;
//验证码
@property (weak, nonatomic) IBOutlet UITextField *code;
//获取验证码
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;
//勾选
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
//用户协议
@property (weak, nonatomic) IBOutlet UIButton *protocolBtn;
//注册
@property (weak, nonatomic) IBOutlet UIButton *signupBtn;

@end

static const NSInteger kTotalTimeInterval = 60;

@implementation SignUpViewController{
    NSDictionary *_codeDict;
    dispatch_source_t _timer;
    NSInteger _second;


}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupUI];
}

#pragma mark - initView
- (void)setupUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    _protocolBtn.hidden = _type == SignupType_FindPsd;
}

//获取验证码
- (IBAction)getCodeClick:(UIButton *)sender {
    
    [self hideKeyboard];
    if (![CommonTools isTelNumber:_phone.text]) {
        [WTAlertView showMessage:@"请输入正确的手机号码"];
        return;
    }
    
    WEAKSELF;
    [NetworkTool getVerifyCodeWithPhone:_phone.text succeedBlock:^(NSDictionary * _Nullable result) {
        [WTAlertView showMessage:[[result objectForKey:kData] objectForKey:kMessage]];
        [weakSelf dealTimer:result];
    } failedBlock:^(id  _Nullable errorInfo) {
        [WTAlertView showMessage:[errorInfo objectForKey:kMessage]];
    }];

    
}

- (void)dealTimer:(NSDictionary *)dict{
    _codeDict = [NSDictionary dictionaryWithDictionary:[dict objectForKey:kData]];
    [self startTimer];
}

- (void)startTimer{
    _getCodeBtn.enabled = false;
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    WEAKSELF;
    dispatch_source_set_event_handler(_timer, ^{
        [weakSelf resetTimer];
    });
    dispatch_resume(_timer);
}

- (void)resetTimer{
    _second ++;
    [_getCodeBtn setTitle:[NSString stringWithFormat:@"重新获取(%02ld)",(kTotalTimeInterval - _second)] forState:UIControlStateNormal];
    if (_second == kTotalTimeInterval) {
        _second = _second % kTotalTimeInterval;
        dispatch_cancel(_timer);
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _getCodeBtn.enabled = true;
    }
}

//勾选
- (IBAction)checkClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}

//点击用户协议
- (IBAction)protocolClick:(UIButton *)sender {
    
}

//点击下一步
- (IBAction)signupClick:(UIButton *)sender {
    
    [self hideKeyboard];

    NSArray *textFei = @[_phone, _code];
    NSArray *message = @[ @"请输入手机号", @"请输入验证码"];
    __block BOOL canGo = true;
    __block NSString *msg = nil;
    [textFei enumerateObjectsUsingBlock:^(UITextField  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.text.length == 0) {
            canGo = false;
            msg = message[idx];
            *stop = true;
        }
    }];
    if (!canGo) {
        [WTAlertView showMessage:msg];
        return;
    }
    
    if (![CommonTools isTelNumber:_phone.text]) {
        [AlertView showMsg:@"请输入正确的手机号码"];
        return;
    }
    
    if (!_checkBtn.isSelected) {
        [WTAlertView showMessage:@"请同意用户协议"];
        return;
    }

    WEAKSELF;
    [NetworkTool codeVerifyWithPhone:_phone.text purpose:@"register" code:_code.text succeedBlock:^(NSDictionary * _Nullable result) {
        [weakSelf goNext];
    } failedBlock:^(id  _Nullable errorInfo) {
        [WTAlertView showMessage:[errorInfo objectForKey:kMessage]];
    }];
}

- (void)goNext{
    
    EnsurePsdViewController *ensurePsd = [[EnsurePsdViewController alloc]init];
    ensurePsd.mobile = _phone.text;
    [self.navigationController pushViewController:ensurePsd animated:true];
}

//隐藏键盘
- (void)hideKeyboard{
    if (_phone.isFirstResponder) {
        [_phone resignFirstResponder];
    }
    
    if ([_code isFirstResponder]) {
        [_code resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
