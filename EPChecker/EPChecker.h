//
//  EPChecker.h
//  EPChecker
//
//  Created by Puttin Wong on 12/02/13.
//  Copyright (c) 2013 Extensivepro. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const EPCheckerErrorDomain;

typedef NS_ENUM(NSUInteger, EPCheckerError) {
    EPCheckerIDCardNilValueError = 100,
    EPCheckerIDCardWrongLengthError = 101,
    EPCheckerIDCardWrongProvinceError = 102,
    EPCheckerIDCardWrongBirthDateError = 103,
    EPCheckerIDCardWrongChecksumError = 104,
    EPCheckerErrorUnknown = -1,
};

@interface EPChecker : NSObject

/**
 *  validate the IDCard, you can just pass nil to error if you don't care error
 *
 *  @param IDCard the IDCard string to check
 *  @param error  the error which contains why the IDCard is invalid
 *
 *  @return YES if the IDCard is a valid IDCard; Otherwise NO.
 */
+ (BOOL)isValidIDCard:(NSString *)IDCard error:(NSError * __autoreleasing *)error;

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

/**
 *  validate the telephone value
 *
 *  @param telephone number to check
 *
 *  @return YES if the telephone value is a valid telephone number in China; Otherwise NO.
 */
+ (BOOL)isValidTelePhoneNumber:(NSString *)telephone;

/**
 *  validate the phone Value
 *
 *  @param phone number to check
 *
 *  @return YES if the phone value is a valid phone number in China; Otherwise NO.
 */
+ (BOOL)isValidPhone:(NSString *)phone;

@end
