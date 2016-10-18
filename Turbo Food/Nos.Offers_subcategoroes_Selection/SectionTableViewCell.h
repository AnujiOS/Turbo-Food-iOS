//
//  SectionTableViewCell.h
//  Turbo Food
//
//  Created by mac on 7/20/16.
//  Copyright © 2016 Ravi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SectionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblMainTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgDropDown;
@property (weak, nonatomic) IBOutlet UIButton *btnSelectSectionHeader;
@property (weak, nonatomic) IBOutlet UILabel *details;

@end
