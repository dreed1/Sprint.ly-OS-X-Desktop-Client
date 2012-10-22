//
//  ItemTableDriver.m
//  Sprint.ly Desktop
//
//  Created by Dan Reed on 10/19/12.
//  Copyright (c) 2012 Dan Reed. All rights reserved.
//

#import "ItemTableDriver.h"

@implementation ItemTableDriver
@synthesize delegate;

- (void) giveTableArray:(NSArray *)newTableArray{
    tableArray = [NSArray arrayWithArray:newTableArray];
}

#pragma mark - tableview datasouce/delegate methods

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex{
    if([[aTableColumn identifier]isEqualToString:@"number_column"]){
        return [[tableArray objectAtIndex:rowIndex]objectForKey:@"number"];
    }
    else if([[aTableColumn identifier]isEqualToString:@"status_column"]){
        return [[tableArray objectAtIndex:rowIndex]objectForKey:@"status"];
    }
    else if([[aTableColumn identifier]isEqualToString:@"type_column"]){
        return [[tableArray objectAtIndex:rowIndex]objectForKey:@"type"];
    }
    else if([[aTableColumn identifier]isEqualToString:@"assigned_column"]){
        if(![[[[tableArray objectAtIndex:rowIndex]objectForKey:@"assigned_to"]class]isSubclassOfClass:[NSNull class]])
            return [[[tableArray objectAtIndex:rowIndex]objectForKey:@"assigned_to"]objectForKey:@"first_name"];
        else
            return @"Nobody";
    }
    else if([[aTableColumn identifier]isEqualToString:@"title_column"]){
        return [[tableArray objectAtIndex:rowIndex]objectForKey:@"title"];
    }
    else{
        DLog(@"%@",[aTableColumn identifier]);
        return @"SH*T!";
    }
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView{
    return [tableArray count];
}

- (BOOL)tableView:(NSTableView *)aTableView shouldSelectTableColumn:(NSTableColumn *)aTableColumn{
    if([[aTableColumn identifier]isEqualToString:@"number_column"]){
        [self sortByNumber];
    }
    else if([[aTableColumn identifier]isEqualToString:@"status_column"]){
        [self sortByStatus];
    }
    else if([[aTableColumn identifier]isEqualToString:@"type_column"]){
        [self sortByType];
    }
    else if([[aTableColumn identifier]isEqualToString:@"assigned_column"]){
        [self sortByAssigned];
    }
    else{
        DLog(@"i refuse to sort by title");
    }
    return NO;
}

#pragma mark - sort methods

- (void) sortByNumber{
    NSSortDescriptor *numberSort = [[NSSortDescriptor alloc]initWithKey:@"number" ascending:YES];
    tableArray  = [tableArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:numberSort]];
    [delegate reloadItemTable];
}

- (void) sortByStatus{
    NSSortDescriptor *numberSort = [[NSSortDescriptor alloc]initWithKey:@"status" ascending:YES];
    tableArray  = [tableArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:numberSort]];
    [delegate reloadItemTable];
}

- (void) sortByType{
    NSSortDescriptor *numberSort = [[NSSortDescriptor alloc]initWithKey:@"type" ascending:YES];
    tableArray  = [tableArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:numberSort]];
    [delegate reloadItemTable];
}

- (void) sortByAssigned{
//    NSSortDescriptor *numberSort = [[NSSortDescriptor alloc]initWithKey:@"number" ascending:YES];
//    [tableArray sort]
//    tableArray  = [tableArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:numberSort]];
//    [delegate reloadItemTable];
}

@end
