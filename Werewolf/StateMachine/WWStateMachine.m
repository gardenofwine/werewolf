//
//  WWStateMachine.m
//  Werewolf
//
//  Created by Benny Weingarten on 4/3/13.
//  Copyright (c) 2013 IIC. All rights reserved.
//

#import "WWStateMachine.h"

@implementation WWStateMachine

-(void) changeState: (id<WWState>)newState{
    
}

-(id<WWState>) getState:(State)state{
    return [self.states objectForKey:[NSNumber numberWithInt:state]];
}



@end
