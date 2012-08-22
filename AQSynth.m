//
//  AQSynth.m
//  Thumbafon
//
//  Created by Chris Lavender on 1/30/11.
//  Copyright 2011 Gnarly Dog Music. All rights reserved.
//
#include "math.h"

#import "AQSynth.h"
#import "Voice.h"
// #import "freeverb.h"

@implementation AQSynth

- (UInt16)volume
{
    return _volume;
}

- (void)setVolume:(UInt16)volume
{
    if (_volume != volume) {
        _volume = volume;
        
        for (int i = 0; i < kNumberVoices; ++i) {
            
            if (_volume > 100) {
                _volume = 100;
            }
            
            Float64 amp = _volume * 0.01;
            //amp = log10f(amp);
            NSLog(@"_volume: %d  amp: %f", _volume, amp);
            [self volumeLevel:amp];
        }
    }
}

-(void)dealloc {
	
//	Reverb_Release();
}

-(void)fillAudioBuffer:(Float64*)buffer:(UInt32)num_samples {
	
    for (UInt8 i = 0; i < kNumberVoices; i++) {
        
        if (!changingSound && voice[i] != nil) {
            
            [voice[i] getSamplesForFreq:buffer:num_samples];
        }
    }
//	revmodel_process(buffer,num_samples,1);
}

#pragma mark - monophonic methods
- (void)midiNoteOn:(int)noteNum
{
    voice[0].freq = [Voice noteNumToFreq:noteNum];
    [voice[0] on];
}

- (void)changeMidiNoteToNoteNum:(int)noteNum
{
    voice[0].freq = [Voice noteNumToFreq:noteNum];
}

- (void)midiNoteOff:(int)noteNum
{
    for (int i = 0 ; i < kNumberVoices; ++i) {
        voice[i].freq = [Voice noteNumToFreq:noteNum];
        [voice[i] off];
    }
}

#pragma mark - polyphonic methods
- (void)midiNoteOn:(int)noteNum atVoiceIndex:(int)voiceIndex
{
    voice[voiceIndex].freq = [Voice noteNumToFreq:noteNum];
    [voice[voiceIndex] on];

}

- (void)changeMidiNoteToNoteNum:(int)noteNum atVoiceIndex:(int)voiceIndex
{
    voice[voiceIndex].freq = [Voice noteNumToFreq:noteNum];

}

- (void)midiNoteOff:(int)noteNum atVoiceIndex:(int)voiceIndex
{
    for (int i = 0 ; i < kNumberVoices; ++i) {
        voice[i].freq = [Voice noteNumToFreq:noteNum];
        [voice[i] off];
    }
}


// old stuff...
- (void)startVoice:(UInt8)note_pos {	
	[voice[note_pos] on];
}

- (void)stopVoice:(UInt8)note_pos {	
	[voice[note_pos] off];
}



@end
