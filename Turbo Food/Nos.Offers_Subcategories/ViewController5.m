//
//  ViewController5.m
//  Turbo Food
//
//  Created by Ravi on 2/23/16.
//  Copyright (c) 2016 Ravi. All rights reserved.
//

#import "ViewController5.h"
#import "MFSideMenu.h"
#import "SlideMenuViewController.h"
#import "ViewController5TableCell.h"
#import "UIImageView+WebCache.h"
#import "ViewController2.h"
#import "ViewController4.h"
#import "WebServiceViewController.h"
#import "NotificationViewController.h"
#import "ViewController6.h"
#import "AIDEViewController.h"


@interface ViewController5 ()
{
    long selectedrow;
    NSMutableArray *fav_arry;
    NSString *menu_id;
    NSString *favourite;
    UIButton *btn1;
    int i;
    int j;
    NSString *fav_id;
    NSString *u_id;
    NSString *resto_id;
    NSString *favourite_resto;
    NSString *user_id;
    NSString *cart_nmuber;
    NSString *u_id0;
}

@end

@implementation ViewController5
{
    NSMutableArray *restroArry;

}

#pragma  marl --> UITableview Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return [restroArry count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*CellIndentifier=@"Cell";
    
    ViewController5TableCell *cell = [self.tableOffers dequeueReusableCellWithIdentifier:CellIndentifier];
    
    if(!cell){
        cell=[[ViewController5TableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier];
    }

    cell.sub_cat_name_lbl.text = [[restroArry objectAtIndex:indexPath.row]objectForKey:@"sub_cat_name"];
    cell.sc_descr_lbl.text = [[restroArry objectAtIndex:indexPath.row]objectForKey:@"sc_descr"];
    [cell.sc_img sd_setImageWithURL:[NSURL URLWithString:[[restroArry objectAtIndex:indexPath.row] objectForKey:@"img_full"]]placeholderImage:[UIImage imageNamed:@"star_image.png"]];
    cell.price_lbl.text = [[restroArry objectAtIndex:indexPath.row]objectForKey:@"price"];
    cell.euro.text = @"\u20ac";
    UIImage *image1 = [UIImage imageNamed:@"star_image.png"];
    UIImage *image2 = [UIImage imageNamed:@"selected_star_image.png"];
    NSString *favc = [[restroArry objectAtIndex:indexPath.row]valueForKey:@"favourite"];
    if ([favc isEqualToString:@"1"])
    {
        [cell.btn_favour setImage:image2 forState:UIControlStateNormal];
    }
    else
    {
        [cell.btn_favour setImage:image1 forState:UIControlStateNormal];

    }
    self.tableOffers.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
     return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   [_tableOffers deselectRowAtIndexPath:indexPath animated:YES];
    NSArray * menu = [[NSArray alloc]init];
    menu = [restroArry objectAtIndex:indexPath.row];
    NSString *menu_id = [menu valueForKey:@"id"];
    NSString *cate_id = [menu valueForKey:@"cat_id"];
    NSString *menu_fav = [menu valueForKey:@"favourite"];
    [[NSUserDefaults standardUserDefaults] setObject:menu_fav forKey:@"Menu_fav"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject:menu_id forKey:@"menu_id"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject:cate_id forKey:@"cate_id"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    selectedrow =indexPath.row;
    [self performSegueWithIdentifier:@"restroDeatils" sender:indexPath];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    i =0;
    j=1;
    
    if ([self.flag_menu isEqualToString:@"Favrit"]) {
       
        NSString *RestorantNo =[[NSUserDefaults standardUserDefaults]stringForKey:@"resto_id"];
        
        NSString *CatagoryNo =[[NSUserDefaults standardUserDefaults]stringForKey:@"cataroty_id"];
       
        [_btn_accueil setTitle:@"ACCUEIL" forState:UIControlStateNormal ];
        [_btn_aide setTitle:@"AIDE" forState:UIControlStateNormal];
        restroArry = [[NSMutableArray alloc]init];
        u_id = [[NSUserDefaults standardUserDefaults]
                stringForKey:@"u_id"];
        NSString *strurl =[NSString stringWithFormat:@"http://vps291033.ovh.net/turbofood//api.php?method=view_category_menu&r_id=%@&c_id=%@&u_id=%@",RestorantNo,CatagoryNo,u_id];
        NSURL *url=[NSURL URLWithString:strurl];
        NSURLRequest *request=[NSURLRequest requestWithURL:url];
        NSData *respose = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSDictionary *allDataDictionary=[NSJSONSerialization JSONObjectWithData:respose options:kNilOptions error:nil];
        NSDictionary *response=[allDataDictionary objectForKey:@"result"];
        
        for (NSDictionary*dic  in response)
        {
            [restroArry addObject:dic];
            [[self tableOffers]reloadData];
        }
        [[NSUserDefaults standardUserDefaults] setObject:self.strca_id forKey:@"cat_id"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSString *desc = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"rest_d"];
        _restro_deatils.text = [NSString stringWithFormat:@"%@",desc];
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

    }
    else{
    // Do any additional setup after loading the view.
    NSString *Catagory_name =[NSString stringWithFormat:@"%@ %@",@"<",[[NSUserDefaults standardUserDefaults]
                              stringForKey:@"CatagoryName"]];
    NSString *RestorantNo =[[NSUserDefaults standardUserDefaults]stringForKey:@"restorantNo"];
    
    NSString *CatagoryNo =[[NSUserDefaults standardUserDefaults]stringForKey:@"CatagoryNo"];
    self.cat_lable.text = Catagory_name;
    [_btn_accueil setTitle:@"ACCUEIL" forState:UIControlStateNormal ];
    [_btn_aide setTitle:@"AIDE" forState:UIControlStateNormal];
    restroArry = [[NSMutableArray alloc]init];
    u_id = [[NSUserDefaults standardUserDefaults]
            stringForKey:@"u_id"];
    NSString *strurl =[NSString stringWithFormat:@"http://vps291033.ovh.net/turbofood//api.php?method=view_category_menu&r_id=%@&c_id=%@&u_id=%@",RestorantNo,CatagoryNo,u_id];
    NSURL *url=[NSURL URLWithString:strurl];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    NSData *respose = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *allDataDictionary=[NSJSONSerialization JSONObjectWithData:respose options:kNilOptions error:nil];
    NSDictionary *response=[allDataDictionary objectForKey:@"result"];
    
    for (NSDictionary*dic  in response)
    {
        [restroArry addObject:dic];
        [[self tableOffers]reloadData];
    }
    [[NSUserDefaults standardUserDefaults] setObject:self.strca_id forKey:@"cat_id"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSString *desc = [[NSUserDefaults standardUserDefaults]
                      stringForKey:@"descc"];
    _restro_deatils.text = [NSString stringWithFormat:@"%@",desc];
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
    
    }
}
-(void) viewWillAppear:(BOOL)animated
{
     if ([self.flag_menu isEqualToString:@"Favrit"]) {
        
         _restro_lbl.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]                                                                      stringForKey:@"resto_n"]];
         [_restro_img sd_setImageWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults]                                                                      stringForKey:@"resto_i"]]placeholderImage:[UIImage imageNamed:@"star_image.png"]];
         NSString *Catagory_name =[NSString stringWithFormat:@"%@ %@",@"<",[[NSUserDefaults standardUserDefaults]
                                                                            stringForKey:@"cat_n"]];
         self.cat_lable.text = Catagory_name;
         [[NSUserDefaults standardUserDefaults] setObject:Catagory_name forKey:@"final_name"];
         [[NSUserDefaults standardUserDefaults] synchronize];
         [[NSUserDefaults standardUserDefaults] setObject:_restro_lbl.text forKey:@"final_lab"];
         [[NSUserDefaults standardUserDefaults] synchronize];
         
     }
     else{
    _restro_lbl.text = [_receiveArray111 valueForKey:@"r_name"];
         if ([[NSUserDefaults standardUserDefaults]stringForKey:@"resto_i"] == nil) {
             [_restro_img sd_setImageWithURL:[NSURL URLWithString:[_receiveArray111 valueForKey:@"img_full"]]placeholderImage:[UIImage imageNamed:@"star_image.png"]];
         }
         else{
     [_restro_img sd_setImageWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults]                                                                      stringForKey:@"resto_i"]]placeholderImage:[UIImage imageNamed:@"star_image.png"]];
         }
     NSString *Catagory_name =[NSString stringWithFormat:@"%@ %@",@"<",[[NSUserDefaults standardUserDefaults]
                                                                           stringForKey:@"CatagoryName"]];
     self.cat_lable.text = Catagory_name;
         
         [[NSUserDefaults standardUserDefaults] setObject:Catagory_name forKey:@"final_name"];
         [[NSUserDefaults standardUserDefaults] synchronize];
         
         [[NSUserDefaults standardUserDefaults] setObject:_restro_lbl.text forKey:@"final_lab"];
         [[NSUserDefaults standardUserDefaults] synchronize];
     }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btn_fav:(id)sender {
    CGPoint touchPoint = [sender convertPoint:CGPointZero toView:self.tableOffers];
    NSIndexPath *indexPath = [self.tableOffers indexPathForRowAtPoint:touchPoint];
    fav_arry = [[NSMutableArray alloc]init];
    fav_arry = [restroArry objectAtIndex:indexPath.row];
    menu_id = [fav_arry valueForKey:@"id"];
    favourite = [fav_arry valueForKey:@"favourite"];
    
    btn1 = (UIButton *)sender;
    if ([sender isSelected])
    {
        fav_id = [NSString stringWithFormat:@"%d",i];
        [btn1 setImage:[UIImage imageNamed:@"star_image.png"] forState:UIControlStateNormal ];
        [sender setSelected:NO];
        [self favoris];
    }
    else
    {
        if ([favourite isEqualToString:@"1"])
        {
            fav_id = [NSString stringWithFormat:@"%d",i];
            [btn1 setImage:[UIImage imageNamed:@"star_image.png"] forState:UIControlStateNormal ];
            [self favoris];
        }
        else
        {
            [self.tableOffers reloadData];
            fav_id = [NSString stringWithFormat:@"%d",j];
            [btn1 setImage: [UIImage imageNamed:@"selected_star_image.png"] forState:UIControlStateNormal];
            [self favoris];
            [sender setSelected:YES];
       }
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
    [WebServiceViewController wsVC].strMethodName = @"menu_favorite";
    [dicSubmit setObject:u_id forKey:@"u_id"];
    [dicSubmit setObject:menu_id forKey:@"m_id"];
    [dicSubmit setObject:fav_id forKey:@"fav"];
    dictResultSignIn = [[WebServiceViewController wsVC] sendRequestWithParameter:dicSubmit];
    if (dictResultSignIn != Nil || dictResultSignIn != NULL)
    {
        [[self tableOffers] reloadData];
        [self viewDidLoad];
    }
}
- (IBAction)sidemenuButton:(id)sender
{
     [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

- (IBAction)aide_btn_action:(id)sender {
     AIDEViewController *AIDE = [self.storyboard instantiateViewControllerWithIdentifier:@"AIDEViewController"];
    [self.navigationController pushViewController:AIDE animated:YES];
}

- (IBAction)OK_btn:(id)sender {
    [_offerchoice_view setHidden:YES];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"restroDeatils"]){
        MenuSelectionViewController *MenuVC = (MenuSelectionViewController*)segue.destinationViewController;
        MenuVC.restroArry = [restroArry objectAtIndex:selectedrow];
        MenuVC.receiveArray111 = _receiveArray111;
        MenuVC.strre_id =_strre_id;
        MenuVC.strca_id=_strca_id;
        MenuVC.cat_name = _cat_name;
    }
}
- (IBAction)btn_accueil:(id)sender
{
    ViewController2 *vc4 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController2"];
    [self.navigationController pushViewController:vc4 animated:YES];
}

- (IBAction)back_menu_btn:(id)sender
{
    
     if ([self.flag_menu isEqualToString:@"Favrit"]) {
         ViewController4 *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController4"];
        vc2.flag_option =@"fav_back";
        // vc2.flag=@"Favrit";
         [self.navigationController pushViewController:vc2 animated:YES];
     }
     else{
         
    [self.navigationController popViewControllerAnimated:YES];
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
-(void)cart_no
{
   // [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    
    u_id0 = [[NSUserDefaults standardUserDefaults]
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


- (IBAction)back_btn:(id)sender
{
    
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

- (IBAction)btn_home:(id)sender
{
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
        // from NO button-
        // _segment_controller.selectedSegmentIndex = 0;
        
        
        
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
- (IBAction)fav_btn:(id)sender {
    resto_id = [_receiveArray111 valueForKey:@"id"];
    NSData *data1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"Menuuu"];
    NSArray *made = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    if (resto_id == nil) {
        resto_id = [made valueForKey:@"r_id"];
        favourite_resto = [made valueForKey:@"rest_fav"];
    }
    else{
    favourite_resto = [_receiveArray111 valueForKey:@"favourite"];
    }
    
    if ([sender isSelected])
    {
        favourite_resto = [NSString stringWithFormat:@"%d",i];
        [_fav_btn setImage:[UIImage imageNamed:@"star_image.png"] forState:UIControlStateNormal ];
        [sender setSelected:NO];
        [self favoris_restro];
        
    }
    else
    {
        if ([favourite_resto isEqualToString:@"1"])
        {
            favourite_resto = [NSString stringWithFormat:@"%d",i];
            [_fav_btn setImage:[UIImage imageNamed:@"star_image.png"] forState:UIControlStateNormal ];
            [self favoris_restro];
        }
        else
        {
            // [self.tableView reloadData];
            favourite_resto = [NSString stringWithFormat:@"%d",j];
            [_fav_btn setImage: [UIImage imageNamed:@"selected_star_image.png"] forState:UIControlStateNormal];
            [sender setSelected:YES];
            [self favoris_restro];
        }
    }
  

}
-(void)favoris_restro
{
    u_id = [[NSUserDefaults standardUserDefaults]
            stringForKey:@"u_id"];
    NSMutableDictionary *dictResultSignIn=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *dicSubmit = [[NSMutableDictionary alloc]init];
    [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood//api.php";
    
    [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
    [WebServiceViewController wsVC].strMethodName = @"rest_favorite";
    
    [dicSubmit setObject:u_id forKey:@"u_id"];
    [dicSubmit setObject:resto_id forKey:@"rest_id"];
    [dicSubmit setObject:favourite_resto forKey:@"fav"];
    
    NSLog(@"DicSubmit = %@",dicSubmit);
    
    dictResultSignIn = [[WebServiceViewController wsVC] sendRequestWithParameter:dicSubmit];
    
    if (dictResultSignIn != Nil || dictResultSignIn != NULL)
    {
        NSLog(@"dictResultSubmit = %@",dictResultSignIn);
        NSLog(@"My Sending Dic :%@",[dictResultSignIn objectForKey:@"message"]);
        NSLog(@"My Sending Dic :%@",[dictResultSignIn objectForKey:@"result"]);
      //  [[self tableView] reloadData];
        // [self tabledisplay];
        favourite_resto = [NSString stringWithFormat:@"%@",[dictResultSignIn valueForKey:@"result"]];
        [[NSUserDefaults standardUserDefaults]setObject:[dictResultSignIn objectForKey:@"result"] forKey:@"fav_star"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

    @end
    
    
