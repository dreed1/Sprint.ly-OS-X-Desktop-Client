//
//  ProductTableDriver.m
//  Sprint.ly Desktop
//
//  Created by Dan Reed on 10/19/12.
//  Copyright (c) 2012 Dan Reed. All rights reserved.
//

#import "ProductTableDriver.h"

@implementation ProductTableDriver
@synthesize delegate;

- (void) giveTableArray:(NSArray *)newTableArray{
    tableArray = [NSArray arrayWithArray:newTableArray];
}

#pragma mark - tableview datasouce/delegate methods

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex{
    if([[aTableColumn identifier]isEqualToString:@"ID_column"]){
        return [[tableArray objectAtIndex:rowIndex]objectForKey:@"id"];
    }
    else if([[aTableColumn identifier]isEqualToString:@"Name_column"]){
        return [[tableArray objectAtIndex:rowIndex]objectForKey:@"name"];
    }
    else{
        return @"THIS IS BAD!";
    }
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView{
    return [tableArray count];
}

- (BOOL)tableView:(NSTableView *)aTableView shouldSelectRow:(NSInteger)rowIndex{
    [delegate userSelectedNewApplication:[[[tableArray objectAtIndex:rowIndex]objectForKey:@"id"]intValue]];
    return YES;
}

@end
