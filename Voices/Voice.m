//
//  Voice.m
//  Thumbafon
//
//  Created by Chris Lavender on 1/30/11.
//  Copyright 2011 Gnarly Dog Music. All rights reserved.
//

#import "Voice.h"
#import "AQPlayer.h"

@implementation Voice

- (id)init
{
    self = [super init];
    if (self) {
        _maxNoteAmp = MAX_AMP/kNumberVoices;
    }
    return self;
}

- (void)on {
	_ampDelta = 1. / _attack;
}

- (void)off {
	_ampDelta = -1. / _release;
}

-(Float64)getEnvelope {
	_amplitude += _ampDelta;
	//1.0 = 1 second)
	if (_amplitude >= 1.0) {
		_amplitude = _sustain;
		_ampDelta = 0.;
	}
	else if (_amplitude <= 0.0) {
		_amplitude = 0.; 
		_ampDelta = 0.;
	}
	return _amplitude;
}

- (void)setAmp:(Float64)amplitude
{
    if (_maxNoteAmp != amplitude) {
        _maxNoteAmp = amplitude;
        
       // NSLog(@"mMaxNoteAmp: %f", mMaxNoteAmp);
    }
}

@synthesize freq = _freq;
@synthesize voiceReg = _voiceReg;

+ (Float64) noteNumToFreq:(UInt8)noteNum {
	return pow(2., (Float64)(noteNum - 69) / 12.) * 440.;
}

- (void) setFreq:(double)val;{
	_freq = val;
	_deltaTheta = _freq / kSR;
}

-(void)getSamplesForFreq:(Float64*)buffer:(UInt32)num_samples {
	
	for (UInt32 i = 0; i < num_samples; i++) {
		buffer[i] += _maxNoteAmp * [self getWaveTable:_theta] * [self getEnvelope];
		_theta += _deltaTheta;
	}
}

- (Float64)getWaveTable:(Float64)index {
	UInt32 i = index * kAudioDataByteSize;
	i %= kAudioDataByteSize;
	return _table[i];
}
@end
