//
//  GSLengthValidator.m
//  z24
//
//  Created by Gantulga on 29/12/2015.
//  Copyright © 2015 NNB. All rights reserved.
//

#import "GSLengthValidator.h"

@implementation GSLengthValidator

//- (instancetype)init {
//    self = [super init];
//    
//    if (self) {
//        _error = [LKValidatorError unknownValidationError];
//    }
//    
//    return self;
//}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.error = [LKValidatorError lengthValidationError];
        _length = 4;
    }
    
    return self;
}

- (BOOL)validate:(NSString *)string error:(NSError **) error {
    NSString *text = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (text.length == self.length) {
        return YES;
    }
    else {
        return [super validate:string error:error];
    }
}
@end
