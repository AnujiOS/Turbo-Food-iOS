//
//  FavorisViewController.m
//  Turbo Food
//
//  Created by ganesh on 3/28/16.
//  Copyright © 2016 Ravi. All rights reserved.
//

#import "FavorisViewController.h"
#import "MFSideMenu.h"
#import "WebServiceViewController.h"
#import "FavorisTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ViewController4.h"
#import "MenuSelectionViewController.h"
#import "ViewController2.h"
#import "NotificationViewController.h"
#import "ViewController6.h"

@interface FavorisViewController ()
{
    NSString *u_id;
    int index;
    NSMutableArray * Arry;
    NSString *order_id;
    NSString *user_id;
    NSString *o_id;
    NSString *cart_nmuber;
    NSMutableArray *menu;
    NSArray *subcell_arry;
    BOOL sub_cellexpand;
    BOOL Grand_cell;
    
   NSInteger index1;
   
    
}
@end

@implementation FavorisViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addSegmentedControl];
    [self restro];
   UISwipeGestureRecognizer *leftswipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(SwipeRecognizer:)];
    leftswipe.delegate = self;
    leftswipe.direction = UISwipeGestureRecognizerDirectionLeft;
    UISwipeGestureRecognizer *rightswipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(SwipeRecognizer:)];
    rightswipe.delegate = self;
    rightswipe.direction = UISwipeGestureRecognizerDirectionRight;
    [_segment_controller setSelectedSegmentIndex:index];
    [self.tableview addGestureRecognizer: leftswipe];
    [self.tableview addGestureRecognizer: rightswipe];
   // [self.tableview setBackgroundView:nil];
    //[self.tableview setBackgroundColor:[UIColor clearColor]];
    self.tableview.backgroundColor = [UIColor clearColor];
}

- (void) addSegmentedControl {
    NSArray * segmentItems = [NSArray arrayWithObjects: @"Restaurant", @"Produit",@"Panier", nil];
    _segment_controller = [[UISegmentedControl alloc] initWithItems: segmentItems];
    _segment_controller.segmentedControlStyle = UISegmentedControlStyleBar;
     _segment_controller.frame = CGRectMake(0 , 118, 320, 29);
   //_segment_controller.selectedSegmentIndex = 0;
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
    [self.view addSubview:_tableview];
}

- (void) SwipeRecognizer:(UISwipeGestureRecognizer *)sender
{
    if ( sender.direction == UISwipeGestureRecognizerDirectionLeft )
    {
        
        if (index < 2) {
        NSLog(@" *** SWIPE LEFT ***");
        
        index++;
        [sender setEnabled:YES ];
       //
        if (index == 0) {
            _segment_controller.selectedSegmentIndex =0;
            [self restro];
            [self.tableview reloadData];
                    }
        else if (index == 1) {
            _segment_controller.selectedSegmentIndex = 1;
            [self menu];
            [self.tableview reloadData];
           
        }
        
        else if(index==2)
        {
            index = 2;
            _segment_controller.selectedSegmentIndex = 2;
            [self order];
            [self.tableview reloadData];
        }
      [sender setEnabled:YES];
        } }
    if ( sender.direction == UISwipeGestureRecognizerDirectionRight ){
        
        if (index > 0) {
            NSLog(@" *** SWIPE RIGHT ***");
                    index--;
        [sender setEnabled:YES ];
        if (index ==1) {
            _segment_controller.selectedSegmentIndex=1;
            [self menu];
            [self.tableview reloadData];
        }
        else if (index ==2) {
            _segment_controller.selectedSegmentIndex=2;
           [self order];
            [self.tableview reloadData];
        }
        else if(index<=0){
            index = 0;
             _segment_controller.selectedSegmentIndex = 0;
            [self restro];
            [self.tableview reloadData];
        }
       [sender setEnabled:YES];
        }
    }
}
- (IBAction)SegmentToggle:(UISegmentedControl *)sender {
    // lazy load data for a segment choice (write this based on your data)
    if (sender.selectedSegmentIndex == 0)
    {
        _segment_controller.selectedSegmentIndex = 0;
        index = 0;
        [self restro];
    }
    else if(sender.selectedSegmentIndex == 1)
    {
        _segment_controller.selectedSegmentIndex = 1;
        index = 1;
        [self menu];
        

    }
    else if(sender.selectedSegmentIndex == 2)
    {
        _segment_controller.selectedSegmentIndex = 2;
        index = 2;
        [self order];
    }
    // reload data based on the new index
    [self.tableview reloadData];
    
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
            //  PaiementViewController *VC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"PaiementViewController"];
            // [self.navigationController pushViewController:VC2 animated:YES];
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    FavorisTableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell=[[FavorisTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // [cell setBackgroundColor:[UIColor colorWithRed:.8 green:.8 blue:1 alpha:1]];
    UIView* backgroundView =  [ [ UIView alloc ] initWithFrame:CGRectZero ] ;
   // backgroundView.backgroundColor = [ UIColor grayColor ];
    backgroundView.backgroundColor = [UIColor clearColor];
    cell.backgroundView = backgroundView;
    
    for ( UIView* view in cell.contentView.subviews )
    {
        view.backgroundColor = [ UIColor clearColor ];
    }
    if (_segment_controller.selectedSegmentIndex == 0 || index == 0)
    {
       
    if (index == 0) {
        cell.menu_image.hidden = YES;
        cell.menu_lbl.hidden = YES;
        cell.Lbl_name.hidden = NO;
        cell.Image_view.hidden = NO;
        
        tableView.scrollEnabled = YES;
        _segment_controller.selectedSegmentIndex = index;
        cell.userInteractionEnabled = YES;
        cell.Lbl_name.enabled = YES;
        cell.order_fav.hidden = YES;
        cell.Lbl_name.text = [[restroArry objectAtIndex:indexPath.row]objectForKey:@"r_name"];
        [cell.Image_view sd_setImageWithURL:[NSURL URLWithString:[[restroArry objectAtIndex:indexPath.row] objectForKey:@"img_full"]]placeholderImage:[UIImage imageNamed:@"star_image.png"]];
        NSString *disable =[[restroArry objectAtIndex:indexPath.row]valueForKey:@"disable"];
        NSString *show =[[NSString alloc]initWithFormat:@"hide"];
        if ([disable isEqualToString:show])
        {
            cell.Lbl_name.enabled = NO;
            cell.userInteractionEnabled = NO;
        }
        NSString *status = [[restroArry objectAtIndex:indexPath.row]valueForKey:@"status"];
        if ([status isEqualToString:@"1"])
        {
            cell.userInteractionEnabled = NO;
            cell.Lbl_name.enabled = NO;
        }
        
           }
    }
    else if (_segment_controller.selectedSegmentIndex == 1 || index == 1){
    if (index == 1)
    {
        cell.menu_image.hidden = YES;
        cell.menu_lbl.hidden = YES;
        cell.Lbl_name.hidden = NO;
        cell.Image_view.hidden = NO;
        
        
        tableView.scrollEnabled = YES;
        cell.userInteractionEnabled = YES;
        cell.Lbl_name.enabled = YES;
        cell.order_fav.hidden = YES;
     _segment_controller.selectedSegmentIndex = index;
    cell.Lbl_name.text = [[restroArry objectAtIndex:indexPath.row]objectForKey:@"sub_cat_name"];
        [cell.Image_view sd_setImageWithURL:[NSURL URLWithString:[[restroArry objectAtIndex:indexPath.row] objectForKey:@"img_full"]]placeholderImage:[UIImage imageNamed:@"star_image.png"]];
        
        NSString *disable =[[restroArry objectAtIndex:indexPath.row]valueForKey:@"disable"];
        NSString *show =[[NSString alloc]initWithFormat:@"hide"];

        if ([disable isEqualToString:show])
        {
            cell.Lbl_name.enabled = NO;
            cell.userInteractionEnabled = NO;
        }
        NSString *status = [[restroArry objectAtIndex:indexPath.row]valueForKey:@"status"];
        if ([status isEqualToString:@"1"])
        {
            cell.userInteractionEnabled = NO;
            cell.Lbl_name.enabled = NO;
        }
    }
    }
    else if(_segment_controller.selectedSegmentIndex ==2  || index == 2){
     if(index ==2)
    {
        //tableView.scrollEnabled = NO;
//        if(!sub_cellexpand){
//        cell.order_fav.hidden = NO;
//        cell.userInteractionEnabled = YES;
//        cell.Lbl_name.enabled = YES;
//        cell.Lbl_name.text =[[restroArry objectAtIndex:indexPath.row]objectForKey:@"daate"];
//        [cell.Image_view sd_setImageWithURL:[NSURL URLWithString:[[restroArry objectAtIndex:indexPath.row] objectForKey:@"rest_image"]]placeholderImage:[UIImage imageNamed:@"star_image.png"]];
//            cell.order_fav.hidden = NO;
//       [cell setIndentationLevel:[[[restroArry objectAtIndex:indexPath.row] valueForKey:@"id"] intValue]];
//        
//        NSString *disable =[[restroArry objectAtIndex:indexPath.row]valueForKey:@"disable"];
//        NSString *show =[[NSString alloc]initWithFormat:@"hide"];
//        
//        if ([disable isEqualToString:show])
//        {
//            cell.Lbl_name.enabled = NO;
//            cell.userInteractionEnabled = NO;
//        }
//        NSString *status = [[restroArry objectAtIndex:indexPath.row]valueForKey:@"status"];
//            if ([status isEqualToString:@"1"])
//            {
//                cell.userInteractionEnabled = NO;
//                cell.Lbl_name.enabled = NO;
//            }
//        }
//        else if (sub_cellexpand){
//            if (Grand_cell) {
//                if(sub_cellexpand){
//                    cell.order_fav.hidden = NO;
//                    cell.userInteractionEnabled = YES;
//                    cell.Lbl_name.enabled = YES;
//                    cell.Lbl_name.text =[[restroArry objectAtIndex:indexPath.row]objectForKey:@"daate"];
//                    [cell.Image_view sd_setImageWithURL:[NSURL URLWithString:[[restroArry objectAtIndex:indexPath.row] objectForKey:@"rest_image"]]placeholderImage:[UIImage imageNamed:@"star_image.png"]];
//                    cell.order_fav.hidden = NO;
//                    [cell setIndentationLevel:[[[restroArry objectAtIndex:indexPath.row] valueForKey:@"id"] intValue]];
//                    
//                    NSString *disable =[[restroArry objectAtIndex:indexPath.row]valueForKey:@"disable"];
//                    NSString *show =[[NSString alloc]initWithFormat:@"hide"];
//                    
//                    if ([disable isEqualToString:show])
//                    {
//                        cell.Lbl_name.enabled = NO;
//                        cell.userInteractionEnabled = NO;
//                    }
//                    NSString *status = [[restroArry objectAtIndex:indexPath.row]valueForKey:@"status"];
//                    if ([status isEqualToString:@"1"])
//                    {
//                        cell.userInteractionEnabled = NO;
//                        cell.Lbl_name.enabled = NO;
//                    }
//                }
//                 if (sub_cellexpand){
//                    
//                    
//                    [cell.Image_view sd_setImageWithURL:[NSURL URLWithString:[[subcell_arry objectAtIndex:index1] objectForKey:@"img_full"]]placeholderImage:[UIImage imageNamed:@"star_image.png"]];//img_full
//                    cell.Lbl_name.text = [[subcell_arry objectAtIndex:index1]valueForKey:@"sub_cat_name"];
//                    cell.order_fav.hidden = YES;
//                    //sub_cat_name
//                    
//                }
//
//            }
//            else{
//          [cell.Image_view sd_setImageWithURL:[NSURL URLWithString:[[subcell_arry objectAtIndex:index1] objectForKey:@"img_full"]]placeholderImage:[UIImage imageNamed:@"star_image.png"]];//img_full
//        cell.Lbl_name.text = [[subcell_arry objectAtIndex:index1]valueForKey:@"sub_cat_name"];
//            cell.order_fav.hidden = YES;
//        //sub_cat_name
//            }
//        }
        
//                            cell.userInteractionEnabled = YES;
//                            cell.Lbl_name.enabled = YES;
//                            cell.Lbl_name.text =[[restroArry objectAtIndex:indexPath.row]objectForKey:@"sub_cat_name"];
//                            [cell.Image_view sd_setImageWithURL:[NSURL URLWithString:[[restroArry objectAtIndex:indexPath.row] objectForKey:@"img_full"]]placeholderImage:[UIImage imageNamed:@"star_image.png"]];
                            NSDictionary *d=[restroArry objectAtIndex:indexPath.row];
        if([d valueForKey:@"day"]){
           tableView.estimatedRowHeight = 80;
                            cell.order_fav.hidden = NO;
            cell.menu_image.hidden = YES;
            cell.menu_lbl.hidden = YES;
            cell.Lbl_name.hidden = NO;
            cell.Image_view.hidden = NO;

            cell.userInteractionEnabled = YES;
            cell.Lbl_name.enabled = YES;
            cell.Lbl_name.text =[[restroArry objectAtIndex:indexPath.row]objectForKey:@"sub_cat_name"];
            [cell.Image_view sd_setImageWithURL:[NSURL URLWithString:[[restroArry objectAtIndex:indexPath.row] objectForKey:@"img_full"]]placeholderImage:[UIImage imageNamed:@"star_image.png"]];
        }
        else{
            tableView.estimatedRowHeight = 50;
            cell.menu_image.hidden = NO;
            cell.menu_lbl.hidden = NO;
            cell.Lbl_name.hidden = YES;
            cell.Image_view.hidden = YES;
            
            cell.order_fav.hidden = YES;
            cell.userInteractionEnabled = YES;
            cell.menu_lbl.enabled = YES;
            cell.menu_lbl.text =[[restroArry objectAtIndex:indexPath.row]objectForKey:@"sub_cat_name"];
            [cell.menu_image sd_setImageWithURL:[NSURL URLWithString:[[restroArry objectAtIndex:indexPath.row] objectForKey:@"img_full"]]placeholderImage:[UIImage imageNamed:@"star_image.png"]];

            
        }
                            [cell setIndentationLevel:[[[restroArry objectAtIndex:indexPath.row] objectForKey:@"o_id"] intValue]];
        
                            NSString *disable =[[restroArry objectAtIndex:indexPath.row]valueForKey:@"disable"];
                            NSString *show =[[NSString alloc]initWithFormat:@"hide"];
        
                            if ([disable isEqualToString:show])
                            {
                                cell.Lbl_name.enabled = NO;
                                cell.userInteractionEnabled = NO;
                            }
                            NSString *status = [[restroArry objectAtIndex:indexPath.row]valueForKey:@"status"];
                            if ([status isEqualToString:@"1"])
                            {
                                cell.userInteractionEnabled = NO;
                                cell.Lbl_name.enabled = NO;
                            }
        
         }
    }
    self.tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    cell.backgroundColor = [UIColor clearColor];
        return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
        return restroArry.count ;
   
   }

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FavorisTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    Arry = [[NSMutableArray alloc]init];
    
    Arry = [restroArry objectAtIndex:indexPath.row];
    NSString *fav = [Arry valueForKey:@"favourite"];
    NSString *r_id = [Arry valueForKey:@"id"];
    if (_segment_controller.selectedSegmentIndex == 0 || index == 0){
        
        [[NSUserDefaults standardUserDefaults] setObject:r_id forKey:@"favr_id"];
       [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSUserDefaults standardUserDefaults] setObject:fav forKey:@"fav_fav"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSData *dataSave = [NSKeyedArchiver archivedDataWithRootObject:Arry];
        [[NSUserDefaults standardUserDefaults] setObject:dataSave forKey:@"resttttt_id"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        ViewController4 *vc4 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController4"];
        vc4.flag=@"Favrit";
        [self.navigationController pushViewController:vc4 animated:YES];
    }
    else if (_segment_controller.selectedSegmentIndex == 1 || index == 1){
        
        NSData *dataSave = [NSKeyedArchiver archivedDataWithRootObject:Arry];
        [[NSUserDefaults standardUserDefaults] setObject:dataSave forKey:@"Menuuu"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        MenuSelectionViewController *mv = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuSelectionViewController"];
        mv.flag_menu=@"Favrit_Menu";
        [self.navigationController pushViewController:mv animated:YES];
    }
    else if(_segment_controller.selectedSegmentIndex == 2 || index == 2){
        
        order_id = [Arry valueForKey:@"o_id"];
        
        subcell_arry = [[NSArray alloc]init];
       // [tableView deselectRowAtIndexPath:indexPath animated:YES];
//        NSDictionary *d=[restroArry objectAtIndex:indexPath.row];
//        if([d valueForKey:@"order_menu"]) {
//            subcell_arry=[d valueForKey:@"order_menu"];
//            BOOL isAlreadyInserted=NO;
//            for(NSDictionary *dInner in subcell_arry ){
//                NSInteger index1=[restroArry indexOfObjectIdenticalTo:dInner];
//                isAlreadyInserted=(index1>0 && index1!=NSIntegerMax);
//                if(isAlreadyInserted) break;
//                
//            }
//            if(isAlreadyInserted) {
//                [self miniMizeThisRows:subcell_arry];
//                sub_cellexpand = NO;
//            } else {
//                sub_cellexpand = YES;
//                NSUInteger count=indexPath.row+1;
//                NSMutableArray *arCells=[NSMutableArray array];
//                for(NSDictionary *dInner in subcell_arry ) {
//                    [arCells addObject:[NSIndexPath indexPathForRow:count inSection:0]];
//                    [restroArry insertObject:dInner atIndex:count++];
//                }
//                [tableView insertRowsAtIndexPaths:arCells withRowAnimation:UITableViewRowAnimationLeft];
//            }
//        }
//        
//        
//        else{
//            NSLog(@"Cell selected");
//            [self favourite_order_add_to_cart ];
//            
//            //ViewController6
//        }
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        NSDictionary *d=[restroArry objectAtIndex:indexPath.row];
        if([d valueForKey:@"order_menu"]) {
            NSArray *ar=[d valueForKey:@"order_menu"];
            BOOL isAlreadyInserted=NO;
            for(NSDictionary *dInner in ar ){
                NSInteger index=[restroArry indexOfObjectIdenticalTo:dInner];
                isAlreadyInserted=(index>0 && index!=NSIntegerMax);
               //  Grand_cell = NO;
                if(isAlreadyInserted) break;
            }
            if(isAlreadyInserted) {
                [self miniMizeThisRows:ar];
               // Grand_cell = NO;
            } else {
                NSUInteger count=indexPath.row+1;
                NSMutableArray *arCells=[NSMutableArray array];
                for(NSDictionary *dInner in ar ) {
                    [arCells addObject:[NSIndexPath indexPathForRow:count inSection:0]];
                    [restroArry insertObject:dInner atIndex:count++];
                    Grand_cell = YES;
                }
                [tableView insertRowsAtIndexPaths:arCells withRowAnimation:UITableViewRowAnimationTop];
            }
        }
        else{
                        NSLog(@"Cell selected");
                        [self favourite_order_add_to_cart ];
            
                        //ViewController6
                    }

    }
   
}

-(void)miniMizeThisRows:(NSArray*)ar{
    for(NSDictionary *dInner in ar ) {
        NSUInteger indexToRemove=[restroArry indexOfObjectIdenticalTo:dInner];
        NSArray *arInner=[dInner valueForKey:@"order_menu"];
        if(arInner && [arInner count]>0){
            [self miniMizeThisRows:arInner];
        }
        if([restroArry indexOfObjectIdenticalTo:dInner]!=NSNotFound) {
            [restroArry removeObjectIdenticalTo:dInner];
            [self.tableview deleteRowsAtIndexPaths:
             [NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexToRemove inSection:0]]
                                  withRowAnimation:UITableViewRowAnimationBottom];
        }
    }
}
- (IBAction)order_fav:(id)sender {
//    UIButton *btn = (UIButton *)sender;
//    restroArry2 = [[NSMutableArray alloc]init];
//    tempery_id = [[restroArry1 objectAtIndex:btn.tag ] valueForKey:@"temp_id"];
//    u_id = [[NSUserDefaults standardUserDefaults]stringForKey:@"u_id"];
//    CGPoint touchPoint = [sender convertPoint:CGPointZero toView:self.tableview];
//    NSIndexPath *indexPath = [self.tableview indexPathForRowAtPoint:touchPoint];
//    [restroArry1 removeObjectAtIndex:indexPath.row];
//    [self.tableview reloadData];
    
    UIButton *btn = (UIButton *)sender;
    UIImage *img = [UIImage imageNamed:@"star_image.png"];
    UIImage *img1 = [UIImage imageNamed:@"selected_star_image.png"];
    CGPoint touchPoint = [sender convertPoint:CGPointZero toView:self.tableview];
    NSIndexPath *indexPath = [self.tableview indexPathForRowAtPoint:touchPoint];
    //tempery_id = [[restroArry1 objectAtIndex:btn.tag ] valueForKey:@"temp_id"];

     order_id = [[restroArry objectAtIndex:btn.tag]valueForKey:@"o_id"];
    //[[NSUserDefaults standardUserDefaults]setObject:order_id forKey:@"order_id"];
    //[[NSUserDefaults standardUserDefaults] synchronize];
    
//       [restroArry removeObjectAtIndex:indexPath.row];
       [self.tableview reloadData];

    [self order_deselect];
    [self.tableview reloadData];
//    if ([btn isSelected]) {
//        [btn setImage:img1 forState:UIControlStateNormal];
//        [self order_deselect];
//        [[self tableview]reloadData];
//    }
//    else
//    {
//        [self order_deselect];
//        [btn setImage:img forState:UIControlStateNormal];
//        //[self order_deselect];
//        [[self tableview]reloadData];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)menu_btn:(id)sender {
    
     [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
    
}
//favourite_order_add_to_cart

-(void)favourite_order_add_to_cart
{
    //restroArry = [[NSMutableArray alloc]init];
    
    u_id = [[NSUserDefaults standardUserDefaults]
            stringForKey:@"u_id"];
   
    NSMutableDictionary *dictResultSignIn=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *dicSubmit = [[NSMutableDictionary alloc]init];
    [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood//api.php";
    
    [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
    [WebServiceViewController wsVC].strMethodName = @"favourite_order_add_to_cart";
    
    [dicSubmit setObject:u_id forKey:@"u_id"];
    [dicSubmit setObject:order_id forKey:@"o_id"];
    dictResultSignIn = [[WebServiceViewController wsVC] sendRequestWithParameter:dicSubmit];
    
    if (dictResultSignIn != Nil || dictResultSignIn != NULL)
    {
        NSLog(@"dictResultSubmit = %@",dictResultSignIn);
        
        if ([[dictResultSignIn objectForKey:@"status"]integerValue] == 0)
        {
            NSDictionary *response=[dictResultSignIn objectForKey:@"result"];
//            NSMutableArray *desc = [[NSMutableArray alloc]init];
//            [desc addObject:response];
//            for (NSDictionary*dic  in response)
//            {
//                [restroArry addObject:dic];
//            }
//            [[self tableview]reloadData];
            ViewController6 *vc6 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController6"];
            [self.navigationController pushViewController:vc6 animated:YES];
            
        }
        else
        {
            
         
        }
    }
    
}

-(void)restro
{
    restroArry = [[NSMutableArray alloc]init];
    
    u_id = [[NSUserDefaults standardUserDefaults]
            stringForKey:@"u_id"];
    NSMutableDictionary *dictResultSignIn=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *dicSubmit = [[NSMutableDictionary alloc]init];
    [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood//api.php";
    
    [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
    [WebServiceViewController wsVC].strMethodName = @"list_favorite_rest";
    
    [dicSubmit setObject:u_id forKey:@"u_id"];
    dictResultSignIn = [[WebServiceViewController wsVC] sendRequestWithParameter:dicSubmit];
    
    if (dictResultSignIn != Nil || dictResultSignIn != NULL)
    {
        NSLog(@"dictResultSubmit = %@",dictResultSignIn);
        
        if ([[dictResultSignIn objectForKey:@"status"]integerValue] == 0)
        {
            NSDictionary *response=[dictResultSignIn objectForKey:@"result"];
            NSMutableArray *desc = [[NSMutableArray alloc]init];
            [desc addObject:response];
            for (NSDictionary*dic  in response)
            {
                [restroArry addObject:dic];
            }
            [[self tableview]reloadData];
        }
        else
        {
            
        }
       o_id = [NSString stringWithFormat:@"%@",[restroArry valueForKey:@"o_id"]];
        [[NSUserDefaults standardUserDefaults]setObject:o_id forKey:@"o_id"];
        [[NSUserDefaults standardUserDefaults] synchronize];

    }
    
}

-(void)menu
{
    restroArry = [[NSMutableArray alloc]init];
    
    u_id = [[NSUserDefaults standardUserDefaults]
            stringForKey:@"u_id"];
    NSMutableDictionary *dictResultSignIn=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *dicSubmit = [[NSMutableDictionary alloc]init];
    [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood//api.php";
    [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
    [WebServiceViewController wsVC].strMethodName = @"list_favourite_menu";
    
    [dicSubmit setObject:u_id forKey:@"u_id"];
    dictResultSignIn = [[WebServiceViewController wsVC] sendRequestWithParameter:dicSubmit];
    
    if (dictResultSignIn != Nil || dictResultSignIn != NULL)
    {
        if ([[dictResultSignIn objectForKey:@"status"]integerValue] == 0)
        {
            NSDictionary *response=[dictResultSignIn objectForKey:@"result"];
            NSMutableArray *desc = [[NSMutableArray alloc]init];
            [desc addObject:response];
            for (NSDictionary*dic  in response)
            {
                [restroArry addObject:dic];
                [[self tableview]reloadData];
            }
        }
        else
        {
        }
    }
}

-(void)order
{
    restroArry = [[NSMutableArray alloc]init];
    
    u_id = [[NSUserDefaults standardUserDefaults]
            stringForKey:@"u_id"];
    NSMutableDictionary *dictResultSignIn=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *dicSubmit = [[NSMutableDictionary alloc]init];
    [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood//api.php";
    
    [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
    [WebServiceViewController wsVC].strMethodName = @"ios_list_favourite_order";
    
    [dicSubmit setObject:u_id forKey:@"u_id"];
    dictResultSignIn = [[WebServiceViewController wsVC] sendRequestWithParameter:dicSubmit];
    if (dictResultSignIn != Nil || dictResultSignIn != NULL)
    {
        if ([[dictResultSignIn objectForKey:@"status"]integerValue] == 0)
        {
             menu = [[NSMutableArray alloc] init];
            NSDictionary *response=[dictResultSignIn objectForKey:@"result"];
            NSMutableArray *desc = [[NSMutableArray alloc]init];
            [desc addObject:response];
            for (NSDictionary*dic  in response)
            {
                [restroArry addObject:dic];
                [[self tableview]reloadData];
                
                menu = [restroArry valueForKey:@"order_menu"];
            }
           
            
        }
        else
        {
            
        }
        
    }
}

-(void)order_deselect
{
    restroArry = [[NSMutableArray alloc]init];
    
    u_id = [[NSUserDefaults standardUserDefaults]
            stringForKey:@"u_id"];
    NSMutableDictionary *dictResultSignIn=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *dicSubmit = [[NSMutableDictionary alloc]init];
    [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood//api.php";
    
    [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
    [WebServiceViewController wsVC].strMethodName = @"update_favourite_order";
    
    [dicSubmit setObject:u_id forKey:@"u_id"];
    [dicSubmit setObject:order_id forKey:@"o_id"];
    
    dictResultSignIn = [[WebServiceViewController wsVC] sendRequestWithParameter:dicSubmit];
    
    if (dictResultSignIn != Nil || dictResultSignIn != NULL)
    {
        if ([[dictResultSignIn objectForKey:@"status"]integerValue] == 0)
        {
            NSDictionary *response=[dictResultSignIn objectForKey:@"result"];
            NSLog(@"Print %@", response);
            [self order];
            [[self tableview]reloadData];
        }
        else
        {
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
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
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
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
   
    Grand_cell = YES;
}

@end
