//
//  MeasureViewController.m
//  OCDemo
//
//  Created by 黄敦仁 on 2022/3/10.
//

#import "MeasureViewController.h"

@interface MeasureViewController ()<BravScaleEventDelegate,BravBleConnectionChangeDelegate>
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;

@property (weak, nonatomic) IBOutlet UILabel *connectionStateLabel;

@property (weak, nonatomic) IBOutlet UIButton *connectionBtn;

@property (nonatomic,strong) id<BravBleApi> bleApi;

@property (nonatomic,assign) BravDeviceConnectionState connectionState;

@end

@implementation MeasureViewController

//-(BravDevice*)device{
//    return _device;
//}
//-(void)setDevice:(int *)device{
//
//}

- (void)viewDidLoad{
    self.bleApi = [BravApiProvider sharedBleApi];
}

- (IBAction)onConnectionBtnClick:(id)sender {
    if(self.connectionState == BravDeviceConnectionStateDisconnected){
        BravUser* user = [[BravUser alloc] initWithGender:BravGenderMale height:180 age:30];
        BravScaleDataOptions* options = [[BravScaleDataOptions alloc] initWithUser:user unit:BravScaleUnitKg];
        [self.bleApi connectDeviceWithDeviceId:self.device.deviceId options:options listener:self connectionChangeListener:self];
    }else{
        [self.bleApi disconnectDeviceWithDeviceId:self.device.deviceId];
    }
    
}


- (void)onGetUnsteadyWeight:(NSString * _Nonnull)deviceId :(double)weight{
    
    self.weightLabel.text = [NSString stringWithFormat:@"%02f",weight];
    
}
/// 回调完整的测量数据
- (void)onMeasureComplete:(NSString * _Nonnull)deviceId :(BravScaleData * _Nonnull)scaleData{
    self.weightLabel.text = [NSString stringWithFormat:@"%02f",scaleData.weight];
    NSLog(@"测量完成：%.2f kg 体脂率：%01f",scaleData.weight,scaleData.bodyfatRate);
    
}
- (void)onGetOfflineData:(NSString * _Nonnull)deviceId :(NSArray<BravOriginData *> * _Nonnull)scaleDataList{
    NSLog(@"收到离线数据： %d",scaleDataList.count);
}

- (void)onConnectionChangeWithDeviceId:(NSString * _Nonnull)deviceId state:(enum BravDeviceConnectionState)state{
    NSLog(@"%@ 连接变化 %d",deviceId,state);
    NSString* text = state == BravDeviceConnectionStateDisconnected ? @"连接" :@"断开连接";
    [self.connectionBtn setTitle:text forState:UIControlStateNormal];
}
@end
