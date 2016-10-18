//
//  RegistrationView.h
//  Turbo Food
//
//  Created by Ravi Brahmbhatt on 10/03/16.
//  Copyright © 2016 Ravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"


@interface RegistrationView : UIViewController<UIScrollViewDelegate,UITextFieldDelegate>

{
    NSMutableDictionary * dict;
    NSDictionary *retrievedDictionary;
}
@property (strong, nonatomic) IBOutlet UIView *view_outlet;

@property (strong, nonatomic) IBOutlet UITextField *txtUserName;
@property (strong, nonatomic) IBOutlet UITextField *txtUserPhone;
@property (strong, nonatomic) IBOutlet UITextField *txtUserEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtUserPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtUserConfirmPassword;
@property (strong, nonatomic) IBOutlet UIButton *btn_alreadyhaveaccount;
@property (strong, nonatomic) IBOutlet UIButton *btn_registration;
@property (strong, nonatomic) IBOutlet UIButton *facebooklogin;


- (IBAction)btn_registration:(UIButton *)sender;

- (IBAction)btn_alreadyRegister:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UIScrollView *aScrollView;
- (IBAction)btn_facebooklogin:(id)sender;
@property(strong,nonatomic)NSString *flag;


@end
