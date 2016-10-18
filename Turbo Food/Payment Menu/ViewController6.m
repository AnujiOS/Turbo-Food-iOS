//
//  ViewController6.m
//  Turbo Food
//
//  Created by Ravi on 2/25/16.
//  Copyright (c) 2016 Ravi. All rights reserved.
//

#import "ViewController6.h"
#import "MFSideMenu.h"
#import "SlideMenuViewController.h"
#import "ViewController6TableCellTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ViewController7.h"
#import "ViewController5.h"
#import "ViewController2.h"
#import "WebServiceViewController.h"
#import "ViewController7.h"
#import "PaiementViewController.h"
#import "NotificationViewController.h"
#import "ViewController4.h"
#import "AIDEViewController.h"

@interface ViewController6 ()
{
    NSMutableArray *restroArry1;
    
    NSString *u_id;
    NSMutableDictionary *finaldic;
    NSString *grant_total;
    NSString *total;
    NSString *temp_id;
    NSMutableArray *arrTotals;
    NSMutableArray *restroArry2;
    NSString *tempery_id;
    NSMutableDictionary *dic2;
    NSArray *Arryy;
    NSMutableDictionary*dic;
    UIButton *btn;
    NSInteger *comm;
    NSString *comisson_val;
    NSString *favourite;
    NSString *fav_id;
    NSString *user_id;
    int i;
    int j;
    NSString *strWallet;
    NSString *strwithoutpoint;
    NSString *total_pri;
    int index;
    NSString *commission;
}

@end

@implementation ViewController6


#pragma  marl --> UITableview Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return restroArry1.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*CellIndentifier=@"Cell";
    
     ViewController6TableCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    if (cell == nil) {
        _btn_paymentcmd.enabled = NO;
        _btn_creditcard.enabled = NO;
        _btn_recharge.enabled = NO;
        _btn_especes.enabled = NO;
    }
    if(!cell){
        cell=[[ViewController6TableCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier];
    }
    cell.btn.tag= 100 + indexPath.row;
   [cell.btn addTarget:self action:@selector(btn_minorder:) forControlEvents:UIControlEventTouchUpInside];
    cell.menu_lbl.text =[[restroArry1 objectAtIndex:indexPath.row] valueForKey:@"sub_cat_name"] ;
    [cell.menu_img sd_setImageWithURL:[NSURL URLWithString:[[restroArry1 objectAtIndex:indexPath.row] valueForKey:@"sc_img"]] placeholderImage:[UIImage imageNamed:@"star_image.png"]];
    cell.menu_price.text = [[restroArry1 objectAtIndex:indexPath.row] valueForKey:@"g_total"];
    cell.euro.text = @"\u20ac";
    cell.btn.tag = indexPath.row;
   total = [[restroArry1 objectAtIndex:indexPath.row]valueForKey:@"g_total"];
    temp_id = [[restroArry1 objectAtIndex:indexPath.row]valueForKey:@"temp_id"];
    _btn_paymentcmd.enabled = YES;
    self.tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableview.indexPathsForVisibleRows == nil)
    {
        _btn_paymentcmd.enabled = NO;
        _btn_creditcard.enabled = NO;
        _btn_especes.enabled = NO;
        _btn_recharge.enabled = NO;
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.euro_1.text= @"\u20ac";
    self.euro_2.text = @"\u20ac";
    i=0;
    j=1;
    _btn_new_order.hidden = YES;
    _btn_recharge.enabled = NO;
    [self commison];
    [_btn_accueil setTitle:@"ACCUEIL" forState:UIControlStateNormal];
    [_btn_aide setTitle:@"AIDE" forState:UIControlStateNormal];
    self.tableview.allowsMultipleSelectionDuringEditing = NO;
     restroArry1 = [[NSMutableArray alloc]init];
     u_id = [[NSUserDefaults standardUserDefaults]stringForKey:@"u_id"];
     NSString *strurl =[NSString stringWithFormat:@"http://vps291033.ovh.net/turbofood//api.php?method=view_cart&u_id=%@",u_id];
        NSURL *url=[NSURL URLWithString:strurl];
        NSURLRequest *request=[NSURLRequest requestWithURL:url];
        NSData *respose = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString *json_string = [[NSString alloc]initWithData:respose encoding:NSUTF8StringEncoding];
        NSDictionary *allDataDictionary=[NSJSONSerialization JSONObjectWithData:respose options:kNilOptions error:nil];
   restroArry1=[[allDataDictionary objectForKey:@"result"]mutableCopy];
          for (dic  in restroArry1)
        {
    
            [finaldic setDictionary:dic];
    
            NSLog(@"Data : %@",dic);
            
        }
    
    NSString *pp =[NSString stringWithFormat:@"http://vps291033.ovh.net/turbofood//api.php?method=get_commission"];
    
    NSURL *url1=[NSURL URLWithString:pp];
    NSURLRequest *request1=[NSURLRequest requestWithURL:url1];
    NSData *respose1= [NSURLConnection sendSynchronousRequest:request1 returningResponse:nil error:nil];
    NSString *json_string1 = [[NSString alloc]initWithData:respose1 encoding:NSUTF8StringEncoding];
    NSDictionary *allDataDictionary1=[NSJSONSerialization JSONObjectWithData:respose1 options:kNilOptions error:nil];

    commission =[NSString stringWithFormat:@"%@",[allDataDictionary1 objectForKey:@"result"]];
    //self.euro_1.text = commission;
     NSString *strTotal =[NSString stringWithFormat:@"%@",_TotalPrize.text];
    [[NSUserDefaults standardUserDefaults]setObject:strTotal forKey:@"g_total"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:temp_id forKey:@"temp_id"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    // Do any additional setup after loading the view.
    
    arrTotals =[[NSMutableArray alloc] init];
    arrTotals =restroArry1;
    double totalprice = [commission doubleValue];
    for (int i=0; i<arrTotals.count; i++) {
        NSString *strcount = [[arrTotals objectAtIndex:i]valueForKey:@"g_total"];
        totalprice= totalprice+[strcount intValue];
    }
    _TotalPrize.text =[NSString stringWithFormat:@"%.02f",totalprice];
    NSString *totalprice1 = [NSString stringWithFormat:@"%@", _TotalPrize.text];
    [[NSUserDefaults standardUserDefaults]setObject:totalprice1 forKey:@"totalprice"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.tableview reloadData];
    fav_id = [NSString stringWithFormat:@"%d",i];
    [[NSUserDefaults standardUserDefaults]setObject:fav_id forKey:@"fav"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self addSegmentedControl];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isCreditcardClicked"];
    [[NSUserDefaults standardUserDefaults] synchronize];
     [_segment_controller setSelectedSegmentIndex:index];
    [self Walletebalances];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
}
- (IBAction)btn_minorder:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    restroArry2 = [[NSMutableArray alloc]init];
    tempery_id = [[restroArry1 objectAtIndex:btn.tag ] valueForKey:@"temp_id"];
    u_id = [[NSUserDefaults standardUserDefaults]stringForKey:@"u_id"];
    CGPoint touchPoint = [sender convertPoint:CGPointZero toView:self.tableview];
    NSIndexPath *indexPath = [self.tableview indexPathForRowAtPoint:touchPoint];
    [restroArry1 removeObjectAtIndex:indexPath.row];
    [self.tableview reloadData];
    if (self.tableview.indexPathsForVisibleRows.count == 0) {
        _btn_paymentcmd.enabled = NO;
    }
    
    [self deleteRecord];
    [self.tableview reloadData];
}

- (IBAction)sidemenuButton:(id)sender
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

- (IBAction)btn_aide_action:(id)sender {
    AIDEViewController *AIDE = [self.storyboard instantiateViewControllerWithIdentifier:@"AIDEViewController"];
    [self.navigationController pushViewController:AIDE animated:YES];
}

- (IBAction)paymentcmd_btn:(id)sender {
    
    NSString *min_comm = [[NSUserDefaults standardUserDefaults]
                              stringForKey:@"mini_order"];
    
    if ([_TotalPrize.text intValue] <= [min_comm intValue]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alerte"message:@"Votre panier ne dépasse pas le montant minimum de la commande pour ce restaurant."delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
    }
    else{
    ViewController7 *VC7 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController7"];
    [self.navigationController pushViewController:VC7 animated:YES];

    }
}
- (IBAction)new_order_btn:(id)sender
{
}

- (IBAction)btn_accueil:(id)sender
{
    ViewController2 *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController2"];
    [self.navigationController pushViewController:vc2 animated:YES];
}
-(void)deleteRecord
{
    NSMutableDictionary *dictResultSignIn=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *dicSubmit = [[NSMutableDictionary alloc]init];
    [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood//api.php";
    [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
    [WebServiceViewController wsVC].strMethodName = @"cart_menu_delete";
    [dicSubmit setObject:tempery_id forKey:@"temp_menu_id"];
    [dicSubmit setObject:u_id forKey:@"u_id"];
    dictResultSignIn = [[WebServiceViewController wsVC] sendRequestWithParameter:dicSubmit];
    
    if (dictResultSignIn != Nil || dictResultSignIn != NULL) {
        NSLog(@"dictResultSubmit = %@",dictResultSignIn);
        
        if ([[dictResultSignIn objectForKey:@"status"]integerValue] == 0)
        {
            double totalprice = [commission doubleValue];
            for (int i=0; i<arrTotals.count; i++) {
                NSString *strcount = [[arrTotals objectAtIndex:i]valueForKey:@"g_total"];
                totalprice= totalprice+[strcount intValue];
            }
            _TotalPrize.text =[NSString stringWithFormat:@"%.02f",totalprice ];
        }
        [self.tableview reloadData];
    }
    else
    {
        
    }
    
}

- (IBAction)btn_creditcard:(id)sender
{
   _btn_creditcard.tag = 100;
    [self changeState:sender];
}
- (IBAction)btn_recharge:(id)sender
{
    _btn_recharge.tag = 101;
    [self changeState:sender];
}

- (IBAction)btn_especes:(id)sender
{
    _btn_especes.tag=102;
    [self changeState:sender];
}
- (IBAction)changeState:(UIButton*)sender
{
    /* if we have multiple buttons, then we can
     differentiate them by tag value of button.*/
    // But note that you have to set the tag value before use this method.
    
    if([sender tag] == 100)
    {
        if ([sender isSelected])
        {
            [_btn_creditcard setImage: [UIImage imageNamed:@"right_green.png"] forState:UIControlStateNormal];
            [sender setSelected:NO];
            [_btn_especes setImage: [UIImage imageNamed:@"round_gray_image.png"] forState:UIControlStateNormal];
            [_btn_recharge setImage: [UIImage imageNamed:@"round_gray_image.png"] forState:UIControlStateNormal]
            ;
            _btn_paymentcmd.enabled = YES;
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isCreditcardClicked"];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"iselectricClicked"];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isrechargeClicked"];
            [[NSUserDefaults standardUserDefaults] synchronize];
         }
        else
        {
            [_btn_creditcard setImage:[UIImage imageNamed:@"round_gray_image.png"] forState:UIControlStateNormal];
            [sender setSelected:YES];
            [_btn_especes setImage: [UIImage imageNamed:@"right_green.png"] forState:UIControlStateNormal];
            [_btn_recharge setImage: [UIImage imageNamed:@"round_gray_image.png"] forState:UIControlStateNormal];
            _btn_paymentcmd.enabled = YES;
            
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isCreditcardClicked"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"iselectricClicked"];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isrechargeClicked"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }
    }
    if([sender tag] == 101)
    {
        
        if ([sender isSelected])
        {
            [_btn_recharge setImage:[UIImage imageNamed:@"round_gray_image.png"] forState:UIControlStateNormal];
            [sender setSelected:YES];
            [_btn_creditcard setImage: [UIImage imageNamed:@"round_gray_image.png"] forState:UIControlStateNormal];
            [_btn_especes setImage: [UIImage imageNamed:@"round_gray_image.png"] forState:UIControlStateNormal];
            
        }
        else
        {
            {
            [_btn_recharge setImage: [UIImage imageNamed:@"right_green.png"] forState:UIControlStateNormal];
            [sender setSelected:NO];
            [_btn_creditcard setImage: [UIImage imageNamed:@"round_gray_image.png"] forState:UIControlStateNormal];
            [_btn_especes setImage: [UIImage imageNamed:@"round_gray_image.png"] forState:UIControlStateNormal];
            
            
            _btn_paymentcmd.enabled = YES;
            }

            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isCreditcardClicked"];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"iselectricClicked"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isrechargeClicked"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self Walletebalances];
                    
                });
            });

        }
    }
    if([sender tag] == 102)
    {
        
        if ([sender isSelected])
        {
            [_btn_especes setImage:[UIImage imageNamed:@"round_gray_image.png"] forState:UIControlStateNormal];
            [sender setSelected:YES];
            [_btn_creditcard setImage: [UIImage imageNamed:@"right_green.png"] forState:UIControlStateNormal];
            [_btn_recharge setImage: [UIImage imageNamed:@"round_gray_image.png"] forState:UIControlStateNormal];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isCreditcardClicked"];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"iselectricClicked"];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isrechargeClicked"];
            [[NSUserDefaults standardUserDefaults] synchronize];


        }
        else
        {
            [_btn_especes setImage: [UIImage imageNamed:@"right_green.png"] forState:UIControlStateNormal];
            [sender setSelected:NO];
            [_btn_creditcard setImage: [UIImage imageNamed:@"round_gray_image.png"] forState:UIControlStateNormal];
            [_btn_recharge setImage: [UIImage imageNamed:@"round_gray_image.png"] forState:UIControlStateNormal];
            _btn_paymentcmd.enabled = YES;

            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isCreditcardClicked"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"iselectricClicked"];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isrechargeClicked"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        
        }
    }
}


-(void)Walletebalances
{
    NSString *u_id2 = [[NSUserDefaults standardUserDefaults]
             stringForKey:@"u_id"];
    
   total_pri =[[NSUserDefaults standardUserDefaults]
stringForKey:@"totalprice"];
    
    NSMutableDictionary *dictResultSignIn=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *dicSubmit = [[NSMutableDictionary alloc]init];
    [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood//api.php";
    [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
    [WebServiceViewController wsVC].strMethodName = @"wallet_user";
    
    [dicSubmit setObject:u_id2 forKey:@"user_id"];
    dictResultSignIn = [[WebServiceViewController wsVC] sendRequestWithParameter:dicSubmit];
    
    if (dictResultSignIn != Nil || dictResultSignIn != NULL) {
        NSLog(@"dictResultSubmit = %@",dictResultSignIn);
        
        if ([[dictResultSignIn objectForKey:@"status"]integerValue] == 0)
        {
           strWallet  = [dictResultSignIn objectForKey:@"result"];
            strwithoutpoint =[NSString stringWithFormat:@"%d",[strWallet intValue]];
            [[NSUserDefaults standardUserDefaults]setObject:strwithoutpoint forKey:@"wallet"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[NSUserDefaults standardUserDefaults]setObject:total_pri forKey:@"Wallet_balance"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            if ([strwithoutpoint intValue]>[total_pri intValue])
            {
                self.btn_paymentcmd.enabled=YES;
            }
            else
            {
                self.btn_paymentcmd.enabled=NO;
            }
            
        }
        else
        {
            
        }
        
        
    }
    
}


-(void)RestorantPayTypeMethod
{
    NSString *restorant_id = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"Restorant_id"];
    NSMutableDictionary *dictResultSignIn=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *dicSubmit = [[NSMutableDictionary alloc]init];
    [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood//api.php";
    [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
    [WebServiceViewController wsVC].strMethodName = @"rest_pay_type";
    [dicSubmit setObject:restorant_id forKey:@"rest_id"];
    dictResultSignIn = [[WebServiceViewController wsVC] sendRequestWithParameter:dicSubmit];
    
    if (dictResultSignIn != Nil || dictResultSignIn != NULL) {
        
        if ([[dictResultSignIn objectForKey:@"status"]integerValue] == 0)
        {
            
            NSString *strcreditcard =[NSString stringWithFormat:@"%@",[[dictResultSignIn objectForKey:@"result"] valueForKey:@"credit_card"]];
            
            NSString *strespeces =[NSString stringWithFormat:@"%@",[[dictResultSignIn objectForKey:@"result"] valueForKey:@"especes"]];
            
            if ([strcreditcard isEqualToString:@"0"])
            {
                self.btn_creditcard.enabled=NO;
            }
            else
            {
                self.btn_creditcard.enabled=YES;
            }
            
            if ([strespeces isEqualToString:@"1"])
            {
                self.btn_especes.enabled=YES;
            }
            else
            {
                self.btn_especes.enabled=NO;
            }
                
        }
        else
        {
            
        }
        
        
    }
    
}
-(void)commison
{
    NSMutableDictionary *dictResultSignIn=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *dicSubmit = [[NSMutableDictionary alloc]init];
    [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood//api.php";
    [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
    [WebServiceViewController wsVC].strMethodName = @"get_commission";
    dictResultSignIn = [[WebServiceViewController wsVC] sendRequestWithParameter:dicSubmit];
    
    if (dictResultSignIn != Nil || dictResultSignIn != NULL) {
        
        if ([[dictResultSignIn objectForKey:@"status"]integerValue] == 0)
        {
            comisson_val = [NSString stringWithFormat:@"%@",[dictResultSignIn valueForKey:@"result"]];
            self.restro_comission.text = comisson_val;
            comm = [comisson_val integerValue];
        }
    }
}
- (IBAction)order_fav_btn:(id)sender {
    
    if ([sender isSelected])
    {
        fav_id = [NSString stringWithFormat:@"%d",i];
      
        [_order_fav setImage:[UIImage imageNamed:@"star_image.png"] forState:UIControlStateNormal ];
        [sender setSelected:NO];
    }
    else
    {
        if ([favourite isEqualToString:@"1"])
        {
            fav_id = [NSString stringWithFormat:@"%d",i];
           
            [_order_fav setImage:[UIImage imageNamed:@"star_image.png"] forState:UIControlStateNormal ];
            
        }
        else
        {
            fav_id = [NSString stringWithFormat:@"%d",j];
          
            [_order_fav setImage: [UIImage imageNamed:@"selected_star_image.png"] forState:UIControlStateNormal];
            [sender setSelected:YES];
        }
    }
    [[NSUserDefaults standardUserDefaults]setObject:fav_id forKey:@"fav"];
    [[NSUserDefaults standardUserDefaults] synchronize];

   }
-(void)fav_order
{

    u_id = [[NSUserDefaults standardUserDefaults]
            stringForKey:@"u_id"];
    NSMutableDictionary *dictResultSignIn=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *dicSubmit = [[NSMutableDictionary alloc]init];
    [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood//api.php";
    
    [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
    [WebServiceViewController wsVC].strMethodName = @"menu_favorite";
    
    [dicSubmit setObject:u_id forKey:@"u_id"];
    dictResultSignIn = [[WebServiceViewController wsVC] sendRequestWithParameter:dicSubmit];
    if (dictResultSignIn != Nil || dictResultSignIn != NULL)
    {
        [[self tableview] reloadData];
    }
}

- (IBAction)btn_home:(id)sender {
//    ViewController2 *VC4 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController2"];
//    [self.navigationController pushViewController:VC4 animated:YES];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Abandoner le paiement ?"message:@"En allant sur cette page, vous perdrez les informations du panier ..."delegate:self cancelButtonTitle:@"Annuler" otherButtonTitles:@"OK",nil];
    alert.tag = 103;
    [alert show];
    
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
                ViewController2 *VC4 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController2"];
                [self.navigationController pushViewController:VC4 animated:YES];
                
            }
        }
    }
}



- (IBAction)bell_btn:(id)sender {
    ViewController4 *vc4 =
    [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController4"];
    [self.navigationController pushViewController:vc4 animated:YES];
    
}

- (void) addSegmentedControl {
    
   
    NSArray * segmentItems = [NSArray arrayWithObjects: @"Carte de credit", @"Espèces", nil];
    _segment_controller = [[UISegmentedControl alloc] initWithItems: segmentItems];
    _segment_controller.segmentedControlStyle = UISegmentedControlStyleBar;
   _segment_controller.frame = CGRectMake(0,160,321,29);
       _segment_controller.selectedSegmentIndex = 0;
    [_segment_controller addTarget: self action: @selector(SegmentToggle:) forControlEvents: UIControlEventValueChanged];//219,112,147
    UIColor *selectedColor = [UIColor colorWithRed: 219/255.0 green:112/255.0 blue:147/255.0 alpha:1.0];
    UIColor *deselectedColor = [UIColor colorWithRed: 128/255.0 green:128/255.0 blue:128/255.0 alpha:1.0];
    
    for (UIControl *subview in [_segment_controller subviews]) {
        if ([subview isSelected])
            [subview setTintColor:selectedColor];
        else
            [subview setTintColor:selectedColor];
    }
    //self.navigationItem.titleView = _segment_controller;
    [self SegmentToggle:_segment_controller];
    [self.view addSubview:_segment_controller];
    
}

- (IBAction)SegmentToggle:(UISegmentedControl *)sender {
    
        // lazy load data for a segment choice (write this based on your data)
    if (sender.selectedSegmentIndex == 0)
    {
        _segment_controller.selectedSegmentIndex = 0;
        index = 0;
       
        //[[sender.subviews objectAtIndex:0]backgroundColor:[UIColor greenColor]];
       
       
       // [[sender.subviews objectAtIndex:1] setTintColor:[UIColor whiteColor]];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isCreditcardClicked"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"iselectricClicked"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isrechargeClicked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else if(sender.selectedSegmentIndex == 1)
    {
        _segment_controller.selectedSegmentIndex = 1;
        index = 1;
       
        //[[sender.subviews objectAtIndex:1]backgroundColor:[UIColor greenColor]];
        
       
        [self Walletebalances];
        NSString *wallet =[[NSUserDefaults standardUserDefaults]
                           stringForKey:@"wallet"];
     //   NSString *total_price = [NSString stringWithFormat:@"%d",[_TotalPrize.text intValue ]];
           // if ([total_price intValue] <= [wallet intValue]  && [wallet isEqualToString:@"20"])
        if ([wallet isEqualToString:@"20"])
        {
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isCreditcardClicked"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"iselectricClicked"];
             [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isrechargeClicked"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else{
             _btn_paymentcmd.enabled = NO;
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alerte"message:@"Vous devez déposer 20 euros de caution pour pouvoir effectuer vos paiements en espèces."delegate:self cancelButtonTitle:@"Annuler" otherButtonTitles:@"Charger",nil];
            alert.tag = 101;
            _segment_controller.selectedSegmentIndex = 0;
           
            [alert show];
           
        }
        
    }
          [self.tableview reloadData];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 101) {
        // from YES button
        if (buttonIndex == 1) {
            PaiementViewController *VC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"PaiementViewController"];
            [self.navigationController pushViewController:VC2 animated:YES];
        }
        else{
                   }
    }
    else if (alertView.tag == 102) {
        // from NO button
        _segment_controller.selectedSegmentIndex = 0;
       
    }
    else if (alertView.tag == 103){
        
            // from YES button
            if (buttonIndex == 1) {
              
                [self profile];
            }
            else{

            }
        }

    }


@end


