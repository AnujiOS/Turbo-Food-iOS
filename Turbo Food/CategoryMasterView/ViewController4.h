//
//  ViewController4.h
//  Turbo Food
//
//  Created by Ravi on 2/23/16.
//  Copyright (c) 2016 Ravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController5.h"



@interface ViewController4 : UIViewController <UITableViewDataSource,UITableViewDelegate>

{
    NSMutableDictionary *retrievedmy4Dic;
    NSMutableDictionary *dicc;
}
@property (strong, nonatomic) IBOutlet UIView *detailViewContainer;
- (IBAction)bell_btn:(id)sender;
- (IBAction)cart_btn:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *
tableView;
@property (weak, nonatomic) IBOutlet UILabel *restro_details;

- (IBAction)btn_home:(id)sender;


@property(strong,nonatomic)NSArray *buttons;

- (IBAction)rightScroll:(UIButton *)sender;

- (IBAction)leftScroll:(UIButton *)sender;

- (IBAction)sideMenu:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *restro_img;
@property (weak, nonatomic) IBOutlet UILabel *restro_lbl;
- (IBAction)fav_btn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *fav_btn;
@property (weak, nonatomic) IBOutlet UIImageView *open_close_img;


@property(strong,nonatomic)NSMutableArray *receiveArray;

@property(strong,nonatomic)NSMutableDictionary *receiveArray11;
@property(strong,nonatomic)NSString *flag_option;

@property(strong,nonatomic)NSString *flag;



@end
