//
//  Voice.h
//  Thumbafon
//
//  Created by Chris Lavender on 1/30/11.
//  Copyright 2011 Gnarly Dog Music. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AQPlayer.h"

@interface Voice : NSObject {
	
    Float64 _amplitude;
	Float64 _maxNoteAmp;
	
	Float64 _attack;
	Float64 _sustain;
	Float64 _release;
	Float64 _ampDelta;
    
    Float64 _theta;
	Float64 _deltaTheta;
	Float64 _freq;
	
	Float64 _table[kAudioDataByteSize];
	
	SInt8	_voiceReg;
}

- (void)on;
- (void)off;
- (Float64)getEnvelope;

- (void)setAmp:(Float64)amplitude;

@property (nonatomic)Float64 freq;
@property SInt8 voiceReg;

+ (Float64)noteNumToFreq:(UInt8)note_num;

- (void)getSamplesForFreq:(Float64*)buffer:(UInt32)num_samples;
- (Float64)getWaveTable:(Float64)index;


@end
