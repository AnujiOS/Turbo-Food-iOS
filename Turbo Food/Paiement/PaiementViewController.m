//
//  PaiementViewController.m
//  Turbo Food
//
//  Created by ganesh on 3/23/16.
//  Copyright © 2016 Ravi. All rights reserved.
//

#import "PaiementViewController.h"
#import "MFSideMenu.h"
#import "WebServiceViewController.h"
#import "ViewController2.h"
#import "ViewController6.h"
#import "PaiementTableViewCell.h"
#import "LoginViewController.h"
#import "NotificationViewController.h"

@interface PaiementViewController ()
{
    NSString *u_id;
    NSString *email;
    NSString *recharge;
    NSString *u_id1;
    NSString *u_id2;
    NSString *user_id;
    NSMutableArray *user_payment;

    NSString *user_id0;
    NSString *cart_nmuber;
}

@end

@implementation PaiementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    u_id1 = [[NSUserDefaults standardUserDefaults]
            stringForKey:@"u_id"];
    self.webview.hidden = YES;
    self.close_btn_webview.hidden = YES;
    _btn_recharge.enabled = NO;
    _textfield_rech.delegate = self;
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    _textfield_rech.inputAccessoryView = numberToolbar;
    [self user_payment_histroy];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self wallet_user];
    int i = 20;
    NSString *stt = [NSString stringWithFormat:@"%d",i];
    if (_credit_rech.text == stt )
    {
        _btn_recharge.enabled = NO;
        _textfield_rech.text = @"0";
        _textfield_rech.enabled = NO;
    }
    else
    {
        int j = [_credit_rech.text intValue];
        int z = i - j;
        NSString *str = [NSString stringWithFormat:@"%d",z];
        _textfield_rech.enabled = NO;
        _textfield_rech.text = str;
        
        _btn_recharge.enabled = YES;
    }
    if ([_textfield_rech.text isEqualToString:@"0"]) {
        _btn_recharge.enabled = NO;
    }
}

-(void)wallet_user
{
    u_id2 = [[NSUserDefaults standardUserDefaults]
             stringForKey:@"u_id"];
    
    NSMutableDictionary *dictResultSignIn=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *dicSubmit = [[NSMutableDictionary alloc]init];
    [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood//api.php";
    [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
    [WebServiceViewController wsVC].strMethodName = @"wallet_user";
    [dicSubmit setObject:u_id2 forKey:@"user_id"];
    dictResultSignIn = [[WebServiceViewController wsVC] sendRequestWithParameter:dicSubmit];
    if (dictResultSignIn != Nil || dictResultSignIn != NULL) {
        if ([[dictResultSignIn objectForKey:@"status"]integerValue] == 0)
        {
            _credit_rech.text = [dictResultSignIn objectForKey:@"result"];
            NSString *strWallet =[NSString stringWithFormat:@"%@",_credit_rech.text];
            [[NSUserDefaults standardUserDefaults]setObject:strWallet forKey:@"Wallet_balance"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else
        {
            
        }
        
    }

}

-(void)cancelNumberPad{
    [_textfield_rech resignFirstResponder];
    _textfield_rech.text = @"";
}

-(void)doneWithNumberPad
{
  //  NSString *numberFromTheKeyboard = _textfield_rech.text;
    [_textfield_rech resignFirstResponder];
    _btn_recharge.enabled = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)btn_home:(id)sender {
    [self cart];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 101) {
        // from YES button
        if (buttonIndex == 1) {
                     [self profile];
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

-(void)profile
{
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


- (IBAction)btn_exit:(id)sender {
    LoginViewController *lv = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];   
    [self.navigationController pushViewController:lv animated:YES];
}

- (IBAction)menu_btn:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

- (IBAction)btn_recharge:(id)sender
{
    recharge = [NSString stringWithFormat:@"%@",_textfield_rech.text];
    self.menu_btn.enabled = NO;
    self.webview.hidden = NO;
    self.close_btn_webview.hidden = NO;
    self.webview.layer.cornerRadius = 15;
    self.webview.layer.borderWidth=10;
    self.webview.layer.borderColor =[UIColor colorWithRed:239.0f/256.0f green:71.0f/256.0f blue:131.0f/256.0f alpha:1].CGColor;
    self.webview.layer.masksToBounds = YES;
    u_id = [[NSUserDefaults standardUserDefaults]
            stringForKey:@"u_id"];
    email =[[NSUserDefaults standardUserDefaults]
            stringForKey:@"email"];
    NSString *urlString = [NSString stringWithFormat:@"http://vps291033.ovh.net/turbofood//wallet/test_redirect.php?pb_email=%@&pb_tot=%@&u_id=%@",email,recharge,u_id];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webview loadRequest:urlRequest];
    
}

- (IBAction)close_btn_webview:(id)sender {
    
    self.webview.hidden = YES;
    self.close_btn_webview.hidden = YES;
    self.menu_btn.enabled = YES;
    self.btn_recharge.enabled=NO;
    [self viewWillAppear:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return user_payment.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*CellIndentifier=@"Cell";
        PaiementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
       if(!cell){
        cell=[[PaiementTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier];
    }
    cell.history_date.text = [[user_payment objectAtIndex:indexPath.row] valueForKey:@"date"] ;
    cell.order_name.text =[[user_payment objectAtIndex:indexPath.row] valueForKey:@"r_name"] ;
    cell.payment_type.text =[[user_payment objectAtIndex:indexPath.row] valueForKey:@"trans_type"] ;
    cell.price.text =[[user_payment objectAtIndex:indexPath.row] valueForKey:@"g_total"] ;
    self.tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
-(void)user_payment_histroy
{
    user_payment = [[NSMutableArray alloc]init];
    user_id = [[NSUserDefaults standardUserDefaults]
             stringForKey:@"u_id"];
    NSMutableDictionary *dictResultSignIn=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *dicSubmit = [[NSMutableDictionary alloc]init];
    [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood//api.php";
    [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
    [WebServiceViewController wsVC].strMethodName = @"user_payment_history";
    
    [dicSubmit setObject:user_id forKey:@"u_id"];
    dictResultSignIn = [[WebServiceViewController wsVC] sendRequestWithParameter:dicSubmit];
    
    if (dictResultSignIn != Nil || dictResultSignIn != NULL) {
        
        if ([[dictResultSignIn objectForKey:@"status"]integerValue] == 0)
        {
            NSDictionary *resposne = [dictResultSignIn objectForKey:@"result"];
            for (NSDictionary*dic in resposne)
                [user_payment addObject:dic];
                [[self tableview]reloadData];
            }
        }
        else
        {
        }
    }
- (IBAction)cart_btn:(id)sender {
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
    [MBProgressHUD showHUDAddedTo:self.tableview animated:YES];
    
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
    
    [MBProgressHUD hideHUDForView:self.tableview animated:YES];
}



@end
