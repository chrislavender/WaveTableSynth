//
//  AQSynth.m
//  Thumbafon
//
//  Created by Chris Lavender on 1/30/11.
//  Copyright 2011 Gnarly Dog Music. All rights reserved.
//

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
//            NSLog(@"_volume: %d  amp: %f", _volume, amp);
            [voice[i] setAmp:amp];
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
    [voice[0] off];
}




- (void)startVoice:(UInt8)note_pos {	
	[voice[note_pos] on];
}

- (void)stopVoice:(UInt8)note_pos {	
	[voice[note_pos] off];
}



@end
