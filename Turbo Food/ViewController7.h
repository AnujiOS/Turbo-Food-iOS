//
//  ViewController7.h
//  Turbo Food
//
//  Created by Ravi on 2/25/16.
//  Copyright (c) 2016 Ravi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController7 : UIViewController
- (IBAction)btnSelect:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSelect;
- (IBAction)menu_btn:(id)sender;
- (IBAction)order_immediate:(id)sender;
- (IBAction)order_diifer:(id)sender;
- (IBAction)OK_differcommand:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *differ_command;
@property (weak, nonatomic) IBOutlet UIButton *preparation_immediate;
- (IBAction)btn_home:(id)sender;

- (IBAction)bell_btn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *valider;
@property (weak, nonatomic) IBOutlet UIView *menu_hour;
@property (weak, nonatomic) IBOutlet UILabel *adujourd;
- (IBAction)cart_btn:(id)sender;

@property(strong,nonatomic)NSString *strre_id;
@property(strong,nonatomic)NSString *strca_id;
@property(strong,nonatomic)NSString *u_id;
@property(strong,nonatomic)NSString *r_id;
@property(strong,nonatomic)NSString *c_id;
@property(strong,nonatomic)NSString *m_id;
@property(strong,nonatomic)NSString *m_qty;
@property(strong,nonatomic)NSString *cpot_id;
@property(strong,nonatomic)NSString *opt_id;
@property(strong,nonatomic)NSString *opt_qty;
@property(strong,nonatomic)NSString *g_total;




@end
