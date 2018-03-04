//
//  PICodeViewController.m
//  Parking
//
//  Created by apple on 2018/3/4.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PICodeViewController.h"
#import <ZBarSDK.h>
#import <AVFoundation/AVFoundation.h>

@interface PICodeViewController ()<CAAnimationDelegate,ZBarReaderDelegate,ZBarReaderViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,AVCaptureMetadataOutputObjectsDelegate, UIAlertViewDelegate>
@property (strong,nonatomic)     AVCaptureSession * session;//输入输出的中间桥梁
@property (strong, nonatomic)  UIImageView *bgImg;
@property (strong, nonatomic)  UIImageView *imgCenter;
@property (strong, nonatomic)  UILabel *codeL;
@property (strong) ZBarReaderView *readview;
@property (strong) NSString *code;

@end

@implementation PICodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"扫码";
    //    if (_isQtCode) {
    [self start];
    //    }else{
    //        [self startByAVFoundation];
    //    }
    [self setupUI];
    [self repeatUpDown];
}

- (void)setupUI{
    
    self.view.backgroundColor = [UIColor blackColor];
    self.bgImg  = [[UIImageView alloc] initWithFrame:CGRectMake(30, SCREEN_HEIGHT / 2 - SCREEN_WIDTH / 2 + 30, SCREEN_WIDTH - 60, SCREEN_WIDTH - 60)];
    self.bgImg.image = [UIImage imageNamed:@"shaoma"];
    [self.view addSubview:self.bgImg];
    self.imgCenter = [[UIImageView alloc] initWithFrame:CGRectMake(30, SCREEN_HEIGHT / 2 - 1.5, SCREEN_WIDTH - 60, 3)];
    self.imgCenter.image = [UIImage imageNamed:@"shaomacenter"];
    [self.view addSubview:self.imgCenter];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(leftBarButtonItemClick:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"图片" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick:)];
}

- (void)dealloc {
    _codeBlock = nil;
    [_session stopRunning];
}

- (void)start {
    //初始化照相机窗口
    _readview = [ZBarReaderView new];
    //自定义大小
    //    readview.frame = CGRectMake(100, 100, 300, 300);
    _readview.frame = self.view.frame;
    //自定义添加相关指示.........发挥各自的APP的想象力
    //此处省略美化10000行代码...................
    //………………………..
    // 好进入正题—— 接着设置好代理
    _readview.readerDelegate = self;
    //将其照相机拍摄视图添加到要显示的视图上
    [self.view addSubview:_readview];
    [self.view insertSubview:_readview atIndex:0];
    //二维码/条形码识别设置
    ZBarImageScanner *scanner = _readview.scanner;
    //    [scanner setSymbology: ZBAR_I25
    //                   config: ZBAR_CFG_ENABLE
    //                       to: 0];
    
    [_readview.session setSessionPreset:AVCaptureSessionPresetHigh];
    
    [scanner setSymbology: ZBAR_CODE128
                   config: ZBAR_CFG_POSITION
                       to: 0];
    //启动，必须启动后，手机摄影头拍摄的即时图像菜可以显示在readview上
    [_readview start];
    
}

- (void)startByAVFoundation {
    // Do any additional setup after loading the view, typically from a nib.
    //获取摄像设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    ///创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    if (!input) return;
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //设置有效扫描区域
    //    CGRect scanCrop=[self getScanCrop:_scanWindow.bounds readerViewBounds:self.view.frame];
    //    output.rectOfInterest = scanCrop;
    //初始化链接对象
    _session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    [_session addInput:input];
    [_session addOutput:output];
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes=@[AVMetadataObjectTypeCode128Code];
    
    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame=self.view.layer.bounds;
    [self.view.layer insertSublayer:layer atIndex:0];
    //开始捕获
    [_session startRunning];
}


-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count>0) {
        //[session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        //输出扫描字符串
        _code = metadataObject.stringValue;
        NSLog(@"%@",metadataObject.stringValue);
        [self finishClick];
        [_session stopRunning];
    }
    
    
}

- (void)repeatUpDown{
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width / 2;
    CGFloat h = [UIScreen mainScreen].bounds.size.height / 2;
    CGFloat a = w - 30;
    //1.创建核心动画
    CAKeyframeAnimation *keyAnima=[CAKeyframeAnimation animation];
    //平移
    
    keyAnima.keyPath=@"position";
    //1.1告诉系统要执行什么动画
    NSValue *value1=[NSValue valueWithCGPoint:CGPointMake(w, h - a)];
    NSValue *value2=[NSValue valueWithCGPoint:CGPointMake(w, h)];
    NSValue *value3=[NSValue valueWithCGPoint:CGPointMake(w, h+ a)];
    NSValue *value4=[NSValue valueWithCGPoint:CGPointMake(w, h)];
    NSValue *value5=[NSValue valueWithCGPoint:CGPointMake(w, h-a)];
    keyAnima.values=@[value1,value2,value3,value4,value5];
    //1.2设置动画执行完毕后，不删除动画
    keyAnima.removedOnCompletion=NO;
    //1.3设置保存动画的最新状态
    keyAnima.fillMode=kCAFillModeForwards;
    //1.4设置动画执行的时间
    keyAnima.duration=4.0;
    keyAnima.repeatCount = HUGE_VALF;
    //2.添加核心动画
    [self.imgCenter.layer addAnimation:keyAnima forKey:nil];
    
}

-(void)animationDidStart:(CAAnimation *)anim {
    NSLog(@"开始动画");
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"结束动画");
}

- (void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image {
    ZBarSymbol *symbol = nil;
    for(symbol in symbols)
        break;
    _codeL.text = symbol.data;
    _code =  symbol.data;
    [self finishClick];
    //    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"消息" message:symbol.data delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:@"OK1", nil];
    //    [alert show];
}
- (void) readerView: (ZBarReaderView*) readerView
   didStopWithError: (NSError*) error{
    //    if (_errorString) {
    //        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"消息" message:_errorString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //        [alert show];
    //    }
}
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    [_readview start];
//}

- (void)leftBarButtonItemClick:(UIBarButtonItem *)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)finishClick{
    if (_code) {
        if (_codeBlock) {
            _codeBlock(_code);
        }
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    
    
}
//相册的照片
- (void)rightBarButtonItemClick:(UIBarButtonItem *)sender {
    [_readview stop];
    UIImagePickerController *pickerVc = [[UIImagePickerController alloc]init];
    pickerVc.delegate = self;
    pickerVc.allowsEditing = YES;
    pickerVc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:pickerVc animated:YES completion:^{
        pickerVc.delegate = self;
    }];
}
#pragma mark  -UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [_session stopRunning];
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (!image ) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    __block typeof(self) myself = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImageView *view = [[UIImageView alloc] initWithImage:image];
        view.frame = _readview.frame;
        [_readview addSubview:view];
        
        ZBarReaderController *read = [ZBarReaderController new];
        CGImageRef cgImageRef = image.CGImage;
        ZBarSymbol* symbol = nil;
        for(symbol in [read scanImage:cgImageRef]){
            _codeL.text = symbol.data ;
            _code = symbol.data;
            [myself finishClick];
            NSLog(@"    qrResult = symbol.data %@",symbol.data);
        }
    }];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
