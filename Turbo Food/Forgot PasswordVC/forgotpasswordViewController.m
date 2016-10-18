//
//  forgotpasswordViewController.m
//  Turbo Food
//
//  Created by mac on 6/18/16.
//  Copyright © 2016 Ravi. All rights reserved.
//

#import "forgotpasswordViewController.h"
#import "WebServiceViewController.h"
#import "Validation.h"
#import "MFSideMenu.h"
#import "Reachability.h"
#import "forgetpasswdsecretcodeViewController.h"
#import "ViewController2.h"

@interface forgotpasswordViewController ()
{
    NSString *user_id;
}
@end

@implementation forgotpasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.forget_emailId setReturnKeyType:UIReturnKeyGo];
    [self.forget_emailId addTarget:self action:@selector(emailFieldFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
     [self.forget_emailId setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(BOOL)emailFieldFinished:(id)sender{
    [self forget_passwd:sender];
    return NO;
}
- (IBAction)forget_passwd:(id)sender {
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    Validation *validate = [[Validation alloc] init];
    // validate email and pop alert if need be
    BOOL emailValid = [validate emailRegEx:self.forget_emailId.text];
    
    if (networkStatus == NotReachable)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alerte"
                                                                                 message:@"Pas de connexion internet." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    
    
    NSMutableDictionary *dictResultSignIn=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *dicSubmit = [[NSMutableDictionary alloc]init];
    [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood//api.php";
    //   http://vps291033.ovh.net/turbofood//api.php?method=user_view_info&id=12
    [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
    [WebServiceViewController wsVC].strMethodName = @"forgot_passemail";
    
    [dicSubmit setObject:self.forget_emailId.text forKey:@"email"];
    NSString * email_id = [NSString stringWithFormat:@"%@",self.forget_emailId.text];
    dictResultSignIn = [[WebServiceViewController wsVC] sendRequestWithParameter:dicSubmit];
    
    if (dictResultSignIn != Nil || dictResultSignIn != NULL) {
        
        if ([[dictResultSignIn objectForKey:@"status"]integerValue] == 0)
        {
            NSDictionary *resposne = [dictResultSignIn objectForKey:@"result"];
            
            NSLog(@"Resposne ::::::: %@",resposne);
            
            [[NSUserDefaults standardUserDefaults] setObject:email_id forKey:@"email"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            forgetpasswdsecretcodeViewController *vc4 = [self.storyboard instantiateViewControllerWithIdentifier:@"forgetpasswdsecretcodeViewController"];
            [self.navigationController pushViewController:vc4 animated:YES];
        }
        else if ([[dictResultSignIn objectForKey:@"status"]integerValue] != 0){
            
            NSDictionary *resposne = [dictResultSignIn objectForKey:@"result"];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alerte"                                                                                     message:@"Infructueux." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:ok];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
//        forgetpasswdsecretcodeViewController *vc4 = [self.storyboard instantiateViewControllerWithIdentifier:@"forgetpasswdsecretcodeViewController"];
//        [self.navigationController pushViewController:vc4 animated:YES];
    }

}
-(void)forget_email:(id)sender
{
        }


- (IBAction)back_btn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
