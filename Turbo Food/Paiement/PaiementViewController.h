//
//  PaiementViewController.h
//  Turbo Food
//
//  Created by ganesh on 3/23/16.
//  Copyright © 2016 Ravi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaiementViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

{
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableview;
- (IBAction)btn_home:(id)sender;
- (IBAction)btn_exit:(id)sender;
- (IBAction)menu_btn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_cart;
- (IBAction)btn_cart:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menu_btn;
- (IBAction)btn_recharge:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textfield_rech;
@property (weak, nonatomic) IBOutlet UILabel *credit_rech;
@property (weak, nonatomic) IBOutlet UIWebView *webview;
- (IBAction)close_btn_webview:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *close_btn_webview;
@property (weak, nonatomic) IBOutlet UIButton *btn_recharge;
- (IBAction)cart_btn:(id)sender;
- (IBAction)bell_btn:(id)sender;

@end
