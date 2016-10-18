//
//  AIDEViewController.h
//  Turbo Food
//
//  Created by mac on 7/6/16.
//  Copyright © 2016 Ravi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AIDEViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *web_View;
- (IBAction)menu_btn:(id)sender;
- (IBAction)home_btn:(id)sender;
- (IBAction)notification_btn:(id)sender;

- (IBAction)cart_btn:(id)sender;

@end
