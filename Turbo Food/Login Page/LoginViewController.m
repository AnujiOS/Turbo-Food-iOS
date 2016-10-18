//
//  ViewController.m
//  Turbo Food
//
//  Created by Ravi on 2/23/16.
//  Copyright (c) 2016 Ravi. All rights reserved.
//

#import "LoginViewController.h"
#import "Validation.h"
#import "MFSideMenu.h"
#import "ViewController2.h"
#import "RegistrationView.h"
#import "WebServiceViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "Reachability.h"
#import "ViewController6.h"
#import "forgotpasswordViewController.h"



#define kOFFSET_FOR_KEYBOARD 100.0

@interface LoginViewController ()
{
    NSString *Fbid;
    NSString *stremail;
    NSString *Firstname;
    NSString *cart;
}
@end

@implementation LoginViewController
@synthesize emailID,password,forgetPassword,connection,aScrollView;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.emailID setReturnKeyType:UIReturnKeyNext];
    [self.password setReturnKeyType:UIReturnKeyGo];
    [self.password setKeyboardType:UIKeyboardTypeASCIICapable]; // Deprecated];
    [self.password addTarget:self action:@selector(passwordFieldFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.emailID addTarget:self action:@selector(emailFieldFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [emailID setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    [password setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapRecognizer];
    
   
    
    
}

- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
  //  self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
  
    [self.menuContainerViewController setPanMode:MFSideMenuPanModeNone];
    //[self registerForKeyboardNotifications];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    retrievedDictionary = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"userLogedinData"];
    
    
    password.text =[NSString stringWithFormat:@"%@",[retrievedDictionary objectForKey:@"pass"]];
    emailID.text =[NSString stringWithFormat:@"%@",[retrievedDictionary objectForKey:@"email"]];
  
    if ([password.text isEqualToString:@"(null)"])
    {
        password.text=@"";
    }

    if ([emailID.text isEqualToString:@"(null)"])
    {
        emailID.text=@"";
    }
    if (emailID.text.length>0)
    {
        
        emailID.enabled=NO;
    }
    else
    {
        
        password.enabled=YES;
    }


}

-(BOOL)emailFieldFinished:(id)sender{
    [emailID resignFirstResponder];
    [password becomeFirstResponder];
    return YES;
}
-(BOOL)passwordFieldFinished:(id)sender{
    [self connection:sender];
    return NO;
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

-(IBAction)connection:(id)sender
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    Validation *validate = [[Validation alloc] init];
    
    // validate email and pop alert if need be
    BOOL emailValid = [validate emailRegEx:emailID.text];
    BOOL passwordValid = [validate passwordMinLength:(NSInteger *)6 password:password.text];

    if (networkStatus == NotReachable)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alerte"
                                                                                 message:@"Pas de connexion internet." preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];

        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    
   else if (!emailValid) {
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Email invalide"
                              message:@"Votre adresse e-mail est pas valide. Veuillez réessayer."
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK",
                              nil];
        [alert show];
       
        [emailID becomeFirstResponder];
        
    }
    
    
    else if (!passwordValid && emailValid) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Mot de passe incorrect"                        message:@"Votre mot de passe doit être d'au moins 6 caractères.Veuillez réessayer."
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK",
                              nil];
        [alert show];
       
        [password becomeFirstResponder];
    }
    
  
   else if (emailID.text.length==0 || password.text.length==0 )
    {
      
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Mot de passe incorrect"
                              message:@"S'il vous plaît entrez email et mot de passe"
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK",
                              nil];
        [alert show];

        [emailID becomeFirstResponder];

    }
    else
    {
        [self userinformation];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"SocialFBClicked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
   // [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"LocalClicked"];
    //[[NSUserDefaults standardUserDefaults] synchronize];

}

-(void)userinformation
{
    NSString *type = @"ios";
    
    NSString *token = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"Device_token"];
    if (token == nil) {
        token = @"b3449d06af52599f0ae61039f48f13a26b23376a25617dc208129856992fd70c";
    }
    
    NSMutableDictionary *dictResultSignIn=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *dicSubmit = [[NSMutableDictionary alloc]init];
    [WebServiceViewController wsVC].strURL =@" http://45.79.169.241/sworkit/";//@"http://vps291033.ovh.net/turbofood///api.php";
    //http://vps291033.ovh.net/turbofood//api.php?method=view_category_menu&r_id=1&c_id=1
    [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
    [WebServiceViewController wsVC].strMethodName = @"register/bubbly";//@"app_login";
    
//    [dicSubmit setObject:emailID.text forKey:@"email"];
//    [dicSubmit setObject:password.text forKey:@"pass"];
//    [dicSubmit setObject:type forKey:@"type"];
//    [dicSubmit setObject:token forKey:@"u_token"];
    [dicSubmit setObject:emailID.text forKey:@"name"];
    [dicSubmit setObject:emailID.text forKey:@"email"];
    [dicSubmit setObject:emailID.text forKey:@"password"];
    
    NSLog(@"DicSubmit = %@",dicSubmit);
    
    dictResultSignIn = [[WebServiceViewController wsVC] sendRequestWithParameter:dicSubmit];
    
    if (dictResultSignIn != Nil || dictResultSignIn != NULL) {
        NSLog(@"dictResultSubmit = %@",dictResultSignIn);
        
        if ([[dictResultSignIn objectForKey:@"status"]integerValue] == 0)
        {
            dict =[dictResultSignIn objectForKey:@"message"];
            
            
            NSMutableDictionary *user = [[NSMutableDictionary alloc]init];
            user = [dictResultSignIn objectForKey:@"user"];
            
            cart = [dictResultSignIn objectForKey:@"cart"];
            
            
            NSMutableDictionary *u_id = [[NSMutableDictionary alloc]init];
            u_id = [user objectForKey:@"id"];
            
            [[NSUserDefaults standardUserDefaults]setObject:u_id forKey:@"u_id"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            NSString *email = [user objectForKey:@"email"];
            NSString *name = [user objectForKey:@"name"];

            NSString *url = [user objectForKey:@"image"];
            [[NSUserDefaults standardUserDefaults]setObject:url forKey:@"image_url"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"LoginClicked"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [[NSUserDefaults standardUserDefaults]setObject:name forKey:@"user_name"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [[NSUserDefaults standardUserDefaults]setObject:email forKey:@"email"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [[NSUserDefaults standardUserDefaults]setObject:name forKey:@"name"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"userLogedinData"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            if ([cart isEqualToString:@"0"]) {
                ViewController2 *VC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController2"];
                [self.navigationController pushViewController:VC2 animated:YES];

            }
            else{
                ViewController6 *VC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController6"];
                [self.navigationController pushViewController:VC2 animated:YES];
            }
            
        }
        else if ( [[dictResultSignIn objectForKey:@"status"]integerValue] == 1){
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message"
                                                           message:@"Mauvais Nom d'utilisateur ou mot de passe" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
    
            
   }
        else
        {
            
        }
    
   
}


- (IBAction)btn_forgetPassword:(UIButton *)sender
{
    forgotpasswordViewController *VC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"forgotpasswordViewController"];
    [self.navigationController pushViewController:VC2 animated:YES];
    
    
}

- (IBAction)sidebarButton:(UIBarButtonItem *)sender {
    
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

- (IBAction)btn_facebooklogin:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"SocialFBClicked"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"SocialDBClicked"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
   FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"picture,first_name,last_name,email,name",@"fields",nil];
    
   [loginManager logInWithReadPermissions:@[@"public_profile", @"email", @"user_friends",@"user_photos"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
     
     {
         
           [[[FBSDKGraphRequest alloc]
           initWithGraphPath:@"me"
           parameters:params
           HTTPMethod:@"GET"]
          startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
              if (!error) {
                  
                  NSLog(@"Result: %@", result);
                  NSMutableDictionary *userInfo = (NSMutableDictionary *)result;
                  NSLog(@"Result: %@", result);
                  
                   NSMutableArray *arruserinfo =[userInfo objectForKey:@"Result"];
                 // ids =[userInfo objectForKey:@"data"];
                  
                  Fbid =[userInfo objectForKey:@"id"];
                  stremail =[userInfo objectForKey:@"email"];
                  Firstname =[NSString stringWithFormat:@"%@",[userInfo objectForKey:@"name"]];
                  NSDictionary *temp1 = [[[userInfo valueForKey:@"picture"]valueForKey:@"data"]valueForKey:@"url"];
                  NSLog(@"temp1 = %@",temp1);
                  
                  NSString *fb_pic = [NSString stringWithFormat:@"%@",temp1];
                  
                  [[NSUserDefaults standardUserDefaults]setObject:stremail forKey:@"email_id"];
                  [[NSUserDefaults standardUserDefaults] synchronize];
                  
                  [[NSUserDefaults standardUserDefaults]setObject:Firstname forKey:@"fb_name"];
                  [[NSUserDefaults standardUserDefaults] synchronize];
                  
                  [[NSUserDefaults standardUserDefaults]setObject:fb_pic forKey:@"fb_pic"];
                  [[NSUserDefaults standardUserDefaults] synchronize];
                  
                  [[NSUserDefaults standardUserDefaults]setObject:Fbid forKey:@"fb_id"];
                  [[NSUserDefaults standardUserDefaults] synchronize];

                  [self FBwithlogn];
                }
          }];
         
         
     }];
    }

    
   

///// FACEBOOK LOGIN METHOD

-(void)FBwithlogn
{
    NSString *type = @"ios";
    
    NSString *token = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"Device_token"];
    if (token == nil) {
        token = @"b3449d06af52599f0ae61039f48f13a26b23376a25617dc208129856992fd70c";
    }

    NSMutableDictionary *dictResultSignIn=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *dicSubmit = [[NSMutableDictionary alloc]init];
    [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood//api.php";
    //http://vps291033.ovh.net/turbofood//api.php?method=view_category_menu&r_id=1&c_id=1
    [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
    [WebServiceViewController wsVC].strMethodName = @"add_fb_user_ios";
    
    [dicSubmit setObject:Fbid forKey:@"fb_id"];
    [dicSubmit setObject:stremail forKey:@"email"];
    [dicSubmit setObject:Firstname forKey:@"name"];
    [dicSubmit setObject:token forKey:@"u_token"];
    [dicSubmit setObject:type forKey:@"type"];
    
    NSLog(@"DicSubmit = %@",dicSubmit);
    
    dictResultSignIn = [[WebServiceViewController wsVC] sendRequestWithParameter:dicSubmit];
    
    if (dictResultSignIn != Nil || dictResultSignIn != NULL) {
        NSLog(@"dictResultSubmit = %@",dictResultSignIn);
        
        if ([[dictResultSignIn objectForKey:@"status"]integerValue] == 0)
        {
            dict =[dictResultSignIn objectForKey:@"message"];
            
            
            
            NSMutableDictionary *user = [[NSMutableDictionary alloc]init];
            user = [dictResultSignIn objectForKey:@"user"];
            
            NSMutableDictionary *u_id = [[NSMutableDictionary alloc]init];
            u_id = [user objectForKey:@"id"];
            
            cart = [dictResultSignIn objectForKey:@"cart"];
            
            [[NSUserDefaults standardUserDefaults]setObject:u_id forKey:@"u_id"];
            [[NSUserDefaults standardUserDefaults] synchronize];

            NSString *email = [user objectForKey:@"email" ];
            NSString *name = [user objectForKey:@"name" ];
            
            [[NSUserDefaults standardUserDefaults]setObject:name forKey:@"name"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [[NSUserDefaults standardUserDefaults]setObject:email forKey:@"email"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"userLogedinData"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            //ViewController2 *VC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController2"];
            
            //[self.navigationController pushViewController:VC2 animated:YES];
            if ([cart isEqualToString:@"0"]) {
                ViewController2 *VC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController2"];
                [self.navigationController pushViewController:VC2 animated:YES];
                
            }
            else{
                ViewController6 *VC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController6"];
                [self.navigationController pushViewController:VC2 animated:YES];
            }
            

            
            
            
        }
        else if ( [[dictResultSignIn objectForKey:@"status"]integerValue] == 1)
        {
            
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message"
//                                                           message:@"Mauvais Nom d'utilisateur ou mot de passe" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//            [alert show];
        }
        
        
    }
    else
    {
        
    }

}
- (IBAction)registration_btn:(id)sender {
    RegistrationView *rv = [self.storyboard instantiateViewControllerWithIdentifier:@"RegistrationView"];
    [self.navigationController pushViewController:rv animated:YES];
}
@end
