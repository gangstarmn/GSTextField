//
//  GSLengthValidator.m
//  z24
//
//  Created by Gantulga on 29/12/2015.
//  Copyright © 2015 NNB. All rights reserved.
//

#import "GSLengthValidator.h"

typedef NS_ENUM(NSInteger, GSLengthValidatorType) {
    
    GSLengthValidatorTypeMoreThan,
    GSLengthValidatorTypeLessThan,
    GSLengthValidatorTypeEqual,
    GSLengthValidatorTypeRange,
};

@interface GSLengthValidator ()
@property (nonatomic, assign) NSUInteger length;
@property (nonatomic, assign) NSUInteger maxLength;
@property (nonatomic, assign) GSLengthValidatorType validatorType;

@end

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

+ (instancetype)validatorMoreThanWithLength:(NSInteger) length {
    GSLengthValidator *validator = [[self alloc] init];
    validator.length = length;
    validator.validatorType = GSLengthValidatorTypeMoreThan;
    return validator;
}

+ (instancetype)validatorLessThanWithLength:(NSInteger) length {
    GSLengthValidator *validator = [[self alloc] init];
    validator.length = length;
    validator.validatorType = GSLengthValidatorTypeLessThan;
    return validator;
}


+ (instancetype)validatorEqualWithLength:(NSInteger) length {
    GSLengthValidator *validator = [[self alloc] init];
    validator.length = length;
    validator.validatorType = GSLengthValidatorTypeEqual;
    return validator;
}

+ (instancetype)validatorRangeWithMin:(NSInteger) length
                                  max:(NSInteger)maxLength{
    GSLengthValidator *validator = [[self alloc] init];
    validator.length = length;
    validator.maxLength = maxLength;
    validator.validatorType = GSLengthValidatorTypeRange;
    return validator;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.error = [LKValidatorError lengthValidationError];
    }
    
    return self;
}

- (BOOL)validate:(NSString *)string error:(NSError **) error {
    NSString *text = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (self.validatorType == GSLengthValidatorTypeMoreThan) {
        if (text.length >= self.length) {
            return YES;
        }
    }
    if (self.validatorType == GSLengthValidatorTypeLessThan) {
        if (text.length >= self.length) {
            return YES;
        }
    }
    if (self.validatorType == GSLengthValidatorTypeEqual) {
        if (text.length <= self.length) {
            return YES;
        }
    }
    if (self.validatorType == GSLengthValidatorTypeRange) {
        if (text.length >= self.length && text.length <= self.maxLength) {
            return YES;
        }
    }
    return [super validate:string error:error];

}
@end
