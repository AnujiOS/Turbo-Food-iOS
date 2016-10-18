//
//  SlideMenuViewController.h
//  Turbo Food
//
//  Created by Ravi on 2/24/16.
//  Copyright (c) 2016 Ravi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideMenuViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *logoutButton;
- (IBAction)btn_logout:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *profile_image;
- (IBAction)paiement_id:(id)sender;

- (IBAction)favoris_id:(id)sender;

- (IBAction)mess_id:(id)sender;
- (IBAction)profile:(id)sender;
- (IBAction)mescommand:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *user_name;

@end
