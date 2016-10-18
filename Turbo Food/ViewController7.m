//
//  ViewController7.m
//  Turbo Food
//
//  Created by Ravi on 2/25/16.
//  Copyright (c) 2016 Ravi. All rights reserved.
//

#import "ViewController7.h"
#import "NIDropDown.h"
#import "MFSideMenu.h"
#import "WebServiceViewController.h"
#import "ViewController2.h"
#import "PaiementViewController.h"
#import "WebServicesViewController.h"
#import "NotificationViewController.h"
#import "ViewController6.h"

@interface ViewController7 ()
{
    NSString *u_id;
    NSString *r_id;
    NSString *c_id;
    NSString *m_id;
    NSString *opt_iddemo;
    //NSString *opt_id;
    NSString *g_total;
    NSString *option_id;
    NSString *option_qty;
    NSString *menu_qty;
    
    NSArray * arr;
    NSString *total;
    NSString *fav_order;
    int i;
    int j;
    NSString *p_now;
    NSString *time;
    UIButton *btn1;
    UIButton *btn2;
    UIImage *unselectedImage;
    UIImage *selectedImage;
    UIImage *unselectedImage_imd;
    UIImage *selectedImage_imd;
    NSString *u_id0;
    NSString *cart_nmuber;
    NSString *user_id;
    BOOL first;
}
@end

@implementation ViewController7
{
    NSMutableArray *FinalArray;
    NIDropDown *dropDown;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    selectedImage = [UIImage imageNamed:@"differer_selected-1.png"];
    unselectedImage = [UIImage imageNamed:@"differer_deselected-1.png"];
    selectedImage_imd = [UIImage imageNamed:@"preparation_selected-1.png"];
    unselectedImage_imd = [UIImage imageNamed:@"preparation_deselected-2.png"];
        
    i = 0;
     j = 1;
    _differ_command.enabled = YES;
    _menu_hour.hidden = YES;
    _adujourd.hidden=YES;
    dropDown.backgroundColor=[UIColor clearColor];
    _btnSelect.layer.borderWidth = 1;
    _btnSelect.layer.borderColor = [[UIColor blackColor] CGColor];
    _btnSelect.layer.cornerRadius = 5;
    
    // Do any additional setup after loading the view.
    
    FinalArray = [[NSMutableArray alloc]init];
    
    //NSLog(@"REstorant :%@",self.receiveArray111);
    
    // NSString *strr_id = [self.receiveArray111 valueForKey:@"id"];
    NSString *strurl =[NSString stringWithFormat:@"http://vps291033.ovh.net/turbofood///api.php?method=view_category_menu&r_id=%@&c_id=%@",self.strre_id,self.strca_id];
    
    NSURL *url=[NSURL URLWithString:strurl];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    NSData *respose = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *json_string = [[NSString alloc]initWithData:respose encoding:NSUTF8StringEncoding];
    NSDictionary *allDataDictionary=[NSJSONSerialization JSONObjectWithData:respose options:kNilOptions error:nil];
    NSDictionary *response=[allDataDictionary objectForKey:@"result"];
    NSLog(@"Print %@", response);
    
    for (NSDictionary*dic  in response)
    {
        
        [FinalArray addObject:dic];
        
        NSLog(@"Data : %@",dic);
        
    }
    //User ID from login page
    u_id = [[NSUserDefaults standardUserDefaults]
                stringForKey:@"u_id"];
    //REstro ID from ViewController 4
    
    r_id = [[NSUserDefaults standardUserDefaults]stringForKey:@"id"];
    
    //Categories like nos of offer/nos of menu
    
    c_id = [[NSUserDefaults standardUserDefaults]stringForKey:@"cat_id"];
    
    m_id = [[NSUserDefaults standardUserDefaults]stringForKey:@"m_id"];
    
    
   // Menu selectionView Controller
    
    opt_iddemo = [[NSUserDefaults standardUserDefaults]stringForKey:@"opt_id"];
    
    
    g_total = [[NSUserDefaults standardUserDefaults]stringForKey:@"g_total"];
    
    //NSLog(@"M_qty %@",_m_qty);
    
//    NSString *option_id;
//    NSString *option_qty;
//    NSString *menu_qty;
    
    option_id = [[NSUserDefaults standardUserDefaults]stringForKey:@"Option_id"];
    
    option_qty = [[NSUserDefaults standardUserDefaults]stringForKey:@"Option_qty"];
    
    menu_qty = [[NSUserDefaults standardUserDefaults]stringForKey:@"order_count"];
    
    
}
- (void)viewDidUnload {
    //    [btnSelect release];
    _btnSelect = nil;
    [self btnSelect:nil];
    [super viewDidUnload];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnSelect:(id)sender {
   // NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"1 Heure", @"2 Heure", @"3 Heure", @"4 Heure",@"5 Heure",nil];
    NSArray * arrImage = [[NSArray alloc] init];
    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], nil];
    
    if(dropDown == nil) {
        CGFloat f = 110;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :nil :@"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }

    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
    NSLog(@"%@", _btnSelect.titleLabel.text);
}

-(void)rel{
    //    [dropDown release];
    dropDown = nil;
}

- (IBAction)menu_btn:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

- (IBAction)order_immediate:(id)sender {
    
    
//    NSMutableDictionary *dictResultSignIn=[[NSMutableDictionary alloc]init];
//    NSMutableDictionary *dicSubmit = [[NSMutableDictionary alloc]init];
//    [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood///api.php";
//    [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
//    [WebServiceViewController wsVC].strMethodName = @"save_order";
//    
//    [dicSubmit setObject:u_id forKey:@"u_id"];
//    [dicSubmit setObject:r_id forKey:@"r_id"];
//    [dicSubmit setObject:c_id forKey:@"c_id"];
//    [dicSubmit setObject:m_id forKey:@"m_id"];
//    [dicSubmit setObject:menu_qty forKey:@"m_qty"];
//     [dicSubmit setObject:@"1"forKey:@"copt_id"];
//    if (option_id && option_qty != nil) {
//        [dicSubmit setObject:option_id forKey:@"opt_id"];
//        [dicSubmit setObject:option_qty forKey:@"opt_qty"];
//    }
//    else
//    {
//        [dicSubmit setObject:@"0" forKey:@"opt_id"];
//        [dicSubmit setObject:@"0" forKey:@"opt_qty"];
//    }
//    [dicSubmit setObject:g_total forKey:@"g_total"];
//    
////    http://vps291033.ovh.net/turbofood///api.php?method=save_order&u_id=1&r_id=2&c_id=3&m_id=4&m_qty=5&copt_id=6&opt_id=7&opt_qty=8&g_total=50
//    NSLog(@"DicSubmit = %@",dicSubmit);
//    
//    dictResultSignIn = [[WebServiceViewController wsVC] sendRequestWithParameter:dicSubmit];
//    
//    if (dictResultSignIn != Nil || dictResultSignIn != NULL) {
//        NSLog(@"dictResultSubmit = %@",dictResultSignIn);
//        
//        if ([[dictResultSignIn objectForKey:@"status"]integerValue] == 0)
//        {
//            NSLog(@"My Sending Dic :%@",[dictResultSignIn objectForKey:@"result"]);
//        }
//    }
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Votre commande a ete effectue" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];

   
    
    
    
    
    
    
//    NSMutableDictionary *dictResultSignIn=[[NSMutableDictionary alloc]init];
//        NSMutableDictionary *dicSubmit = [[NSMutableDictionary alloc]init];
//        [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood///api.php";
//        [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
//        [WebServiceViewController wsVC].strMethodName = @"cart_payment";
//    
//        [dicSubmit setObject:u_id forKey:@"u_id"];
//    
//    NSLog(@"DicSubmit = %@",dicSubmit);
//    
//        dictResultSignIn = [[WebServiceViewController wsVC] sendRequestWithParameter:dicSubmit];
//    
//        if (dictResultSignIn != Nil || dictResultSignIn != NULL) {
//            NSLog(@"dictResultSubmit = %@",dictResultSignIn);
//    
//            if ([[dictResultSignIn objectForKey:@"status"]integerValue] == 0)
//            {
//                NSLog(@"My Sending Dic :%@",[dictResultSignIn objectForKey:@"result"]);
//            }
//        }
//      //  UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Votre commande a ete effectue" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        //    [alert show];
//   
////    PaiementViewController *VC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"PaiementViewController"];
////    [self.navigationController pushViewController:VC2 animated:YES];
//

    
    
    //   btn1 = (UIButton *)sender;
//    if ([sender isSelected])
//    {
//        [btn1 setImage:[UIImage imageNamed:@"preparation_deselected.png"] forState:UIControlStateNormal ];
//        [sender setSelected:NO];
//        
//    }
//    else
//    {
//        [btn1 setImage:[UIImage imageNamed:@"preparation_selected.png"] forState:UIControlStateNormal ];
//        [sender setSelected:YES];
//    
//    }
    
    NSString *choice = @"Choix";
    [_btnSelect setTitle:choice forState:UIControlStateNormal];
   // _btnSelect.titleLabel.text =@"Choix";
    _valider.enabled =NO;
    btn1 = (UIButton *)sender;
    [btn1 setImage:selectedImage_imd forState:UIControlStateNormal];
    [self performSelector:@selector(toggleUIButtonImage1:) withObject:nil afterDelay:0.1];
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components =[gregorian components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:today];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    NSInteger second = [components second];
    NSLog(@"Hour %ld",(long)hour);
    NSLog(@"Minite %ld",(long)minute);
    NSLog(@"Secound %ld",(long)second);
    
    
    NSString *open_hour = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"open_h"];
    
    NSString *close_hour =[[NSUserDefaults standardUserDefaults]
                           stringForKey:@"close_h"];
    //NSInteger openhour = [open_hour integerValue];
    NSInteger closehour = [close_hour integerValue];
    
    if (hour>closehour) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message"
                                                       message:@"Restraurant est fermé" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        _btnSelect.titleLabel.text = @"Chiox";
        self.valider.enabled = NO;
    }
    else
    {
        p_now = [NSString stringWithFormat:@"%d",i];
       
        NSDate *now = [NSDate date];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"HH:mm:ss";
        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        //  NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:now]);
        time = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:now]];
        
        [[NSUserDefaults standardUserDefaults]setObject:time forKey:@"time"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        
        [[NSUserDefaults standardUserDefaults]setObject:p_now forKey:@"p_now"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"isCreditcardClicked"])
    {
        
        
       
        
        WebServicesViewController *ws = [self.storyboard instantiateViewControllerWithIdentifier:@"WebServicesViewController"];
        [self.navigationController pushViewController:ws animated:YES];
    }
    else if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isrechargeClicked"])
    {
        
        [self WalletMehtod];
        
    }
    else if ([[NSUserDefaults standardUserDefaults] boolForKey:@"iselectricClicked"])
    {
         [self cashpayment];
        
    }
    }
}
-(IBAction) toggleUIButtonImage1:(id)sender{
    self.adujourd.hidden = YES;
    self.menu_hour.hidden = YES;
    
    if ([sender isSelected]) {
        [sender setImage:unselectedImage_imd forState:UIControlStateNormal];
        [sender setSelected:NO];
    } else {
        [sender setImage:selectedImage_imd forState:UIControlStateSelected];
        [self.differ_command setImage:[UIImage imageNamed:@"differer_deselected-1.png"] forState:UIControlStateNormal];

        [sender setSelected:YES];
    }
}
- (IBAction)order_diifer:(id)sender {
//    
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Please select Choice Option of Hours" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alert show];
   // self.menu_hour.hidden = NO;
   // btn2 = (UIButton *)sender;
    //[btn2 setImage:unselectedImage forState:UIControlStateNormal];
    [self.preparation_immediate setImage:[UIImage imageNamed:@"preparation_deselected-2.png"] forState:UIControlStateNormal];

    [self performSelector:@selector(toggleUIButtonImage:) withObject:sender afterDelay:0.0];
    
    
//    NSMutableDictionary *dictResultSignIn=[[NSMutableDictionary alloc]init];
//    NSMutableDictionary *dicSubmit = [[NSMutableDictionary alloc]init];
//    [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood///api.php";
//    [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
//    [WebServiceViewController wsVC].strMethodName = @"cart_payment";
//    
//    
//       [dicSubmit setObject:u_id forKey:@"u_id"];
////    [dicSubmit setObject:r_id forKey:@"r_id"];
////    [dicSubmit setObject:c_id forKey:@"c_id"];
////    [dicSubmit setObject:m_id forKey:@"m_id"];
////    [dicSubmit setObject:menu_qty forKey:@"m_qty"];
////    [dicSubmit setObject:@"1"forKey:@"copt_id"];
////    if (option_id && option_qty != nil) {
////        [dicSubmit setObject:option_id forKey:@"opt_id"];
////        [dicSubmit setObject:option_qty forKey:@"opt_qty"];
////    }
////    else
////    {
////        [dicSubmit setObject:@"0" forKey:@"opt_id"];
////        [dicSubmit setObject:@"0" forKey:@"opt_qty"];
////    }
////    [dicSubmit setObject:g_total forKey:@"g_total"];
//    
//    //    http://vps291033.ovh.net/turbofood///api.php?method=save_order&u_id=1&r_id=2&c_id=3&m_id=4&m_qty=5&copt_id=6&opt_id=7&opt_qty=8&g_total=50
//    NSLog(@"DicSubmit = %@",dicSubmit);
//    
//    dictResultSignIn = [[WebServiceViewController wsVC] sendRequestWithParameter:dicSubmit];
//    
//    if (dictResultSignIn != Nil || dictResultSignIn != NULL) {
//        NSLog(@"dictResultSubmit = %@",dictResultSignIn);
//        
//        if ([[dictResultSignIn objectForKey:@"status"]integerValue] == 0)
//        {
//            NSLog(@"My Sending Dic :%@",[dictResultSignIn objectForKey:@"result"]);
//        }
//    }
//
//   // UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Votre commande a ete effectue" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//  //  [alert show];
////    PaiementViewController *VC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"PaiementViewController"];
////    [self.navigationController pushViewController:VC2 animated:YES];
//    btn1 = (UIButton *)sender;
//    if ([sender isSelected])
//    {
//        [btn1 setImage:[UIImage imageNamed:@"differer_deselected.png"] forState:UIControlStateNormal ];
//        [sender setSelected:YES];
//        
//    }
//    else
//    {
//        [btn1 setImage:[UIImage imageNamed:@"differer_selected.png"] forState:UIControlStateNormal ];
//        [sender setSelected:NO];
//        
//    }
//    btn1 = (UIButton *)sender;
//    [btn1 setImage:selectedImage forState:UIControlStateNormal];
//
//
//    NSDate *today = [NSDate date];
//    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDateComponents *components =[gregorian components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:today];
//    NSInteger hour = [components hour];
//    NSInteger minute = [components minute];
//    NSInteger second = [components second];
//    NSLog(@"Hour %ld",(long)hour);
//    NSLog(@"Minite %ld",(long)minute);
//    NSLog(@"Secound %ld",(long)second);
//  //  NSInteger extxa_time = []
//    
//    NSString *close_hour =[[NSUserDefaults standardUserDefaults]
//                           stringForKey:@"close_h"];
//    NSInteger closehour = [close_hour integerValue];
//    p_now = [NSString stringWithFormat:@"%d",j];
//    
//    [[NSUserDefaults standardUserDefaults]setObject:p_now forKey:@"p_now"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    
//    if ([_btnSelect.titleLabel.text isEqualToString:@"Choix"]) {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message"
//                                                       message:@"S'il vous plaît sélectionnez Choix" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        [alert show];
//    }
//    
//    
//   else if ([ _btnSelect.titleLabel.text isEqualToString: @"1 Heure"])
//    {
//        if (closehour <= hour+1) {
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message"
//                                                           message:@"Restraurant est fermé" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//            [alert show];
//            
//        }
//        else{
//            
//            if([[NSUserDefaults standardUserDefaults] boolForKey:@"isCreditcardClicked"])
//            {
//                NSDate *now = [NSDate date];
//                
//                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//                dateFormatter.dateFormat = @"HH:mm:ss";
//                [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
//                //  NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:now]);
//                NSTimeInterval secondsInOneHours = 1 * 45 * 60;
//                NSDate *dateOneHoursAhead = [now dateByAddingTimeInterval:secondsInOneHours];
//                
//                
//               time = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:dateOneHoursAhead]];
//                
//                
//                [[NSUserDefaults standardUserDefaults]setObject:time forKey:@"time"];
//                [[NSUserDefaults standardUserDefaults] synchronize];
//
//                WebServicesViewController *ws = [self.storyboard instantiateViewControllerWithIdentifier:@"WebServicesViewController"];
//                [self.navigationController pushViewController:ws animated:YES];
//            }
//            else if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isrechargeClicked"])
//            {
//                
//                [self WalletMehtod];
//                
//            }
//            else if ([[NSUserDefaults standardUserDefaults] boolForKey:@"iselectricClicked"])
//            {
//                NSDate *now = [NSDate date];
//                
//                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//                dateFormatter.dateFormat = @"HH:mm:ss";
//                [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
//                //  NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:now]);
//                NSTimeInterval secondsInOneHours = 1 * 45 * 60;
//                NSDate *dateOneHoursAhead = [now dateByAddingTimeInterval:secondsInOneHours];
//                
//                
//               time = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:dateOneHoursAhead]];
//
//                [self cashpayment];
//            }
//
//        }
//    }
//    else if([ _btnSelect.titleLabel.text isEqualToString: @"2 Heure"])
//    {
//            if (closehour <= hour+2)
//            {
//                
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message"
//                                                           message:@"Restraurant est fermé" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//                     [alert show];
//                
//
//            }
//            else{
//                if([[NSUserDefaults standardUserDefaults] boolForKey:@"isCreditcardClicked"])
//                {
//                    NSDate *now = [NSDate date];
//                    
//                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//                    dateFormatter.dateFormat = @"HH:mm:ss";
//                    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
//                    //  NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:now]);
//                    NSTimeInterval secondsInOneHours = 2 * 45 * 60;
//                    NSDate *dateOneHoursAhead = [now dateByAddingTimeInterval:secondsInOneHours];
//                    
//                    
//                    time = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:dateOneHoursAhead]];
//                    
//                    
//                    [[NSUserDefaults standardUserDefaults]setObject:time forKey:@"time"];
//                    [[NSUserDefaults standardUserDefaults] synchronize];
//                    WebServicesViewController *ws = [self.storyboard instantiateViewControllerWithIdentifier:@"WebServicesViewController"];
//                    [self.navigationController pushViewController:ws animated:YES];
//                }
//                else if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isrechargeClicked"])
//                {
//                    
//                    [self WalletMehtod];
//                    
//                }
//                else if ([[NSUserDefaults standardUserDefaults] boolForKey:@"iselectricClicked"])
//                {
//                    NSDate *now = [NSDate date];
//                    
//                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//                    dateFormatter.dateFormat = @"HH:mm:ss";
//                    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
//                    //  NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:now]);
//                    NSTimeInterval secondsInOneHours = 2 * 45 * 60;
//                    NSDate *dateOneHoursAhead = [now dateByAddingTimeInterval:secondsInOneHours];
//                    
//                    
//                   time = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:dateOneHoursAhead]];
//
//                    [self cashpayment];
//                }
//
//            }
//    }
//        else if([ _btnSelect.titleLabel.text isEqualToString: @"3 Heure"])
//        {
//            if (closehour <= hour+3)
//            {
//                
//            
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message"
//                                                           message:@"Restraurant est fermé" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//            [alert show];
//                
//
//            }
//            else{
//                if([[NSUserDefaults standardUserDefaults] boolForKey:@"isCreditcardClicked"])
//                {
//                    NSDate *now = [NSDate date];
//                    
//                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//                    dateFormatter.dateFormat = @"HH:mm:ss";
//                    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
//                    //  NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:now]);
//                    NSTimeInterval secondsInOneHours = 3 * 45 * 60;
//                    NSDate *dateOneHoursAhead = [now dateByAddingTimeInterval:secondsInOneHours];
//                    
//                    
//                    time = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:dateOneHoursAhead]];
//                    
//                    
//                    [[NSUserDefaults standardUserDefaults]setObject:time forKey:@"time"];
//                    [[NSUserDefaults standardUserDefaults] synchronize];
//                    WebServicesViewController *ws = [self.storyboard instantiateViewControllerWithIdentifier:@"WebServicesViewController"];
//                    [self.navigationController pushViewController:ws animated:YES];
//                }
//                else if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isrechargeClicked"])
//                {
//                    
//                    [self WalletMehtod];
//                    
//                }
//                else if ([[NSUserDefaults standardUserDefaults] boolForKey:@"iselectricClicked"])
//                {
//                    NSDate *now = [NSDate date];
//                    
//                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//                    dateFormatter.dateFormat = @"HH:mm:ss";
//                    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
//                    //  NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:now]);
//                    NSTimeInterval secondsInOneHours = 3 * 45 * 60;
//                    NSDate *dateOneHoursAhead = [now dateByAddingTimeInterval:secondsInOneHours];
//                    
//                    
//                    time = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:dateOneHoursAhead]];
//
//                    [self cashpayment];
//                }
//
//            }
//        }
//
//        else if([ _btnSelect.titleLabel.text isEqualToString: @"4 Heure"])
//        {
//            if (closehour <= hour+4)
//            {
//                
//            
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message"
//                                                           message:@"Restraurant est fermé" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//            [alert show];
//              
//
//            }
//            else{
//                if([[NSUserDefaults standardUserDefaults] boolForKey:@"isCreditcardClicked"])
//                {
//                    NSDate *now = [NSDate date];
//                    
//                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//                    dateFormatter.dateFormat = @"HH:mm:ss";
//                    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
//                    //  NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:now]);
//                    NSTimeInterval secondsInOneHours = 4 * 45 * 60;
//                    NSDate *dateOneHoursAhead = [now dateByAddingTimeInterval:secondsInOneHours];
//                    
//                    
//                    time = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:dateOneHoursAhead]];
//                    
//                    
//                    [[NSUserDefaults standardUserDefaults]setObject:time forKey:@"time"];
//                    [[NSUserDefaults standardUserDefaults] synchronize];
//                    WebServicesViewController *ws = [self.storyboard instantiateViewControllerWithIdentifier:@"WebServicesViewController"];
//                    [self.navigationController pushViewController:ws animated:YES];
//                }
//                else if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isrechargeClicked"])
//                {
//                    
//                    [self WalletMehtod];
//                    
//                }
//                else if ([[NSUserDefaults standardUserDefaults] boolForKey:@"iselectricClicked"])
//                {
//                    NSDate *now = [NSDate date];
//                    
//                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//                    dateFormatter.dateFormat = @"HH:mm:ss";
//                    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
//                    //  NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:now]);
//                    NSTimeInterval secondsInOneHours = 1 * 45 * 60;
//                    NSDate *dateOneHoursAhead = [now dateByAddingTimeInterval:secondsInOneHours];
//                    
//                    
//                   time = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:dateOneHoursAhead]];
//
//                    [self cashpayment];
//                }
//
//            }
//        }
//    
//
//        else if([ _btnSelect.titleLabel.text isEqualToString: @"5 Heure"])
//        {
//            if (closehour <= hour+5)
//            {
//                
//            
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message"
//                                                           message:@"Restraurant est fermé" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//            [alert show];
//               
//
//                
//            }
//            else{
//                if([[NSUserDefaults standardUserDefaults] boolForKey:@"isCreditcardClicked"])
//                {
//                    NSDate *now = [NSDate date];
//                    
//                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//                    dateFormatter.dateFormat = @"HH:mm:ss";
//                    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
//                    //  NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:now]);
//                    NSTimeInterval secondsInOneHours = 5 * 45 * 60;
//                    NSDate *dateOneHoursAhead = [now dateByAddingTimeInterval:secondsInOneHours];
//                    
//                    
//                    time = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:dateOneHoursAhead]];
//                    
//                    
//                    [[NSUserDefaults standardUserDefaults]setObject:time forKey:@"time"];
//                    [[NSUserDefaults standardUserDefaults] synchronize];
//                    WebServicesViewController *ws = [self.storyboard instantiateViewControllerWithIdentifier:@"WebServicesViewController"];
//                    [self.navigationController pushViewController:ws animated:YES];
//                }
//                else if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isrechargeClicked"])
//                {
//                    
//                    [self WalletMehtod];
//                    
//                }
//                else if ([[NSUserDefaults standardUserDefaults] boolForKey:@"iselectricClicked"])
//                {
//                    NSDate *now = [NSDate date];
//                    
//                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//                    dateFormatter.dateFormat = @"HH:mm:ss";
//                    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
//                    //  NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:now]);
//                    NSTimeInterval secondsInOneHours = 5 * 45 * 60;
//                    NSDate *dateOneHoursAhead = [now dateByAddingTimeInterval:secondsInOneHours];
//                    
//                    
//                   time = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:dateOneHoursAhead]];
//
//                    [self cashpayment];
//                }
//
//            }
//        }
//
//    
//    
//    
//        else {
//        
    
    
//    if([[NSUserDefaults standardUserDefaults] boolForKey:@"isCreditcardClicked"])
//    {
//        WebServicesViewController *ws = [self.storyboard instantiateViewControllerWithIdentifier:@"WebServicesViewController"];
//        [self.navigationController pushViewController:ws animated:YES];
//    }
//    else if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isrechargeClicked"])
//    {
//        
//        [self WalletMehtod];
//        
//    }
//    else if ([[NSUserDefaults standardUserDefaults] boolForKey:@"iselectricClicked"])
//    {
//        [self cashpayment];
//    }
        
//    }
//    WebServicesViewController *ws = [self.storyboard instantiateViewControllerWithIdentifier:@"WebServicesViewController"];
//    [self.navigationController pushViewController:ws animated:YES];
}

-(IBAction) toggleUIButtonImage:(id)sender{
    
//       if ([sender isSelected]) {
//        [sender setImage:selectedImage forState:UIControlStateSelected];
//        [sender setSelected:NO];
//        self.menu_hour.hidden = YES;
//        self.adujourd.hidden = YES;
//        
//    } else {
//        [sender setImage:unselectedImage forState:UIControlStateNormal];
//        self.menu_hour.hidden = NO;
//        self.adujourd.hidden = NO;
//        [sender setSelected:YES];
//  
//   }
    
        if(first == NO){
            [self.differ_command setImage:[UIImage imageNamed:@"differer_selected-1.png"] forState:UIControlStateNormal];
            self.menu_hour.hidden = NO;
            self.adujourd.hidden = NO;

            //[btn2 setImage:[UIImage imageNamed:@"second.png"] forState:UIControlStateNormal];
            first = YES;
        }
        else
        {
            first = NO;
            [self.differ_command setImage:[UIImage imageNamed:@"differer_deselected-1.png"] forState:UIControlStateNormal];
            self.menu_hour.hidden = YES;
            self.adujourd.hidden = YES;
           
        
    }}
- (IBAction)OK_differcommand:(id)sender {
    
    //_differ_command.enabled = YES;
    btn1 = (UIButton *)sender;
    [btn1 setImage:selectedImage forState:UIControlStateNormal];
    
    
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components =[gregorian components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:today];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    NSInteger second = [components second];
    NSLog(@"Hour %ld",(long)hour);
    NSLog(@"Minite %ld",(long)minute);
    NSLog(@"Secound %ld",(long)second);
    //  NSInteger extxa_time = []
    
    NSString *close_hour =[[NSUserDefaults standardUserDefaults]
                           stringForKey:@"close_h"];
    NSInteger closehour = [close_hour integerValue];
    p_now = [NSString stringWithFormat:@"%d",j];
    
    [[NSUserDefaults standardUserDefaults]setObject:p_now forKey:@"p_now"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if ([_btnSelect.titleLabel.text isEqualToString:@"Choix"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message"
                                                       message:@"S'il vous plaît sélectionnez Choix" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
    
    else if ([ _btnSelect.titleLabel.text isEqualToString: @"1 Heure"])
    {
        if (closehour <= hour+1) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message"
                                                           message:@"Restraurant est fermé" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            
        }
        else{
            
            if([[NSUserDefaults standardUserDefaults] boolForKey:@"isCreditcardClicked"])
            {
                NSDate *now = [NSDate date];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                dateFormatter.dateFormat = @"HH:mm:ss";
                [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                //  NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:now]);
                NSTimeInterval secondsInOneHours = 1 * 45 * 60;
                NSDate *dateOneHoursAhead = [now dateByAddingTimeInterval:secondsInOneHours];
                
                
                time = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:dateOneHoursAhead]];
                
                
                [[NSUserDefaults standardUserDefaults]setObject:time forKey:@"time"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                WebServicesViewController *ws = [self.storyboard instantiateViewControllerWithIdentifier:@"WebServicesViewController"];
                [self.navigationController pushViewController:ws animated:YES];
            }
            else if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isrechargeClicked"])
            {
                
                [self WalletMehtod];
                
            }
            else if ([[NSUserDefaults standardUserDefaults] boolForKey:@"iselectricClicked"])
            {
                NSDate *now = [NSDate date];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                dateFormatter.dateFormat = @"HH:mm:ss";
                [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                //  NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:now]);
                NSTimeInterval secondsInOneHours = 1 * 45 * 60;
                NSDate *dateOneHoursAhead = [now dateByAddingTimeInterval:secondsInOneHours];
                
                
                time = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:dateOneHoursAhead]];
                
                [self cashpayment];
            }
            
        }
    }
    else if([ _btnSelect.titleLabel.text isEqualToString: @"2 Heure"])
    {
        if (closehour <= hour+2)
        {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message"
                                                           message:@"Restraurant est fermé" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            
            
        }
        else{
            if([[NSUserDefaults standardUserDefaults] boolForKey:@"isCreditcardClicked"])
            {
                NSDate *now = [NSDate date];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                dateFormatter.dateFormat = @"HH:mm:ss";
                [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                //  NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:now]);
                NSTimeInterval secondsInOneHours = 2 * 45 * 60;
                NSDate *dateOneHoursAhead = [now dateByAddingTimeInterval:secondsInOneHours];
                
                
                time = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:dateOneHoursAhead]];
                
                
                [[NSUserDefaults standardUserDefaults]setObject:time forKey:@"time"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                WebServicesViewController *ws = [self.storyboard instantiateViewControllerWithIdentifier:@"WebServicesViewController"];
                [self.navigationController pushViewController:ws animated:YES];
            }
            else if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isrechargeClicked"])
            {
                
                [self WalletMehtod];
                
            }
            else if ([[NSUserDefaults standardUserDefaults] boolForKey:@"iselectricClicked"])
            {
                NSDate *now = [NSDate date];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                dateFormatter.dateFormat = @"HH:mm:ss";
                [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                //  NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:now]);
                NSTimeInterval secondsInOneHours = 2 * 45 * 60;
                NSDate *dateOneHoursAhead = [now dateByAddingTimeInterval:secondsInOneHours];
                
                
                time = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:dateOneHoursAhead]];
                
                [self cashpayment];
            }
            
        }
    }
    else if([ _btnSelect.titleLabel.text isEqualToString: @"3 Heure"])
    {
        if (closehour <= hour+3)
        {
            
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message"
                                                           message:@"Restraurant est fermé" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            
            
        }
        else{
            if([[NSUserDefaults standardUserDefaults] boolForKey:@"isCreditcardClicked"])
            {
                NSDate *now = [NSDate date];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                dateFormatter.dateFormat = @"HH:mm:ss";
                [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                //  NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:now]);
                NSTimeInterval secondsInOneHours = 3 * 45 * 60;
                NSDate *dateOneHoursAhead = [now dateByAddingTimeInterval:secondsInOneHours];
                
                
                time = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:dateOneHoursAhead]];
                
                
                [[NSUserDefaults standardUserDefaults]setObject:time forKey:@"time"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                WebServicesViewController *ws = [self.storyboard instantiateViewControllerWithIdentifier:@"WebServicesViewController"];
                [self.navigationController pushViewController:ws animated:YES];
            }
            else if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isrechargeClicked"])
            {
                
                [self WalletMehtod];
                
            }
            else if ([[NSUserDefaults standardUserDefaults] boolForKey:@"iselectricClicked"])
            {
                NSDate *now = [NSDate date];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                dateFormatter.dateFormat = @"HH:mm:ss";
                [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                //  NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:now]);
                NSTimeInterval secondsInOneHours = 3 * 45 * 60;
                NSDate *dateOneHoursAhead = [now dateByAddingTimeInterval:secondsInOneHours];
                
                
                time = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:dateOneHoursAhead]];
                
                [self cashpayment];
            }
            
        }
    }
    
    else if([ _btnSelect.titleLabel.text isEqualToString: @"4 Heure"])
    {
        if (closehour <= hour+4)
        {
            
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message"
                                                           message:@"Restraurant est fermé" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            
            
        }
        else{
            if([[NSUserDefaults standardUserDefaults] boolForKey:@"isCreditcardClicked"])
            {
                NSDate *now = [NSDate date];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                dateFormatter.dateFormat = @"HH:mm:ss";
                [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                //  NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:now]);
                NSTimeInterval secondsInOneHours = 4 * 45 * 60;
                NSDate *dateOneHoursAhead = [now dateByAddingTimeInterval:secondsInOneHours];
                
                
                time = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:dateOneHoursAhead]];
                
                
                [[NSUserDefaults standardUserDefaults]setObject:time forKey:@"time"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                WebServicesViewController *ws = [self.storyboard instantiateViewControllerWithIdentifier:@"WebServicesViewController"];
                [self.navigationController pushViewController:ws animated:YES];
            }
            else if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isrechargeClicked"])
            {
                
                [self WalletMehtod];
                
            }
            else if ([[NSUserDefaults standardUserDefaults] boolForKey:@"iselectricClicked"])
            {
                NSDate *now = [NSDate date];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                dateFormatter.dateFormat = @"HH:mm:ss";
                [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                //  NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:now]);
                NSTimeInterval secondsInOneHours = 1 * 45 * 60;
                NSDate *dateOneHoursAhead = [now dateByAddingTimeInterval:secondsInOneHours];
                
                
                time = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:dateOneHoursAhead]];
                
                [self cashpayment];
            }
            
        }
    }
    
    
    else if([ _btnSelect.titleLabel.text isEqualToString: @"5 Heure"])
    {
        if (closehour <= hour+5)
        {
            
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message"
                                                           message:@"Restraurant est fermé" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            
            
            
        }
        else{
            if([[NSUserDefaults standardUserDefaults] boolForKey:@"isCreditcardClicked"])
            {
                NSDate *now = [NSDate date];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                dateFormatter.dateFormat = @"HH:mm:ss";
                [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                //  NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:now]);
                NSTimeInterval secondsInOneHours = 5 * 45 * 60;
                NSDate *dateOneHoursAhead = [now dateByAddingTimeInterval:secondsInOneHours];
                
                
                time = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:dateOneHoursAhead]];
                
                
                [[NSUserDefaults standardUserDefaults]setObject:time forKey:@"time"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                WebServicesViewController *ws = [self.storyboard instantiateViewControllerWithIdentifier:@"WebServicesViewController"];
                [self.navigationController pushViewController:ws animated:YES];
            }
            else if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isrechargeClicked"])
            {
                
                [self WalletMehtod];
                
            }
            else if ([[NSUserDefaults standardUserDefaults] boolForKey:@"iselectricClicked"])
            {
                NSDate *now = [NSDate date];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                dateFormatter.dateFormat = @"HH:mm:ss";
                [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                //  NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:now]);
                NSTimeInterval secondsInOneHours = 5 * 45 * 60;
                NSDate *dateOneHoursAhead = [now dateByAddingTimeInterval:secondsInOneHours];
                
                
                time = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:dateOneHoursAhead]];
                
                [self cashpayment];
            }
            
        }
    }
    
    
    
    
    else {
        
    }
}


-(void)WalletMehtod
{
    NSString *strWalletblance =[[NSUserDefaults standardUserDefaults]
                                stringForKey:@"Wallet_balance"];
    
    NSMutableDictionary *dictResultSignIn=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *dicSubmit = [[NSMutableDictionary alloc]init];
    [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood///api.php";
    
    [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
    [WebServiceViewController wsVC].strMethodName = @"pay_wallet";
    
    
    [dicSubmit setObject:u_id forKey:@"u_id"];
    [dicSubmit setObject:strWalletblance forKey:@"wallet_bal"];
    
    
    
    NSLog(@"DicSubmit = %@",dicSubmit);
    
    
    NSLog(@"DicSubmit = %@",dicSubmit);
    
    
    dictResultSignIn = [[WebServiceViewController wsVC] sendRequestWithParameter:dicSubmit];
    
    if (dictResultSignIn != Nil || dictResultSignIn != NULL) {
        NSLog(@"dictResultSubmit = %@",dictResultSignIn);
        
        if ([[dictResultSignIn objectForKey:@"status"]integerValue] == 0)
        {
            
            NSLog(@"My Sending Dic :%@",[dictResultSignIn objectForKey:@"message"]);
            NSLog(@"My Sending Dic :%@",[dictResultSignIn objectForKey:@"result"]);
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message"
                                                           message:@"Your Order Suceccfull from your wallet" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
           
            NotificationViewController *VC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationViewController"];
            [self.navigationController pushViewController:VC2 animated:YES];
        }
        else
        {
            
        }
        
        
        
        
    }
    
}
-(void)cashpayment
{
   total =[[NSUserDefaults standardUserDefaults]
                                stringForKey:@"totalprice"];
    fav_order = [[NSUserDefaults standardUserDefaults]stringForKey:@"fav"];
    
    
    NSMutableDictionary *dictResultSignIn=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *dicSubmit = [[NSMutableDictionary alloc]init];
    [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood///api.php";
    
    [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
    [WebServiceViewController wsVC].strMethodName = @"pay_cash";
    
    
    [dicSubmit setObject:u_id forKey:@"u_id"];
    [dicSubmit setObject:total forKey:@"g_total"];
    [dicSubmit setObject:fav_order forKey:@"favourite"];
    [dicSubmit setObject:p_now forKey:@"p_now"];
    [dicSubmit setObject:time forKey:@"delivery"];
    
    NSLog(@"DicSubmit = %@",dicSubmit);
    
    dictResultSignIn = [[WebServiceViewController wsVC] sendRequestWithParameter:dicSubmit];
    
    if (dictResultSignIn != Nil || dictResultSignIn != NULL) {
        NSLog(@"dictResultSubmit = %@",dictResultSignIn);
        
        if ([[dictResultSignIn objectForKey:@"status"]integerValue] == 0)
        {
            
            NSLog(@"My Sending Dic :%@",[dictResultSignIn objectForKey:@"message"]);
            NSLog(@"My Sending Dic :%@",[dictResultSignIn objectForKey:@"result"]);
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message"
                                                           message:@"Votre commande a été passé avec succès" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            
            NotificationViewController *VC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationViewController"];
            [self.navigationController pushViewController:VC2 animated:YES];
        }
        else
        {
            
        }
        
        
        
        
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
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Abandoner le paiement ?"message:@"Si vous retournez au panier, vous perdrez les informations saisies."delegate:self cancelButtonTitle:@"Annuler" otherButtonTitles:@"OK",nil];
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
- (IBAction)cart_btn:(id)sender
{
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
    [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood///api.php";
    
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
    
  //  [MBProgressHUD hideHUDForView:self.tableView animated:YES];
}

@end
