//
//  EPChecker.h
//  EPChecker
//
//  Created by Puttin Wong on 12/02/13.
//  Copyright (c) 2013 Extensivepro. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, EPIDCardValidateResult) {
    EPIDCardValidateResultPass = 0,
    EPIDCardValidateResultNilValue,
    EPIDCardValidateResultWrongLength,
    EPIDCardValidateResultWrongProvince,
    EPIDCardValidateResultWrongBirthDate,
    EPIDCardValidateResultWrongChecksum,
    EPIDCardValidateResultError,
};

@interface EPChecker : NSObject

/**
 *  validate the IDCard String
 *
 *  @param IDCardValue the IDCard string to check
 *
 *  @return a value of EPIDCardValidateResult
 *  @see EPIDCardValidateResult
 */
+ (EPIDCardValidateResult)validateIDCardNumber:(NSString *)IDCardValue;

/**
 *  validate the emailValue
 *
 *  @param emailValue the email string to check
 *
 *  @return YES if the emailValue is a valid email; Otherwise NO.
 */
+ (BOOL)isValidEmail:(NSString *)emailValue;

/**
 *  validate the mobileNumberValue
 *
 *  @param mobileNumberValue the mobile number to check
 *
 *  @return YES if the mobileNumberValue is a valid mobile number in China; Otherwise NO.
 */
+ (BOOL)isValidMobileNumber:(NSString *)mobileNumberValue;

@end
