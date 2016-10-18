//
//  ViewController4.m
//  Turbo Food
//
//  Created by Ravi on 2/23/16.
//  Copyright (c) 2016 Ravi. All rights reserved.
//

#import "ViewController4.h"
#import "MFSideMenu.h"
#import "SlideMenuViewController.h"
#import "UIImageView+WebCache.h"
#import "ViewController4TableCell.h"
#import "ViewController5.h"
#import "ViewController2.h"
#import "NotificationViewController.h"
#import "WebServiceViewController.h"
#import "ViewController6.h"

@interface ViewController4 ()
{
    int row;
    NSMutableArray *restroArry;
    NSMutableDictionary *restore;
    NSString *cat_name;
    NSString *strr_id;
    NSMutableDictionary *restroArry1;
    NSString *favourite;
    int i;
    int j;
    NSMutableArray *fav_arry;
    NSString *fav;
    NSString *fav_id;
    NSString *u_id;
    NSString *user_id;
    NSString *cart_nmuber;
}

@end

@implementation ViewController4

static NSString *simpleTableIdentifier = @"SimpleTableItem";

- (void)viewDidLoad {
    [super viewDidLoad];
    i = 0;
    j= 1;
    if ([self.flag isEqualToString:@"Favrit"])
    {
        restroArry = [[NSMutableArray alloc]init];
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"resttttt_id"];
        restroArry1 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        _restro_lbl.text = [restroArry1 valueForKey:@"r_name"];
        [_restro_img sd_setImageWithURL:[NSURL URLWithString:[restroArry1 valueForKey:@"img_full"]]placeholderImage:[UIImage imageNamed:@"star_image.png"]];
        NSString *desc = [restroArry1 valueForKey:@"descc"];
        [[NSUserDefaults standardUserDefaults] setObject:desc forKey:@"descc"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        _restro_details.text = [restroArry1 valueForKey:@"descc"];
        UIImage *image1 = [UIImage imageNamed:@"star_image.png"];
        UIImage *image2 = [UIImage imageNamed:@"selected_star_image.png"];
        NSString *f_star = [[NSUserDefaults standardUserDefaults]stringForKey:@"fav_fav"];
        
        if ([f_star isEqualToString:@"1"]) {
            NSString *value = @"1";
            [[NSUserDefaults standardUserDefaults] setObject:value forKey:@"fav_star"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        if ([f_star isEqualToString:@"0"])
        {
            [_fav_btn setImage:image1 forState:UIControlStateNormal];
            
        }
        else if([f_star isEqualToString:@"1"])
        {
            [_fav_btn setImage:image2 forState:UIControlStateNormal];
            
        }
        // Getting restro ID
        
        [[NSUserDefaults standardUserDefaults] setObject:strr_id forKey:@"id"];
        [[NSUserDefaults standardUserDefaults] synchronize];
         NSString *reeee = [[NSUserDefaults standardUserDefaults]stringForKey:@"favr_id"];
        NSString *strurl =[NSString stringWithFormat:@"http://vps291033.ovh.net/turbofood//api.php?method=view_category&r_id=%@",reeee];
        NSURL *url=[NSURL URLWithString:strurl];
        NSURLRequest *request=[NSURLRequest requestWithURL:url];
        NSData *respose = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSDictionary *allDataDictionary=[NSJSONSerialization JSONObjectWithData:respose options:kNilOptions error:nil];
        restroArry=[allDataDictionary objectForKey:@"result"];

        self.receiveArray11= restroArry1;
        
    }
    else if ([self.flag_option isEqualToString:@"fav_back"]){//fav_back
        restroArry = [[NSMutableArray alloc]init];
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"Menuuu"];
        restroArry1 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        _restro_lbl.text = [restroArry1 valueForKey:@"r_name"];
        [_restro_img sd_setImageWithURL:[NSURL URLWithString:[restroArry1 valueForKey:@"rest_img_full"]]placeholderImage:[UIImage imageNamed:@"star_image.png"]];
        NSString *desc = [restroArry1 valueForKey:@"descc"];
        [[NSUserDefaults standardUserDefaults] setObject:desc forKey:@"descc"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        _restro_details.text = [restroArry1 valueForKey:@"descc"];
        UIImage *image1 = [UIImage imageNamed:@"star_image.png"];
        UIImage *image2 = [UIImage imageNamed:@"selected_star_image.png"];
        //NSString *f_star = [[NSUserDefaults standardUserDefaults]stringForKey:@"fav_fav"];
        NSString *f_star = [restroArry1 valueForKey:@"rest_fav"];
        if ([f_star isEqualToString:@"1"]) {
            NSString *value = @"1";
            [[NSUserDefaults standardUserDefaults] setObject:value forKey:@"fav_star"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        if ([f_star isEqualToString:@"0"])
        {
            [_fav_btn setImage:image1 forState:UIControlStateNormal];
            
        }
        else if([f_star isEqualToString:@"1"])
        {
            [_fav_btn setImage:image2 forState:UIControlStateNormal];
            
        }
        // Getting restro ID
        
        [[NSUserDefaults standardUserDefaults] setObject:strr_id forKey:@"id"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        //NSString *reeee = [[NSUserDefaults standardUserDefaults]stringForKey:@"favr_id"];
        NSString *reeee = [restroArry1 valueForKey:@"r_id"];
        NSString *strurl =[NSString stringWithFormat:@"http://vps291033.ovh.net/turbofood//api.php?method=view_category&r_id=%@",reeee];
        NSURL *url=[NSURL URLWithString:strurl];
        NSURLRequest *request=[NSURLRequest requestWithURL:url];
        NSData *respose = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSDictionary *allDataDictionary=[NSJSONSerialization JSONObjectWithData:respose options:kNilOptions error:nil];
        restroArry=[allDataDictionary objectForKey:@"result"];
        
        self.receiveArray11= restroArry1;
    }
    else
    {
        retrievedmy4Dic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"View4Dic"];
        if (retrievedmy4Dic == nil) {
            strr_id = [[NSUserDefaults standardUserDefaults]stringForKey:@"resto_id"];
            NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"Menuuu"];
            restroArry1 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            _restro_lbl.text = [restroArry1 valueForKey:@"r_name"];
            [_restro_img sd_setImageWithURL:[NSURL URLWithString:[restroArry1 valueForKey:@"rest_img_full"]]placeholderImage:[UIImage imageNamed:@"star_image.png"]];
            NSString *desc = [restroArry1 valueForKey:@"descc"];
            [[NSUserDefaults standardUserDefaults] setObject:desc forKey:@"descc"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            _restro_details.text = [restroArry1 valueForKey:@"descc"];
            UIImage *image1 = [UIImage imageNamed:@"star_image.png"];
            UIImage *image2 = [UIImage imageNamed:@"selected_star_image.png"];
            //NSString *f_star = [[NSUserDefaults standardUserDefaults]stringForKey:@"fav_fav"];
            NSString *f_star = [restroArry1 valueForKey:@"rest_fav"];
            //        if ([f_star isEqualToString:@"1"]) {
            //            NSString *value = @"1";
            //            [[NSUserDefaults standardUserDefaults] setObject:value forKey:@"fav_star"];
            //            [[NSUserDefaults standardUserDefaults] synchronize];
            //        }
            if ([f_star isEqualToString:@"0"])
            {
                [_fav_btn setImage:image1 forState:UIControlStateNormal];
                
            }
            else if([f_star isEqualToString:@"1"])
            {
                [_fav_btn setImage:image2 forState:UIControlStateNormal];
                
            }
            // Getting restro ID
            
            [[NSUserDefaults standardUserDefaults] setObject:strr_id forKey:@"id"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            //NSString *reeee = [[NSUserDefaults standardUserDefaults]stringForKey:@"favr_id"];
            NSString *reeee = [restroArry1 valueForKey:@"r_id"];
            NSString *strurl =[NSString stringWithFormat:@"http://vps291033.ovh.net/turbofood//api.php?method=view_category&r_id=%@",reeee];
            NSURL *url=[NSURL URLWithString:strurl];
            NSURLRequest *request=[NSURLRequest requestWithURL:url];
            NSData *respose = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            NSDictionary *allDataDictionary=[NSJSONSerialization JSONObjectWithData:respose options:kNilOptions error:nil];
            restroArry=[allDataDictionary objectForKey:@"result"];
            
            self.receiveArray11= restroArry1;

        }
        else{
            _receiveArray11 =retrievedmy4Dic;
            row=1;
            restroArry = [[NSMutableArray alloc]init];
            strr_id =[self.receiveArray11 valueForKey:@"id"];
            NSString *strurl =[NSString stringWithFormat:@"http://vps291033.ovh.net/turbofood//api.php?method=view_category&r_id=%@",strr_id];
            NSURL *url=[NSURL URLWithString:strurl];
            NSURLRequest *request=[NSURLRequest requestWithURL:url];
            NSData *respose = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            NSDictionary *allDataDictionary=[NSJSONSerialization JSONObjectWithData:respose options:kNilOptions error:nil];
            restroArry=[allDataDictionary objectForKey:@"result"];
            _restro_lbl.text = [_receiveArray11 valueForKey:@"r_name"];
            [_restro_img sd_setImageWithURL:[NSURL URLWithString:[_receiveArray11 valueForKey:@"img_full"]]placeholderImage:[UIImage imageNamed:@"star_image.png"]];
            NSString *desc = [[NSUserDefaults standardUserDefaults]
                              stringForKey:@"descc"];
            _restro_details.text = [_receiveArray11 valueForKey:@"descc"];
            UIImage *image1 = [UIImage imageNamed:@"star_image.png"];
            UIImage *image2 = [UIImage imageNamed:@"selected_star_image.png"];
            NSString *f_star = [[NSUserDefaults standardUserDefaults]stringForKey:@"fav_star"];
            if ([f_star isEqualToString:@"0"])
            {
                [_fav_btn setImage:image1 forState:UIControlStateNormal];
                
            }
            else if([f_star isEqualToString:@"1"])
            {
                [_fav_btn setImage:image2 forState:UIControlStateNormal];
                
            }
            // Getting restro ID
            [[NSUserDefaults standardUserDefaults] setObject:strr_id forKey:@"id"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }

        }
       
        
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma  marl --> UITableview Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return [restroArry count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*CellIndentifier=@"Cell";
    ViewController4TableCell *cell=[self.tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    
    if(!cell){
        cell=[[ViewController4TableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier];
    }

    cell.categories_lbl.text = [[restroArry objectAtIndex:indexPath.row]objectForKey:@"cat_name"];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    return cell;
        
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strre_id =[NSString stringWithFormat:@"%@",[[restroArry objectAtIndex:indexPath.row] objectForKey:@"r_id"]];
    NSString *strca_id =[NSString stringWithFormat:@"%@",[[restroArry objectAtIndex:indexPath.row] objectForKey:@"id"]];
    cat_name = [NSString stringWithFormat:@"%@",[[restroArry objectAtIndex:indexPath.row]objectForKey:@"cat_name"]];
    [[NSUserDefaults standardUserDefaults] setObject:strre_id forKey:@"restorantNo"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject:strca_id forKey:@"CatagoryNo"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject:cat_name forKey:@"CatagoryName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    ViewController5 *VC5 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController5"];
    VC5.receiveArray111 = self.receiveArray11;
    VC5.strre_id = strre_id;
    VC5.strca_id= strca_id;
    [VC5.array addObject:_receiveArray11];
    VC5.restro_lbl.text = _restro_lbl.text;
    VC5.cat_name = cat_name;
    [self.navigationController pushViewController:VC5 animated:YES];
}
-(void) viewWillAppear:(BOOL)animated
{
    [[NSUserDefaults standardUserDefaults] setObject:[restroArry1 valueForKey:@"rest_img_full"]forKey:@"resto_i"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)rightScroll:(UIButton *)sender
{
}

- (IBAction)leftScroll:(UIButton *)sender
{

}
- (IBAction)sideMenu:(id)sender
{
     [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}
- (IBAction)fav_btn:(id)sender
{
    
    
    fav = [_receiveArray11 valueForKey:@"id"];
    
    favourite = [_receiveArray11 valueForKey:@"favourite"];
    if ([sender isSelected])
    {
        fav_id = [NSString stringWithFormat:@"%d",i];
        [_fav_btn setImage:[UIImage imageNamed:@"star_image.png"] forState:UIControlStateNormal ];
        [sender setSelected:NO];
        [self favoris];
        
    }
    else
    {
        if ([favourite isEqualToString:@"1"])
        {
            fav_id = [NSString stringWithFormat:@"%d",i];
            [_fav_btn setImage:[UIImage imageNamed:@"star_image.png"] forState:UIControlStateNormal ];
            [self favoris];
        }
        else
        {
            // [self.tableView reloadData];
            fav_id = [NSString stringWithFormat:@"%d",j];
            [_fav_btn setImage: [UIImage imageNamed:@"selected_star_image.png"] forState:UIControlStateNormal];
            [sender setSelected:YES];
            [self favoris];
        }
//        [[NSUserDefaults standardUserDefaults]setObject:fav_id forKey:@"fav_star"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
    }




}
-(void)favoris
{
    u_id = [[NSUserDefaults standardUserDefaults]
            stringForKey:@"u_id"];
    NSMutableDictionary *dictResultSignIn=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *dicSubmit = [[NSMutableDictionary alloc]init];
    [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood//api.php";
    
    [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
    [WebServiceViewController wsVC].strMethodName = @"rest_favorite";
    
    [dicSubmit setObject:u_id forKey:@"u_id"];
    [dicSubmit setObject:fav forKey:@"rest_id"];
    [dicSubmit setObject:fav_id forKey:@"fav"];
    
    NSLog(@"DicSubmit = %@",dicSubmit);
    
    dictResultSignIn = [[WebServiceViewController wsVC] sendRequestWithParameter:dicSubmit];
    
    if (dictResultSignIn != Nil || dictResultSignIn != NULL)
    {
        NSLog(@"dictResultSubmit = %@",dictResultSignIn);
        NSLog(@"My Sending Dic :%@",[dictResultSignIn objectForKey:@"message"]);
        NSLog(@"My Sending Dic :%@",[dictResultSignIn objectForKey:@"result"]);
        
        
        fav_id = [NSString stringWithFormat:@"%@",[dictResultSignIn valueForKey:@"result"]];
        [[NSUserDefaults standardUserDefaults]setObject:[dictResultSignIn objectForKey:@"result"] forKey:@"fav_star"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[self tableView] reloadData];
        
        // [self tabledisplay];
    }
}

- (IBAction)btn_home:(id)sender
{
    [self cart];
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Abandoner le paiement ?"message:@"Si vous retournez au panier, vous perdrez les informations saisies."delegate:self cancelButtonTitle:@"Annuler" otherButtonTitles:@"OK",nil];
//     alert.tag = 101;
//    [alert show];
    
    
   }


-(void)cart_no
{
    [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    
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
    
    [MBProgressHUD hideHUDForView:self.tableView animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 101) {
        // from YES button
        if (buttonIndex == 1)
        {
                    [self profile];
            
        }
        else{
        }
    }
    else if (alertView.tag == 102) {
        // from NO button
       // _segment_controller.selectedSegmentIndex = 0;
       

        
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
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Abandoner le paiement ?"message:@"En allant sur cette page, vous perdrez les informations du panier ...."delegate:self cancelButtonTitle:@"Annuler" otherButtonTitles:@"OK",nil];
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
                ViewController2 *VC4 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController2"];
                [self.navigationController pushViewController:VC4 animated:YES];
                
            }
        }
    }
}
- (IBAction)bell_btn:(id)sender {
    NotificationViewController *vc4 =
    [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationViewController"];
      [self.navigationController pushViewController:vc4 animated:YES];
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

@end
