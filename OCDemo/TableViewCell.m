//
//  TableViewCell.m
//  QNDeviceSDKDemo
//
//  Created by Yolanda on 2018/5/11.
//  Copyright © 2018年 Yolanda. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *rssiLabel;
@property (weak, nonatomic) IBOutlet UILabel *internalModelLabel;
@property (weak, nonatomic) IBOutlet UILabel *macLabel;

@end

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)setDevice:(BravDevice*)device {
    _device = device;

    self.nameLabel.text = device.profileId;
    self.statusLabel.text = @"开";
    self.rssiLabel.text = [NSString stringWithFormat:@"%d",device.rssi];
    self.internalModelLabel.text = device.modelId;
    self.macLabel.text = device.mac;
}

@end
