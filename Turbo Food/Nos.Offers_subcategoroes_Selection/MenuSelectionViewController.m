//
//  MenuSelectionViewController.m
//  Turbo Food
//
//  Created by ganesh on 3/18/16.
//  Copyright © 2016 Ravi. All rights reserved.
//

#import "MenuSelectionViewController.h"
#import "UIImageView+WebCache.h"
#import "NIDropDown.h"
#import "QuartzCore/QuartzCore.h"
#import "MFSideMenu.h"
#import "ViewController6.h"
#import "WebServiceViewController.h"
#import "ViewController4.h"
#import "ViewController2.h"
#import "MenuSelectionTableViewCell.h"
#import "NotificationViewController.h"
#import "SectionTableViewCell.h"

@interface MenuSelectionViewController ()
{
    NSMutableArray *option_name;
    NSMutableArray *optionid;
    NSMutableArray *option_prize;
    NSString *stroldprice;
    NSString *stroption;
    NSString *optID;
    NSMutableArray *restroArry2;
    NSString * quantity;
    NSString *quantity1;
    NSString *copt_id;
    NSString *u_id;
    NSMutableArray *cat_opt_nm;
    NSString *favourite_resto;
    NSString *user_id;
    // Final Strings
    NSString *mystrcat_id;
    NSString *menu_id;
    NSString *menu_price;
    NSString *restro_id;
    NSString *menuid;
    NSString *cate_id;
    int index;
    NSString *cart_nmuber;
    NSMutableDictionary *restroMenu;
    NSMutableArray *arry ;
    NSMutableArray *arry1;
    NSMutableArray *a;
    NSMutableArray * single_option;
    NSMutableArray * optionf_id;
    NSMutableArray * optionf_price;
    NSMutableArray * coptf_id;
    NSString *f_star;
    NSString *res_id;
    NSString *fav_menu;
    int qty_option;
    NSMutableArray *category_id;
    /////////////////////
    //New Option Menu //
//    NSMutableArray      *sectionTitleArray;
//    NSMutableDictionary *sectionContentDict;
//    NSMutableArray      *arrayForBool;
//    int ii;
    ////////////////////
//    NSArray *topItems;
//    NSArray *topItemsSecond;
//    NSMutableArray *subItems; // array of arrays
    
    NSMutableArray *subItems1; // array of arrays
 //   int currentExpandedIndex;
    int count;
    
    //////////////////////
    NSMutableArray      *sectionTitleArray;
    NSMutableDictionary *sectionContentDict;
    NSMutableDictionary *sectionContentDict_rate;
    NSMutableDictionary *sectionContentDict_id;
    NSMutableArray      *arrayForBool;
    
    NSMutableArray *topItems;
    NSArray *topItemsSecond;
    NSMutableArray *subItems; // array of arrays
    NSMutableArray *subItems_rate;
    NSMutableArray *subItems_id;
    
    int currentExpandedIndex;
    NSDictionary *allDataDictionary;
    
    int CurrentSection;
    
    NSMutableArray *arrSelectedname;
    NSMutableArray *arrSelectedrate;

    
    int total_price;
    
    
    int app;
    int org;
    int plus;

    
    NSMutableArray *getAlldata;
    NSMutableArray *getOptiondata;
    NSMutableArray *Expandlist;
    NSMutableDictionary *saveddataDictionary;
    NSMutableDictionary *setrow;
    int menuprice;
    int optionprice;
    int totoal;
    NSString *string;
    NSString*copt;
    NSString*opt;
    NSString*oprice;
    NSString*optqty;
    
   }


@property(strong,nonatomic)NSMutableArray *data;
@property(strong,nonatomic)NSMutableDictionary *setdata;
@property(strong)  NSIndexPath* lastIndexPath;
@property (atomic, retain) IBOutlet NSString *string;
@end

@implementation MenuSelectionViewController
{
    NSMutableArray *option_list;
    NSMutableArray *restroArry1;
    NIDropDown *dropDown;
    NSString *str;
    NSString *str_1;
    NSMutableArray *itemsInTable;
    NSArray *array;
    int i;
    int j;
}
@synthesize _contity,option_price,option_id,order_contity_lbl;




- (void)viewDidLoad {
    [super viewDidLoad];
    /////////////////////
    getAlldata=[[NSMutableArray alloc]init];
    getOptiondata=[[NSMutableArray alloc]init];
    Expandlist=[[NSMutableArray alloc]init];
    saveddataDictionary=[[NSMutableDictionary alloc]init];
    _setdata=[[NSMutableDictionary alloc]init];
    _data=[[NSMutableArray alloc]init];
    setrow=[[NSMutableDictionary alloc]init];
    
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedSectionHeaderHeight = 25;

    self.total_prize_sym.text = @"\u20ac";
    
   category_id = [[NSMutableArray alloc]init];
    
    app = 1;
    i = 1;
    //Option Menu
    qty_option = 1;
    self.chioce_view.hidden = YES;
    self.tableView.allowsMultipleSelection = YES;
    self.total_qty_prize.text = @"0";
    arrSelectedname =[[NSMutableArray alloc] init];
    self.price_textfield.text = [NSString stringWithFormat:@"%@ %@",@"0",@"\u20ac"];
    //self.lab_euro.text =@"\u20ac";
    
    [self.chioce_view addSubview:self.total_qty_prize];
    
    subItems =[[NSMutableArray alloc] init];
    subItems_rate =[[NSMutableArray alloc] init];
    subItems_id =[[NSMutableArray alloc] init];
    //ii=0;
    i = 0;
    j = 1;
    index = 0;
    _ok_btn.enabled = NO;
    arry = [[NSMutableArray alloc]init];
    arry1 = [[NSMutableArray alloc]init];
    NSString *title = @"OPTIONS";
    [_btn_select setTitle:title forState:UIControlStateNormal];
    _tableView.hidden = YES;
    optionf_id = [[NSMutableArray alloc]init];
    optionf_price = [[NSMutableArray alloc]init];
    coptf_id = [[NSMutableArray alloc]init];
    if ([self.flag_menu isEqualToString:@"Favrit_Menu"])
    {
        fav_menu = @"1";
        self.euro_sym.text = @"\u20ac";
        self.euro.text = @"\u20ac";
        NSData *data1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"Menuuu"];
        restroMenu = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
        NSString *cat_name = [restroMenu valueForKey:@"cat_name"];
       // _cat_lable.text = cat_name;
        NSString *cataroy_name = [NSString stringWithFormat:@"%@ %@",@"<",cat_name];
        _cat_lable.text = cataroy_name;
        NSString *menu_id = [restroMenu valueForKey:@"id"];
        menuid = [NSString stringWithFormat:@"%@",menu_id];
        NSString *cat_id = [restroMenu valueForKey:@"cat_id"];
        NSString *r_id = [restroMenu valueForKey:@"r_id"];
        
        [[NSUserDefaults standardUserDefaults] setObject:cat_name forKey:@"cat_n"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSUserDefaults standardUserDefaults] setObject:r_id forKey:@"resto_id"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSUserDefaults standardUserDefaults] setObject:cat_id forKey:@"cataroty_id"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSString *url=[NSString stringWithFormat:@"http://vps291033.ovh.net/turbofood//api.php?method=view_cat_option&r_id=%@&c_id=%@&m_id=%@",r_id,cat_id,menu_id];
        NSLog(@"url--%@",url);
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        NSError* error;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data //1
                              
                                                             options:kNilOptions
                                                               error:&error];
        NSLog(@"==%@",json);
        
        getAlldata=[json valueForKey:@"result"];
        NSLog(@"getall data=%@",getAlldata);
      
        for (int k=0; k<restroMenu.count; k++)
        {
            [[NSUserDefaults standardUserDefaults] setObject:self.copt_id forKey:@"m_id"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            u_id = [[NSUserDefaults standardUserDefaults]
            stringForKey:@"u_id"];
            NSString *desc = [[NSUserDefaults standardUserDefaults]
                      stringForKey:@"descc"];
            _restro_details.text = [NSString stringWithFormat:@"%@",desc];

            // Do any additional setup after loading the view.
            UIImage *image1 = [UIImage imageNamed:@"star_image.png"];
            UIImage *image2 = [UIImage imageNamed:@"selected_star_image.png"];
            f_star = @"1";
            if ([f_star isEqualToString:@"0"])
            {
                [_menu_fav setImage:image1 forState:UIControlStateNormal];
            }
            else if([f_star isEqualToString:@"1"])
            {
                [_menu_fav setImage:image2 forState:UIControlStateNormal];
        
            }
            UIImage *image3 = [UIImage imageNamed:@"star_image.png"];
            UIImage *image4 = [UIImage imageNamed:@"selected_star_image.png"];
            NSString *f_star1 = [[NSUserDefaults standardUserDefaults]stringForKey:@"fav_star"];
            if ([f_star1 isEqualToString:@"0"])
            {
                [_fav_btn setImage:image3 forState:UIControlStateNormal];
        
            }
            else if([f_star isEqualToString:@"1"])
            {
                [_fav_btn setImage:image4 forState:UIControlStateNormal];
        
            }
        }
    
    }
        else
        {
            self.euro_sym.text = @"\u20ac";
            self.euro.text = @"\u20ac";
            if (_cat_name == nil) {
                NSString *final = [[NSUserDefaults standardUserDefaults]
                                  stringForKey:@"final_name"];
                _cat_lable.text = [NSString stringWithFormat:@"%@",final];
            }
            else{
            NSString *cataroy_name = [NSString stringWithFormat:@"%@ %@",@"<",_cat_name];
            _cat_lable.text = cataroy_name;
            }
                restroArry1 = [[NSMutableArray alloc]init];
            menuid = [[NSUserDefaults standardUserDefaults]
                         stringForKey:@"menu_id"];
            cate_id = [[NSUserDefaults standardUserDefaults]stringForKey:@"cate_id"];
            NSString *url=[NSString stringWithFormat:@"http://vps291033.ovh.net/turbofood//api.php?method=view_cat_option&r_id=%@&c_id=%@&m_id=%@",self.strre_id,cate_id,menuid];
            NSLog(@"url--%@",url);
            NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            NSError* error;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data //1
                                  
                                                                 options:kNilOptions
                                                                   error:&error];
            NSLog(@"==%@",json);
            
            getAlldata=[json valueForKey:@"result"];
            NSLog(@"getall data=%@",getAlldata);
            // Do any additional setup after loading the view, typically from a nib.
            
            [_tableView reloadData];
           
            [[NSUserDefaults standardUserDefaults] setObject:self.copt_id forKey:@"m_id"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            u_id = [[NSUserDefaults standardUserDefaults]
            stringForKey:@"u_id"];
            NSString *desc = [[NSUserDefaults standardUserDefaults]
                      stringForKey:@"descc"];
            _restro_details.text = [NSString stringWithFormat:@"%@",desc];
            // Do any additional setup after loading the view.
            UIImage *image1 = [UIImage imageNamed:@"star_image.png"];
            UIImage *image2 = [UIImage imageNamed:@"selected_star_image.png"];
            NSString *f_star = [[NSUserDefaults standardUserDefaults]stringForKey:@"Menu_fav"];
            
            if ([f_star isEqualToString:@"0"])
            {
                [_menu_fav setImage:image1 forState:UIControlStateNormal];
            }
            else if([f_star isEqualToString:@"1"])
            {
                [_menu_fav setImage:image2 forState:UIControlStateNormal];
            }
            UIImage *image3 = [UIImage imageNamed:@"star_image.png"];
            UIImage *image4 = [UIImage imageNamed:@"selected_star_image.png"];
            NSString *f_star1 = [[NSUserDefaults standardUserDefaults]stringForKey:@"fav_star"];
            if ([f_star1 isEqualToString:@"0"])
            {
                [_fav_btn setImage:image3 forState:UIControlStateNormal];
            }
            else if([f_star1 isEqualToString:@"1"])
            {
                [_fav_btn setImage:image4 forState:UIControlStateNormal];
        
            }
        }

}

- (void)viewDidUnload {
    _btn_select = nil;
    [self btn_select:nil];
    [super viewDidUnload];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void) viewWillAppear:(BOOL)animated
{
    //self.tableView.allowsMultipleSelectionDuringEditing = YES;
    //[self.tableView setEditing:YES animated:YES];
    if ([self.flag_menu isEqualToString:@"Favrit_Menu"]) {
        _restro_lbl.text = [restroMenu valueForKey:@"r_name"];
        [_restro_img sd_setImageWithURL:[NSURL URLWithString:[restroMenu valueForKey:@"rest_img_full"]]placeholderImage:[UIImage imageNamed:@"star_image.png"]];
       // [_restro_img sd_setImageWithURL:[NSURL URLWithString:[restroMenu valueForKey:@"rest_img_full"]]placeholderImage:[UIImage imageNamed:@"star_image.png"]];
        [_menu_image sd_setImageWithURL:[NSURL URLWithString:[restroMenu valueForKey:@"img_full"]]placeholderImage:[UIImage imageNamed:@"star_image.png"]];
        _menu_lbl.text = [restroMenu valueForKey:@"sub_cat_name"];
        _menudetails_lbl.text = [restroMenu valueForKey:@"sc_descr"];
        _restro_details.text = [restroMenu valueForKey:@"descc"];
        string = [restroMenu valueForKey:@"price"];
        menuprice = [string intValue];
        optionprice = [lblTotalPrise.text intValue];
        totoal = menuprice + optionprice;
        _menu_Price.text = [NSString stringWithFormat:@"%d",menuprice+optionprice];
//        _menu_Price.text = [restroMenu valueForKey:@"price"];
        NSString *menu_p = [NSString stringWithFormat:@"%@ %@",[restroMenu valueForKey:@"price"],@"\u20ac"];
        _menu_price_org.text =menu_p;
        stroldprice =[restroMenu valueForKey:@"price"];
        str_1 = _menu_Price.text;
        self.i = 1;
        self.menu_name.text = [NSString stringWithFormat:@"%@",self.menu_lbl.text];
        
        [[NSUserDefaults standardUserDefaults] setObject:self.restro_lbl.text forKey:@"resto_n"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSUserDefaults standardUserDefaults] setObject:[restroMenu valueForKey:@"rest_img_full"]forKey:@"resto_i"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSUserDefaults standardUserDefaults] setObject:_restro_details.text forKey:@"rest_d"];
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
        
        
//        [_restro_img sd_setImageWithURL:[NSURL URLWithString:[_receiveArray111 valueForKey:@"img_full"]]placeholderImage:[UIImage imageNamed:@"star_image.png"]];
//        [_restro_img sd_setImageWithURL:[NSURL URLWithString:[_receiveArray111 valueForKey:@"img_full"]]placeholderImage:[UIImage imageNamed:@"star_image.png"]];
        [_menu_image sd_setImageWithURL:[NSURL URLWithString:[_restroArry valueForKey:@"img_full"]]placeholderImage:[UIImage imageNamed:@"star_image.png"]];
        _menu_lbl.text = [_restroArry valueForKey:@"sub_cat_name"];
        _menudetails_lbl.text = [_restroArry valueForKey:@"sc_descr"];
        string = [_restroArry valueForKey:@"price"];
        menuprice = [string intValue];
        optionprice = [lblTotalPrise.text intValue];
        totoal = menuprice + optionprice;
        _menu_Price.text = [NSString stringWithFormat:@"%d",menuprice+optionprice];
//         NSString *cat_name = [_restroArry valueForKey:@"cat_name"];
//        NSString *cataroy_name = [NSString stringWithFormat:@"%@ %@",@"<",_cat_name];
//        _cat_lable.text = cataroy_name;
       // _menu_Price.text = [_restroArry valueForKey:@"price"];
        NSString *menu_p = [NSString stringWithFormat:@"%@ %@",[_restroArry valueForKey:@"price"],@"\u20ac"];
        _menu_price_org.text =menu_p;
        stroldprice =[_restroArry valueForKey:@"price"];
        str_1 = _menu_Price.text;
        self.i = 1;
        self.menu_name.text = [NSString stringWithFormat:@"%@",self.menu_lbl.text];
        self.restro_lbl.text =[[NSUserDefaults standardUserDefaults]
                               stringForKey:@"final_lab"];
    }
  
}
- (IBAction)btn_select:(id)sender
{
    if ([_btn_select isSelected])
    {
       // _tableView.hidden = YES;
        // [_btn_select setSelected:NO];
    }
    else
    {
        self.chioce_view.hidden = NO;
        _tableView.hidden = NO;
        self.btn_select.hidden = YES;
        self.aBtnValidate.hidden = NO;
        self.payment_menu_btn.hidden = YES;
//        self.menu_Price.text = self.menu_price_org.text;
        
       // [_btn_select setSelected:YES];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
//    [self rel];
//     NSString *indexpathrow = [[NSUserDefaults standardUserDefaults]
//                                stringForKey:@"dropdownindexpathrow"];
//    stroption = [option_prize objectAtIndex:[indexpathrow intValue]];
//    optID = [optionid objectAtIndex:[indexpathrow intValue] ];
//    copt_id = [restroArry2 objectAtIndex:[indexpathrow intValue]];
//   }
//
//-(void)rel
//{
//    dropDown = nil;
//}
//
- (IBAction)plus_btn:(id)sender
{
    self.i++;
    {
        int demo2 = [stroldprice intValue];
        //self.j = [_menu_Price.text intValue] + demo2 ;
        self.j = [_menu_Price.text intValue] + demo2 ;
        demo2 = nil;
    }
    order_contity_lbl.text = [NSString stringWithFormat:@"%d",self.i];
   _menu_Price.text = [NSString stringWithFormat:@"%d",self.j];
    str = _menu_Price.text;
}

- (IBAction)min_btn:(id)sender {
    
    if (self.i > 1) {
//        self.i--;
//        [self._contity setText:[NSString stringWithFormat:@"%d",self.i]];
//       
//        
//        str = _menu_Price.text;
//        
//        self.j = [str intValue];
//        self.j = (self.j / 2);
//        
//        str = 
//        _menu_Price.text = [NSString stringWithFormat:@"%d",self.j];
//        str = _menu_Price.text;
        
        self.i--;
        
        {
            
            int demo2 = [stroldprice intValue];
            
            
            self.j = [_menu_Price.text intValue] - demo2 ;
            
            demo2 = nil;
            
        }

        order_contity_lbl.text =[NSString stringWithFormat:@"%d",self.i];
        
       // NSString *strorder = order_contity_lbl.text;
        _menu_Price.text = [NSString stringWithFormat:@"%d",self.j];
        str = _menu_Price.text;

    }
//    else if (self.i >= 2){
//        NSString *str = _menu_Price.text;
//        
//        self.j = [str intValue];
//        self.j = (self.j / 2);
//        
//    }
}

- (IBAction)ok_btn:(id)sender
{
    
    
   [optionf_id addObject:[single_option valueForKey:@"id" ]];
   [ optionf_price addObject:[single_option valueForKey:@"price" ]];
   [coptf_id addObject:[single_option valueForKey:@"cat_opt_id" ]];
    NSString *optionprice = [NSString stringWithFormat:@"%@",[single_option valueForKey:@"price" ]];
    self.qty++;
    {
        int xyz = [optionprice intValue];
        self.m = [_menu_Price.text intValue] + xyz ;
        _menu_Price.text = [NSString stringWithFormat:@"%d",self.m];
        str = _menu_Price.text;
        quantity1 = [NSString stringWithFormat:@"%d",self.qty];
    }
   optionprice = nil;
    }

- (IBAction)menu_payment:(id)sender
{
    optID = [optionf_id componentsJoinedByString:@", "];
    stroption = [optionf_price componentsJoinedByString:@", "];
    copt_id = [coptf_id componentsJoinedByString:@", "];
    if ([self.flag_menu isEqualToString:@"Favrit_Menu"])
    {
        restro_id = [restroMenu valueForKey:@"r_id"];
        cate_id = [restroMenu valueForKey:@"cat_id"];
        menuid = [restroMenu valueForKey:@"id"];
        menu_price =[restroMenu valueForKey:@"price"];
        
    }
    else
    {
        mystrcat_id =[restroArry1 valueForKey:@"id"];
        menu_price = [_restroArry valueForKey:@"price"];
        restro_id = [_restroArry valueForKey:@"r_id"];
    }
    [[NSUserDefaults standardUserDefaults]setObject:restro_id forKey:@"Restorant_id"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSMutableDictionary *dictResultSignIn=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *dicSubmit = [[NSMutableDictionary alloc]init];
    [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood//api.php";
    [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
    [WebServiceViewController wsVC].strMethodName = @"temp_menu_ios";
    [dicSubmit setObject:u_id forKey:@"u_id"];
    [dicSubmit setObject:restro_id forKey:@"r_id"];
    [dicSubmit setObject:cate_id forKey:@"c_id"];
    [dicSubmit setObject:menuid forKey:@"m_id"];
    [dicSubmit setObject:self.menu_price_org.text forKey:@"price"];
    [dicSubmit setObject: order_contity_lbl.text forKey:@"qty"];
    [dicSubmit setObject:_menu_Price.text forKey:@"g_total"];
    if (opt && oprice != nil)
    {
        [dicSubmit setObject:opt forKey:@"opt_id"];//array  opt
        [dicSubmit setObject:oprice forKey:@"o_price"];//array
        [dicSubmit setObject:copt forKey:@"copt_id"];//Bossionm& Maccafe arry
        [dicSubmit setObject:optqty forKey:@"opt_qty"];//array
    }
    else
    {
        [dicSubmit setObject:@"0" forKey:@"opt_id"];
        [dicSubmit setObject:@"0" forKey:@"o_price"];
        [dicSubmit setObject:@"0" forKey:@"copt_id"];
         [dicSubmit setObject:@"0" forKey:@"opt_qty"];
    }
    dictResultSignIn = [[WebServiceViewController wsVC] sendRequestWithParameter:dicSubmit];
    
    if (dictResultSignIn != Nil || dictResultSignIn != NULL) {
        NSLog(@"dictResultSubmit = %@",dictResultSignIn);
        
        if ([[dictResultSignIn objectForKey:@"status"]integerValue] == 0)
        {
        }
    }
    [self performSegueWithIdentifier:@"restroDeatils" sender:sender];
}
//- (IBAction)plus_conti:(id)sender
//{
//}

- (IBAction)sideMenu_button:(id)sender
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
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
        // from NO button
        // _segment_controller.selectedSegmentIndex = 0;
        
        
        
    }
//    if (_ipToDeselect != nil) {
//        [self.tableView deselectRowAtIndexPath:_ipToDeselect animated:YES];
//        //[_ipToDeselect release];
//        _ipToDeselect = nil;
//    }

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

- (IBAction)min_conti:(id)sender
{
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"restroDeatils"])
    {
          NSMutableDictionary *my4Dic =[[NSMutableDictionary alloc] init];
        ViewController6 *vc6 = (ViewController6*)segue.destinationViewController;
        vc6.restroArry6 = _restroArry;
        vc6.strre_id =restro_id;
        vc6.strca_id=_strca_id;
        vc6.str = str;
        vc6.str1  = str_1;
        vc6.opt_id = optID;
        vc6.m_qty = order_contity_lbl.text;
        vc6.cpot_id = _copt_id;
        vc6.opt_qty = quantity;
        NSLog(@"Str : %@",str);
        [[NSUserDefaults standardUserDefaults] setObject:option_name forKey:@"opt_id"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSUserDefaults standardUserDefaults] setObject:_menu_Price.text forKey:@"menu_price"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSUserDefaults standardUserDefaults] setObject:quantity forKey:@"menu_quantitfy"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSUserDefaults standardUserDefaults]setObject:order_contity_lbl.text forKey:@"order_count"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSUserDefaults standardUserDefaults]setObject:optID forKey:@"Option_id"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSUserDefaults standardUserDefaults]setObject:quantity1 forKey:@"Option_qty"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

- (IBAction)Back_bttn:(id)sender
{
    if([self.flag_menu isEqualToString:@"Favrit_Menu"])
    {
        ViewController5 *VC4 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController5"];
        VC4.flag_menu=@"Favrit";
        [self.navigationController pushViewController:VC4 animated:YES];
    }
    else{
    [self.navigationController popViewControllerAnimated:YES];
    }
}

//- (IBAction)btn_precedent:(id)sender
//{
//   
//    if (index !=0) {
//        --index;
//        arry = [[NSMutableArray alloc]init];
//        arry1 = [[NSMutableArray alloc]init];
//       
//        [arry addObject:[restroArry1 objectAtIndex:index]];
//        [arry1 addObject:[restroArry1 objectAtIndex:index]];
//        _option_cat_name.text = [cat_opt_nm objectAtIndex:index];
//        arry =[[restroArry1 objectAtIndex:index]valueForKey:@"name"];
//        arry1 =[[restroArry1 objectAtIndex:index]valueForKey:@"price"];
//        [self.tableView reloadData];
//    }
//}

//- (IBAction)btn_suivant:(id)sender
//{
//   
//
//    if (index < cat_opt_nm.count -1)
//    {
//        ++index;
//        arry = [[NSMutableArray alloc]init];
//        arry1 = [[NSMutableArray alloc]init];
//        _option_cat_name.text = [cat_opt_nm objectAtIndex:index];
//               arry = [restroArry1 objectAtIndex:index];
//        arry1 = [restroArry1 objectAtIndex:index];
//        [self.tableView reloadData];
//    }
//}

- (IBAction)btn_fav_restro:(id)sender {
     res_id = [_receiveArray111 valueForKey:@"id"];
    NSData *data1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"Menuuu"];
    restroMenu = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    if (res_id == nil) {
        NSData *data1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"Menuuu"];
        restroMenu = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
         res_id = [restroMenu valueForKey:@"r_id"];
        favourite_resto = [restroMenu valueForKey:@"rest_fav"];

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
    [[NSUserDefaults standardUserDefaults]setObject:favourite_resto forKey:@"fav_star"];
    [[NSUserDefaults standardUserDefaults] synchronize];

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
    [dicSubmit setObject:res_id forKey:@"rest_id"];
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
    }
}



- (IBAction)bell_btn:(id)sender
{
    NotificationViewController *vc4 =
    [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationViewController"];
    [self.navigationController pushViewController:vc4 animated:YES];
}

- (IBAction)aCloseBtn:(id)sender
{
    
    if ([sender isSelected]) {
        self.tableView.hidden = YES;
        self.aBtnValidate.hidden = YES;
        self.chioce_view.hidden = YES;
        self.btn_select.hidden = NO;
        optionprice = [lblTotalPrise.text intValue];
        _menu_Price.text = [NSString stringWithFormat:@"%d",totoal];
        self.payment_menu_btn.hidden = NO;
    }
    else
    {
        
        self.tableView.hidden = NO;
        self.aBtnValidate.hidden = NO;
        self.btn_select.hidden = YES;
        self.btn_select.hidden = YES;
    }
}

- (IBAction)aBtnValidate:(id)sender {
    
    NSLog(@"%lu",(unsigned long)saveddataDictionary.count);
    
    NSString * pp = [NSString stringWithFormat:@"%@",_menu_price_org.text];
    NSString *xx = [NSString stringWithFormat:@"%@",lblTotalPrise.text];
    if([xx isEqualToString:@"0"]){
        int value = [_menu_price_org.text intValue] * [order_contity_lbl.text intValue];
        _menu_Price.text = [NSString stringWithFormat:@"%d",value];
         totoal = [xx intValue]+ value;
    }
    else{
        int value = [_menu_price_org.text intValue]*[order_contity_lbl.text intValue];
    totoal = [xx intValue] + value;
    }
    self.menu_Price.text = [NSString stringWithFormat:@"%d",totoal];
    self.tableView.hidden = YES;
    self.chioce_view.hidden = YES;
    self.aBtnValidate.hidden = YES;
    self.btn_select.hidden = NO;
    self.payment_menu_btn.hidden = NO;
    if ([lblTotalPrise.text isEqualToString:@"0"]) {
        copt = nil;
        opt = nil;
        oprice = nil;
        optqty = nil;
    }
    else{
    copt=[self returnstringforkey:@"copt_id"];
    opt=[self returnstringforkey:@"opt_id"];
    oprice=[self returnstringforkey:@"o_price"];
    
    
    optqty=[self returnstringforkey:@"totalproduct"];
    
    
    NSLog(@"copt_id=%@,opt_id==%@,o_price==%@,opt_qty==%@",copt,opt,oprice,optqty);
    }
    
}

- (IBAction)menu_fav:(id)sender {
    
    if ([sender isSelected])
    {
        fav_menu = [NSString stringWithFormat:@"%d",i];
        [_menu_fav setImage:[UIImage imageNamed:@"star_image.png"] forState:UIControlStateNormal ];
        [sender setSelected:NO];
        [self fav_menu];
        
    }
    else
    {
        if ([fav_menu isEqualToString:@"1"])
        {
            fav_menu = [NSString stringWithFormat:@"%d",i];
            [_menu_fav setImage:[UIImage imageNamed:@"star_image.png"] forState:UIControlStateNormal ];
            [self fav_menu];
        }
        else
        {
            // [self.tableView reloadData];
            fav_menu = [NSString stringWithFormat:@"%d",j];
            [_menu_fav setImage: [UIImage imageNamed:@"selected_star_image.png"] forState:UIControlStateNormal];
            [sender setSelected:YES];
            [self fav_menu];
        }
    }

    [[NSUserDefaults standardUserDefaults]setObject:fav_menu forKey:@"Menu"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
-(void)fav_menu
{
    u_id = [[NSUserDefaults standardUserDefaults]stringForKey:@"u_id"];
    NSMutableDictionary *dictResultSignIn=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *dicSubmit = [[NSMutableDictionary alloc]init];
    [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood//api.php";
    
    [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
    [WebServiceViewController wsVC].strMethodName = @"menu_favorite";
    
    [dicSubmit setObject:u_id forKey:@"u_id"];
    [dicSubmit setObject:menuid forKey:@"m_id"];
    [dicSubmit setObject:fav_menu forKey:@"fav"];

    
    NSLog(@"DicSubmit = %@",dicSubmit);
    
    dictResultSignIn = [[WebServiceViewController wsVC] sendRequestWithParameter:dicSubmit];
    
    if (dictResultSignIn != Nil || dictResultSignIn != NULL)
    {
        NSLog(@"dictResultSubmit = %@",dictResultSignIn);
        NSLog(@"My Sending Dic :%@",[dictResultSignIn objectForKey:@"message"]);
        NSLog(@"My Sending Dic :%@",[dictResultSignIn objectForKey:@"result"]);
        //  [[self tableView] reloadData];
        // [self tabledisplay];
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




#pragma mark ---> UITableview DataSource

//Section
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 50;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"section is %lu",(unsigned long)[[getAlldata valueForKey:@"4"] count]);
    return [[getAlldata valueForKey:@"4"] count];
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    SectionTableViewCell *cell = (SectionTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.lblMainTitle.text=[[getAlldata valueForKey:@"4"]objectAtIndex:section];
    NSDictionary *d = [[getAlldata objectAtIndex:section]valueForKey:@"option"];
    
    if ([Expandlist containsObject:d]) {
        cell.imgDropDown.image=[UIImage imageNamed:@"up_arrow_img.png"];
        
    }
    else
    {
        cell.imgDropDown.image=[UIImage imageNamed:@"down_arrow_img.png"];
        if ([[saveddataDictionary valueForKey:[NSString stringWithFormat:@"%ld",(long)section]]valueForKey:@"subcategory"]) {
            
            NSMutableArray *combinearray=[[NSMutableArray alloc]init];
            for (NSString *category in [[saveddataDictionary valueForKey:[NSString stringWithFormat:@"%ld",(long)section]]valueForKey:@"subcategory"]) {
                NSString *temp=[[[saveddataDictionary valueForKey:[NSString stringWithFormat:@"%ld",(long)section]]valueForKey:@"subcategory"] valueForKey:category];
                [combinearray addObject:temp];
            }
            NSString * result = [combinearray componentsJoinedByString:@"\n"];
            //NSString *myLabelText = [myLabelText stringByReplacingOccurrencesOfString:@"\\n" withString:result];
            cell.details.numberOfLines=0;
            //myLabel.text = myLabelText;
            cell.details.text=result;
            [cell.details sizeToFit];
        }
    }
    
    
    cell.btnSelectSectionHeader.tag=section;
    
    return cell.contentView;


}

//Row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    SectionTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSDictionary *d = [[getAlldata objectAtIndex:section]valueForKey:@"option"];
    
    if ([Expandlist containsObject:d]) {
        cell.imgDropDown.image=[UIImage imageNamed:@"up_arrow_img.png"];
        return d.count;
    }
    else
        cell.imgDropDown.image=[UIImage imageNamed:@"down_arrow_img.png"];
    return 0;

    
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 55;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MenuSelectionTableViewCell *cell = (MenuSelectionTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:@"expandedCell"];
    cell.btnTagSec.tag=indexPath.row;
    cell.imgCheckUncheck.image=nil;
    cell.vwSHowhideView.hidden=YES;
    
    NSMutableArray *data=[[getAlldata objectAtIndex:indexPath.section]valueForKey:@"option"];
    cell.lblSubcategory.text=[[data valueForKey:@"name"]objectAtIndex:indexPath.row];
    cell.lblRupees.text=[[data valueForKey:@"price"]objectAtIndex:indexPath.row];
    cell.lblTotalProduct.text=@"1";
    cell.euro_symbol.text=@"\u20ac";
    NSString *selectedindexpath=[NSString stringWithFormat:@"%ld",(long)indexPath.section];
    NSString *selectedRow=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    if ([saveddataDictionary count] == 0) {
        cell.vwSHowhideView.hidden=YES;
        
    }
    else if ([[[saveddataDictionary valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]]valueForKey:@"section"] isEqualToString:selectedindexpath])
    {
        NSString *s =[saveddataDictionary valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
        NSString *ss =[[saveddataDictionary valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]]valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
        NSLog(@"S %@",s);
        NSLog(@"SS %@",ss);
        if ([[saveddataDictionary valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]]valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]] )
        {
            NSMutableArray*demo=[[NSMutableArray alloc]init];
            if ([[[saveddataDictionary valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]]valueForKey:@"subcategory"]valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]) {
                
                cell.imgCheckUncheck.image=[UIImage imageNamed:@"checkmark.png"];
                cell.vwSHowhideView.hidden=NO;
                cell.lblRupees.text=[[[saveddataDictionary valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]]valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]valueForKey:@"updatedvalue"];
                cell.lblTotalProduct.text=[[[saveddataDictionary valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]]valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]valueForKey:@"totalproduct"];
            }
            
        }
        else
        {
            
            cell.imgCheckUncheck.image=Nil;
            cell.vwSHowhideView.hidden=YES;
            
            
        }
        
        
    }
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;

}
#pragma mark ----> UITableview Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuSelectionTableViewCell *cell = (MenuSelectionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"expandedCell"];
    NSMutableDictionary *addname=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    NSString *selectedindexpath=[NSString stringWithFormat:@"%ld",(long)indexPath.section];
    NSString *selectedRow=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    
    
    cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (cell.imgCheckUncheck.image ==nil) {
        
        cell.imgCheckUncheck.image=[UIImage imageNamed:@"checkmark.png"];
        cell.vwSHowhideView.hidden=NO;
        [_data removeAllObjects];
        NSLog(@"section for check==%@",[[saveddataDictionary valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]]valueForKey:@"section" ]);
        if ([setrow valueForKey:@"section"]) {
            NSString *section=[setrow valueForKey:@"section"];
            if ([section isEqualToString:selectedindexpath]) {
                NSLog(@"no change");
                
            }
            else
            {
                setrow=[[NSMutableDictionary alloc]init];
            }
        }
        if ([[[saveddataDictionary valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]]valueForKey:@"section" ] isEqualToString:selectedindexpath] || [saveddataDictionary count]==0) {
            if ([saveddataDictionary valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]]) {
                setrow=[saveddataDictionary valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
            };
            
            NSMutableDictionary *data1=[[NSMutableDictionary alloc]init];
            [data1 setObject:@"image" forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
            [data1 setObject:[NSString stringWithFormat:@"%ld",(long)indexPath.section] forKey:@"section"];
            [data1 setObject:cell.lblRupees.text forKey:@"euro"];
            [data1 setObject:cell.lblRupees.text forKey:@"updatedvalue"];
            [data1 setObject:cell.lblTotalProduct.text forKey:@"totalproduct"];
            
            if ([[getAlldata objectAtIndex:indexPath.section]valueForKey:@"option"]) {
                NSString *str=[[[[getAlldata objectAtIndex:indexPath.section] valueForKey:@"option"] objectAtIndex:indexPath.row]valueForKey:@"cat_id"];
                NSMutableDictionary *addparam=[[NSMutableDictionary alloc]init];
                [addparam setObject:str forKey:@"copt_id"];
                NSString *str1=[[[[getAlldata objectAtIndex:indexPath.section] valueForKey:@"option"] objectAtIndex:indexPath.row]valueForKey:@"cat_opt_id"];
                [addparam setObject:str1 forKey:@"opt_id"];
                NSString *str2=[[[[getAlldata objectAtIndex:indexPath.section] valueForKey:@"option"] objectAtIndex:indexPath.row]valueForKey:@"price"];
                [addparam setObject:str2 forKey:@"o_price"];
                [data1 setObject:addparam forKey:@"param"];
            }
            
            // [[getAlldata objectAtIndex:[sender tag]]valueForKey:@"option"];
            
            ///////////////////////////////////////////////
            if ([[saveddataDictionary valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section ]]valueForKey:@"subcategory"]) {
                addname=[[saveddataDictionary valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section ]]valueForKey:@"subcategory"];
            }
            [addname setObject:cell.lblSubcategory.text forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
            [setrow setObject:addname forKey:@"subcategory"];
            
            ////////////////////////////////////////////////
            
            
            //////////////////////////////////////////////
            
            
            [setrow setObject:data1 forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
            [setrow setObject:[NSString stringWithFormat:@"%ld",(long)indexPath.section] forKey:@"section"];
            [saveddataDictionary setObject:setrow forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
            int result=[lblTotalPrise.text intValue]+[cell.lblRupees.text intValue];
            lblTotalPrise.text=[NSString stringWithFormat:@"%d",result];
            
        }
        else
        {
            int result=[lblTotalPrise.text intValue]+[cell.lblRupees.text intValue];
            lblTotalPrise.text=[NSString stringWithFormat:@"%d",result];
            setrow=[[NSMutableDictionary alloc]init];
            NSMutableDictionary *data1=[[NSMutableDictionary alloc]init];
            [data1 setObject:@"image" forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
            [data1 setObject:[NSString stringWithFormat:@"%ld",(long)indexPath.section] forKey:@"section"];
            [data1 setObject:cell.lblRupees.text forKey:@"euro"];
            [data1 setObject:cell.lblRupees.text forKey:@"updatedvalue"];
            [data1 setObject:cell.lblTotalProduct.text forKey:@"totalproduct"];
            
            //////////////////////////////
            if ([[getAlldata objectAtIndex:indexPath.section]valueForKey:@"option"]) {
                NSString *str=[[[[getAlldata objectAtIndex:indexPath.section] valueForKey:@"option"] objectAtIndex:indexPath.row]valueForKey:@"cat_id"];
                NSMutableDictionary *addparam=[[NSMutableDictionary alloc]init];
                [addparam setObject:str forKey:@"copt_id"];
                NSString *str1=[[[[getAlldata objectAtIndex:indexPath.section] valueForKey:@"option"] objectAtIndex:indexPath.row]valueForKey:@"cat_opt_id"];
                [addparam setObject:str1 forKey:@"opt_id"];
                NSString *str2=[[[[getAlldata objectAtIndex:indexPath.section] valueForKey:@"option"] objectAtIndex:indexPath.row]valueForKey:@"price"];
                [addparam setObject:str2 forKey:@"o_price"];
                [data1 setObject:addparam forKey:@"param"];
            }
            ////////////////////////////////////////////
            
            [setrow setObject:data1 forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
            if ([[saveddataDictionary valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section ]]valueForKey:@"subcategory"]) {
                addname=[[saveddataDictionary valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section ]]valueForKey:@"subcategory"];
            }
            [addname setObject:cell.lblSubcategory.text forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
            [setrow setObject:addname forKey:@"subcategory"];
            [setrow setObject:[NSString stringWithFormat:@"%ld",(long)indexPath.section] forKey:@"section"];
            [saveddataDictionary setObject:setrow forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
            
            
        }
        
        
    }
    else
    {
        if ([[[saveddataDictionary valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]]valueForKey:@"section" ] isEqualToString:selectedindexpath]) {
            if ([[saveddataDictionary valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]]valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]) {
                cell.imgCheckUncheck.image=Nil;
                cell.vwSHowhideView.hidden=YES;
                int result=[lblTotalPrise.text intValue]-[cell.lblRupees.text intValue];
                lblTotalPrise.text=[NSString stringWithFormat:@"%d",result];
                NSMutableDictionary*no1=[[NSMutableDictionary alloc]init];
                NSMutableDictionary *no2=[[NSMutableDictionary alloc]init];
                no1=[saveddataDictionary mutableCopy];
                //no2=[[no1 valueForKey:[NSString stringWithFormat:@"%ld",indexPath.section]]valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
                if ([[saveddataDictionary valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section ]]valueForKey:@"subcategory"]) {
                    NSMutableDictionary *demo=[[NSMutableDictionary alloc]init];
                    demo=[[saveddataDictionary valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section ]]valueForKey:@"subcategory"];
                    [demo removeObjectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
                    NSMutableDictionary *check=[saveddataDictionary valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
                    if (demo.count>0) {
                        
                        [check setObject:demo forKey:@"subcategory"];
                        
                        
                        
                    }
                    else
                    {
                        [check removeObjectForKey:@"subcategory"];
                        
                    }
                    [saveddataDictionary setObject:check forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
                    
                    //[saveddataDictionary setObject:check forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
                }
                
                NSString *rupee=[[[saveddataDictionary valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]]valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]valueForKey:@"euro"];
                cell.lblRupees.text=rupee;
                cell.lblTotalProduct.text=@"1";
                
                //[no2 removeObjectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
                //                if ([no1 valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]) {
                //                    [no1 removeObjectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
                //                    [saveddataDictionary setObject:no1 forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
                //                }
                
                // [no2 setObject:rupee forKey:@"updatedvalue"];
                // [no2 setObject:@"1" forKey:@"totalproduct"];
                NSLog(@"no 1 == %@",no1);
                NSLog(@"no 2 == %@",no2);
                
            }
            else
            {
                NSLog(@"key not exist");
            }
            
        }
    }
    

}

- (IBAction)btnAddandMinus:(UIButton *)sender {
    
    //Get Row and Section Both
    CGPoint buttonOrigin = [sender frame].origin;
    CGPoint originInTableView = [_tableView convertPoint:buttonOrigin fromView:[sender superview]];
    
    // gets the row corresponding to the converted point
    NSIndexPath *rowIndexPath = [_tableView indexPathForRowAtPoint:originInTableView];
    
    NSInteger section = [rowIndexPath section];
    
    if (sender.tag==1) { // Addition of Value
        NSLog(@"tag = 1");
        
        //Fetch Default Prise
        NSString *rupee=[[[saveddataDictionary valueForKey:[NSString stringWithFormat:@"%ld",(long)section]]valueForKey:[NSString stringWithFormat:@"%ld",(long)rowIndexPath.row]]valueForKey:@"euro"];
        
        //Fetch Updated Value
        NSString *totalvalue=[[[saveddataDictionary valueForKey:[NSString stringWithFormat:@"%ld",(long)section]]valueForKey:[NSString stringWithFormat:@"%ld",(long)rowIndexPath.row]]valueForKey:@"updatedvalue"];
        NSString *totalProductCount=[[[saveddataDictionary valueForKey:[NSString stringWithFormat:@"%ld",(long)section]]valueForKey:[NSString stringWithFormat:@"%ld",(long)rowIndexPath.row]]valueForKey:@"totalproduct"];
        //Total to Update the value
        int totalvalue1=[totalvalue intValue] + [rupee intValue];
        int totalproduct=[totalProductCount intValue] + 1;
        
        //Store Value in NSDictionary to display it in Tableview
        NSMutableDictionary*no1=[[NSMutableDictionary alloc]init];
        NSMutableDictionary *no2=[[NSMutableDictionary alloc]init];
        no1=[saveddataDictionary mutableCopy];
        no2=[[no1 valueForKey:[NSString stringWithFormat:@"%ld",(long)section]]valueForKey:[NSString stringWithFormat:@"%ld",(long)rowIndexPath.row]];
        [no2 setObject:[NSString stringWithFormat:@"%d",totalvalue1] forKey:@"updatedvalue"];
        [no2 setObject:[NSString stringWithFormat:@"%d",totalproduct] forKey:@"totalproduct"];
        
        //Count Total Data
        int result=[lblTotalPrise.text intValue]+[rupee intValue];
        if (lblTotalPrise.text >= 0) {
            lblTotalPrise.text=[NSString stringWithFormat:@"%d",result];
            //Show live value in Tableview
            MenuSelectionTableViewCell *cell = [self.tableView cellForRowAtIndexPath:rowIndexPath];
            cell.lblRupees.text=[NSString stringWithFormat:@"%d",totalvalue1];
            cell.lblTotalProduct.text=[NSString stringWithFormat:@"%d",totalproduct];
        }
        // lblTotalPrise.text=[NSString stringWithFormat:@"%d",result];
        
        
        
        
        
    }
    else if (sender.tag==2){//Minus
        NSLog(@"tag = 2");
        
        //Fetch Default Prise
        NSString *rupee=[[[saveddataDictionary valueForKey:[NSString stringWithFormat:@"%ld",(long)section]]valueForKey:[NSString stringWithFormat:@"%ld",(long)rowIndexPath.row]]valueForKey:@"euro"];
        
        //Fetch Updated Value
        NSString *totalvalue=[[[saveddataDictionary valueForKey:[NSString stringWithFormat:@"%ld",(long)section]]valueForKey:[NSString stringWithFormat:@"%ld",(long)rowIndexPath.row]]valueForKey:@"updatedvalue"];
        NSString *totalProductCount=[[[saveddataDictionary valueForKey:[NSString stringWithFormat:@"%ld",(long)section]]valueForKey:[NSString stringWithFormat:@"%ld",(long)rowIndexPath.row]]valueForKey:@"totalproduct"];
        //Total to Update the value
        if (![totalvalue isEqualToString:rupee]) {
            int totalvalue1=[totalvalue intValue] - [rupee intValue];
            int totalproduct=[totalProductCount intValue] - 1;
            
            //Store Value in NSDictionary to display it in Tableview
            NSMutableDictionary*no1=[[NSMutableDictionary alloc]init];
            NSMutableDictionary *no2=[[NSMutableDictionary alloc]init];
            no1=[saveddataDictionary mutableCopy];
            no2=[[no1 valueForKey:[NSString stringWithFormat:@"%ld",(long)section]]valueForKey:[NSString stringWithFormat:@"%ld",(long)rowIndexPath.row]];
            [no2 setObject:[NSString stringWithFormat:@"%d",totalvalue1] forKey:@"updatedvalue"];
            [no2 setObject:[NSString stringWithFormat:@"%d",totalproduct] forKey:@"totalproduct"];
            
            //Count Total Data
            int result=[lblTotalPrise.text intValue]-[rupee intValue];
            if (lblTotalPrise.text >= 0) {
                lblTotalPrise.text=[NSString stringWithFormat:@"%d",result];
                
                //Show live value in Tableview
                MenuSelectionTableViewCell *cell = [self.tableView cellForRowAtIndexPath:rowIndexPath];
                cell.lblRupees.text=[NSString stringWithFormat:@"%d",totalvalue1];
                cell.lblTotalProduct.text=[NSString stringWithFormat:@"%d",totalproduct];
            }
            
        }
        else
            
        {
            NSLog(@"last product");
        }
        
        
        
    }

}

- (IBAction)btnSelectSectionHeader:(UIButton *)sender {
    NSDictionary *d = [[getAlldata objectAtIndex:[sender tag]]valueForKey:@"option"];
    if (d.count<=0) {
        // cell.imgDropDown.image=[UIImage imageNamed:@"down_arrow_img.png"];
        return;
    }
    if ([Expandlist containsObject:d]) {
        // cell.imgDropDown.image=[UIImage imageNamed:@"up_arrow_img.png"];
        [Expandlist removeObject:d];
        
    }else{
        // cell.imgDropDown.image=[UIImage imageNamed:@"down_arrow_img.png"];
        [Expandlist addObject:d];
    }
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:[sender tag]] withRowAnimation:UITableViewRowAnimationAutomatic];
}
-(NSString *)returnstringforkey :(NSString *)key
{
    NSString *combinestring;
    NSMutableArray*f=[[NSMutableArray alloc]init];
    NSMutableArray *combinearray=[[NSMutableArray alloc]init];
    f=[saveddataDictionary mutableCopy];
    id val = nil;
    NSArray *values = [saveddataDictionary allValues];
    
    if ([values count] != 0)
    {
        val = [values objectAtIndex:0];
        NSString *temp =[[values objectAtIndex:0]valueForKey:@"section"];
        if (saveddataDictionary.count>1) {
            // int i = [temp intValue];
            for (i = [temp intValue]; i<[saveddataDictionary count]; i++) {
                
                NSArray  *indexes=[[[f valueForKey:[NSString stringWithFormat:@"%d",i]]valueForKey:@"subcategory"]allKeys];
                indexes = [indexes sortedArrayUsingComparator:^(id a, id b) {
                    return [a compare:b options:NSNumericSearch];
                }];
                
                if (indexes.count>1 || !indexes.count) {
                    NSString *j1=[indexes objectAtIndex:0];
                    //  int j=[j1 intValue];
                    for (j=[j1 intValue]; j<[indexes count]; j++) {
                        if ([key isEqualToString:@"totalproduct"]) {
                            if ([[values valueForKey:[NSString stringWithFormat:@"%d",j]] valueForKey:@"totalproduct"]) {
                                NSLog(@"%@",[[values valueForKey:[NSString stringWithFormat:@"%d",j]]valueForKey:@"totalproduct"]);
                                str=[[[values objectAtIndex:i ] valueForKey:[NSString stringWithFormat:@"%d",j]]valueForKey:key];
                                
                            }
                        }
                        else
                        {
                            
                            str=[[[[values objectAtIndex:i]valueForKey:[NSString stringWithFormat:@"%d",j]]valueForKey:@"param"]valueForKey:key];
                        }
                        [combinearray addObject:str];
                    }
                    
                }
                else
                {
                    NSString *index1=[indexes componentsJoinedByString:@""];
                    
                    if ([key isEqualToString:@"totalproduct"]) {
                        if ([[values valueForKey:index1] valueForKey:@"totalproduct"]) {
                            NSLog(@"%@",[[values valueForKey:index1]valueForKey:@"totalproduct"]);
                            str=[[[values objectAtIndex:i]valueForKey:index1]valueForKey:key];
                            
                        }
                    }
                    else
                    {
                        
                        str=[[[[values objectAtIndex:i ] valueForKey:index1]valueForKey:@"param"]valueForKey:key];
                        
                    }
                    if (![str isEqualToString:@""]) {
                        [combinearray addObject:str];
                    }
                    
                }
                
            }
            combinestring =[combinearray componentsJoinedByString:@","];
            
            
        }
        
        
        else{
            NSArray  *indexes=[[[values objectAtIndex:0]valueForKey:@"subcategory"]allKeys];
            if (indexes.count>1) {
                NSString *j1=[indexes objectAtIndex:0];
                //  int j=[j1 intValue];
                for (j=[j1 intValue]; j<[indexes count]; j++) {
                    if ([key isEqualToString:@"totalproduct"]) {
                        if ([[values valueForKey:[NSString stringWithFormat:@"%d",j]] valueForKey:@"totalproduct"]) {
                            NSLog(@"%@",[[values valueForKey:[NSString stringWithFormat:@"%d",j]]valueForKey:@"totalproduct"]);
                            str=[[values valueForKey:[NSString stringWithFormat:@"%d",j]]valueForKey:key];
                            
                        }
                    }
                    else
                    {
                        
                        str=[[[values valueForKey:[NSString stringWithFormat:@"%d",j]]valueForKey:@"param"]valueForKey:key];
                    }
                    [combinearray addObject:str];
                }
                NSString *du =[combinearray componentsJoinedByString:@","];
                NSString *tu=[du stringByReplacingOccurrencesOfString:@"(" withString:@""];
                NSString *pu=[tu stringByReplacingOccurrencesOfString:@")" withString:@""];
                combinestring=[pu stringByReplacingOccurrencesOfString:@" " withString:@""];
                
            }
            else
            {
                NSString *index1=[indexes componentsJoinedByString:@""];
                
                if ([key isEqualToString:@"totalproduct"]) {
                    if ([[values valueForKey:index1] valueForKey:@"totalproduct"]) {
                        NSLog(@"%@",[[values valueForKey:index1]valueForKey:@"totalproduct"]);
                        combinestring=[[values valueForKey:index1]valueForKey:key];
                        
                    }
                }
                else
                {
                    
                    combinestring=[[[values valueForKey:index1]valueForKey:@"param"]valueForKey:key];
                }
            }
        }
        
        
    }
    
    
    
    
    
    
    return combinestring;
    
}
//-(NSString *)returnstringforkey :(NSString *)key
//{
//    NSString *combinestring;
//    NSMutableArray*f=[[NSMutableArray alloc]init];
//    NSMutableArray *combinearray=[[NSMutableArray alloc]init];
//    f=[saveddataDictionary mutableCopy];
//    id val = nil;
//    NSArray *values = [saveddataDictionary allValues];
//    
//    if ([values count] != 0)
//    {
//        val = [values objectAtIndex:0];
//        NSString *temp =[[values objectAtIndex:0]valueForKey:@"section"];
//        if (saveddataDictionary.count>1) {
//           // int i = [temp intValue];
//            for (i = [temp intValue]; i<[saveddataDictionary count]; i++) {
//                
//                 NSArray  *indexes=[[[f valueForKey:[NSString stringWithFormat:@"%d",i]]valueForKey:@"subcategory"]allKeys];
//                if (indexes.count>1) {
//                    NSString *j1=[indexes objectAtIndex:0];
//                  //  int j=[j1 intValue];
//                    for (j=[j1 intValue]; j<[indexes count]; j++) {
//                        if ([key isEqualToString:@"totalproduct"]) {
//                            if ([[values valueForKey:[NSString stringWithFormat:@"%d",j]] valueForKey:@"totalproduct"]) {
//                                NSLog(@"%@",[[values valueForKey:[NSString stringWithFormat:@"%d",j]]valueForKey:@"totalproduct"]);
//                                str=[[[values objectAtIndex:i ] valueForKey:[NSString stringWithFormat:@"%d",j]]valueForKey:key];
//                                
//                            }
//                        }
//                        else
//                        {
//                            
//                            str=[[[[values objectAtIndex:i]valueForKey:[NSString stringWithFormat:@"%d",j]]valueForKey:@"param"]valueForKey:key];
//                        }
//                         [combinearray addObject:str];
//                    }
//                   
//                }
//                else
//                {
//                    NSString *index1=[indexes componentsJoinedByString:@""];
//                    
//                    if ([key isEqualToString:@"totalproduct"]) {
//                        if ([[values valueForKey:index1] valueForKey:@"totalproduct"]) {
//                            NSLog(@"%@",[[values valueForKey:index1]valueForKey:@"totalproduct"]);
//                            str=[[[values objectAtIndex:i]valueForKey:index1]valueForKey:key];
//                            
//                        }
//                    }
//                    else
//                    {
//                        if (![str isEqualToString:@""]) {
//                            [combinearray addObject:str];
//                        }
//                        
//                        str=[[[[values objectAtIndex:i ] valueForKey:index1]valueForKey:@"param"]valueForKey:key];
//                        
//                    }
//                     [combinearray addObject:str];
//                }
//               
//            }
//            combinestring =[combinearray componentsJoinedByString:@","];
//
//            
//        }
//        
//        
//        else{
//            NSArray  *indexes=[[[values objectAtIndex:0]valueForKey:@"subcategory"]allKeys];
//            if (indexes.count>1) {
//                NSString *j1=[indexes objectAtIndex:0];
//                //  int j=[j1 intValue];
//                for (j=[j1 intValue]; j<[indexes count]; j++) {
//                    if ([key isEqualToString:@"totalproduct"]) {
//                        if ([[values valueForKey:[NSString stringWithFormat:@"%d",j]] valueForKey:@"totalproduct"]) {
//                            NSLog(@"%@",[[values valueForKey:[NSString stringWithFormat:@"%d",j]]valueForKey:@"totalproduct"]);
//                            str=[[values valueForKey:[NSString stringWithFormat:@"%d",j]]valueForKey:key];
//                            
//                        }
//                    }
//                    else
//                    {
//                        
//                        str=[[[values valueForKey:[NSString stringWithFormat:@"%d",j]]valueForKey:@"param"]valueForKey:key];
//                    }
//                    [combinearray addObject:str];
//                }
//                NSString *du =[combinearray componentsJoinedByString:@","];
//                NSString *tu=[du stringByReplacingOccurrencesOfString:@"(" withString:@""];
//                NSString *pu=[tu stringByReplacingOccurrencesOfString:@")" withString:@""];
//                combinestring=[pu stringByReplacingOccurrencesOfString:@" " withString:@""];
//
//            }
//            else
//            {
//            NSString *index1=[indexes componentsJoinedByString:@""];
//            
//            if ([key isEqualToString:@"totalproduct"]) {
//                if ([[values valueForKey:index1] valueForKey:@"totalproduct"]) {
//                    NSLog(@"%@",[[values valueForKey:index1]valueForKey:@"totalproduct"]);
//                    combinestring=[[values valueForKey:index1]valueForKey:key];
//                    
//                }
//            }
//            else
//            {
//                
//                combinestring=[[[values valueForKey:index1]valueForKey:@"param"]valueForKey:key];
//            }
//            }
//        }
//        
//        
//    }
//    
//
//
//
//    
//    
//    return combinestring;
//    
//}

- (NSDictionary *) indexKeyedDictionaryFromArray:(NSArray *)array
{
    NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] init];
    [array enumerateObjectsUsingBlock:
     ^(id obj, NSUInteger idx, BOOL *stop){
         NSNumber *index = [NSNumber numberWithInteger:idx];
         [mutableDictionary setObject:obj forKey:index];
     }];
    NSDictionary *result = [NSDictionary.alloc initWithDictionary:mutableDictionary];
    return result;
}

- (NSString *)actorForFilm:(NSString *)film {
    NSDictionary * dictionary = saveddataDictionary; //your dictionary as read from the plist
    for (NSString * actorName in dictionary) {
        NSArray * films = [dictionary objectForKey:actorName];
        if ([films containsObject:film]) {
            return actorName;
        }
    }
    return nil;
}

@end
