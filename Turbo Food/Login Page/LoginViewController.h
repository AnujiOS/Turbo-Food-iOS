//
//  ViewController.h
//  Turbo Food
//
//  Created by Ravi on 2/23/16.
//  Copyright (c) 2016 Ravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegistrationView.h"
#import "Reachability.h"


@interface LoginViewController : UIViewController<UITextFieldDelegate,UIScrollViewAccessibilityDelegate,UIScrollViewDelegate>

{
    NSMutableArray *users;
    NSMutableDictionary * dict;
    NSDictionary *retrievedDictionary;

}
@property (strong, nonatomic) IBOutlet UIView *loginView;
@property (strong, nonatomic) IBOutlet UIScrollView *aScrollView;
- (IBAction)registration_btn:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *forgetPassword;
@property (weak, nonatomic) IBOutlet UIButton *connection;
@property (weak, nonatomic) IBOutlet UITextField *emailID;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIButton *fbLogin;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

- (IBAction)connection:(id)sender;
- (IBAction)btn_forgetPassword:(UIButton *)sender;
- (IBAction)sidebarButton:(UIBarButtonItem *)sender;


- (IBAction)btn_facebooklogin:(id)sender;


@end

