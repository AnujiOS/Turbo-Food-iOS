//
//  Validation.h
//  Turbo Food
//
//  Created by Ravi on 2/23/16.
//  Copyright (c) 2016 Ravi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Validation : NSObject{
    

}

- (BOOL)emailRegEx:(NSString *)string;
- (BOOL)passwordMinLength:(NSInteger *)length password:(NSString *)string;

@end
