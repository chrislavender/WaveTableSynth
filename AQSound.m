//
//  AQSound.m
//  Thumbafon
//
//  Created by Chris Lavender on 2/4/11.
//  Copyright 2011 Gnarly Dog Music. All rights reserved.
//

#import "AQSound.h"
#import "SinePiano.h"
#import "PulseOrgan.h"
#import "SquareStrings.h"
#import "SawBrass.h"
#import "TriangleFlute.h"

@implementation AQSound
@synthesize soundType;

- (id)init
{
    self = [super init];
    
    if (self) {
        for (UInt8 i = 0; i < kNumberVoices; i++) {
            voice[i] = [[SinePiano alloc] init];
        }
    }
    return self;
}

- (SoundType)soundType
{
    return soundType;
}

- (void)setSoundType:(SoundType)newSoundType
{
    if (soundType != newSoundType) {
        soundType = newSoundType;
        changingSound = YES;
        
        switch (soundType) {
            
            case Organ:
                for (UInt8 i = 0; i < kNumberVoices; i++) voice[i] = [[PulseOrgan alloc] init];
                break;
            case Brass:
                for (UInt8 i = 0; i < kNumberVoices; i++) voice[i] = [[SawBrass alloc] init];
                break;
            case Strings:
                for (UInt8 i = 0; i < kNumberVoices; i++) voice[i] = [[SquareStrings alloc] init];
                break;
            case Flute:
                for (UInt8 i = 0; i < kNumberVoices; i++) voice[i] = [[TriangleFlute alloc] init];
                break;
                
            default:
                for (UInt8 i = 0; i < kNumberVoices; i++) voice[i] = [[SinePiano alloc] init];
                break;
        }
        
        changingSound = NO;
    }
}

@end
