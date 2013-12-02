//
//  EPCTMainViewController.m
//  EPCheckerTest
//
//  Created by Puttin Wong on 12/02/13.
//  Copyright (c) 2013 Extensivepro. All rights reserved.
//

#import "EPCTMainViewController.h"

@interface EPCTMainViewController ()

@end

@implementation EPCTMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *tipLabel = [UILabel new];
    tipLabel.translatesAutoresizingMaskIntoConstraints = NO;
    tipLabel.text = @"Run Unit Test!";
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipLabel];
    
    NSDictionary *bindingsDict = NSDictionaryOfVariableBindings(tipLabel);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[tipLabel]-|" options:0 metrics:nil views:bindingsDict]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[tipLabel]-|" options:0 metrics:nil views:bindingsDict]];
}

@end
