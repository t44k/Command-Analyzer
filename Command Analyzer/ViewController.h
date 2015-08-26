//
//  ViewController.h
//  Command Analyzer
//
//  Created by tkorodi on 19/03/15.
//  Copyright (c) 2015 kotyo. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController <NSTextDelegate, NSTableViewDataSource>
@property (unsafe_unretained) IBOutlet NSTextView *commandTextView;
@property (strong) IBOutlet NSArrayController *arrayController;
@end

