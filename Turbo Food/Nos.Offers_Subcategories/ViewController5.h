//
//  ViewController5.h
//  Turbo Food
//
//  Created by Ravi on 2/23/16.
//  Copyright (c) 2016 Ravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController4.h"
#import "MenuSelectionViewController.h"

@interface ViewController5 : UIViewController<UITableViewDelegate,UITableViewDataSource>
- (IBAction)bell_btn:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *viewcontianer;
@property (weak, nonatomic) IBOutlet UIButton *fav_btn;

@property (strong, nonatomic) IBOutlet UITableView *tableOffers;

@property (weak, nonatomic) IBOutlet UILabel *restro_deatils;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btn_home;
- (IBAction)btn_home:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *offerchoice_view;
- (IBAction)btn_fav:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_aide;
@property(strong,nonatomic)NSString *flag_menu;
@property(strong,nonatomic)NSString *flag_option;
- (IBAction)sidemenuButton:(id)sender;
- (IBAction)aide_btn_action:(id)sender;

@property (weak, nonatomic) NSString *cat_name;
@property (weak, nonatomic) IBOutlet UILabel *cat_lable;
@property (weak, nonatomic) IBOutlet UIButton *cart_red_btn;

//Choice Menu properties

@property (strong, nonatomic) IBOutlet UIView *choixMenu;
- (IBAction)fav_btn:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *menuShowButton;

@property(strong,nonatomic)NSMutableArray *array;

@property (weak, nonatomic) IBOutlet UIImageView *restro_img;
@property (weak, nonatomic) IBOutlet UILabel *restro_lbl;
@property (weak, nonatomic) IBOutlet UIButton *Back_btn;
- (IBAction)back_btn:(id)sender;

@property(strong,nonatomic)NSMutableDictionary *receiveArray111;
//- (IBAction)menuShow:(UIButton *)sender;
//- (IBAction)menuSelectionMade:(UIButton *)sender;
@property(strong,nonatomic)NSString *strre_id;
@property(strong,nonatomic)NSString *strca_id;
- (IBAction)OK_btn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_accueil;
- (IBAction)btn_accueil:(id)sender;
- (IBAction)back_menu_btn:(id)sender;
- (IBAction)cart_btn:(id)sender;

@end
