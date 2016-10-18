//
//  AppDelegate.h
//  Turbo Food
//
//  Created by Ravi on 2/23/16.
//  Copyright (c) 2016 Ravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFSideMenu.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    UINavigationController *navigationController;
}

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic)UINavigationController *navigationController;


@end

