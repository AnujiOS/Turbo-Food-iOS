//
//  MenuSelectionViewController.h
//  Turbo Food
//
//  Created by ganesh on 3/18/16.
//  Copyright © 2016 Ravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuSelectionTableViewCell.h"


@interface MenuSelectionViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>{//VPPDropDownDelegate,
@private
//    VPPDropDown *_dropDownSelection;
//    VPPDropDown *_dropDownDisclosure;
//    VPPDropDown *_dropDownCustom;
//    
//    NSIndexPath *_ipToDeselect;
 IBOutlet UILabel *lblTotalPrise;
 
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *restro_lbl;
@property (weak, nonatomic) IBOutlet UIImageView *restro_img;
@property (weak, nonatomic) IBOutlet UIButton *fav_btn;
- (IBAction)min_conti:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *cat_lable;
@property(strong,nonatomic)NSString *cat_name;
@property (weak, nonatomic) IBOutlet UILabel *restro_details;
- (IBAction)plus_conti:(id)sender;
- (IBAction)sideMenu_button:(id)sender;
- (IBAction)btn_home:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *euro;
@property (weak, nonatomic) IBOutlet UILabel *menu_price_org;
@property (weak, nonatomic) IBOutlet UILabel *euro_sym;
- (IBAction)cart_btn:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *menu_image;
@property (weak, nonatomic) IBOutlet UILabel *menu_lbl;
@property (weak, nonatomic) IBOutlet UILabel *menudetails_lbl;
@property (weak, nonatomic) IBOutlet UITextField *_contity;
@property (weak, nonatomic) IBOutlet UIButton *plus_btn;
- (IBAction)Back_bttn:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *min_btn;
@property (weak, nonatomic) IBOutlet UIButton *btn_select;
- (IBAction)btn_select:(id)sender;
- (IBAction)plus_btn:(id)sender;
- (IBAction)min_btn:(id)sender;
- (IBAction)ok_btn:(id)sender;
- (IBAction)menu_payment:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *chioce_view;
@property (weak, nonatomic) IBOutlet UILabel *order_contity_lbl;

@property(strong,nonatomic)NSString *strre_id;
@property(strong,nonatomic)NSString *strca_id;
@property(strong,nonatomic)NSString *copt_id;

@property (strong,nonatomic)NSMutableDictionary *restroArry;
@property (weak, nonatomic) IBOutlet UILabel *menu_Price;
@property (weak, nonatomic) IBOutlet UIButton *menu_fav;
- (IBAction)menu_fav:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *payment_menu_btn;

@property(strong,nonatomic)NSMutableDictionary *receiveArray111;
@property (nonatomic) int i;
@property (nonatomic) int j;
@property(nonatomic)int m;
@property(nonatomic)int qty;
@property(strong,nonatomic)NSString *option_id;
@property(strong,nonatomic)NSString *option_price;

@property(strong,nonatomic)NSString *flag_menu;
@property(strong,nonatomic)NSString *flag_option;
@property (weak, nonatomic) IBOutlet UILabel *option_cat_name;
- (IBAction)btn_precedent:(id)sender;
- (IBAction)btn_suivant:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *ok_btn;
- (IBAction)btn_fav_restro:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *price_textfield;

- (IBAction)bell_btn:(id)sender;

- (IBAction)aCloseBtn:(id)sender;
- (IBAction)aBtnValidate:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *aBtnValidate;
@property (weak, nonatomic) IBOutlet UILabel *total_qty_prize;

@property (weak, nonatomic) IBOutlet UILabel *lab_euro;
@property (weak, nonatomic) IBOutlet UILabel *menu_name;
- (IBAction)btnAddandMinus:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *total_prize_sym;


- (IBAction)btnSelectSectionHeader:(UIButton *)sender;




@end
