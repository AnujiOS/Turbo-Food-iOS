//
//  ProfileViewController.h
//  Turbo Food
//
//  Created by ganesh on 5/3/16.
//  Copyright © 2016 Ravi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController<UINavigationControllerDelegate,
UIImagePickerControllerDelegate,UITextFieldDelegate,UIScrollViewDelegate>
- (IBAction)menu_bar:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *profile_pic;
@property (weak, nonatomic) IBOutlet UIImageView *profile_pic_bg;
@property (weak, nonatomic) IBOutlet UITextField *txtfd_name;
@property (weak, nonatomic) IBOutlet UITextField *txtfd_email;
@property (weak, nonatomic) IBOutlet UITextField *txtfd_ph;
@property (weak, nonatomic) IBOutlet UITextField *txtfd_city;
@property (weak, nonatomic) IBOutlet UIButton *edit_save;

- (IBAction)edit_save_action:(id)sender;
- (IBAction)home_action:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lbl_ph_nm;
@property (weak, nonatomic) IBOutlet UILabel *lbl_city;
- (IBAction)image_picker:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *image_pick;

- (IBAction)cart_btn:(id)sender;
- (IBAction)bell_btn:(id)sender;

@end
