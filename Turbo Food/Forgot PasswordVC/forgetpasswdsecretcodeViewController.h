//
//  forgetpasswdsecretcodeViewController.h
//  Turbo Food
//
//  Created by mac on 6/18/16.
//  Copyright © 2016 Ravi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface forgetpasswdsecretcodeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *secret_code;
@property (weak, nonatomic) IBOutlet UITextField *user_new_passwd;

@property (weak, nonatomic) IBOutlet UITextField *user_confirm_new_passwd;
- (IBAction)confirm:(id)sender;

- (IBAction)back_btn:(id)sender;

@end
