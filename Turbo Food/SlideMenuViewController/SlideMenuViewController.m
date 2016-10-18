//
//  SlideMenuViewController.m
//  Turbo Food
//
//  Created by Ravi on 2/24/16.
//  Copyright (c) 2016 Ravi. All rights reserved.
//

#import "SlideMenuViewController.h"
#import "PaiementViewController.h"
#import "FavorisViewController.h"
#import "MFSideMenu.h"
#import "ViewController2.h"
#import "LoginViewController.h"
#import "ProfileViewController.h"
#import "ProfileViewController.h"
#import "WebServiceViewController.h"
#import "UIImageView+WebCache.h"
#import "NotificationViewController.h"
#import "MFSideMenuContainerViewController.h"
@interface SlideMenuViewController ()<UIGestureRecognizerDelegate>
{
    NSString *user_id;
    NSString *user_name;
}
@end

@implementation SlideMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   NSTimer *atimer =[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(viewWillAppear:) userInfo:nil repeats:YES];
//    if([[NSUserDefaults standardUserDefaults] boolForKey:@"SocialFBClicked"])
//    {
//        
//        NSString *fb_pic =[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large",[[NSUserDefaults standardUserDefaults]stringForKey:@"fb_id"]];
//        //NSString *fb_pic =[[NSUserDefaults standardUserDefaults]stringForKey:@"fb_pic"];
//        NSString *fb_name =[[NSUserDefaults standardUserDefaults]stringForKey:@"fb_name"];
//        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:fb_pic]];
//        self.profile_image.image = [UIImage imageWithData:imageData];
//        
//        self.user_name.text = [NSString stringWithFormat:@"%@",fb_name];
//    }
//    else
//    {
//       
//        self.user_name.text = [NSString stringWithFormat:@"%@",user_name];
//        if (self.profile_image.image == nil) {
//            self.profile_image.image = [UIImage imageNamed:@"no_img.png"];
//            
//    }
//       }
//    self.profile_image.layer.cornerRadius = self.profile_image.frame.size.width / 2;
//    self.profile_image.clipsToBounds = YES;
//    self.profile_image.layer.borderWidth = 1.0f;
//    self.profile_image.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    UITapGestureRecognizer *atapGester =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(profile:)];
    atapGester.delegate=self;
    atapGester.numberOfTapsRequired =1;
    [self.profile_image addGestureRecognizer:atapGester];
    //[self Profilename];
   // self.user_name.text = [NSString stringWithFormat:@"%@",user_name];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
-(void)imageandname
{
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"SocialFBClicked"])
    {
        NSString *fb_pic =[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large",[[NSUserDefaults standardUserDefaults]stringForKey:@"fb_id"]];
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:fb_pic]];
        self.profile_image.image = [UIImage imageWithData:imageData];
        NSString *fb_name =[[NSUserDefaults standardUserDefaults]stringForKey:@"fb_name"];
        self.user_name.text = [NSString stringWithFormat:@"%@",fb_name];
         //self.profile_pic_bg.image = [UIImage imageWithData:imageData];
        self.profile_image.layer.cornerRadius = self.profile_image.frame.size.width / 2;
        self.profile_image.clipsToBounds = YES;
        self.profile_image.layer.borderWidth = 1.0f;
        self.profile_image.layer.borderColor = [UIColor whiteColor].CGColor;
        
    }
    else
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *getImagePath = [documentsDirectory stringByAppendingPathComponent:@"image.png"];
        UIImage *image1 = [UIImage imageWithContentsOfFile:getImagePath];
        
        
       // NSString *imggg = [[NSUserDefaults standardUserDefaults]stringForKey:@"image_url"];
        [self.profile_image setImage:image1];
        user_name =[[NSUserDefaults standardUserDefaults]stringForKey:@"user_name"];
        self.user_name.text = [NSString stringWithFormat:@"%@",user_name];
      //  self.profile_image.image
       // if (image1!=nil) {
            self.profile_image.contentMode=UIViewContentModeScaleAspectFill;
            [self.profile_image setClipsToBounds:YES];
            [self.profile_image.layer setMasksToBounds:YES];
            self.profile_image.layer.borderWidth=2.0;
            [self.profile_image.layer setCornerRadius:self.profile_image.frame.size.width/2];
            [self.profile_image.layer setCornerRadius:self.profile_image.frame.size.width/2];
            self.profile_image.layer.borderColor=[UIColor whiteColor].CGColor;
            //[self.profile_image setImage:image1 forState:(UIControlStateNormal)];
           
            //[self profile];
            
            NSString *url_image = [[NSUserDefaults standardUserDefaults]stringForKey:@"image_url"];
            //NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url_image]];
           // self.profile_image.image = [UIImage imageWithData:imageData];
        [self.profile_image setImageWithURL:[NSURL URLWithString:url_image]  placeholderImage:[UIImage imageNamed:@"no_img-2.png"]];
           //self.profile_image.image = [UIImage imageWithData:imageData];
       // }
       //else
       //e@ {
            
       // }
    }

}

-(void)viewWillAppear:(BOOL)animated{
    
     NSLog(@"viewWillAppear");
    
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"SocialFBClicked"])
    {
        NSString *fb_pic =[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large",[[NSUserDefaults standardUserDefaults]stringForKey:@"fb_id"]];
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:fb_pic]];
        self.profile_image.image = [UIImage imageWithData:imageData];
        NSString *fb_name =[[NSUserDefaults standardUserDefaults]stringForKey:@"fb_name"];
        self.user_name.text = [NSString stringWithFormat:@"%@",fb_name];
        //self.profile_pic_bg.image = [UIImage imageWithData:imageData];
        self.profile_image.layer.cornerRadius = self.profile_image.frame.size.width / 2;
        self.profile_image.clipsToBounds = YES;
        self.profile_image.layer.borderWidth = 1.0f;
        self.profile_image.layer.borderColor = [UIColor whiteColor].CGColor;
        
    }
    else
    {
        if([[NSUserDefaults standardUserDefaults] boolForKey:@"LoginClicked"])
        {
            self.profile_image.contentMode=UIViewContentModeScaleAspectFill;
            [self.profile_image setClipsToBounds:YES];
            [self.profile_image.layer setMasksToBounds:YES];
            self.profile_image.layer.borderWidth=2.0;
            [self.profile_image.layer setCornerRadius:self.profile_image.frame.size.width/2];
            [self.profile_image.layer setCornerRadius:self.profile_image.frame.size.width/2];
            self.profile_image.layer.borderColor=[UIColor whiteColor].CGColor;
            
            NSString *url_image = [[NSUserDefaults standardUserDefaults]stringForKey:@"image_url"];
            //NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url_image]];
            //self.profile_image.image = [UIImage imageWithData:imageData];
            [self.profile_image sd_setImageWithURL:[NSURL URLWithString:url_image]  placeholderImage:[UIImage imageNamed:@"no_img-2.png"]];
            
            NSString *name = [[NSUserDefaults standardUserDefaults]stringForKey:@"user_name"];
            self.user_name.text = [NSString stringWithFormat:@"%@",name];
        }
        else{
            
            
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *getImagePath = [documentsDirectory stringByAppendingPathComponent:@"image.png"];
            UIImage *image1 = [UIImage imageWithContentsOfFile:getImagePath];
            [self.profile_image setImage:image1];
            
            //user_name =[[NSUserDefaults standardUserDefaults]stringForKey:@"user_name"];
            self.user_name.text = [[NSUserDefaults standardUserDefaults]stringForKey:@"u_name"];
            
            //  self.profile_image.image
            // if (image1!=nil) {
            self.profile_image.contentMode=UIViewContentModeScaleAspectFill;
            [self.profile_image setClipsToBounds:YES];
            [self.profile_image.layer setMasksToBounds:YES];
            self.profile_image.layer.borderWidth=2.0;
            [self.profile_image.layer setCornerRadius:self.profile_image.frame.size.width/2];
            [self.profile_image.layer setCornerRadius:self.profile_image.frame.size.width/2];
            self.profile_image.layer.borderColor=[UIColor whiteColor].CGColor;
            //[self.profile_image setImage:image1 forState:(UIControlStateNormal)];
            
            //[self profile];
            
          //  NSString *url_image = [[NSUserDefaults standardUserDefaults]stringForKey:@"image_url"];
           // NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url_image]];
            //self.profile_image.image = [UIImage imageWithData:imageData];
            //self.profile_image.image = [UIImage imageWithData:imageData];
       // }
            //else
            //e@ {
            
            // }
        }

    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"RgClicked"])
    {
         self.user_name.text = [[NSUserDefaults standardUserDefaults]stringForKey:@"user_name"];
        
    }
    }
-(void)cart_no
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
            int tap = 0;
           NSDictionary *result =[dictResultSignIn objectForKey:@"result"];
            NSString *temp = [NSString stringWithFormat:@"%@",result];
            if ([temp intValue]> tap ) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Abandoner le paiement ?"message:@"En allant sur cette page, vous perdrez les informations du panier..."delegate:self cancelButtonTitle:@"Annuler" otherButtonTitles:@"OK",nil];
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

-(void)profile
{
    user_id = [[NSUserDefaults standardUserDefaults]stringForKey:@"u_id"];
    if(user_id != nil)
    {
        
    
        NSMutableDictionary *dictResultSignIn=[[NSMutableDictionary alloc]init];
        NSMutableDictionary *dicSubmit = [[NSMutableDictionary alloc]init];
        [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood//api.php";
        //   http://vps291033.ovh.net/turbofood//api.php?method=user_view_info&id=12
        [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
        [WebServiceViewController wsVC].strMethodName = @"user_all_cart_remove";
        
        [dicSubmit setObject:user_id forKey:@"u_id"];
        
        dictResultSignIn = [[WebServiceViewController wsVC] sendRequestWithParameter:dicSubmit];
        
        if (dictResultSignIn != Nil || dictResultSignIn != NULL) {
            
            if ([[dictResultSignIn objectForKey:@"status"]integerValue] == 0)
            {
                NSDictionary *resposne = [dictResultSignIn objectForKey:@"result"];
                
                NSLog(@"Resposne ::::::: %@",resposne);
    }
    else{
    }
    }
    }
}

- (IBAction)btn_logout:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@" Voulez vous sure de vouloir vous déconnecter ?"delegate:self cancelButtonTitle:@"NON" otherButtonTitles:@"OUI",nil];
    alert.tag = 102;
    [alert show];
}
- (IBAction)paiement_id:(id)sender
{
    PaiementViewController *pv = [self.storyboard instantiateViewControllerWithIdentifier:@"PaiementViewController"];
   [self.navigationController pushViewController:pv animated:YES];
    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
    NSArray *controller = [NSArray arrayWithObject:pv];
    navigationController.viewControllers=controller;
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    
}

- (IBAction)favoris_id:(id)sender
{
    FavorisViewController *fv = [self.storyboard instantiateViewControllerWithIdentifier:@"FavorisViewController"];
    [self.navigationController pushViewController:fv animated:YES];
    
    UINavigationController *navigationController  = self.menuContainerViewController.centerViewController;
    NSArray *controller = [NSArray arrayWithObject:fv];
    navigationController.viewControllers  = controller;
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    
}

- (IBAction)mess_id:(id)sender {
    
    [self cart_no];
   
   
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 101) {
        // from YES button
        if (buttonIndex == 1) {
            [self profile];
            ViewController2 *vc4 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController2"];
            [self.navigationController pushViewController:vc4 animated:YES];
            
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controller = [NSArray arrayWithObject:vc4];
            navigationController.viewControllers=controller;
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
        }
        else{
            
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
        }
    }
    else if (alertView.tag == 102) {
        // from NO button
        // _segment_controller.selectedSegmentIndex = 0;
        if (buttonIndex == 1) {
            LoginViewController *pv = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            [self.navigationController pushViewController:pv animated:YES];
            
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controller = [NSArray arrayWithObject:pv];
            navigationController.viewControllers=controller;
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];

            NSString *folderPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSError *error = nil;
            for (NSString *file in [[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:&error]) {
                [[NSFileManager defaultManager] removeItemAtPath:[folderPath stringByAppendingPathComponent:file] error:&error];
            }
            //self.profile_image.image = nil;
            //self.user_name.text = nil;
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"LoginClicked"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"RgClicked"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else{
           
        }

        
        
        
    }
}

- (IBAction)profile:(id)sender {
    
    ProfileViewController *pv = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    [self.navigationController pushViewController:pv animated:YES];
    
    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
    NSArray *controller = [NSArray arrayWithObject:pv];
    navigationController.viewControllers = controller;
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
}

- (IBAction)mescommand:(id)sender {
    NotificationViewController *pv = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationViewController"];
    [self.navigationController pushViewController:pv animated:YES];
    
    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
    NSArray *controller = [NSArray arrayWithObject:pv];
    navigationController.viewControllers = controller;
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];

}
@end
