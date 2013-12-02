//
//  EPCheckerTestTests.m
//  EPCheckerTestTests
//
//  Created by Puttin Wong on 12/02/13.
//  Copyright (c) 2013 Extensivepro. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EPChecker.h"

@interface EPCheckerTests : XCTestCase

@end

@implementation EPCheckerTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testValidateIDCard
{
    //valid ID:652100198806111135,34052419800101001X
    XCTAssertTrue([EPChecker validateIDCardNumber:@"652100198806111135"] == EPIDCardValidateResultPass, @"valid identifier(652100198806111135) check failed!");
    XCTAssertTrue([EPChecker validateIDCardNumber:@"34052419800101001X"] == EPIDCardValidateResultPass, @"valid identifier(34052419800101001X) check failed!");
    XCTAssertTrue([EPChecker validateIDCardNumber:@"34052419800101001x"] == EPIDCardValidateResultPass, @"valid identifier(34052419800101001x) check failed!");
    //invalid
    XCTAssertTrue([EPChecker validateIDCardNumber:@"652100198806111134"] == EPIDCardValidateResultWrongChecksum, @"valid identifier(652100198806111134) check failed!");
    XCTAssertTrue([EPChecker validateIDCardNumber:@"340524198001010011"] == EPIDCardValidateResultWrongChecksum, @"valid identifier(340524198001010011) check failed!");
    XCTAssertTrue([EPChecker validateIDCardNumber:@"000000000000000000"] == EPIDCardValidateResultWrongProvince, @"valid identifier(000000000000000000) check failed!");
    XCTAssertTrue([EPChecker validateIDCardNumber:nil] == EPIDCardValidateResultNilValue, @"valid identifier(nil) check failed!");
    XCTAssertTrue([EPChecker validateIDCardNumber:@""] == EPIDCardValidateResultWrongLength, @"valid identifier(\"\") check failed!");
}

- (void) testMobileNumber {
    //valid phone:13676058888
    XCTAssertTrue([EPChecker isValidMobileNumber:@"13676058888"], @"valid phone(13676058888) check failed!");
    //invalid
    XCTAssertFalse([EPChecker isValidMobileNumber:@"123"], @"valid phone(123) check failed!");
    XCTAssertFalse([EPChecker isValidMobileNumber:nil], @"valid phone(nil) check failed!");
    XCTAssertFalse([EPChecker isValidMobileNumber:@""], @"valid phone(\"\") check failed!");
}

- (void) testEmail {
    //valid email:example@example.com
    XCTAssertTrue([EPChecker isValidEmail:@"example@example.com"], @"valid email(example@example.com) check failed!");
    //invalid
    XCTAssertFalse([EPChecker isValidEmail:@"123"], @"valid email(123) check failed!");
    XCTAssertFalse([EPChecker isValidEmail:nil], @"valid email(nil) check failed!");
    XCTAssertFalse([EPChecker isValidEmail:@""], @"valid email(\"\") check failed!");
}

@end
