//
//  ViewController6.h
//  Turbo Food
//
//  Created by Ravi on 2/25/16.
//  Copyright (c) 2016 Ravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController6 : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableDictionary *dic1;
}
- (IBAction)btn_minorder:(id)sender;

- (IBAction)sidemenuButton:(id)sender;
- (IBAction)btn_aide_action:(id)sender;

- (IBAction)paymentcmd_btn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *order_fav;
- (IBAction)order_fav_btn:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btn_home;
- (IBAction)btn_home:(id)sender;
- (IBAction)bell_btn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *euro_1;
@property (weak, nonatomic) IBOutlet UILabel *euro_2;

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UILabel *restro_comission;
@property (weak, nonatomic) IBOutlet UIButton *btn_accueil;
@property (weak, nonatomic) IBOutlet UIButton *btn_aide;

@property(strong,nonatomic)NSMutableDictionary *restroArry6;
@property (weak, nonatomic) IBOutlet UILabel *TotalPrize;
@property (weak, nonatomic) IBOutlet UIButton *btn_paymentcmd;
- (IBAction)new_order_btn:(id)sender;
- (IBAction)btn_accueil:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_new_order;
- (IBAction)btn_creditcard:(id)sender;

- (IBAction)btn_recharge:(id)sender;
- (IBAction)btn_especes:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btn_recharge;
@property (weak, nonatomic) IBOutlet UIButton *btn_creditcard;
@property (weak, nonatomic) IBOutlet UIButton *btn_especes;

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
@property (weak, nonatomic) IBOutlet UIView *segment_view;
@property (weak, nonatomic) IBOutlet UIImageView *checkbox;
@property (weak, nonatomic) IBOutlet UIImageView *checkbox1;

@property(strong,nonatomic)NSString *str;
@property(strong,nonatomic)NSString *str1;
@property (weak, nonatomic) IBOutlet UIButton *aBtnCredit;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segment_controller;
- (IBAction)SegmentToggle:(UISegmentedControl *)sender;

@end
