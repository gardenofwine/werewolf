//
//  WWState.h
//  Werewolf
//
//  Created by Benny Weingarten on 4/3/13.
//  Copyright (c) 2013 IIC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WWStateMachine.h"

@class WWStateMachine;

@protocol WWState <NSObject>

-(id) initWithStateMachine:(WWStateMachine *)stateMachine;
-(void) enter;
-(void) cleanup;

@end
