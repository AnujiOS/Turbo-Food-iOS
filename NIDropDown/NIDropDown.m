//
//  NIDropDown.m
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import "NIDropDown.h"
#import "QuartzCore/QuartzCore.h"
#import "MenuSelectionViewController.h"
#import "NIDropDownTableViewCell.h"

@interface NIDropDown ()
@property(nonatomic, strong) UITableView *table;
@property(nonatomic, strong) UIButton *btnSender;
@property(nonatomic, retain) NSArray *list;
@property(nonatomic, retain) NSArray *imageList;
@end

@implementation NIDropDown
@synthesize table;
@synthesize btnSender;
@synthesize list;
@synthesize imageList;
@synthesize delegate;
@synthesize animationDirection;

- (id)showDropDown:(UIButton *)b :(CGFloat *)height :(NSArray *)arr :(NSArray *)imgArr :(NSString *)direction {
    btnSender = b;
    animationDirection = direction;
    self.table = (UITableView *)[super init];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        CGRect btn = b.frame;
        self.list = [NSArray arrayWithArray:arr];
        self.imageList = [NSArray arrayWithArray:imgArr];
        if ([direction isEqualToString:@"up"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y, btn.size.width, 0);
            self.layer.shadowOffset = CGSizeMake(-5, -5);
        }else if ([direction isEqualToString:@"down"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, 0);
            self.layer.shadowOffset = CGSizeMake(-5, 5);
        }
        
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 8;
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.5;
        
        table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, btn.size.width, 0)];
        table.delegate = self;
        table.dataSource = self;
        table.layer.cornerRadius = 5;
        //table.backgroundColor = [UIColor colorWithRed:0.239 green:0.239 blue:0.239 alpha:1];
        table.backgroundColor = [UIColor clearColor];
        table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        table.separatorColor = [UIColor grayColor];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        if ([direction isEqualToString:@"up"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y-*height, btn.size.width, *height);
        } else if([direction isEqualToString:@"down"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, *height);
        }
        table.frame = CGRectMake(0, 0, btn.size.width, *height);
        [UIView commitAnimations];
        [b.superview addSubview:self];
        [self addSubview:table];
    }
    return self;
}

-(void)hideDropDown:(UIButton *)b {
    CGRect btn = b.frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    if ([animationDirection isEqualToString:@"up"]) {
        self.frame = CGRectMake(btn.origin.x, btn.origin.y, btn.size.width, 0);
    }else if ([animationDirection isEqualToString:@"down"]) {
        self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, 0);
    }
    table.frame = CGRectMake(0, 0, btn.size.width, 0);
    [UIView commitAnimations];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.list count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        static NSString *CellIdentifier = @"Cell";
    NIDropDownTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[NIDropDownTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.option_name.font = [UIFont systemFontOfSize:12];
        cell.option_price.font = [UIFont systemFontOfSize:12];
       // cell.option_name.textLabel.textAlignment = UITextAlignmentCenter;
        cell.option_name.textAlignment = UITextAlignmentLeft;
        cell.option_price.textAlignment = UITextAlignmentRight;
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NIDropDownTableViewCell" owner:self options:nil];
        
        //cell = [nib objectAtIndex:indexPath.row];
        cell = [nib objectAtIndex:0];
    }
        if ([self.imageList count] == [self.list count]) {
                cell.option_name.text =[list objectAtIndex:indexPath.row];
               // cell.imageView.image = [imageList objectAtIndex:indexPath.row];
            cell.option_price.text = [imageList objectAtIndex:indexPath.row];
            
            NSLog(@"Option Name : %@",cell.option_name.text);
            NSLog(@"Option Price :%@",cell.option_price.text);
            } else if ([self.imageList count] > [self.list count]) {
                cell.option_name.text =[list objectAtIndex:indexPath.row];
                if (indexPath.row < [imageList count]) {
                    //cell.imageView.image = [imageList objectAtIndex:indexPath.row];
                    cell.option_price.text = [imageList objectAtIndex:indexPath.row];
                }
            } else if ([self.imageList count] < [self.list count]) {
                cell.option_name.text =[list objectAtIndex:indexPath.row];
                if (indexPath.row < [imageList count]) {
                    //cell.imageView.image = [imageList objectAtIndex:indexPath.row];
                    cell.option_price.text = [imageList objectAtIndex:indexPath.row];
                }
            }
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor grayColor];

            UIView * v = [[UIView alloc] init];
            v.backgroundColor = [UIColor grayColor];
            cell.selectedBackgroundView = v;

    return cell;

//    static NSString *MainTableIdentifier = @"CustomTableViewCell";
//    CustomTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:MainTableIdentifier];
//    cell = [tableView dequeueReusableCellWithIdentifier:MainTableIdentifier];
//    
//    if (cell == nil)
//    {
//        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomTableViewCell" owner:self options:nil];
//        cell = [nib objectAtIndex:0];
//    }
//    return cell;
    
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        cell.textLabel.font = [UIFont systemFontOfSize:15];
//        cell.textLabel.textAlignment = UITextAlignmentCenter;
//        
//    }
//    if ([self.imageList count] == [self.list count]) {
//        cell.textLabel.text =[list objectAtIndex:indexPath.row];
//        cell.imageView.image = [imageList objectAtIndex:indexPath.row];
//    } else if ([self.imageList count] > [self.list count]) {
//        cell.textLabel.text =[list objectAtIndex:indexPath.row];
//        if (indexPath.row < [imageList count]) {
//            cell.imageView.image = [imageList objectAtIndex:indexPath.row];
//        }
//    } else if ([self.imageList count] < [self.list count]) {
//        cell.textLabel.text =[list objectAtIndex:indexPath.row];
//        if (indexPath.row < [imageList count]) {
//            cell.imageView.image = [imageList objectAtIndex:indexPath.row];
//        }
//    }
//    
//    cell.textLabel.textColor = [UIColor whiteColor];
//    cell.backgroundColor = [UIColor grayColor];
//    
//    UIView * v = [[UIView alloc] init];
//    v.backgroundColor = [UIColor grayColor];
//    cell.selectedBackgroundView = v;
//    
//    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideDropDown:btnSender];
    
    
    NIDropDownTableViewCell *c = [tableView cellForRowAtIndexPath:indexPath];
    [btnSender setTitle:c.option_name.text  forState:UIControlStateNormal];
   // [btnSender setTitle:c.option_price.text forState:UIControlStateNormal];
    
    for (UIView *subView in btnSender.subviews){
        
        if ([subView isKindOfClass:[UITextField class]]) {
            [subView removeFromSuperview];
        }
    }
    
    
//    UITableViewCell *c = [tableView cellForRowAtIndexPath:indexPath];
//    [btnSender setTitle:c.textLabel.text forState:UIControlStateNormal];
//    
//    for (UIView *subview in btnSender.subviews) {
//        if ([subview isKindOfClass:[UIImageView class]]) {
//            [subview removeFromSuperview];
//        }
//    }
//    imgView.image = c.imageView.image;
//    imgView = [[UIImageView alloc] initWithImage:c.imageView.image];
//    imgView.frame = CGRectMake(5, 5, 25, 25);
//    [btnSender addSubview:imgView];
    
    NSString *strrow =[NSString stringWithFormat:@"%ld",indexPath.row];
    
    [[NSUserDefaults standardUserDefaults] setObject:strrow forKey:@"dropdownindexpathrow"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self myDelegate];
}

- (void) myDelegate {
    [self.delegate niDropDownDelegateMethod:self];
}

-(void)dealloc {
//    [super dealloc];
//    [table release];
//    [self release];
}

@end
