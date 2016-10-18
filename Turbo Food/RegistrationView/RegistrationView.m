//
//  RegistrationView.m
//  Turbo Food
//
//  Created by Ravi Brahmbhatt on 10/03/16.
//  Copyright © 2016 Ravi. All rights reserved.
//

#import "RegistrationView.h"
#import "WebServiceViewController.h"
#import "ViewController2.h"
#import "LoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "Validation.h"
#import "SlideMenuViewController.h"
#import "MFSideMenuContainerViewController.h"
#import "MFSideMenu.h"
#import "MFSideMenuContainerViewController.h"
#import "Reachability.h"
#import "ViewController6.h"


#define kOFFSET_FOR_KEYBOARD 140.0


@interface RegistrationView ()
{
    NSString *Fbid;
    NSString *stremail;
    NSString *Firstname;
    NSString *cart;
}
@end

@implementation RegistrationView
@synthesize txtUserName,txtUserPhone,txtUserEmail,txtUserConfirmPassword,txtUserPassword,aScrollView,facebooklogin;

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
    self.navigationController.navigationBar.hidden = YES;
    
    [txtUserName setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    [txtUserEmail setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    [txtUserPhone setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    [txtUserPassword setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    [txtUserConfirmPassword setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    //Set Return Key for Keyboard
    
    [txtUserName setReturnKeyType:UIReturnKeyNext];
    [txtUserPhone setReturnKeyType:UIReturnKeyNext];
    [txtUserEmail setReturnKeyType:UIReturnKeyNext];
    [txtUserPassword setReturnKeyType:UIReturnKeyNext];
    [txtUserConfirmPassword setReturnKeyType:UIReturnKeyGo];
  
    [txtUserName addTarget:self action:@selector(userNameFinished:) forControlEvents:UIControlEventEditingDidEndOnExit ];
    [txtUserPhone addTarget:self action:@selector(telephoneFinished:) forControlEvents:UIControlEventEditingDidEndOnExit ];
     [txtUserEmail addTarget:self action:@selector(emailFinished:) forControlEvents:UIControlEventEditingDidEndOnExit ];
    [txtUserPassword addTarget:self action:@selector(passwordFinished:) forControlEvents:UIControlEventEditingDidEndOnExit ];
    
    
    [txtUserConfirmPassword addTarget:self action:@selector(userconfirmpasswordFieldFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    //Keyboard stuff
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapRecognizer];
    
    
}

-(BOOL)userNameFinished:(id)sender
{
    [txtUserName resignFirstResponder];
    [txtUserPhone becomeFirstResponder];
    return YES;
}
-(BOOL)telephoneFinished:(id)sender
{
    [txtUserPhone resignFirstResponder];
    [txtUserEmail becomeFirstResponder];
    return YES;
}
-(BOOL)emailFinished:(id)sender
{
    [txtUserEmail resignFirstResponder];
    [txtUserPassword becomeFirstResponder];
    return YES;
}
-(BOOL)passwordFinished:(id)sender
{
    [txtUserPassword resignFirstResponder];
    [txtUserConfirmPassword becomeFirstResponder];
    return YES;
}

-(BOOL)userconfirmpasswordFieldFinished:(id)sender{
    [self btn_registration:sender];
    return NO;
}



- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
}

-(void)viewWillAppear:(BOOL)animated{
   
    [super viewWillAppear:animated];
    
     [self.menuContainerViewController setPanMode:MFSideMenuPanModeNone];
    
    // register for keyboard notifications
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

    
    retrievedDictionary = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"userLogedinData"];
    
    txtUserName.text =[NSString stringWithFormat:@"%@",[retrievedDictionary objectForKey:@"name"]];
    txtUserPassword.text =[NSString stringWithFormat:@"%@",[retrievedDictionary objectForKey:@"pass"]];
    txtUserEmail.text =[NSString stringWithFormat:@"%@",[retrievedDictionary objectForKey:@"email"]];
    txtUserPhone.text =[NSString stringWithFormat:@"%@",[retrievedDictionary objectForKey:@"mobile"]];
    txtUserConfirmPassword.text =[NSString stringWithFormat:@"%@",[retrievedDictionary objectForKey:@"confirm_pass"]];
    
    
    if ([txtUserName.text isEqualToString:@"(null)"])
    {
     
        txtUserName.text=@"";
    }
    if ([txtUserPassword.text isEqualToString:@"(null)"])
    {

        txtUserEmail.text=@"";

        txtUserPassword.text=@"";
    }
    if ([txtUserEmail.text isEqualToString:@"(null)"])
    {

        txtUserEmail.text=@"";
    }
    if ([txtUserPhone.text isEqualToString:@"(null)"])
    {

        txtUserPhone.text=@"";
    }
    if ([txtUserConfirmPassword.text isEqualToString:@"(null)"])
    {

        txtUserConfirmPassword.text=@"";
    }
    if (txtUserEmail.text.length>0)
    {
        
        txtUserEmail.enabled=NO;
    }
    else
    {
        
        txtUserEmail.enabled=YES;
    }
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)btn_registration:(UIButton *)sender
{
    Validation *validate = [[Validation alloc] init];
     BOOL emailValid = [validate emailRegEx:txtUserEmail.text];
    BOOL passwordValid = [validate passwordMinLength:(NSInteger *)6 password:txtUserPassword.text];
   
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"userLogedinData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    if (networkStatus == NotReachable)
    {
        NSLog(@"There IS NO internet connection");
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alerte"
                                                                                 message:@"Pas de connexion internet." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        [txtUserName becomeFirstResponder];
        
    }
   
    else if (txtUserName.text.length==0 || txtUserPassword.text.length==0 || txtUserEmail.text.length==0 || txtUserPhone.text.length==0 || txtUserConfirmPassword.text.length==0 || txtUserEmail.text.length==0)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alerte" message:@"Enregistrement échoué " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
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
        
        [txtUserEmail becomeFirstResponder];
        
    }
    else if (!passwordValid && emailValid) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Mot de passe incorrect"                           message:@"Votre mot de passe doit être d'au moins 6 caractères.Veuillez réessayer."
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK",
                              nil];
        [alert show];
        
         [txtUserPassword becomeFirstResponder];
    
    }
    else
    {
        NSString*txtUserPass = [NSString stringWithFormat:@"%@",txtUserPassword.text];
        NSString*txtUserConfirmPass = [NSString stringWithFormat:@"%@",txtUserConfirmPassword.text];
        
        if ([txtUserPass isEqualToString:txtUserConfirmPass])
        {
            [self userinformation];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alerte"
                                                           message:@"Votre mots de passes diffèrent"
                                                          delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [txtUserPassword becomeFirstResponder];
            
            
        }
    }
    
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
    [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood//api.php";
    [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
    [WebServiceViewController wsVC].strMethodName = @"add_app_user";
    
    [dicSubmit setObject:txtUserName.text forKey:@"name"];
    [dicSubmit setObject:txtUserEmail.text forKey:@"email"];
    [dicSubmit setObject:txtUserPassword.text forKey:@"pass"];
    [dicSubmit setObject:txtUserPhone.text forKey:@"mobile"];
    [dicSubmit setObject:type forKey:@"type"];
    [dicSubmit setObject:token forKey:@"u_token"];
 
   
    
    NSLog(@"DicSubmit = %@",dicSubmit);
    
    dictResultSignIn = [[WebServiceViewController wsVC] sendRequestWithParameter:dicSubmit];
    
    if (dictResultSignIn != Nil || dictResultSignIn != NULL) {
        NSLog(@"dictResultSubmit = %@",dictResultSignIn);
        
        if ([[dictResultSignIn objectForKey:@"status"]integerValue] == 0)
        {
            dict =[dictResultSignIn objectForKey:@"message"];
            
            NSMutableDictionary *user = [[NSMutableDictionary alloc]init];
            user = [dictResultSignIn objectForKey:@"user"];
            
            
            NSString *email = [user objectForKey:@"email" ];
            NSMutableDictionary *u_id = [[NSMutableDictionary alloc]init];
            u_id = [user objectForKey:@"id"];
            
            cart = [dictResultSignIn objectForKey:@"cart"];
            
            [[NSUserDefaults standardUserDefaults]setObject:u_id forKey:@"u_id"];
            [[NSUserDefaults standardUserDefaults] synchronize];

            [[NSUserDefaults standardUserDefaults]setObject:email forKey:@"email"];
            [[NSUserDefaults standardUserDefaults] synchronize];
          ////////////////
            NSString *user_name = [NSString stringWithFormat:@"%@",txtUserName.text];
            
            [[NSUserDefaults standardUserDefaults]setObject:user_name forKey:@"user_name"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"RgClicked"];
            [[NSUserDefaults standardUserDefaults] synchronize];

            ///////////////
            [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"userLogedinData"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }
        else
        {
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alerte" message:@"Cet utilisateur existe déjà" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
        }
        
    }
    else
    {
        
    }
    
    ViewController2 *VC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController2"];
    [self.navigationController pushViewController:VC2 animated:YES];
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
-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if  (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
   
        //Keyboard becomes visible
        aScrollView.frame = CGRectMake(aScrollView.frame.origin.x,
                                      aScrollView.frame.origin.y,
                                      aScrollView.frame.size.width,
                                      aScrollView.frame.size.height - 215 + 50);   //resize
    

}
-(void)textFieldDidEndEditing:(UITextField *)textField {
    //keyboard will hide
    aScrollView.frame = CGRectMake(aScrollView.frame.origin.x,
                                  aScrollView.frame.origin.y,
                                  aScrollView.frame.size.width,
                                  aScrollView.frame.size.height + 215 - 50); //resize
    
    
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





- (IBAction)btn_alreadyRegister:(UIButton *)sender {
    
    
    LoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self.navigationController pushViewController:loginVC animated:YES];
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
                  
                  
                  //NSArray *data = [result valueForKey:@"data"];
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
            
            [[NSUserDefaults standardUserDefaults]setObject:u_id forKey:@"u_id"];
            [[NSUserDefaults standardUserDefaults] synchronize];

            NSString *email = [user objectForKey:@"email" ];
            cart = [dictResultSignIn objectForKey:@"cart"];

            [[NSUserDefaults standardUserDefaults]setObject:email forKey:@"email"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"userLogedinData"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            //ViewController2 *VC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController2"];
           // [self.navigationController pushViewController:VC2 animated:YES];
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
            

        }
        
        
    }
    else
    {
        
    }
    
}

@end
