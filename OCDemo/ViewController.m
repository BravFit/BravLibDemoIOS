//
//  ViewController.m
//  OCDemo
//
//  Created by 黄敦仁 on 2022/3/9.
//

#import "ViewController.h"
#import <BravLib/BravLib-Swift.h>
#import "TableViewCell.h"
#define ScanCellIdentifier @"scanCellIdentifier"

#import "MeasureViewController.h"


@interface ViewController ()<BravBleEventDelegate,UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *scanBtn;

@property (weak, nonatomic) IBOutlet UILabel *bleStateLabel;

@property (weak, nonatomic) IBOutlet UITableView *deviceListTable;

@property (nonatomic,strong) id<BravBleApi> bleApi;
@property (nonatomic,assign) BOOL isScanning;

@property (nonatomic,strong) NSMutableArray<BravDevice*>* deviceList;

@property (nonatomic,strong) BravDevice* targetDevice;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.deviceList =  [[NSMutableArray alloc] init];
    
    [self.deviceListTable registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:ScanCellIdentifier];
    self.deviceListTable.dataSource = self;
    self.deviceListTable.delegate = self;
    
    
    self.bleApi = [BravApiProvider sharedBleApi];
    self.bleApi.bleEventDelegate = self;

    
    [self setupBleStateLabel];
    

}

- (IBAction)onScanBtnClick:(id)sender {
    if(self.isScanning){
        [self.bleApi stopScan];
        
        self.isScanning = false;
        [self.scanBtn setTitle:@"开始扫描" forState:UIControlStateNormal];
    }else{
        BravResult* result = [self.bleApi startScanWithOptions:nil];
        
        if(result.isSuccess){
            self.isScanning = true;
            [self.scanBtn setTitle:@"停止扫描" forState:UIControlStateNormal];
            self.scanBtn.titleLabel.text = @"停止扫描";
        }
    }
}


-(void) setupBleStateLabel{
    switch (self.bleApi.bleEnableState) {
        case BleEnableStateEnable:
            self.bleStateLabel.text = @"可用";
            break;
        case BleEnableStateUnknown:
            self.bleStateLabel.text = @"位置";
            break;
        case BleEnableStateUnauthorized:
            self.bleStateLabel.text = @"未授权";
            break;
        case BleEnableStateDisable:
            self.bleStateLabel.text = @"未不可用";
            break;
        default:
            break;
    }
}


#pragma mark BravBleEventListener
- (void)onBleEnableStateChangeWithState:(enum BleEnableState)state{
    [self setupBleStateLabel];
}
/// 出现新的Brav蓝牙设备
- (void)onBravDeviceFoundWithDevice:(BravDevice * _Nonnull)device{
    NSLog(@"扫描到设备：%@",device.mac);
    NSInteger index = [self.deviceList indexOfObjectPassingTest:^BOOL(BravDevice * itemDevice, NSUInteger idx, BOOL *stop) {
        if([device.deviceId isEqual:itemDevice.deviceId]) return YES;
        else return NO;
    }];
    
    if(index == NSNotFound){
        NSLog(@"添加设备：%@",device.mac);
        [self.deviceList addObject:device];
    }else{
        NSLog(@"跟新设备：%d %@",index, device.mac);
        self.deviceList[index] = device;
    }
    [self.deviceListTable reloadData];
    
}

- (void)onConnectionChangeWithDeviceId:(NSString * _Nonnull)deviceId state:(enum BravDeviceConnectionState)state{
    
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.deviceList.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ScanCellIdentifier];

    cell.device = self.deviceList[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    self.navigationController.
    BravDevice* device = self.deviceList[indexPath.row];
    
    self.targetDevice = device;
    
//    self.storyboard.per
    [self performSegueWithIdentifier:@"toMeausreVC" sender:nil];
    
}

- (IBSegueAction ViewController *)onNavigateToMeasure:(NSCoder *)coder {
    MeasureViewController * vc =  [[MeasureViewController alloc] initWithCoder:coder];
    
    vc.device = self.targetDevice;
    
    return vc;
}


@end
