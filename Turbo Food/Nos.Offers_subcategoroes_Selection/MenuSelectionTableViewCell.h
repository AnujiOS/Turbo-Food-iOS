//
//  MenuSelectionTableViewCell.h
//  Turbo Food
//
//  Created by ganesh on 4/13/16.
//  Copyright © 2016 Ravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuSelectionViewController.h"

@interface MenuSelectionTableViewCell : UITableViewCell
{

}
@property (weak, nonatomic) IBOutlet UIImageView *imgCheckUncheck;
@property (weak, nonatomic) IBOutlet UILabel *lblSubcategory;
@property (weak, nonatomic) IBOutlet UILabel *lblRupees;
@property (weak, nonatomic) IBOutlet UIView *vwSHowhideView;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
@property (weak, nonatomic) IBOutlet UIButton *btnMinus;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalProduct;

@property (weak, nonatomic) IBOutlet UIButton *btnTagSec;
@property (weak, nonatomic) IBOutlet UILabel *euro_symbol;

@end
