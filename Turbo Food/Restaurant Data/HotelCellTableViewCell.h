//
//  HotelCellTableViewCell.h
//  Turbo Food
//
//  Created by Ravi Brahmbhatt on 11/03/16.
//  Copyright © 2016 Ravi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelCellTableViewCell : UITableViewCell

{


}
@property (weak, nonatomic) IBOutlet UIImageView *time_image;
- (IBAction)favoris_btn:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *resto_image;
@property (weak, nonatomic) IBOutlet UILabel *euro;

@property (strong, nonatomic) IBOutlet UILabel *Restro_lable;
@property (weak, nonatomic) IBOutlet UILabel *restro_time;
@property (weak, nonatomic) IBOutlet UILabel *mini_order;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (weak, nonatomic) IBOutlet UILabel *payment_type;
@property (weak, nonatomic) IBOutlet UIButton *favoris_btn;


@end
