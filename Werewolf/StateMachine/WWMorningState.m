//
//  WWMorningState.m
//  Werewolf
//
//  Created by Benny Weingarten on 4/3/13.
//  Copyright (c) 2013 IIC. All rights reserved.
//

#import "WWMorningState.h"

@implementation WWMorningState

- (id)initWithStateMachine:(WWStateMachine *)theStateMachine{
    self = [super init];
    if (self) {
        stateMachine = theStateMachine;
    }
    return self;
}

-(void) enter{
    NSLog(@"Entering Morning state");
    
    NSString *notificationName = @"WWNoLynch";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noLynch:) name:notificationName object:nil];
}

-(void) cleanup {
    NSLog(@"Cleaning up Morning state");
}

-(void) noLynch{
    [self gotoNightState];
}

-(void) vote{
    [self gotoVotingState];
}

-(void) gotoVotingState{
    [stateMachine changeState:[stateMachine getState:voting]];
}

-(void) gotoNightState{
    [stateMachine changeState:[stateMachine getState:night]];
}



@end
