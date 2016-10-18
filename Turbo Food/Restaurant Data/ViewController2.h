//
//  ViewController2.h
//  Turbo Food
//
//  Created by Ravi on 2/23/16.
//  Copyright (c) 2016 Ravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"
#import "NIDropDown.h"
#import "ViewController4.h"
#import <CoreData/CoreData.h>
#import "MBProgressHUD.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <CoreLocation/CoreLocation.h>



@interface ViewController2 : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,NIDropDownDelegate,CLLocationManagerDelegate>
{
    IBOutlet UIButton *btnSelect;
    NIDropDown *dropDown;
    CLLocationManager *locationManager;
    NSMutableArray *restroArry;;
   BOOL isSearching;
}

@property (nonatomic, strong) NSArray *searchResult;

@property(nonatomic,strong) NSFetchRequest *searchFetchRequest;
@property (weak, nonatomic) IBOutlet UITableView *search_autocomplete_table;

@property (weak, nonatomic) IBOutlet UIButton *fav_btn;

@property (retain, nonatomic) IBOutlet UIButton *btnSelect;
- (IBAction)selectClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *menu_view;
- (IBAction)fav_btn:(id)sender;

- (IBAction)bell_btn:(id)sender;


- (IBAction)btn_cart:(id)sender;
- (IBAction)BtnLivraison:(UIButton *)sender;
- (IBAction)btnEmporter:(UIButton *)sender;
- (IBAction)btnEspeces:(UIButton *)sender;
- (IBAction)Cartedecredit:(UIButton *)sender;
- (IBAction)btnSpecialite:(UIButton *)sender;
- (IBAction)btnAproximite:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_livraison;
@property (weak, nonatomic) IBOutlet UIButton *btn_emporter;
@property (weak, nonatomic) IBOutlet UIButton *btn_aproximate;
@property (weak, nonatomic) IBOutlet UIButton *btn_especes;
@property (weak, nonatomic) IBOutlet UIButton *btn_cartedecredit;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
- (IBAction)sidebarButton:(UIBarButtonItem *)sender;

@property (nonatomic,strong) NSMutableArray *objectHolderArray;

@property (strong, nonatomic) IBOutlet UIImageView *img_restro;
@property (strong, nonatomic) IBOutlet UILabel *lbl_restroName;






@end
