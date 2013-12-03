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
    NSError *error;
    XCTAssertTrue([EPChecker isValidIDCard:@"652100198806111135" error:&error]);
    XCTAssertNil(error);
    
    XCTAssertTrue([EPChecker isValidIDCard:@"34052419800101001X" error:&error]);
    XCTAssertNil(error);
    
    XCTAssertTrue([EPChecker isValidIDCard:@"34052419800101001x" error:nil]);
    //invalid
    XCTAssertFalse([EPChecker isValidIDCard:@"652100198806111134" error:&error]);
    XCTAssertNotNil(error);
    XCTAssertEqual((EPCheckerError)error.code, EPCheckerIDCardWrongChecksumError);
    
    XCTAssertFalse([EPChecker isValidIDCard:@"340524200102290011" error:&error]);
    XCTAssertNotNil(error);
    XCTAssertEqual((EPCheckerError)error.code, EPCheckerIDCardWrongBirthDateError);
    
    XCTAssertFalse([EPChecker isValidIDCard:@"000000000000000000" error:&error]);
    XCTAssertNotNil(error);
    XCTAssertEqual((EPCheckerError)error.code, EPCheckerIDCardWrongProvinceError);
    
    XCTAssertFalse([EPChecker isValidIDCard:nil error:&error]);
    XCTAssertNotNil(error);
    XCTAssertEqual((EPCheckerError)error.code, EPCheckerIDCardNilValueError);
    
    XCTAssertFalse([EPChecker isValidIDCard:@"" error:&error]);
    XCTAssertNotNil(error);
    XCTAssertEqual((EPCheckerError)error.code, EPCheckerIDCardWrongLengthError);
    
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
