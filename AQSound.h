//
//  AQSound.h
//  Thumbafon
//
//  Created by Chris Lavender on 2/4/11.
//  Copyright 2011 Gnarly Dog Music. All rights reserved.
//

//This class determines what sound will be alloc/inited

#import <Foundation/Foundation.h>
#import "AQSynth.h"

typedef enum {
    EPiano = 0,
    Organ,
    Brass,
    Strings,
    Flute
} SoundType;

@interface AQSound : AQSynth

@property SoundType soundType;

@end

