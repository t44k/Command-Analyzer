//
//  ViewController.m
//  Command Analyzer
//
//  Created by tkorodi on 19/03/15.
//  Copyright (c) 2015 kotyo. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void)textDidChange:(NSNotification *)notification
{
    NSLog(@"Text did changed");
    // Remove all objects
    NSRange range = NSMakeRange(0, [[self.arrayController arrangedObjects] count]);
    [self.arrayController removeObjectsAtArrangedObjectIndexes:[NSIndexSet indexSetWithIndexesInRange:range]];
    [self splitCommand:self.commandTextView.textStorage.string arrayController:self.arrayController];
}

- (void)splitCommand:(NSString*)command arrayController:(NSArrayController*)array
{
    NSMutableDictionary* pair = NSMutableDictionary.new;
    [pair setObject:@"command" forKey:@"key"];
    for (NSString* part in [command componentsSeparatedByString:@" "]) {
        if ([part hasPrefix:@"-"]) {
            if (pair) {
                [array addObject:pair];
            }
            pair = NSMutableDictionary.new;
            
            unichar chr = 0;
            if ([part length] > 1) {
                chr = [part characterAtIndex:1];
            }
            BOOL isUppercase = [[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:chr];
            if (isUppercase) {
                [pair setObject:[part substringToIndex:2] forKey:@"key"];
                [pair setObject:[part substringFromIndex:2] forKey:@"value"];
                [array addObject:pair];
                pair = nil;
            } else if ([part containsString:@"="]) {
                NSRange range = [part rangeOfString:@"=" options:NSLiteralSearch];
                [pair setObject:[part substringToIndex:range.location+1] forKey:@"key"];
                [pair setObject:[part substringFromIndex:range.location+1] forKey:@"value"];
                [array addObject:pair];
                pair = nil;
            } else {
                [pair setObject:part forKey:@"key"];
            }
                
        } else {
            if (!pair) {
                pair = NSMutableDictionary.new;
            }
            NSString* oldValue = [pair valueForKey:@"value"];
            NSString* value;
            if (oldValue) {
                value = [NSString stringWithFormat:@"%@ %@", oldValue, part];
            } else {
                value = part;
            }
            [pair setObject:value forKey:@"value"];
            [array addObject:pair];
            pair = nil;
        }
    }
    
    if (pair) {
        [array addObject:pair];
    }
}

//- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
//{
//    return 10;
//}
//
//- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
//{
//    NSLog(@"identifier: %@", tableColumn.identifier);
//    NSTableCellView* cell = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
////    if (!field) {
////        field = [[NSTextField alloc] init];
////    }
//    cell.textField.stringValue = @"faszom";
//    return cell;
//}

@end
