//
//  ViewController2.m
//  Turbo Food
//
//  Created by Ravi on 2/23/16.
//  Copyright (c) 2016 Ravi. All rights reserved.
//

#import "ViewController2.h"
#import "MFSideMenu.h"
#import "SlideMenuViewController.h"
#import "Base64.h"
#import "UIImageView+WebCache.h"

#import "NIDropDown.h"
#import "ViewController4.h"
#import "WebServiceViewController.h"
#import "ViewController6.h"
#import "MBProgressHUD.h"
#import "NotificationViewController.h"
#import "CustomSearchTableViewCell.h"
#import "HotelCellTableViewCell.h"
#import  "QuartzCore/QuartzCore.h"

#define JSON_URL @"http://vps291033.ovh.net/turbofood//api.php?method=list_rest"


@interface ViewController2 ()<UISearchBarDelegate>

{
    
    NSMutableArray *searchResults;
    NSMutableArray *selectedrow;
    BOOL buttonCurrentStatus;
    
    BOOL isFilterclicked;
    UIButton *btn;
    UIButton *btn1;
    NSString *u_id;
    CGPoint touchPoint;

    NSMutableArray *keyword_sep;
    NSString *status;
    NSString *cart_nmuber;
    NSMutableArray *searchpaytype;
    NSString *search;
    NSMutableArray *serach;
    NSMutableArray *fav_arry;
    
    NSString *livraison ;
    NSString *emporter;
    NSString *especes;
    NSString *cc;
    NSString *latitude_string;
    NSString *longitude_string;
    int i ;
    int j ;
    float latitude;
    float longitude ;
    NSString *fav_id;
    NSString *fav;
    NSString *favourite;
    NSMutableArray *search_keyword;
    NSMutableArray *searchArry;
    
    ///
    UILabel *noResultLabel;
    BOOL small_display;
    BOOL big_display;
    NSString *favc;
    NSString *temp;
   // HotelCellTableViewCell *cell;
  //  CustomSearchTableViewCell *Cell;
    
}
@end

@implementation ViewController2

@synthesize btnSelect,menu_view;

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIImage *image1 = [UIImage imageNamed:@"actionbar_bg.png"];
//    [[UINavigationBar appearance] setBackgroundImage:image1 forBarMetrics:UIBarMetricsDefault];
    // Create your image
     //self.search_autocomplete_table.hidden=YES;
   // [self.searchBar setShowsCancelButton:NO animated:NO];
    //[[UISearchBar appearance] setSearchFieldBackgroundImage:[UIImage imageNamed:@"txt_bg_01.png"]forState:UIControlStateNormal];
    self.search_autocomplete_table.layer.borderWidth = 2.0;
    self.search_autocomplete_table.layer.borderColor = [UIColor clearColor].CGColor;

    search_keyword =[[NSMutableArray alloc]init];
    searchArry = [[NSMutableArray alloc]init];
    self.tableView.hidden = YES;
    self.search_autocomplete_table.hidden = YES;
   [self convertButtonTitle:@"Cancel" toTitle:@"Annuller" inView:self.searchBar];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    [locationManager requestAlwaysAuthorization]; //Note this one
    [locationManager requestWhenInUseAuthorization];
    
    latitude = locationManager.location.coordinate.latitude;
    longitude = locationManager.location.coordinate.longitude;
    i = 0;
    j= 1;
    
    livraison = [NSString stringWithFormat:@"%d",i];
    especes = [NSString stringWithFormat:@"%d",i];
    cc = [NSString stringWithFormat:@"%d",i];
    emporter = [NSString stringWithFormat:@"%d",i];
    longitude_string = [NSString stringWithFormat:@"%d",i];
    latitude_string =[NSString stringWithFormat:@"%d",i];
    self.title = NSLocalizedString(@"SearchBarTitle", @"");
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];    // use the table view background color
    
    self.navigationController.navigationBarHidden = YES;
    
    [self tabledisplay];
    
    [btnSelect setTitle:@"Filtre +" forState:UIControlStateNormal];
    menu_view.hidden = YES;
    self.tableView.frame = CGRectMake(0,220,self.tableView.frame.size.width,370);
    
     btnSelect.frame = CGRectMake(0, 180, CGRectGetWidth(self.view.frame), 40);
    searchArry = [[NSMutableArray alloc] init];
    searchArry = [NSMutableArray arrayWithCapacity:[restroArry count]];
    
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        for (UIView *v in self.tableView.subviews) {
                    if ([v isKindOfClass:[UILabel self]]) {
                
                ((UILabel *)v).text = @"Il n'y a pas de résultats correspondant à votre recherche";
                ((UILabel *)v).textAlignment = NSTextAlignmentCenter;
                ((UILabel *)v).numberOfLines=0;
                //((UILabel *)v).textColor=[UIColor purpleColor];
                
                break;
            }
        }
    });
    
    // [self.searchBar becomeFirstResponder];
  
}
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
}
-(void)viewWillAppear:(BOOL)animated{   
    //[self.searchBar becomeFirstResponder];
    [super viewDidAppear:animated];
}
- (void)convertButtonTitle:(NSString *)from toTitle:(NSString *)to inView:(UIView *)view
{
    if ([view isKindOfClass:[UIButton class]])
    {
        UIButton *button = (UIButton *)view;
        if ([[button titleForState:UIControlStateNormal] isEqualToString:from])
        {
            [button setTitle:to forState:UIControlStateNormal];
        }
    }
    
    for (UIView *subview in view.subviews)
    {
        [self convertButtonTitle:from toTitle:to inView:subview];
    }
}

#pragma  marl --> UITableview Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (tableView == self.tableView)
    {
        if (isSearching) {
            return [searchArry count];
        }
        else {
            return [restroArry count];
        }
        return YES;
    }
    
    if (tableView == self.search_autocomplete_table)
    {
        if (isSearching) {
            return [searchResults count];
        }
        else {
            return [restroArry count];
        }
        
    }
    return YES;

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.tableView)
    {
        return 1;
    }
    
    if (tableView == self.search_autocomplete_table)
    {
        return 1;
    }
    
    return YES;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    //Find Current Time
     HotelCellTableViewCell *cell;
  
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components =[gregorian components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:today];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    NSInteger second = [components second];
    
    //Find Restro Time for Close & Open
    
    NSString *day = [[restroArry objectAtIndex:indexPath.row]objectForKey:@"day"];
    NSArray *arr = [day componentsSeparatedByString:@"-"];
    NSString *var = [arr objectAtIndex:0];
    NSString *opentime = [arr objectAtIndex:1];
    NSString *closetime = [arr objectAtIndex:2];
    
    NSArray *arr1 = [opentime componentsSeparatedByString:@":"];
    NSString *open_h = [arr1 objectAtIndex:0];
    NSArray *arr2 = [closetime componentsSeparatedByString:@":"];
    NSString *close_h = [arr2 objectAtIndex:0];
   
    NSInteger openhour = [open_h integerValue];
    NSInteger closehour = [close_h integerValue];
    
   // status = [[restroArry objectAtIndex:indexPath.row]objectForKey:@"status"];
  
   //Restro find using keyword
//    if(tableView == self.tableView){
//       [self.search_autocomplete_table registerClass:[HotelCellTableViewCell self] forCellReuseIdentifier:@"Cell"];
//            }
//    else if (tableView == self.search_autocomplete_table){
//       [self.search_autocomplete_table registerClass:[CustomSearchTableViewCell self] forCellReuseIdentifier:@"CellText"];
//    }
   // NSString *restro_keyword = [[restroArry objectAtIndex:indexPath.row]objectForKey:@"search"];
    //keyword_sep = [restro_keyword componentsSeparatedByString:@"-"];
    keyword_sep = [[NSMutableArray alloc]init];
    if (tableView  == self.search_autocomplete_table)
    {
        CustomSearchTableViewCell *Cell;
        static NSString *CellIdentifier2 = @"CellText";
        
        Cell = [self.search_autocomplete_table dequeueReusableCellWithIdentifier:CellIdentifier2];
    
        if (!Cell)
        {
            Cell = [[CustomSearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2];
            
        }
       [self.search_autocomplete_table registerClass:[CustomSearchTableViewCell self] forCellReuseIdentifier:@"CellText"];

      
        if (isSearching) {
            if (!searchResults.count) {
                NSLog(@"Empty Error");
            }else{
                

            Cell.textLabel.text = [searchResults objectAtIndex:indexPath.row];
            }
        }
        else {
             }
        return Cell;
       
    }
    else
    {
       
       

        static NSString *CellIdentifier1 = @"Cell";
       
        cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        
        if (!cell)
        {
            cell = [[HotelCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
            [self.tableView registerClass:[HotelCellTableViewCell self] forCellReuseIdentifier:@"Cell"];
        }
//        
//        if (!searchResults.count) {
//                NSLog(@"Arry Empty");
//                
//            }
            if(searchResults.count){
                
                
            //cell.textLabel.text = [searchResults objectAtIndex:indexPath.row];
            cell.Restro_lable.text = [[searchArry objectAtIndex:indexPath.row]objectForKey:@"r_name"];
            [cell.resto_image sd_setImageWithURL:[NSURL URLWithString:[[searchArry objectAtIndex:indexPath.row] objectForKey:@"img_full"]]placeholderImage:[UIImage imageNamed:@"star_image.png"]];
            cell.restro_time.text = [[searchArry objectAtIndex:indexPath.row]objectForKey:@"day"];
            cell.payment_type.text = [[searchArry objectAtIndex:indexPath.row]objectForKey:@"pay_type"];
            cell.mini_order.text = [[searchArry objectAtIndex:indexPath.row]objectForKey:@"mini_order"];
            cell.euro.text = @"\u20ac";
                UIImage *image1 = [UIImage imageNamed:@"star_image.png"];
                UIImage *image2 = [UIImage imageNamed:@"selected_star_image.png"];
                if (searchArry.count == 0) {
                    favc = [[restroArry objectAtIndex:indexPath.row]valueForKey:@"favourite"];

                }
                else{
                    favc = [[searchArry objectAtIndex:indexPath.row]valueForKey:@"favourite"];

                }
               
                if ([favc isEqualToString:@"1"])
                 {
                     [cell.favoris_btn setImage:image2 forState:UIControlStateNormal];
                 }
                else
                {
                 [cell.favoris_btn setImage:image1 forState:UIControlStateNormal];
                    
                    
                }
                
                if (searchArry.count == 0) {
                    status = [[restroArry objectAtIndex:indexPath.row]objectForKey:@"status"];
                }
                else{
                    status = [[searchArry objectAtIndex:indexPath.row]objectForKey:@"status"];
                }
                // status = [[restroArry objectAtIndex:indexPath.row]objectForKey:@"status"];
                
                if ([status isEqualToString:@"0"])
                {
                    if (hour >= openhour && hour <= closehour)
                    {
                        cell.time_image.image = [UIImage imageNamed:@"ouvert_btn.png"];
                    }
                    else
                    {
                        cell.time_image.image = [UIImage imageNamed:@"ouvert_btn.png"];
                    }
                }
                else if([status isEqualToString:@"1"])
                {
                    if (hour <= openhour && hour >= closehour)
                    {
                        cell.time_image.image = [UIImage imageNamed:@"ferme_btn.png"];
                    }
                    else
                    {
                        cell.time_image.image = [UIImage imageNamed:@"ferme_btn.png"];
                    }
                    
                }
        }
            else if(restroArry.count){
                cell.Restro_lable.text = [[restroArry objectAtIndex:indexPath.row]objectForKey:@"r_name"];
                [cell.resto_image sd_setImageWithURL:[NSURL URLWithString:[[restroArry objectAtIndex:indexPath.row] objectForKey:@"img_full"]]placeholderImage:[UIImage imageNamed:@"star_image.png"]];
                cell.restro_time.text = [[restroArry objectAtIndex:indexPath.row]objectForKey:@"day"];
                cell.payment_type.text = [[restroArry objectAtIndex:indexPath.row]objectForKey:@"pay_type"];
                cell.mini_order.text = [[restroArry objectAtIndex:indexPath.row]objectForKey:@"mini_order"];
                cell.euro.text = @"\u20ac";
                UIImage *image1 = [UIImage imageNamed:@"star_image.png"];
                UIImage *image2 = [UIImage imageNamed:@"selected_star_image.png"];
                if (searchArry.count == 0) {
                    favc = [[restroArry objectAtIndex:indexPath.row]valueForKey:@"favourite"];
                    
                }
                else{
                    favc = [[searchArry objectAtIndex:indexPath.row]valueForKey:@"favourite"];
                    
                }
                
                if ([favc isEqualToString:@"1"])
                {
                    [cell.favoris_btn setImage:image2 forState:UIControlStateNormal];
                }
                else
                {
                    [cell.favoris_btn setImage:image1 forState:UIControlStateNormal];
                    
                    
                }
                
                if (searchArry.count == 0) {
                    status = [[restroArry objectAtIndex:indexPath.row]objectForKey:@"status"];
                }
                else{
                    status = [[searchArry objectAtIndex:indexPath.row]objectForKey:@"status"];
                }
                // status = [[restroArry objectAtIndex:indexPath.row]objectForKey:@"status"];
                
                if ([status isEqualToString:@"0"])
                {
                    if (hour >= openhour && hour <= closehour)
                    {
                        cell.time_image.image = [UIImage imageNamed:@"ouvert_btn.png"];
                    }
                    else
                    {
                        cell.time_image.image = [UIImage imageNamed:@"ouvert_btn.png"];
                    }
                }
                else if([status isEqualToString:@"1"])
                {
                    if (hour <= openhour && hour >= closehour)
                    {
                        cell.time_image.image = [UIImage imageNamed:@"ferme_btn.png"];
                    }
                    else
                    {
                        cell.time_image.image = [UIImage imageNamed:@"ferme_btn.png"];
                    }
                    
                }

            }
            else{
                
            }
        return cell;
    }
 }


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!searchResults.count) {
        NSLog(@"Selection is Nil");
    }
    else{
    
    if (tableView == self.search_autocomplete_table) {
        self.search_autocomplete_table.hidden = YES;
        [self.tableView reloadData];
        self.tableView.hidden = NO;
        [self.tableView reloadData];
        self.searchBar.text =@"";
        [self.searchBar resignFirstResponder];
        NSString *menu = [searchResults objectAtIndex:indexPath.row];

        self.searchBar.text = [NSString stringWithFormat:@"%@",menu];
        
    }
    else{
    NSString *favvvv = [searchArry objectAtIndex:indexPath.row];
        NSString *f_star = [favvvv valueForKey:@"favourite"];

        if (fav_id == nil) {
            [[NSUserDefaults standardUserDefaults]setObject:f_star forKey:@"fav_star"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else {
            [[NSUserDefaults standardUserDefaults]setObject:fav_id forKey:@"fav_star"];
            [[NSUserDefaults standardUserDefaults] synchronize];

        }
    NSString *mini_order = [[searchArry objectAtIndex:indexPath.row]valueForKey:@"mini_order"];
    [[NSUserDefaults standardUserDefaults]setObject:mini_order forKey:@"mini_order"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //Find Current Time
    
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components =[gregorian components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:today];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    NSInteger second = [components second];
    
    //Find Restro Time for Close & Open
    
    NSString *day = [[searchArry objectAtIndex:indexPath.row]objectForKey:@"day"];
    NSArray *arr = [day componentsSeparatedByString:@"-"];
    NSString *var = [arr objectAtIndex:0];
    NSString *opentime = [arr objectAtIndex:1];
    NSString *closetime = [arr objectAtIndex:2];
    
    NSArray *arr1 = [opentime componentsSeparatedByString:@":"];
    NSString *open_h = [arr1 objectAtIndex:0];
    NSArray *arr2 = [closetime componentsSeparatedByString:@":"];
    NSString *close_h = [arr2 objectAtIndex:0];
    
    [[NSUserDefaults standardUserDefaults]setObject:open_h forKey:@"open_h"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    [[NSUserDefaults standardUserDefaults]setObject:close_h forKey:@"close_h"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    NSString *desc = [[searchArry objectAtIndex:indexPath.row]valueForKey:@"descc"];
    [[NSUserDefaults standardUserDefaults]setObject:desc forKey:@"descc"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSString *s = [[searchArry objectAtIndex:indexPath.row]objectForKey:@"status"];
        if ([s isEqualToString:@"1" ])
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Message"
                              message:@"Le restaurant est fermé"
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK",
                              nil];
        [alert show];
    }
    else
    {
       [self performSegueWithIdentifier:@"restroDeatils" sender:indexPath];
    }
    }
}
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    isSearching = YES;
    //self.search_autocomplete_table.hidden = NO;
    self.tableView.hidden=YES;
    
    
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"Text change - %d",isSearching);
    self.search_autocomplete_table.hidden = NO;
    self.tableView.hidden=YES;

    //Remove all objects first.
   // [searchResults removeAllObjects];
    if ([searchText length] == 0) {
        [searchResults removeAllObjects];
        [self.search_autocomplete_table reloadData];
        self.search_autocomplete_table.hidden = YES;
    }
    if([searchText length] != 0) {
        isSearching = YES;
        NSString *searchString = self.searchBar.text;
        [self searchTableList:(NSString *)searchString scope:(NSString*)searchBar];
        //[self searchTableList:(NSString *)searchBar];
    }
    else {
        isSearching = NO;
    }
    // [self.tblContentList reloadData];
    //[self.tableView reloadData];
    [self.search_autocomplete_table reloadData];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Cancel clicked");
    [searchBar resignFirstResponder];
    [searchResults removeAllObjects];
    [self.search_autocomplete_table reloadData];
    self.search_autocomplete_table.hidden=YES;
}


- (void)searchTableList:(NSString *)searchText scope:(NSString*)scope{
    NSString *searchString = self.searchBar.text;
    searchResults = [[NSMutableArray alloc] init];
    search_keyword = [[NSMutableArray alloc]init];
    searchArry = [[NSMutableArray alloc]init];
    /////////////
    for (int s=0; s<restroArry.count; s++)
    {
        
        NSString *restro_keyword = [[restroArry objectAtIndex:s]objectForKey:@"new_search"];
        keyword_sep = [restro_keyword componentsSeparatedByString:@","];
        for (int k=0; k<keyword_sep.count; k++) {
            if (![search_keyword containsObject:[keyword_sep objectAtIndex:k]])
            {
                [search_keyword addObject:[keyword_sep objectAtIndex:k]];
            }
            //[search_keyword addObject:[keyword_sep objectAtIndex:k]];
        }
       // uniquearray = [[NSSet setWithArray:yourarray] allObjects];
        NSLog(@"%@",search_keyword);
    }
    
    
////////////////////////
   
      NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", searchText];
    
    searchResults = [NSMutableArray arrayWithArray: [search_keyword filteredArrayUsingPredicate:resultPredicate]];
    
    NSPredicate *resultArry = [NSPredicate predicateWithFormat:@"SELF.new_search contains[c] %@ || SELF.pay_type contains[c] %@",searchString,searchString];
    
    searchArry = [NSMutableArray arrayWithArray:[restroArry filteredArrayUsingPredicate:resultArry]];
    
//        NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF.new_search contains[c] %@ || SELF.pay_type contains[c] %@", searchText,searchText];
//     
//            searchResults = [NSMutableArray arrayWithArray: [restroArry filteredArrayUsingPredicate:resultPredicate]];
//    for (int s=0; s<searchResults.count; s++)
//    {
//        
//        NSString *restro_keyword = [[searchResults objectAtIndex:s]objectForKey:@"new_search"];
//        keyword_sep = [restro_keyword componentsSeparatedByString:@","];
//        for (int k=0; k<keyword_sep.count; k++) {
//            [search_keyword addObject:[keyword_sep objectAtIndex:k]];
//        }
//        
//        NSLog(@"%@",search_keyword);
//    }
    
//    NSPredicate *resultPredicate1 = [NSPredicate predicateWithFormat:@"SELF contains[c] %@ ", searchText];
//    NSMutableArray *alloc  = [NSMutableArray arrayWithArray: [restroArry filteredArrayUsingPredicate:resultPredicate1]];
    
}




- (IBAction)fav_btn:(id)sender
{
    CGPoint touchPoint = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:touchPoint];
    NSLog(@"Indexpath : %@",indexPath);
    fav_arry = [[NSMutableArray alloc]init];
    fav_arry = [searchArry objectAtIndex:indexPath.row];
    
    fav = [fav_arry valueForKey:@"id"];
    
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
        // [self.tableView reloadData];
        fav_id = [NSString stringWithFormat:@"%d",j];
        [btn1 setImage: [UIImage imageNamed:@"selected_star_image.png"] forState:UIControlStateNormal];
        [sender setSelected:YES];
        [self favoris];
        }
    }

    
 }

- (IBAction)bell_btn:(id)sender {
    NotificationViewController *vc4 =
    [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationViewController"];
    [self.navigationController pushViewController:vc4 animated:YES];
}

-(void)favoris
{

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
        //[[self tableView] reloadData];
        //[self tabledisplay];
        
         }
}

-(void)tabledisplay
{
    restroArry = [[NSMutableArray alloc]init];

    u_id = [[NSUserDefaults standardUserDefaults]
            stringForKey:@"u_id"];
    NSMutableDictionary *dictResultSignIn=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *dicSubmit = [[NSMutableDictionary alloc]init];
    [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood//api.php";
    
    [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
    [WebServiceViewController wsVC].strMethodName = @"list_rest";
    
    [dicSubmit setObject:u_id forKey:@"u_id"];
    
   dictResultSignIn = [[WebServiceViewController wsVC] sendRequestWithParameter:dicSubmit];
    
    if (dictResultSignIn != Nil || dictResultSignIn != NULL)
    {
        NSLog(@"dictResultSubmit = %@",dictResultSignIn);
        
        if ([[dictResultSignIn objectForKey:@"status"]integerValue] == 0)
        {
            NSString *link_string = [NSString stringWithFormat:@"%@",[dictResultSignIn objectForKey:@"link"]];
            
            [[NSUserDefaults standardUserDefaults]setObject:link_string forKey:@"link_string"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            NSDictionary *response=[dictResultSignIn objectForKey:@"result"];
            
            NSMutableArray *desc = [[NSMutableArray alloc]init];
            
            searchpaytype = [[NSMutableArray alloc]init];
            search = [response valueForKey:@"serch_payment_type"];
            
            [desc addObject:response];
            
             for (NSDictionary*dic  in response)
            {
                
                [restroArry addObject:dic];
                
                [[self tableView]reloadData];
            }
            
        }
        else
        {
            
        }
        

        
    }
    
    NSLog(@"RestroArray %@",restroArry);

}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    }

//- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller{
//    
//    [controller.searchBar setFrame:CGRectMake(0,135,320,44)];
//    //controller.searchBar.showsCancelButton = NO;
//    //[controller.searchBar setShowsCancelButton:YES animated:YES];
//    //    for (UIView *subView in controller.searchBar.subviews){
//    //        if([subView isKindOfClass:[UIButton class]]){
//    //            UIButton *cancelButton = (UIButton*)subView;
//    //        [cancelButton setTitle:@"Annuler" forState:UIControlStateNormal];
//    //        }
//    //    }
//   // [controller.searchResultsTableView setFrame:CGRectMake(0,160,320,200)];
//    
//     //[search_display.searchResultsTableView setFrame:CGRectMake(0,140,320,50)];
//    //[search_display.searchResultsTableView setFrame:CGRectMake(0,160,320,200)];
//    // controller.searchBar.showsCancelButton = NO;
//    [self.searchDisplayController.searchResultsTableView setDelegate:self];
//}
//- (void) searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
//{
//    
//    [controller.searchBar setFrame:CGRectMake(0,135, 320,44)];
//    //    [controller.searchBar setShowsCancelButton:YES animated:YES];
//    //    for (UIView *subView in _searchBar.subviews){
//    //        if([subView isKindOfClass:[UIButton class]]){
//    //            [(UIButton*)subView setTitle:@"Annuler" forState:UIControlStateNormal];
//    //        }
//    //    }
//    
//    
//    [self.searchDisplayController.searchResultsTableView setDelegate:self];
//}
//- (void)filterForSearchText:(NSString*)searchText scope:(NSString*)scope
//{
//    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF.search contains[c] %@ || SELF.serch_payment_type contains[c] %@", searchText,searchText];
//    
//    searchResults = [NSMutableArray arrayWithArray: [restroArry filteredArrayUsingPredicate:resultPredicate]];
//    
//}
//
//-(BOOL) searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
//{
//    [self filterForSearchText:searchString scope:[[[[self searchDisplayController] searchBar] scopeButtonTitles] objectAtIndex:[[[self searchDisplayController] searchBar] selectedScopeButtonIndex] ]];
//    
//    dispatch_async(dispatch_get_main_queue(), ^(void) {
//        for (UIView *v in controller.searchResultsTableView.subviews) {
//            if ([v isKindOfClass:[UILabel self]]) {
//                
//                ((UILabel *)v).text = @"Il n'y a pas de résultats correspondant à votre recherche";
//                ((UILabel *)v).textAlignment = NSTextAlignmentCenter;
//                ((UILabel *)v).numberOfLines=0;
//                //((UILabel *)v).textColor=[UIColor purpleColor];
//                
//                break;
//            }
//        }
//    });
//    [self.searchDisplayController setActive:YES];
//    self.searchDisplayController.searchBar.text = searchString;
//  
//    
//    return YES;
//}

//-(BOOL) searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
//{
//    [self filterForSearchText:self.searchDisplayController.searchBar.text scope:
//     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
//    
//    return YES;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btn_cart:(id)sender {
    
    
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



- (IBAction)BtnLivraison:(UIButton *)sender
{
   [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    
    _btn_livraison.tag = 100;
    [self changeState:sender];
    [MBProgressHUD hideHUDForView:self.tableView animated:YES];
    
}

- (IBAction)btnEmporter:(UIButton *)sender
{
    [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    _btn_emporter.tag = 101;
    [self changeState:sender];
    [MBProgressHUD hideHUDForView:self.tableView animated:YES];
}

- (IBAction)btnEspeces:(UIButton *)sender
{
  [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
   _btn_especes.tag = 102;
  [self changeState:sender];
  [MBProgressHUD hideHUDForView:self.tableView animated:YES];
}

- (IBAction)Cartedecredit:(UIButton *)sender
{
    [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
     _btn_cartedecredit.tag = 103;
    [self changeState:sender];
    [MBProgressHUD hideHUDForView:self.tableView animated:YES];
}

- (IBAction)btnSpecialite:(UIButton *)sender
{
   [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    btn = (UIButton*)sender;
    btn.tag = 104;
    [self changeState:sender];
   [MBProgressHUD hideHUDForView:self.tableView animated:YES];
}

- (IBAction)btnAproximite:(id)sender
{
   [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    btn = (UIButton*)sender;
    _btn_aproximate.tag = 105;
    [self changeState:sender];
   [MBProgressHUD hideHUDForView:self.tableView animated:YES];
 
}


// connect this method with Touchupinside function
- (IBAction)changeState:(UIButton*)sender
{
    /* if we have multiple buttons, then we can
     differentiate them by tag value of button.*/
    // But note that you have to set the tag value before use this method.
    
    if([sender tag] == 101)
    {
        
         if ([sender isSelected])
        {
            emporter = [NSString stringWithFormat:@"%d",i];
                      // [self searchPayment];
            
            [_btn_emporter setImage:[UIImage imageNamed:@"emporter_deselect.png"] forState:UIControlStateNormal];
            [sender setSelected:NO];
        
        }
        else
        {
            emporter = [NSString stringWithFormat:@"%d",j];
            //[self searchPayment];
            [_btn_emporter setImage: [UIImage imageNamed:@"emporter.png"] forState:UIControlStateNormal];
            [sender setSelected:YES];
        }
    }
    else if([sender tag] == 100){
        
        if ([sender isSelected])
        {
            
            livraison = [NSString stringWithFormat:@"%d",i];
            //[self searchPayment];
            [_btn_livraison setImage:[UIImage imageNamed:@"livraison_deselect.png"] forState:UIControlStateNormal];
            [sender setSelected:NO];
        }
        else
        {
          livraison = [NSString stringWithFormat:@"%d",j];
          //[self searchPayment];
          [_btn_livraison setImage: [UIImage imageNamed:@"livraison.png"] forState:UIControlStateNormal];
          [sender setSelected:YES];
            
        }
    }
   else if([sender tag] == 102)
   {
        if ([sender isSelected])
        {
            
            especes = [NSString stringWithFormat:@"%d",i];
           //[self searchPayment];
            [_btn_especes setImage:[UIImage imageNamed:@"especes_deselect.png"] forState:UIControlStateNormal];
            [sender setSelected:NO];
        }
        else
        {
           especes = [NSString stringWithFormat:@"%d",j];
           //[self searchPayment];
           [_btn_especes setImage: [UIImage imageNamed:@"especes.png"] forState:UIControlStateNormal];
           [sender setSelected:YES];
        }
    }
  else  if([sender tag] == 103)
  {
        if ([sender isSelected])
        {
            
            
             cc = [NSString stringWithFormat:@"%d",i];

         // [self searchPayment];
          [_btn_cartedecredit setImage:[UIImage imageNamed:@"carte_deselect.png"] forState:UIControlStateNormal];
          [sender setSelected:NO];
        }
        else
        {
        cc = [NSString stringWithFormat:@"%d",j];
       // [self searchPayment];
        [_btn_cartedecredit setImage: [UIImage imageNamed:@"carte.png"] forState:UIControlStateNormal];
        [sender setSelected:YES];
        }
    }

    if([sender tag] == 105){
        
        if ([sender isSelected])
        {
           
            longitude_string = [NSString stringWithFormat:@"%d",i];
            latitude_string =[NSString stringWithFormat:@"%d",i];
           // [self searchPayment];
            [_btn_aproximate setImage:[UIImage imageNamed:@"aproximite_deselect.png"] forState:UIControlStateNormal];
            [sender setSelected:NO];
        }
        else
        {
            latitude_string = [NSString stringWithFormat:@"%f",latitude];
            longitude_string = [NSString stringWithFormat:@"%f",longitude];
            //[self searchPayment];
            [_btn_aproximate setImage: [UIImage imageNamed:@"aproximite.png"] forState:UIControlStateNormal];
            [sender setSelected:YES];        }
    }

}


-(void)searchPayment{
   restroArry = [[NSMutableArray alloc]init];
    self.tableView.hidden = NO;
    u_id = [[NSUserDefaults standardUserDefaults]
            stringForKey:@"u_id"];
     NSMutableDictionary *dictResultSignIn=[[NSMutableDictionary alloc]init];
     NSMutableDictionary *dicSubmit = [[NSMutableDictionary alloc]init];
    [WebServiceViewController wsVC].strURL =@"http://vps291033.ovh.net/turbofood//api.php";
    
    [WebServiceViewController wsVC].strCallHttpMethod = @"POST";
    [WebServiceViewController wsVC].strMethodName = @"serch_payment_android";
    
    [dicSubmit setObject:u_id forKey:@"u_id"];
    [dicSubmit setObject:livraison forKey:@"livraison"];
    [dicSubmit setObject:emporter forKey:@"emporter"];
    [dicSubmit setObject:especes forKey:@"especes"];
    [dicSubmit setObject:cc forKey:@"cc"];
    [dicSubmit setObject:latitude_string forKey:@"lati"];
    [dicSubmit setObject:longitude_string forKey:@"longi"];
    
    NSLog(@"DicSubmit = %@",dicSubmit);
    
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
                [restroArry addObject:dic];//restroarry
            }
            if (restroArry.count >0 ) {
                [[self tableView]reloadData];
            }
                }
        else
        {
            
        }
    }
 
   }

- (IBAction)checkBoxToggle:(id)sender {
     UIButton *btn = (UIButton*)sender;
    btn.selected = !btn.selected; // toggle the selected property, just a simple BOOL
    
}

- (IBAction)sidebarButton:(id)sender {
    
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
    
}
//- (MFSideMenuContainerViewController *)menuContainerViewController
//{
//    MFSideMenuContainerViewController *mc = [[MFSideMenuContainerViewController alloc]init];
//    //[[self navigationController] popViewControllerAnimated:TRUE];
//   // [UIViewController willMoveToParentViewController:MFSideMenuContainerViewController]
//   // [mc viewDidAppear:YES];
//    //return  (MFSideMenuContainerViewController*)self.navigationController.parentViewController;
//}

- (IBAction)selectClicked:(id)sender
{
    
    if (isFilterclicked==NO)
    {
        isFilterclicked=YES;
        
        
        [btnSelect setTitle:@"Filtre -" forState:UIControlStateNormal];
        menu_view.hidden = NO;
        self.tableView.frame = CGRectMake(0,330,self.tableView.frame.size.width,260);
        
        btnSelect.frame = CGRectMake(0,290,CGRectGetWidth(self.view.frame),40);
        
    }
    else
    {
        isFilterclicked=NO;
        [btnSelect setTitle:@"Filtre +" forState:UIControlStateNormal];
        menu_view.hidden = YES;
         self.tableView.frame = CGRectMake(0,220,self.tableView.frame.size.width,370);
        btnSelect.frame = CGRectMake(0, 180, CGRectGetWidth(self.view.frame), 40);
        
    }
  
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (tableView == self.tableView) {
//        return 140;
//    }
//    if (tableView == self.search_autocomplete_table) {
//         return 44;
//    }
//    return YES;
//}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
}

-(void)rel
{
    dropDown = nil;
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"restroDeatils"]){
        
        NSMutableDictionary *my4Dic =[[NSMutableDictionary alloc] init];
        ViewController4 *VC4 = (ViewController4*)segue.destinationViewController;
        
        //CGPoint touchPoint = [sender convertPoint:CGPointZero toView:self.tableView];
       // NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:touchPoint];

        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSLog(@"Selected Index %@",indexPath);
        if (searchArry.count == 0) {
            VC4.receiveArray11 = [restroArry objectAtIndex:indexPath.row];
            my4Dic =[restroArry objectAtIndex:indexPath.row];
        }
        else if (searchArry != 0)
        {
            VC4.receiveArray11 = [searchArry objectAtIndex:indexPath.row];
            my4Dic =[searchArry objectAtIndex:indexPath.row];
        }
        [[NSUserDefaults standardUserDefaults] setObject:my4Dic forKey:@"View4Dic"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
}


////////


@end
