//
//  AboutWindow.m
//  tafus
//
//  Created by Moshe Gottlieb on 07/08/2016.
//  Copyright © 2016 Sharkfood. All rights reserved.
//

#import "AboutWindow.h"

@implementation AboutWindow
- (IBAction)close:(id)sender {
    [[NSApplication sharedApplication] endSheet:self returnCode:0];
}

@end
