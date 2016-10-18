//
//  FavorisTableViewCell.h
//  Turbo Food
//
//  Created by ganesh on 3/28/16.
//  Copyright © 2016 Ravi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavorisTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *Image_view;
@property (weak, nonatomic) IBOutlet UILabel *Lbl_name;
@property (weak, nonatomic) IBOutlet UIButton *order_fav;
@property (weak, nonatomic) IBOutlet UIImageView *menu_image;
@property (weak, nonatomic) IBOutlet UILabel *menu_lbl;

@end
