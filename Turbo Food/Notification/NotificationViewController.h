//
//  NotificationViewController.h
//  Turbo Food
//
//  Created by ganesh on 4/15/16.
//  Copyright © 2016 Ravi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table_view;
- (IBAction)menu_btn:(id)sender;
- (IBAction)home_btn:(id)sender;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segment_controller;
- (IBAction)SegmentToggle:(UISegmentedControl *)sender;
- (IBAction)cart_btn:(id)sender;

@end
