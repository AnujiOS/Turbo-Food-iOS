//
//  forgetpasswdsecretcodeViewController.m
//  Turbo Food
//
//  Created by mac on 6/18/16.
//  Copyright © 2016 Ravi. All rights reserved.
//

#import "forgetpasswdsecretcodeViewController.h"
#import "Validation.h"
#import "MFSideMenu.h"
#import "Reachability.h"
#import "WebServiceViewController.h"
#import "ViewController2.h"
#import "LoginViewController.h"

@interface forgetpasswdsecretcodeViewController ()
{
    NSString *email_id;
    NSString *user_id;
}
@end

@implementation forgetpasswdsecretcodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.secret_code setReturnKeyType:UIReturnKeyNext];
    [self.user_new_passwd setReturnKeyType:UIReturnKeyNext];
    [self.user_confirm_new_passwd setReturnKeyType:UIReturnKeyGo];
    
    
    [self.secret_code addTarget:self action:@selector(secret_code:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.user_new_passwd addTarget:self action:@selector(user_pass:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.user_confirm_new_passwd addTarget:self action:@selector(user_pass_confirm:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.secret_code setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.user_new_passwd setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.user_confirm_new_passwd setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapRecognizer];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
}

-(BOOL)secret_code:(id)sender{
    [self.secret_code resignFirstResponder];
    [self.user_new_passwd becomeFirstResponder];
    return YES;
}
-(BOOL)user_pass:(id)sender{
    [self.user_new_passwd resignFirstResponder];
    [self.user_confirm_new_passwd becomeFirstResponder];
    return YES;
}

-(BOOL)user_pass_confirm:(id)sender{
    [self confirm:sender];
    return NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)confirm:(id)sender {
    
    
    
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    Validation *validate = [[Validation alloc] init];
    // validate email and pop alert if need be
   // BOOL emailValid = [validate emailRegEx:self.forget_emailId.text];
    BOOL passwordValid = [validate passwordMinLength:(NSInteger *)6 password:self.user_new_passwd.text];
     BOOL confirmpasswordValid = [validate passwordMinLength:(NSInteger *)6 password:self.user_confirm_new_passwd.text];
    if (networkStatus == NotReachable)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alerte"
                                                                                 message:@"Pas de connexion internet." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    else if (self.secret_code.text.length==0 || self.user_new_passwd.text.length==0 || self.user_confirm_new_passwd.text.length==0 )
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alerte" message:@"S'il vous plaît remplir besoin champ" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
//    else if (!passwordValid) {
//        
//        UIAlertView *alert = [[UIAlertView alloc]
//                              initWithTitle:@"Email invalide"
//                              message:@"Votre adresse e-mail est pas valide. Veuillez réessayer."
//                              delegate:self
//                              cancelButtonTitle:nil
//                              otherButtonTitles:@"OK",
//                              nil];
//        [alert show];
//        
//        [txtUserEmail becomeFirstResponder];
//        
//    }
    else if (!passwordValid && confirmpasswordValid) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Mot de passe incorrect"                           message:@"Votre mot de passe doit être d'au moins 6 caractères.Veuillez réessayer."
                                                      delegate:self
                                             cancelButtonTitle:nil
                                             otherButtonTitles:@"OK",
                              nil];
        [alert show];
        
        [self.user_new_passwd becomeFirstResponder];
        
    }
    else
    {
        NSString*txtUserPass = [NSString stringWithFormat:@"%@",self.user_new_passwd.text];
        NSString*txtUserConfirmPass = [NSString stringWithFormat:@"%@",self.user_confirm_new_passwd.text];
        
        if ([txtUserPass isEqualToString:txtUserConfirmPass])
        {
            NSMutableDictionary *dictResultSignIn=[[NSMutableDictionary alloc]init];
            NSMutableDictionary *dicSubmit = [[NSMutableDictionary alloc]init];
            [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood//api.php";
            //   http://vps291033.ovh.net/turbofood//api.php?method=user_view_info&id=12
            [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
            [WebServiceViewController wsVC].strMethodName = @"reset_app_password";
            
            email_id = [[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
            
            [dicSubmit setObject:self.secret_code.text forKey:@"secret"];
            [dicSubmit setObject:email_id forKey:@"email"];
            [dicSubmit setObject:self.user_new_passwd.text forKey:@"new_pass"];
            
            
            dictResultSignIn = [[WebServiceViewController wsVC] sendRequestWithParameter:dicSubmit];
            
            if (dictResultSignIn != Nil || dictResultSignIn != NULL) {
                
                if ([[dictResultSignIn objectForKey:@"status"]integerValue] == 0)
                {
                    NSDictionary *resposne = [dictResultSignIn objectForKey:@"result"];
                    
                    NSLog(@"Resposne ::::::: %@",resposne);
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alerte"
                                                                   message:@"Réussi"
                                                                  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    LoginViewController *vc4 = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                    [self.navigationController pushViewController:vc4 animated:NO];
                    
                    
                }
            }

        }
        else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alerte"
                                                           message:@"Votre mots de passes diffèrent"
                                                          delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [self.user_new_passwd becomeFirstResponder];
            
            
        }
    }

    
    
   }

- (IBAction)back_btn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
