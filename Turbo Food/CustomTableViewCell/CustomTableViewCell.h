//
//  CustomTableViewCell.h
//  Turbo Food
//
//  Created by Ravi on 2/23/16.
//  Copyright (c) 2016 Ravi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
{
    
}
@property (strong, nonatomic) IBOutlet UIImageView *restorantImage;


@property (weak, nonatomic) IBOutlet UILabel *Restorant;

@property (strong, nonatomic) IBOutlet UILabel *lbl_restrotime;

@property (strong, nonatomic) IBOutlet UILabel *lbl_paymentoption;
    
@property (strong, nonatomic) IBOutlet UILabel *lbl_minimumAmount;

@property (strong, nonatomic) IBOutlet UIImageView *img_restrostatus;
- (IBAction)btn_favr:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btn_favr;


@end
