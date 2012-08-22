//
//  AQSynth.h
//  Thumbafon
//
//  Created by Chris Lavender on 1/30/11.
//  Copyright 2011 Gnarly Dog Music. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AQPlayer.h"

@class Voice;

@interface AQSynth : AQPlayer {

	Float64	theta;
	Float64	deltaTheta;

	Voice	*voice[kNumberVoices];
		
	BOOL	changingSound;
    
    UInt16 _volume;
}

@property UInt16 volume;

#pragma mark - monophonic methods
- (void)midiNoteOn:(int)noteNum;
- (void)changeMidiNoteToNoteNum:(int)noteNum;
- (void)midiNoteOff:(int)noteNum;

#pragma mark - polyphonic methods
- (void)midiNoteOn:(int)noteNum atVoiceIndex:(int)voiceIndex;
- (void)changeMidiNoteToNoteNum:(int)noteNum atVoiceIndex:(int)voiceIndex;
- (void)midiNoteOff:(int)noteNum atVoiceIndex:(int)voiceIndex;

@end
