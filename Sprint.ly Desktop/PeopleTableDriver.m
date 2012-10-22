//
//  PeopleTableDriver.m
//  Sprint.ly Desktop
//
//  Created by Dan Reed on 10/19/12.
//  Copyright (c) 2012 Dan Reed. All rights reserved.
//

#import "PeopleTableDriver.h"

@implementation PeopleTableDriver

@synthesize delegate;

- (void) giveTableArray:(NSArray *)newTableArray{
    tableArray = [NSArray arrayWithArray:newTableArray];
}

#pragma mark - tableview datasouce/delegate methods

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex{
    if([[aTableColumn identifier]isEqualToString:@"person_id"]){
        return [[tableArray objectAtIndex:rowIndex]objectForKey:@"id"];
    }
    else if([[aTableColumn identifier]isEqualToString:@"person_name"]){
        return [NSString stringWithFormat:@"%@ %@",[[tableArray objectAtIndex:rowIndex]objectForKey:@"first_name"],[[tableArray objectAtIndex:rowIndex]objectForKey:@"last_name"]];
    }
    else if([[aTableColumn identifier]isEqualToString:@"person_email"]){
        return [[tableArray objectAtIndex:rowIndex]objectForKey:@"email"];
    }
    else{
        return @"THIS IS BAD!";
    }
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView{
    return [tableArray count];
}

- (BOOL)tableView:(NSTableView *)aTableView shouldSelectRow:(NSInteger)rowIndex{
    [delegate userSelectedNewPerson:[[[tableArray objectAtIndex:rowIndex]objectForKey:@"id"]intValue]];
    return YES;
}

@end
