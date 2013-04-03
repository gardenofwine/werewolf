//
//  WWStateMachine.h
//  Werewolf
//
//  Created by Benny Weingarten on 4/3/13.
//  Copyright (c) 2013 IIC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WWState.h"

typedef enum {
    morning,
    night,
    voting
} State;

@protocol WWState;

@interface WWStateMachine : NSObject

@property (strong, nonatomic) NSDictionary* states;

-(void) changeState: (id<WWState>)newState;
-(id<WWState>) getState:(State)state;

@end
