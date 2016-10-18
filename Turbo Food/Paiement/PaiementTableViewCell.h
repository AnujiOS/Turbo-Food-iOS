//
//  PaiementTableViewCell.h
//  Turbo Food
//
//  Created by ganesh on 3/31/16.
//  Copyright © 2016 Ravi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaiementTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *history_date;
@property (weak, nonatomic) IBOutlet UILabel *order_name;
@property (weak, nonatomic) IBOutlet UILabel *payment_type;
@property (weak, nonatomic) IBOutlet UILabel *price;

@end
