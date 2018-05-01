//
//  PIHomeNaviDriveController.m
//  Parking
//
//  Created by apple on 2018/4/29.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIHomeNaviDriveController.h"
#import <AMapNaviKit/AMapNaviKit.h>
#import <iflyMSC/iflyMSC.h>
#import <AVFoundation/AVFoundation.h>

@interface PIHomeNaviDriveController ()<AMapNaviDriveViewDelegate, AMapNaviDriveManagerDelegate, MAMapViewDelegate, IFlySpeechSynthesizerDelegate>

///-- 导航视图
@property (nonatomic, strong) AMapNaviDriveView *driveView;
///-- <#Notes#>
@property (nonatomic, weak) MAMapView *mapView;

/* 用于显示当前路线方案. */
@property (nonatomic) AMapNaviRoute * naviRoute;
///-- <#Notes#>
@property (nonatomic, strong) IFlySpeechSynthesizer *iFlySpeechSynthesizer;
@end

@implementation PIHomeNaviDriveController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDriveView];
  //  [self setupIFlySpeechSynthesizer];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)setupDriveView {
    
//    PIMapManager *mapManager = [PIMapManager sharedManager];
//    
//    mapManager.mapController = self;
//    [mapManager initMapView];
//    mapManager.mapView.delegate = self;
//    self.mapView = mapManager.mapView;
    
    if (self.driveView == nil) {
        
        self.driveView = [[AMapNaviDriveView alloc] initWithFrame:self.view.bounds];
        self.driveView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.driveView setDelegate:self];
        
        [self.view addSubview:self.driveView];
    }
    
    [[AMapNaviDriveManager sharedInstance] setDelegate:self];
    [[AMapNaviDriveManager sharedInstance] setIsUseInternalTTS:YES];
    [[AMapNaviDriveManager sharedInstance] addDataRepresentative:self.driveView];
    
    AMapNaviPoint *startPoint = [AMapNaviPoint locationWithLatitude:self.startCoor.latitude longitude:self.startCoor.longitude];
    AMapNaviPoint *endPoint = [AMapNaviPoint locationWithLatitude:self.destinationCoor.latitude longitude:self.destinationCoor.longitude];
    
    [[AMapNaviDriveManager sharedInstance] calculateDriveRouteWithStartPoints:@[startPoint] endPoints:@[endPoint] wayPoints:nil drivingStrategy:10];
}

- (void)setupIFlySpeechSynthesizer {
    
    _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
    _iFlySpeechSynthesizer.delegate = self;
    //-- 设置在线工作方式
    [_iFlySpeechSynthesizer setParameter:[IFlySpeechConstant TYPE_CLOUD] forKey:[IFlySpeechConstant ENGINE_TYPE]];
    //-- 获取系统音量
//    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
//    CGFloat currentVol = audioSession.outputVolume;
//    NSString *volString = [NSString stringWithFormat:@"%lf", currentVol];
    //-- 设置音量
    [_iFlySpeechSynthesizer setParameter:@"50" forKey:[IFlySpeechConstant VOLUME]];
    //-- 设置发音人
    [_iFlySpeechSynthesizer setParameter:@"xiaoyan" forKey:[IFlySpeechConstant VOICE_NAME]];
    [_iFlySpeechSynthesizer setParameter:nil forKey:[IFlySpeechConstant TTS_AUDIO_PATH]];
    
}
/**路径规划*/

/**路径会话成功--开始导航*/
- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager {
    
    [[AMapNaviDriveManager sharedInstance] startGPSNavi];
    
   // NSLog(@"%@", self.naviRoute.routeCoordinates);
    
//
//    CLLocationCoordinate2D commonPolyArr[self.naviRoute.routeCoordinates.count];
//
//    for (NSInteger i = 0; i < self.naviRoute.routeCoordinates.count; i++) {
//
//        AMapNaviPoint *point = self.naviRoute.routeCoordinates[i];
//
//        commonPolyArr[i].latitude = point.latitude;
//        commonPolyArr[i].longitude = point.longitude;
//
//    }
//
//    MAPolyline *commonPloyline = [MAPolyline polylineWithCoordinates:commonPolyArr count:self.naviRoute.routeCoordinates.count];
//
//    [self.mapView addOverlay:commonPloyline];
    
   
}

/**是否进行语音导航*/
- (BOOL)driveManagerIsNaviSoundPlaying:(AMapNaviDriveManager *)driveManager {
    
    return [_iFlySpeechSynthesizer isSpeaking];
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType {
    
    [_iFlySpeechSynthesizer startSpeaking:soundString];
}

- (void)driveViewCloseButtonClicked:(AMapNaviDriveView *)driveView {
    
    [self.navigationController popViewControllerAnimated:YES];
}
/**设置折线颜色*/
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay {
    
    if ([overlay isKindOfClass:[MAPolyline class]]) {
        
        MAPolyline *line = (MAPolyline *)overlay;
        
        MAPolylineRenderer *polylineRender = [[MAPolylineRenderer alloc] initWithPolyline:line];
        
        polylineRender.lineWidth = 8.0f;
        polylineRender.strokeColor = PIMainColor;
        polylineRender.lineJoinType = kMALineJoinRound;
        polylineRender.lineCapType = kMALineCapRound;
        
        return polylineRender;
    }
    
    return nil;
}
/**地图根据折线自适应*/

- (MAMapRect)mapRectForOverlays:(NSArray *)overlays
{
    if (overlays.count == 0)
    {
        NSLog(@"%s: 无效的参数.", __func__);
        return MAMapRectZero;
    }
    
    MAMapRect mapRect;
    
    MAMapRect *buffer = (MAMapRect*)malloc(overlays.count * sizeof(MAMapRect));
    
    [overlays enumerateObjectsUsingBlock:^(id<MAOverlay> obj, NSUInteger idx, BOOL *stop) {
        buffer[idx] = [obj boundingMapRect];
    }];
    
    mapRect = [self mapRectUnion:buffer count:overlays.count];
    
    free(buffer), buffer = NULL;
    
    return mapRect;
}

- (MAMapRect)mapRectUnion:(MAMapRect *)mapRects count:(NSUInteger)count
{
    if (mapRects == NULL || count == 0)
    {
        NSLog(@"%s: 无效的参数.", __func__);
        return MAMapRectZero;
    }
    
    MAMapRect unionMapRect = mapRects[0];
    
    for (int i = 1; i < count; i++)
    {
        unionMapRect = [self unionMapRect1:unionMapRect mapRect2:mapRects[i]];
    }
    
    return unionMapRect;
}

- (MAMapRect)unionMapRect1:(MAMapRect)mapRect1 mapRect2:(MAMapRect)mapRect2
{
    CGRect rect1 = CGRectMake(mapRect1.origin.x, mapRect1.origin.y, mapRect1.size.width, mapRect1.size.height);
    CGRect rect2 = CGRectMake(mapRect2.origin.x, mapRect2.origin.y, mapRect2.size.width, mapRect2.size.height);
    
    CGRect unionRect = CGRectUnion(rect1, rect2);
    
    return MAMapRectMake(unionRect.origin.x, unionRect.origin.y, unionRect.size.width, unionRect.size.height);
}


/**退出界面销毁导航*/
- (void)dealloc {
    
    [[AMapNaviDriveManager sharedInstance] stopNavi];
    [[AMapNaviDriveManager sharedInstance] removeDataRepresentative:self.driveView];
    [[AMapNaviDriveManager sharedInstance] setDelegate:nil];
    
    BOOL success = [AMapNaviDriveManager destroyInstance];
    
    NSLog(@"%d", success);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
