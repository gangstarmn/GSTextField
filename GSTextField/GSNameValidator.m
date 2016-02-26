//
//  GSNameValidator.m
//  z24
//
//  Created by Gantulga on 11/01/2016.
//  Copyright © 2016 NNB. All rights reserved.
//

#import "GSNameValidator.h"

@implementation GSNameValidator

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.regex = @"^[a-zA-Z-]*$";
        self.error = [LKValidatorError alphaValidationError];
    }
    
    return self;
}

@end
