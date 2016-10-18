//
//  NotificationViewController.m
//  Turbo Food
//
//  Created by ganesh on 4/15/16.
//  Copyright © 2016 Ravi. All rights reserved.
//

#import "NotificationViewController.h"
#import "WebServiceViewController.h"
#import "NotificationTableViewCell.h"
#import "MFSideMenu.h"
#import "ViewController2.h"
#import "ViewController6.h"

@interface NotificationViewController ()
{
    NSString *user_id;
    NSMutableArray *notification;
    NSString *user_id0;
    int index;
    NSMutableArray *segment1;
    NSMutableArray *segment2;
    NSString *cart_nmuber;
    NSString *u_id;
}
@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self user_payment_histroy];
    [self addSegmentedControl];
    [_segment_controller setSelectedSegmentIndex:index];
    UISwipeGestureRecognizer *leftswipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(SwipeRecognizer:)];
    leftswipe.delegate = self;
    leftswipe.direction = UISwipeGestureRecognizerDirectionLeft;
    UISwipeGestureRecognizer *rightswipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(SwipeRecognizer:)];
    rightswipe.delegate = self;
    rightswipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.table_view addGestureRecognizer: leftswipe];
    [self.table_view addGestureRecognizer: rightswipe];
    [_segment_controller setSelectedSegmentIndex:index];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) SwipeRecognizer:(UISwipeGestureRecognizer *)sender
{
    if ( sender.direction == UISwipeGestureRecognizerDirectionLeft )
    {
        
        if (index < 1) {
            NSLog(@" *** SWIPE LEFT ***");
            
            index++;
            [sender setEnabled:YES ];
            //
            if (index == 0) {
                _segment_controller.selectedSegmentIndex =0;
                //[self restro];
                [self.table_view reloadData];
            }
            else if (index == 1) {
                _segment_controller.selectedSegmentIndex = 1;
               // [self menu];
                [self.table_view reloadData];
                
            }
            
//            else if(index==2)
//            {
//                index = 2;
//                _segment_controller.selectedSegmentIndex = 2;
//               // [self order];
//                [self.table_view reloadData];
//            }
            [sender setEnabled:YES];
        } }
    if ( sender.direction == UISwipeGestureRecognizerDirectionRight ){
        
        if (index > 0) {
            NSLog(@" *** SWIPE RIGHT ***");
            index--;
            [sender setEnabled:YES ];
            if (index ==1) {
                _segment_controller.selectedSegmentIndex=1;
               // [self menu];
                [self.table_view reloadData];
            }
//            else if (index ==2) {
//                _segment_controller.selectedSegmentIndex=2;
//                [self order];
//                [self.table_view reloadData];
//            }
            else if(index<=0){
                index = 0;
                _segment_controller.selectedSegmentIndex = 0;
              //  [self restro];
                [self.table_view reloadData];
            }
            [sender setEnabled:YES];
        }
    }
}

-(void)user_payment_histroy
{
    notification = [[NSMutableArray alloc]init];
    user_id = [[NSUserDefaults standardUserDefaults]stringForKey:@"u_id"];
    
    NSMutableDictionary *dictResultSignIn=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *dicSubmit = [[NSMutableDictionary alloc]init];
    [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood//api.php";
    //http://vps291033.ovh.net/turbofood//api.php?method=poppup_notification_list&u_id=12
    [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
    [WebServiceViewController wsVC].strMethodName = @"poppup_notification_list";
    
    [dicSubmit setObject:user_id forKey:@"u_id"];
    dictResultSignIn = [[WebServiceViewController wsVC] sendRequestWithParameter:dicSubmit];
    if (dictResultSignIn != Nil || dictResultSignIn != NULL)
    {
      
        if ([[dictResultSignIn objectForKey:@"status"]integerValue] == 0)
        {
         
            NSDictionary *resposne = [dictResultSignIn objectForKey:@"result"];
            for (NSDictionary*dic in resposne)
            {
                [notification addObject:dic];
            
               //[[self table_view]reloadData];
            
                }
    }
    else
    {
        
    }
 }

}
-(void)viewWillAppear:(BOOL)animated
{
    segment1 = [[NSMutableArray alloc]init];
    segment2 = [[NSMutableArray alloc]init];
    for (int i=0; i<notification.count; i++) {
        NSString *strCommit =[[notification objectAtIndex:i] valueForKey:@"o_complit"];
        if ([strCommit isEqualToString:@"0"])
        {
            
            [segment1 addObject:[notification objectAtIndex:i]];
        }
        else
        {
            
            [segment2 addObject:[notification objectAtIndex:i]];

        }
        
    }
    [self.table_view reloadData];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_segment_controller.selectedSegmentIndex == 0)
    {
        return segment1.count;        
    }
    else
    {
        return segment2.count;
    }
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *complete	 = @"Achevée";
    NSString *pending = @"En attente";
    
    static NSString*CellIndentifier=@"Cell";
    
    NotificationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    
    if(!cell){
        cell=[[NotificationTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier];
    }
    if (_segment_controller.selectedSegmentIndex == 0 || index == 0)
    {
       
        //if ([[[notification objectAtIndex:indexPath.row]valueForKey:@"o_complit"]isEqualToString:@"0"]) {
            
            cell.order_btn.text = [NSString stringWithFormat:@"%@",pending];
            cell.order_date.text = [[segment1 objectAtIndex:indexPath.row] valueForKey:@"pay_date"] ;
            cell.order_num.text =[[segment1 objectAtIndex:indexPath.row] valueForKey:@"o_tran_id"] ;
            cell.pay_type.text =[[segment1 objectAtIndex:indexPath.row] valueForKey:@"trans_type"] ;
            cell.restro_name.text =[[segment1 objectAtIndex:indexPath.row] valueForKey:@"r_name"] ;
            cell.order_date.text =[[segment1 objectAtIndex:indexPath.row] valueForKey:@"pay_date"] ;
            cell.order_price.text =[[segment1 objectAtIndex:indexPath.row] valueForKey:@"total"] ;
            cell.order_time.text = [[segment1 objectAtIndex:indexPath.row]valueForKey:@"delivery"];
        //}

    }
   else if (_segment_controller.selectedSegmentIndex == 1 || index == 1)
   {
       
       

       //if ([[[notification objectAtIndex:indexPath.row]valueForKey:@"o_complit"]isEqualToString:@"1"])
       //{
           cell.order_btn.text = [NSString stringWithFormat:@"%@",complete];
           cell.order_date.text = [[segment2 objectAtIndex:indexPath.row] valueForKey:@"pay_date"] ;
           cell.order_num.text =[[segment2 objectAtIndex:indexPath.row] valueForKey:@"o_tran_id"] ;
           cell.pay_type.text =[[segment2 objectAtIndex:indexPath.row] valueForKey:@"trans_type"] ;
           cell.restro_name.text =[[segment2 objectAtIndex:indexPath.row] valueForKey:@"r_name"] ;
           cell.order_date.text =[[segment2 objectAtIndex:indexPath.row] valueForKey:@"pay_date"] ;
           cell.order_price.text =[[segment2 objectAtIndex:indexPath.row] valueForKey:@"total"] ;
           cell.order_time.text = [[segment2 objectAtIndex:indexPath.row]valueForKey:@"delivery"];
      // }

   
    
   }
    

    self.table_view.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


- (IBAction)menu_btn:(id)sender {
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

- (IBAction)home_btn:(id)sender {
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

- (IBAction)SegmentToggle:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0)
    {
        _segment_controller.selectedSegmentIndex = 0;
        index = 0;
        [self.table_view reloadData];
        
        //[[sender.subviews objectAtIndex:0]backgroundColor:[UIColor greenColor]];
        
        
    }
    else if (sender.selectedSegmentIndex == 1){
        _segment_controller.selectedSegmentIndex = 1;
        index = 1;
         [self.table_view reloadData];
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
    [MBProgressHUD showHUDAddedTo:self.table_view animated:YES];
    
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
    
    [MBProgressHUD hideHUDForView:self.table_view animated:YES];
}


- (void) addSegmentedControl {
    
    
    NSArray * segmentItems = [NSArray arrayWithObjects: @"COMMANDES ACTIVES", @"COMMANES PASSEES", nil];
    _segment_controller = [[UISegmentedControl alloc] initWithItems: segmentItems];
    _segment_controller.segmentedControlStyle = UISegmentedControlStyleBar;
    _segment_controller.frame = CGRectMake(0,111,321,29);
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


@end
