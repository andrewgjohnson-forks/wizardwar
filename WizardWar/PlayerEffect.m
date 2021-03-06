//
//  Effect.m
//  WizardWar
//
//  Created by Sean Hess on 6/11/13.
//  Copyright (c) 2013 The LAB. All rights reserved.
//

#import "PlayerEffect.h"
#import "Spell.h"
#import "Wizard.h"

@implementation PlayerEffect

-(id)init {
    self = [super init];
    if (self) {
        self.delay = 0;
        self.duration = EFFECT_INDEFINITE;
    }
    return self;
}

-(NSComparisonResult)compare:(PlayerEffect*)effect {
    if (effect) return NSOrderedSame;
    return NSOrderedAscending;
}

-(void)start:(NSInteger)tick player:(Wizard *)player {
    player.effectStartTick = tick;
//    NSLog(@"STARTED %@ %i", player, player.effectStartTick);
}

-(void)activateEffect:(Wizard*)wizard {
    
}

-(void)cancel:(Wizard*)player {
    // doesn't actually cancel it!?
}

// Default effect applied to player, is to deal damage
-(BOOL)applySpell:(Spell*)spell onWizard:(Wizard*)wizard currentTick:(NSInteger)currentTick {
    wizard.health -= spell.damage;
    
    if (spell.damage > 0)
        [wizard setStatus:WizardStatusHit atTick:currentTick];
    
    if (wizard.effect.cancelsOnHit) {
        [wizard.effect cancel:wizard];
        wizard.effect = nil;
    }
    
    spell.strength = 0;
    
    return YES;
}

// means did not intercept, go ahead with default behavior
-(BOOL)interceptSpell:(Spell*)spell onWizard:(Wizard*)wizard interval:(NSTimeInterval)interval currentTick:(NSInteger)currentTick {
    return NO;
}

-(BOOL)simulateTick:(NSInteger)currentTick interval:(NSTimeInterval)interval player:(Wizard*)player {
    return NO;
}

@end
