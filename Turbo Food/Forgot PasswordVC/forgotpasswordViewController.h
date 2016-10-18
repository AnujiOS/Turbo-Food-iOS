//
//  forgotpasswordViewController.h
//  Turbo Food
//
//  Created by mac on 6/18/16.
//  Copyright © 2016 Ravi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface forgotpasswordViewController : UIViewController
- (IBAction)forget_passwd:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *forget_emailId;

- (IBAction)back_btn:(id)sender;

@end
