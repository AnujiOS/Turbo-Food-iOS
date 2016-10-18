//
//  NotificationTableViewCell.h
//  Turbo Food
//
//  Created by ganesh on 4/15/16.
//  Copyright © 2016 Ravi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *restro_name;
@property (weak, nonatomic) IBOutlet UILabel *order_date;
@property (weak, nonatomic) IBOutlet UILabel *order_btn;
@property (weak, nonatomic) IBOutlet UILabel *order_num;
@property (weak, nonatomic) IBOutlet UILabel *pay_type;
@property (weak, nonatomic) IBOutlet UILabel *order_price;
@property (weak, nonatomic) IBOutlet UILabel *order_time;

@end
