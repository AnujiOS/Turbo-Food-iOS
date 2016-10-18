//
//  WebServicesViewController.m
//  Turbo Food
//
//  Created by ganesh on 3/28/16.
//  Copyright © 2016 Ravi. All rights reserved.
//

#import "WebServicesViewController.h"
#import "PaiementViewController.h"
#import "MFSideMenu.h"
#import "ViewController2.h"
#import "NotificationViewController.h"
#import "WebServiceViewController.h"

@interface WebServicesViewController ()
{
    NSTimer *timer;
    NSString *u_id;
    NSString *email;
    NSString *totalprice;
    NSString *fav_order;
    NSString *time;
    NSString *p_now;
}
@end

@implementation WebServicesViewController
@synthesize webView;

- (void)viewDidLoad {
    [super viewDidLoad];
    webView.layer.cornerRadius = 5;
    webView.layer.borderWidth=5;
    webView.layer.borderColor =[UIColor colorWithRed:239.0f/256.0f green:71.0f/256.0f blue:131.0f/256.0f alpha:1].CGColor;
    webView.layer.masksToBounds = YES;
   
    u_id = [[NSUserDefaults standardUserDefaults]
            stringForKey:@"u_id"];
    
    email =[[NSUserDefaults standardUserDefaults]
            stringForKey:@"email"];
    
    totalprice = [[NSUserDefaults standardUserDefaults]
                  stringForKey:@"totalprice"];
    fav_order = [[NSUserDefaults standardUserDefaults]stringForKey:@"fav"];
    
    time = [[NSUserDefaults standardUserDefaults]stringForKey:@"time"];
    p_now = [[NSUserDefaults standardUserDefaults]stringForKey:@"p_now"];

    NSString *urlString = [NSString stringWithFormat:@"http://vps291033.ovh.net/turbofood//cc_redirect.php?pb_email=%@&pb_tot=%@&u_id=%@&favourite=%@&delivery=%@&p_now=%@",email,totalprice,u_id,fav_order,time,p_now];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [webView loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    
    
}
-(void)finish
{
    NotificationViewController *VC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationViewController"];
    [self.navigationController pushViewController:VC2 animated:YES];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView1{
}
-(IBAction)menu_btn:(id)sender
{
     [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

- (IBAction)close_webview:(id)sender {
    NotificationViewController *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationViewController"];
    [self.navigationController pushViewController:vc2 animated:YES];
    
}

@end
