//
//  Task.m
//  Quiz5
//
//  Created by Moser, Wesley on 3/14/14.
//  Copyright (c) 2014 Moser, Wesley. All rights reserved.
//

#import "Task.h"

@implementation Task

- (id)init
{
    self = [super init];
    if (self)
    {
        self.dueDate = [NSDate date];
        self.urgency = 5.0;
    }
    return self;
}

@end
