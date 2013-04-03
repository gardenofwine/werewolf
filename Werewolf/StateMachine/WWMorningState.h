//
//  WWMorningState.h
//  Werewolf
//
//  Created by Benny Weingarten on 4/3/13.
//  Copyright (c) 2013 IIC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WWState.h"

@interface WWMorningState : NSObject<WWState>{
    @private
    WWStateMachine *stateMachine;
}

@end
