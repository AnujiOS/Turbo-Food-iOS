//
//  WebServicesViewController.h
//  Turbo Food
//
//  Created by ganesh on 3/28/16.
//  Copyright © 2016 Ravi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebServicesViewController : UIViewController<UIWebViewDelegate>
{
    
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;


- (IBAction)menu_btn:(id)sender;
- (IBAction)close_webview:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *close_btn;

@end
