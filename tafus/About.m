//
//  About.m
//  tafus
//
//  Created by Moshe Gottlieb on 07/08/2016.
//  Copyright © 2016 Sharkfood. All rights reserved.
//

#import "About.h"

@implementation About

- (IBAction)logo:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://sharkfood.com"]];
}

@end
