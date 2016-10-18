//
//  ProfileViewController.m
//  Turbo Food
//
//  Created by ganesh on 5/3/16.
//  Copyright © 2016 Ravi. All rights reserved.
//

#import "ProfileViewController.h"
#import "ViewController2.h"
#import "WebServiceViewController.h"
#import "UIImageView+WebCache.h"
#import "SlideMenuViewController.h"
#import "MBProgressHUD.h"
#import "MFSideMenu.h"
#import "ViewController6.h"
#import "NotificationViewController.h"


#define POST_BODY_BOURDARY  @"boundary"
#define kOFFSET_FOR_KEYBOARD 165.0

@interface ProfileViewController ()<NSURLSessionDelegate,UIActionSheetDelegate>
{
    UIImagePickerController *imagePickerController;
    NSString *email_id;
    NSString *fb_name;
    NSString *fb_pic;
    
    UIImage *picimage;
    NSURLSession *urlSession;
    NSMutableData *receiveData;
    
    NSString *user_name;
    NSString *user_email;
    NSString *mobile;
    NSString *city;
    NSString *user_id;
    BOOL first;
    NSString *user_id0;
    NSString *cart_nmuber;
    NSString *u_id;
}
@end

@implementation ProfileViewController
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ( [gestureRecognizer isMemberOfClass:[UITapGestureRecognizer class]] ) {
        // Return NO for views that don't support Taps
        return NO;
    } else if ( [gestureRecognizer isMemberOfClass:[UISwipeGestureRecognizer class]] ) {
        // Return NO for views that don't support Swipes
        return NO;
    }
    
    
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.txtfd_name setReturnKeyType:UIReturnKeyNext];
    [self.txtfd_email setReturnKeyType:UIReturnKeyNext];
    [self.txtfd_ph setReturnKeyType:UIReturnKeyNext];
    [self.txtfd_city setReturnKeyType:UIReturnKeyDone];
   
    [self.txtfd_name addTarget:self action:@selector(userNameFinished:) forControlEvents:UIControlEventEditingDidEndOnExit ];
    [self.txtfd_email addTarget:self action:@selector(userMailFinished:) forControlEvents:UIControlEventEditingDidEndOnExit ];
    [self.txtfd_ph addTarget:self action:@selector(phoneFinished:) forControlEvents:UIControlEventEditingDidEndOnExit ];
    [self.txtfd_city addTarget:self action:@selector(cityFinished:) forControlEvents:UIControlEventEditingDidEndOnExit ];
    //Keyboard stuff
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapRecognizer];

    // Do any additional setup after loading the view.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [self user_payment_histroy];
            
        });
    });
    
    user_id = [[NSUserDefaults standardUserDefaults]stringForKey:@"u_id"];
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"SocialFBClicked"])
    {
        NSString *email_id =[[NSUserDefaults standardUserDefaults]stringForKey:@"email_id"];
        
        NSString *fb_name =[[NSUserDefaults standardUserDefaults]stringForKey:@"fb_name"];
        
        NSString *fb_pic =[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=9999",[[NSUserDefaults standardUserDefaults]stringForKey:@"fb_id"]];
        
        //NSString * newString = [fb_pic stringByReplacingOccurrencesOfString:@"t1.0-1" withString:@"t1.0-9"];
        
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:fb_pic]];
        self.profile_pic.image = [UIImage imageWithData:imageData];
        //self.profile_pic_bg.image = [UIImage imageWithData:imageData];
        
        self.txtfd_email.text = [NSString stringWithFormat:@"%@",email_id];
        self.txtfd_name.text = [NSString stringWithFormat:@"%@",fb_name];
        self.txtfd_ph.hidden = YES;
        self.edit_save.hidden = YES;
        self.txtfd_city.hidden = YES;
        self.lbl_city.hidden = YES;
        self.lbl_ph_nm.hidden = YES;
        self.txtfd_name.enabled = NO;
        self.txtfd_email.enabled =NO;
        [self.edit_save setTitle:@"EDITER" forState:UIControlStateNormal];
        
            self.profile_pic.layer.cornerRadius = self.profile_pic.frame.size.width / 2;
            self.profile_pic.clipsToBounds = YES;
            self.profile_pic.layer.borderWidth = 1.0f;
            self.profile_pic.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    else
    {
        self.txtfd_ph.hidden = NO;
        self.edit_save.hidden = NO;
        self.txtfd_city.hidden = NO;
        self.lbl_city.hidden = NO;
        self.lbl_ph_nm.hidden = NO;

        self.txtfd_ph.enabled = NO;
        self.txtfd_email.enabled = NO;
        self.txtfd_city.enabled = NO;
        self.txtfd_name.enabled = NO;
      
        
        [self.edit_save setTitle:@"Edit" forState:UIControlStateNormal];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *getImagePath = [documentsDirectory stringByAppendingPathComponent:@"image.png"];
        UIImage *image1 = [UIImage imageWithContentsOfFile:getImagePath];
        self.profile_pic.layer.cornerRadius = self.profile_pic.frame.size.width / 2;
        self.profile_pic.clipsToBounds = YES;
        self.profile_pic.layer.borderWidth = 1.0f;
        self.profile_pic.layer.borderColor = [UIColor whiteColor].CGColor;
        if (image1!=nil) {
            self.profile_pic.contentMode=UIViewContentModeScaleAspectFill;
            [self.profile_pic setClipsToBounds:YES];
            [self.profile_pic.layer setMasksToBounds:YES];
            self.profile_pic.layer.borderWidth=2.0;
            [self.profile_pic.layer setCornerRadius:self.profile_pic.frame.size.width/2];
            [self.profile_pic.layer setCornerRadius:self.profile_pic.frame.size.width/2];
            self.profile_pic.layer.borderColor=[UIColor whiteColor].CGColor;
            //[self.profile_pic setImage:image1 forState:(UIControlStateNormal)];
            [self.profile_pic setImage:image1];
            //[self.profile_pic_bg setImage:image1];
        }
        else
        {
            
        }


    }
//    self.profile_pic.layer.cornerRadius = self.profile_pic.frame.size.width / 2;
//    self.profile_pic.clipsToBounds = YES;
//    self.profile_pic.layer.borderWidth = 1.0f;
//    self.profile_pic.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}
-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y > 0)
    {
        [self setViewMovedUp:YES];
        [self.view endEditing:YES];
    }
    
}
-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


-(BOOL)userNameFinished:(id)sender
{
    [self.txtfd_name resignFirstResponder];
    [self.txtfd_email becomeFirstResponder];
    return YES;
}
-(BOOL)userMailFinished:(id)sender
{
    [self.txtfd_email resignFirstResponder];
    [self.txtfd_ph becomeFirstResponder];
    return YES;
}
-(BOOL)phoneFinished:(id)sender
{
    [self.txtfd_ph resignFirstResponder];
    [self.txtfd_city becomeFirstResponder];
    return YES;
}
-(BOOL)cityFinished:(id)sender
{
    [self edit_save_action:sender];
    return NO;
}
- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)menu_bar:(id)sender {
    
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
    
    
}
- (IBAction)edit_save_action:(id)sender {
//    if([sender isSelected ]){
//        user_name = [NSString stringWithFormat:@"%@",self.txtfd_name.text];
//        user_email = [NSString stringWithFormat:@"%@",self.txtfd_email.text];
//        mobile = [NSString stringWithFormat:@"%@",self.txtfd_ph.text];
//        city = [NSString stringWithFormat:@"%@",self.txtfd_city.text];
//        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//       [self SenduserRegistrationData];
//        [self.edit_save setTitle:@"Edit" forState:UIControlStateNormal];
//        self.txtfd_ph.enabled = NO;
//        self.txtfd_email.enabled = NO;
//        self.txtfd_city.enabled = NO;
//        self.txtfd_name.enabled = NO;
//        self.image_pick.enabled = YES;
//        [sender setSelected:NO];
//    }
//    else{
//        [self.edit_save setTitle:@"Save" forState:UIControlStateNormal];
//        self.txtfd_ph.enabled = YES;
//        self.txtfd_email.enabled = YES;
//        self.txtfd_city.enabled = YES;
//        self.txtfd_name.enabled = YES;
//        self.image_pick.enabled = YES;
//        [sender setSelected:YES];
//        
//
//    }
    if(first == YES){
        [self.edit_save setTitle:@"ENREGISTRER" forState:UIControlStateNormal];
        self.txtfd_ph.enabled = YES;
        self.txtfd_email.enabled = YES;
        self.txtfd_city.enabled = YES;
        self.txtfd_name.enabled = YES;
        self.image_pick.enabled = YES;
        first = NO;
    }
    else
    {
        first = YES;
        user_name = [NSString stringWithFormat:@"%@",self.txtfd_name.text];
        user_email = [NSString stringWithFormat:@"%@",self.txtfd_email.text];
        mobile = [NSString stringWithFormat:@"%@",self.txtfd_ph.text];
        city = [NSString stringWithFormat:@"%@",self.txtfd_city.text];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self SenduserRegistrationData];
        [self.edit_save setTitle:@"EDITER" forState:UIControlStateNormal];
        self.txtfd_ph.enabled = NO;
        self.txtfd_email.enabled = NO;
        self.txtfd_city.enabled = NO;
        self.txtfd_name.enabled = NO;
        self.image_pick.enabled = YES;
        
        
    }
    
    }

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) { return; }
    
    switch (buttonIndex) {
        case 0:
            [self takeNewPhotoFromCamera];
            // [self performSegueWithIdentifier:@"segueCamera" sender:self];
            
            break;
        case 1:
            [self choosePhotoFromExistingImages];
            // [self performSegueWithIdentifier:@"segueCamera" sender:self];
            
            break;
            
        default:
            break;
    }
}

- (void)takeNewPhotoFromCamera
{
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        controller.allowsEditing = NO;
        controller.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType: UIImagePickerControllerSourceTypeCamera];
        controller.delegate = self;
        [self.navigationController presentViewController: controller animated: YES completion: nil];
    }
}

-(void)choosePhotoFromExistingImages
{
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        controller.allowsEditing = NO;
        controller.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType: UIImagePickerControllerSourceTypePhotoLibrary];
        controller.delegate = self;
        
        //controller.navigationItem.rightBarButtonItem.title=@"Annuler";
        
        controller.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"Annuler" style:(UIBarButtonItemStylePlain) target:self action:@selector(cancel:)];
        
        [self.navigationController presentViewController: controller animated: YES completion: nil];
    }
}
-(void)cart
{
    
    
    user_id = [[NSUserDefaults standardUserDefaults]
               stringForKey:@"u_id"];
    NSMutableDictionary *dictResultSignIn=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *dicSubmit = [[NSMutableDictionary alloc]init];
    [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood//api.php";
    
    [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
    [WebServiceViewController wsVC].strMethodName = @"count_cart";
    
    [dicSubmit setObject:user_id forKey:@"u_id"];
    
    dictResultSignIn = [[WebServiceViewController wsVC] sendRequestWithParameter:dicSubmit];
    
    if (dictResultSignIn != Nil || dictResultSignIn != NULL)
    {
        
        if ([[dictResultSignIn objectForKey:@"status"]integerValue] == 0)
        {
            NSDictionary *result =[dictResultSignIn objectForKey:@"result"];
            NSString *temp = [NSString stringWithFormat:@"%@",result];
            if ([temp isEqualToString:@"1"]) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Abandoner le paiement ?"message:@"En allant sur cette page, vous perdrez les informations du panier ..."delegate:self cancelButtonTitle:@"Annuler" otherButtonTitles:@"OK",nil];
                alert.tag = 101;
                [alert show];
            }
            else if([temp isEqualToString:@"0"]){
                ViewController2 *VC4 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController2"];
                [self.navigationController pushViewController:VC4 animated:YES];
                
                UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
                NSArray *controller = [NSArray arrayWithObject:VC4];
                navigationController.viewControllers=controller;
                [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            }
        }
        else
        {
            
        }
    }
    
}

- (IBAction)home_action:(id)sender {
    [self cart];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 101) {
        // from YES button
        if (buttonIndex == 1) {
            //  PaiementViewController *VC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"PaiementViewController"];
            // [self.navigationController pushViewController:VC2 animated:YES];
            [self restro];
        }
        else{
//            ViewController2 *vc4 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController2"];
//            [self.navigationController pushViewController:vc4 animated:YES];
        }
    }
    else if (alertView.tag == 102) {
        // from NO button
        // _segment_controller.selectedSegmentIndex = 0;
        
        
        
    }
}
-(void)restro{
    user_id0 = [[NSUserDefaults standardUserDefaults]stringForKey:@"u_id"];
    if(user_id0 != nil)
    {
        
        
        NSMutableDictionary *dictResultSignIn=[[NSMutableDictionary alloc]init];
        NSMutableDictionary *dicSubmit = [[NSMutableDictionary alloc]init];
        [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood//api.php";
        //   http://vps291033.ovh.net/turbofood//api.php?method=user_view_info&id=12
        [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
        [WebServiceViewController wsVC].strMethodName = @"user_all_cart_remove";
        
        [dicSubmit setObject:user_id0 forKey:@"u_id"];
        
        dictResultSignIn = [[WebServiceViewController wsVC] sendRequestWithParameter:dicSubmit];
        
        if (dictResultSignIn != Nil || dictResultSignIn != NULL) {
            
            if ([[dictResultSignIn objectForKey:@"status"]integerValue] == 0)
            {
                NSDictionary *resposne = [dictResultSignIn objectForKey:@"result"];
                
                NSLog(@"Resposne ::::::: %@",resposne);
                ViewController2 *VC4 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController2"];
                [self.navigationController pushViewController:VC4 animated:YES];
                
            }
        }
    }

}

- (IBAction)image_picker:(id)sender
{
////    UIImagePickerController *pickerController = [[UIImagePickerController alloc]
////                                                 init];
////    pickerController.delegate = self;
////    [self presentModalViewController:pickerController animated:YES];
//    // Lazily allocate image picker controller
//    if (!imagePickerController) {
//        imagePickerController = [[UIImagePickerController alloc] init];
//        
//        // If our device has a camera, we want to take a picture, otherwise, we just pick from
//        // photo library
//        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//        {
//            [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
//        }else
//        {
//            [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
//        }
//        
//        // image picker needs a delegate so we can respond to its messages
//        [imagePickerController setDelegate:self];
//    }
//    // Place image picker on the screen
//    [self presentModalViewController:imagePickerController animated:YES];
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"SocialFBClicked"])
    {
        
    }
    else{
    UIActionSheet *actionSheet;
    
    NSString *strCancel =@"Annuler";
    NSString *strotherTitle1 =@"Prendre une nouvelle photo";
    NSString *strotherTitle2 =@"Sélectionner dans ma galerie";
    
    actionSheet = [[UIActionSheet alloc] initWithTitle: nil
                                              delegate: self
                                     cancelButtonTitle: [strCancel uppercaseString]
                                destructiveButtonTitle: nil
                                     otherButtonTitles: [strotherTitle1 uppercaseString],[strotherTitle2 uppercaseString], nil];
    
    [actionSheet showInView:self.view];
    }
}
#pragma mark -
#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
//    self.profile_pic.image = image;
//    self.profile_pic_bg.image = image;
//    [self dismissModalViewControllerAnimated:YES];
    
    //Do this first!!
    
    //UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
   //
   // image = [ imageWithImage:image scaledToSize:CGSizeMake(480, 640)];
    
    
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"image.png"]; //Add the file name
    [imageData writeToFile:filePath atomically:NO]; //Write the file
    
    [[NSUserDefaults standardUserDefaults] setObject:filePath forKey:@"UserProfilePicPath"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.profile_pic.contentMode=UIViewContentModeScaleAspectFill;
    [self.profile_pic setClipsToBounds:YES];
    [self.profile_pic.layer setMasksToBounds:YES];
    self.profile_pic.layer.borderWidth=2.0;
    [self.profile_pic.layer setCornerRadius:self.profile_pic.frame.size.width/2];
    [self.profile_pic.layer setCornerRadius:self.profile_pic.frame.size.width/2];
    self.profile_pic.layer.borderColor=[UIColor whiteColor].CGColor;
    
    //[btnProfilePic setImage:image forState:UIControlStateNormal];
    //image = [self imageWithImage:image scaledToSize:CGSizeMake(500,500)];
    //[aBtnProfilePic setImage:image forState:(UIControlStateNormal)];
    
    [self.profile_pic setImage:image];
    picimage=image;
    //[self.profile_pic_bg setImage:image];
    
     [self dismissModalViewControllerAnimated:YES];
     [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"LoginClicked"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self savelivresCatimages];
    
}

-(void)user_payment_histroy
{
    //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    user_id = [[NSUserDefaults standardUserDefaults]stringForKey:@"u_id"];

    
    NSMutableDictionary *dictResultSignIn=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *dicSubmit = [[NSMutableDictionary alloc]init];
    [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood//api.php";
   //   http://vps291033.ovh.net/turbofood//api.php?method=user_view_info&id=12
    [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
    [WebServiceViewController wsVC].strMethodName = @"user_view_info";
    
    [dicSubmit setObject:user_id forKey:@"id"];
    
     dictResultSignIn = [[WebServiceViewController wsVC] sendRequestWithParameter:dicSubmit];
    
    if (dictResultSignIn != Nil || dictResultSignIn != NULL) {
        
        if ([[dictResultSignIn objectForKey:@"status"]integerValue] == 0)
        {
            NSDictionary *resposne = [dictResultSignIn objectForKey:@"result"];
            
            NSLog(@"Resposne ::::::: %@",resposne);
            [[NSUserDefaults standardUserDefaults]setObject:[resposne valueForKey:@"name"] forKey:@"name"];
            [[NSUserDefaults standardUserDefaults] synchronize];

            
            user_name = [NSString stringWithFormat:@"%@",[resposne valueForKey:@"name"]];
            mobile = [NSString stringWithFormat:@"%@",[resposne valueForKey:@"mobile"]];
            city = [NSString stringWithFormat:@"%@",[resposne valueForKey:@"city"]];
            email_id = [NSString stringWithFormat:@"%@",[resposne valueForKey:@"email"]];
            [self.profile_pic sd_setImageWithURL:[NSURL URLWithString:[resposne valueForKey:@"image"]] placeholderImage:[ UIImage imageNamed:@"no_img-2.png"]];
            
            [[NSUserDefaults standardUserDefaults]setObject:user_name forKey:@"u_name"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            if (user_name == nil) {
                self.txtfd_name.text = @" ";
                
            }
            else{
                self.txtfd_name.text = [NSString stringWithFormat:@"%@",user_name];
            }
            if (mobile == nil) {
                self.txtfd_ph.text = @" ";
                
            }
            else{
                self.txtfd_ph.text = [NSString stringWithFormat:@"%@",mobile];
            }
            if (city == nil) {
                self.txtfd_city.text = @" ";
                
            }
            else{
                self.txtfd_city.text = [NSString stringWithFormat:@"%@",city];
            }
            if (email_id == nil) {
                self.txtfd_email.text = @" ";
                
            }
            else{
                self.txtfd_email.text = [NSString stringWithFormat:@"%@",email_id];
            }
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }
    else
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
}


////////

 -(void)savelivresCatimages
{
//   // user_id = [[NSUserDefaults standardUserDefaults]stringForKey:@"u_id"];
//    NSMutableDictionary *dictResultSignIn=[[NSMutableDictionary alloc]init];
//    NSMutableDictionary *dicSubmit = [[NSMutableDictionary alloc]init];
//    [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood//api.php";
//    //   http://vps291033.ovh.net/turbofood//api.php?method=user_view_info&id=12
//    [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
//    [WebServiceViewController wsVC].strMethodName = @"unser_image_update";
//    
//    [dicSubmit setObject:user_id forKey:@"id"];
//    
//    dictResultSignIn = [[WebServiceViewController wsVC] PostDataWithImage:picimage withParameter:dicSubmit withImageKey:@"image"];
//    
//    if (dictResultSignIn != Nil || dictResultSignIn != NULL) {
//        
//        if ([[dictResultSignIn objectForKey:@"status"]integerValue] == 0)
//        {
//            NSDictionary *resposne = [dictResultSignIn objectForKey:@"result"];
//            NSLog(@"Resposne :::::: %@",resposne);
//        }
//        
//        
//    }
//}

  NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    urlSession = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    //user_info_save_android
   NSURL *url = [NSURL URLWithString:@"http://vps291033.ovh.net/turbofood//api.php?method=unser_image_update"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *contentTypeValue = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", POST_BODY_BOURDARY];
    [request addValue:contentTypeValue forHTTPHeaderField:@"Content-type"];
    
    
    NSMutableData *dataForm = [NSMutableData alloc];
    
    NSData *imageData = UIImageJPEGRepresentation(picimage,0.9);
    
    [dataForm appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",POST_BODY_BOURDARY] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [dataForm appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image\"; filename=\"%@%d.jpg\"\r\n", @"test",1]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [dataForm appendData:[[NSString stringWithFormat:@"Content-Type: image/jpeg\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [dataForm appendData:[NSData dataWithData:imageData]];
   // NSData *imagedata =
    
    
    
    
    [dataForm appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",POST_BODY_BOURDARY] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [dataForm appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"param1\";\r\n\r\n%@", @"10001"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [dataForm appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [dataForm appendData:[[NSString stringWithFormat:@"--%@\r\n", POST_BODY_BOURDARY] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [dataForm appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [dataForm appendData:[[NSString stringWithString:user_id] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [dataForm appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [dataForm appendData:[[NSString stringWithFormat:@"--%@\r\n", POST_BODY_BOURDARY] dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLSessionUploadTask *uploadTask = [urlSession uploadTaskWithRequest:request fromData:dataForm];
    NSLog(@"Request :%@",request);
    [uploadTask resume];
   [MBProgressHUD hideHUDForView:self.view animated:NO];
}
 //////

///////////////////


- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend {
   
    NSLog(@"Sent %lld, Total sent %lld, Not Sent %lld", bytesSent, totalBytesSent, totalBytesExpectedToSend);
    
}



- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
     [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    receiveData = [NSMutableData data];
    
    [receiveData setLength:0];
    
    completionHandler(NSURLSessionResponseAllow);
    
    NSLog(@"NSURLSession Starts to Receive Data");
    
}



- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    
    [receiveData appendData:data];
    
    NSLog(@"NSURLSession Receive Data");
    [MBProgressHUD hideHUDForView:self.view animated:NO];
}



- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
   
    NSLog(@"URL Session Complete: %@", task.response.description);
    
    
    
    
    if(error != nil) {
        
        NSLog(@"Error %@",[error userInfo]);
        
       
    } else {
        
        NSLog(@"Uploading is Succesfull");
        
        
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *getImagePath = [documentsDirectory stringByAppendingPathComponent:@"savedImage.png"];
        picimage = [UIImage imageWithContentsOfFile:getImagePath];
        
        NSString *result = [[NSString alloc] initWithData:receiveData encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@", result);
        
       
    }
    
}


-(void)SenduserRegistrationData
{
    
    user_id = [[NSUserDefaults standardUserDefaults]stringForKey:@"u_id"];
    
    
    NSMutableDictionary *dictResultSignIn=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *dicSubmit = [[NSMutableDictionary alloc]init];
    [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood//api.php";
    //   http://vps291033.ovh.net/turbofood//api.php?method=user_view_info&id=12
    [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
    [WebServiceViewController wsVC].strMethodName = @"user_info_save_android";
    
    [dicSubmit setObject:user_id forKey:@"id"];
    [dicSubmit setObject:self.txtfd_name.text forKey:@"name"];
    [dicSubmit setObject:self.txtfd_ph.text forKey:@"mobile"];
    [dicSubmit setObject:self.txtfd_city.text forKey:@"city"];
    [dicSubmit setObject:self.txtfd_email.text forKey:@"email"];
    
    dictResultSignIn = [[WebServiceViewController wsVC] sendRequestWithParameter:dicSubmit];
    
    if (dictResultSignIn != Nil || dictResultSignIn != NULL) {
        
        if ([[dictResultSignIn objectForKey:@"status"]integerValue] == 0)
        {
            NSDictionary *resposne = [dictResultSignIn objectForKey:@"result"];
            
            NSLog(@"Resposne ::::::: %@",resposne);
            
            [[NSUserDefaults standardUserDefaults]setObject:[resposne valueForKey:@"name"] forKey:@"name"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            user_name = [NSString stringWithFormat:@"%@",[resposne valueForKey:@"name"]];
            mobile = [NSString stringWithFormat:@"%@",[resposne valueForKey:@"mobile"]];
            city = [NSString stringWithFormat:@"%@",[resposne valueForKey:@"city"]];
            email_id = [NSString stringWithFormat:@"%@",[resposne valueForKey:@"email"]];
           // [self.profile_pic_bg sd_setImageWithURL:[NSURL URLWithString:[resposne valueForKey:@"image"]] placeholderImage:[ UIImage imageNamed:@"no_img"]];
            //[self.profile_pic sd_setImageWithURL:[NSURL URLWithString:[resposne valueForKey:@"image"]] placeholderImage:[ UIImage imageNamed:@"no_img"]];
//            NSString *url_image = [[NSUserDefaults standardUserDefaults]stringForKey:@"image_url"];
//            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url_image]];
//            //imageView.image = [UIImage imageWithData:imageData];
//            self.profile_image.image = [UIImage imageWithData:imageData];
            if (user_name == nil) {
                self.txtfd_name.text = @" ";
                
            }
            else{
                self.txtfd_name.text = [NSString stringWithFormat:@"%@",user_name];
                [[NSUserDefaults standardUserDefaults]setObject:self.txtfd_name.text forKey:@"user_name"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            if (mobile == nil) {
                self.txtfd_ph.text = @" ";
                
            }
            else{
                self.txtfd_ph.text = [NSString stringWithFormat:@"%@",mobile];
            }
            if (city == nil) {
                self.txtfd_city.text = @" ";
                
            }
            else{
                self.txtfd_city.text = [NSString stringWithFormat:@"%@",city];
            }
            if (email_id == nil) {
                self.txtfd_email.text = @" ";
                
            }
            else{
                self.txtfd_email.text = [NSString stringWithFormat:@"%@",email_id];
            }
            if(self.profile_pic.image == nil)    {
                self.profile_pic.image = [UIImage imageNamed:@"no_img-2.png"];
            }
            else{
                
            }
            
        }
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];

}



- (IBAction)cart_btn:(id)sender
{
    [self cart_no];
    
    
    if ([cart_nmuber isEqualToString:@"0"]) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alerte"message:@"Le panier est vide."delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
        [alert show];
    }
    else{
        ViewController6 *vc6 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController6"];
        [self.navigationController pushViewController:vc6 animated:YES];
    }
    
}

- (IBAction)bell_btn:(id)sender {
    NotificationViewController *vc4 =
    [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationViewController"];
    [self.navigationController pushViewController:vc4 animated:YES];
}
-(void)cart_no
{
    //[MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    
    u_id = [[NSUserDefaults standardUserDefaults]
            stringForKey:@"u_id"];
    NSMutableDictionary *dictResultSignIn=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *dicSubmit = [[NSMutableDictionary alloc]init];
    [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood//api.php";
    
    [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
    [WebServiceViewController wsVC].strMethodName = @"count_cart";
    
    [dicSubmit setObject:u_id forKey:@"u_id"];
    
    dictResultSignIn = [[WebServiceViewController wsVC] sendRequestWithParameter:dicSubmit];
    
    if (dictResultSignIn != Nil || dictResultSignIn != NULL)
    {
        
        if ([[dictResultSignIn objectForKey:@"status"]integerValue] == 0)
        {
            NSDictionary *response=[dictResultSignIn objectForKey:@"result"];
            cart_nmuber = [NSString stringWithFormat:@"%@",response];
            
        }
        else
        {
            
        }
    }
    
    //[MBProgressHUD hideHUDForView:self.tableView animated:YES];
}

@end
