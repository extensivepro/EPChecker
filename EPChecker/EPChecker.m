//
//  EPChecker.m
//  EPChecker
//
//  Created by Puttin Wong on 12/02/13.
//  Copyright (c) 2013 Extensivepro. All rights reserved.
//

#import "EPChecker.h"

NSString * const EPCheckerErrorDomain = @"EPCheckerErrorDomain";

typedef NS_ENUM(NSUInteger, EPIDCardValidateResult) {
    EPIDCardValidateResultPass = 0,
    EPIDCardValidateResultNilValue,
    EPIDCardValidateResultWrongLength,
    EPIDCardValidateResultWrongProvince,
    EPIDCardValidateResultWrongBirthDate,
    EPIDCardValidateResultWrongChecksum,
    EPIDCardValidateResultError,
};

@implementation EPChecker

//http://blog.csdn.net/afyzgh/article/details/16965107
+ (EPIDCardValidateResult)validateIDCardNumber:(NSString *)value
{
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    value = [value uppercaseString];
    
    NSUInteger length = 0;
    if (!value) {
        return EPIDCardValidateResultNilValue;
    }else {
        length = value.length;
        
        if (length != 15 && length !=18) {
            return EPIDCardValidateResultWrongLength;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11", @"12", @"13", @"14", @"15", @"21", @"22", @"23", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"41", @"42", @"43", @"44", @"45", @"46", @"50", @"51", @"52", @"53", @"54", @"61", @"62", @"63", @"64", @"65", @"71", @"81", @"82", @"91"];
    
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag = NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return EPIDCardValidateResultWrongProvince;
    }
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year = 0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];// 测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];// 测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                              options:NSMatchingReportProgress
                                                                range:NSMakeRange(0, value.length)];
            
            
            if(numberofMatch > 0) {
                return EPIDCardValidateResultPass;
            }else {
                return EPIDCardValidateResultWrongBirthDate;
            }
        case 18:
            
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];// 测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];// 测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                              options:NSMatchingReportProgress
                                                                range:NSMakeRange(0, value.length)];
            
            
            if(numberofMatch > 0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S % 11;
                NSString *M = @"F";
                NSString *JYM = @"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)]; // 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return EPIDCardValidateResultPass;// 检测ID的校验位
                }else {
                    return EPIDCardValidateResultWrongChecksum;
                }
                
            } else {
                return EPIDCardValidateResultWrongBirthDate;
            }
        default:
            return EPIDCardValidateResultError;
    }
}

+ (BOOL)isValidIDCard:(NSString *)IDCard error:(NSError * __autoreleasing *)error
{
    EPIDCardValidateResult result = [self validateIDCardNumber:IDCard];
    switch (result) {
        case EPIDCardValidateResultPass:
            if (error) {
                *error = nil;
            }
            return YES;
            break;
        case EPIDCardValidateResultNilValue:
            if (error) {
                *error = [NSError errorWithDomain:EPCheckerErrorDomain code:EPCheckerIDCardNilValueError userInfo:nil];
            }
            return NO;
            break;
        case EPIDCardValidateResultWrongBirthDate:
            if (error) {
                *error = [NSError errorWithDomain:EPCheckerErrorDomain code:EPCheckerIDCardWrongBirthDateError userInfo:nil];
            }
            return NO;
            break;
        case EPIDCardValidateResultWrongChecksum:
            if (error) {
                *error = [NSError errorWithDomain:EPCheckerErrorDomain code:EPCheckerIDCardWrongChecksumError userInfo:nil];
            }
            return NO;
            break;
        case EPIDCardValidateResultWrongLength:
            if (error) {
                *error = [NSError errorWithDomain:EPCheckerErrorDomain code:EPCheckerIDCardWrongLengthError userInfo:nil];
            }
            return NO;
            break;
        case EPIDCardValidateResultWrongProvince:
            if (error) {
                *error = [NSError errorWithDomain:EPCheckerErrorDomain code:EPCheckerIDCardWrongProvinceError userInfo:nil];
            }
            return NO;
            break;
        case EPIDCardValidateResultError:
        default:
            if (error) {
                *error = [NSError errorWithDomain:EPCheckerErrorDomain code:EPCheckerErrorUnknown userInfo:nil];
            }
            return NO;
            break;
    }
}

+ (BOOL)isValidEmail:(NSString *)email {
    NSArray *array = [email componentsSeparatedByString:@"."];
    if ([array count] >= 4) {
        return FALSE;
    }
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)isValidMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,184
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2478])\\d)\\d{7}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,152,155,156,185,186
     */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,1349,153,180,189
     */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (BOOL)isValidTelePhoneNumber:(NSString *)telephone
{
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";

    NSPredicate *regextest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    return [regextest evaluateWithObject:telephone];
}

+ (BOOL)isValidPhone:(NSString *)phone
{
    return ([self isValidMobileNumber:phone] || [self isValidTelePhoneNumber:phone]);
}

@end
