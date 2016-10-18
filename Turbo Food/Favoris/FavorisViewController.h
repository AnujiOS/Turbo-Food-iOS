//
//  FavorisViewController.h
//  Turbo Food
//
//  Created by ganesh on 3/28/16.
//  Copyright © 2016 Ravi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FavorisViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
{
    NSMutableArray *restroArry;
  
}
- (IBAction)menu_btn:(id)sender;
@property (strong, nonatomic) IBOutlet UIPageViewController *page_controller;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segment_controller;
- (IBAction)SegmentToggle:(UISegmentedControl *)sender;
- (IBAction)order_fav:(id)sender;

- (IBAction)btn_home:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableview;
- (IBAction)bell_btn:(id)sender;
- (IBAction)cart_btn:(id)sender;
//@property (nonatomic, strong) HMSegmentedControl *segmented;
@end
