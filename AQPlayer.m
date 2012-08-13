//
//  AQPlayer.m
//  Thumbafon
//
//  Created by Chris Lavender on 4/7/10.
//  Copyright 2010 Gnarly Dog Music. All rights reserved.
//

#import "AQPlayer.h"

@implementation AQPlayer

@synthesize isRunning;

void AQBufferCallback(void *inUserData, AudioQueueRef inAQ, AudioQueueBufferRef inAQBuffer) {	
	
	AQPlayer *aqp = (__bridge AQPlayer *)inUserData;
	
	const SInt32 numFrames = (inAQBuffer->mAudioDataBytesCapacity) / sizeof(SInt16);
	Float64 sampleBuffer[numFrames];
	
	memset(sampleBuffer,0,sizeof(Float64)*numFrames);
	[aqp fillAudioBuffer:sampleBuffer:numFrames];

	Float64 sample = 0.;	
	for (UInt32 i = 0; i < numFrames; i++) {	
		sample = sampleBuffer[i];
		sample = sample > MAX_AMP ? MAX_AMP : sample < -MAX_AMP ? -MAX_AMP : sample;
		((SInt16*)inAQBuffer->mAudioData)[i] = sample * (SInt16)0x7FFF;
	}

	inAQBuffer->mAudioDataByteSize = kAudioDataByteSize;
	inAQBuffer->mPacketDescriptionCount = 0;
	AudioQueueEnqueueBuffer(inAQ, inAQBuffer, 0, nil);
}


- (void)dealloc {
	
	[self stop];
}

-(void) newAQ {
	
	mDataFormat.mSampleRate = kSR;
	mDataFormat.mFormatID = kAudioFormatLinearPCM;
	mDataFormat.mFormatFlags = kAudioFormatFlagIsSignedInteger;
	mDataFormat.mBytesPerPacket = sizeof(SInt16);
	mDataFormat.mFramesPerPacket = 1;
	mDataFormat.mBytesPerFrame = sizeof(SInt16);
	mDataFormat.mChannelsPerFrame = 1;
	mDataFormat.mBitsPerChannel = 16;

	OSStatus result = AudioQueueNewOutput(&mDataFormat, AQBufferCallback, (__bridge void *)(self), nil, nil, 0, &mQueue);

	if (result != noErr)
		printf("AudioQueueNewOutput %ld\n",result);
	
	for (UInt8 i = 0; i < kNumberBuffers; ++i) {
		result = AudioQueueAllocateBuffer(mQueue, kAudioDataByteSize, &mBuffers[i]);
		if (result != noErr)
			printf("AudioQueueAllocateBuffer %ld\n",result);
	}
}

-(OSStatus) start; { 	
	OSStatus result = noErr;
    
	// if we have no queue, create one now
	if (mQueue == nil)
		[self newAQ];
	
	// prime the queue with some data before starting
	for (UInt8 i = 0; i < kNumberBuffers; ++i)
		AQBufferCallback((__bridge void *)(self), mQueue, mBuffers[i]);
	
	result = AudioQueueStart(mQueue, nil);
	self.isRunning = YES;

	return result;
}


-(OSStatus) stop; {
	OSStatus result = noErr;
	
	result = AudioQueueStop(mQueue, true);
	self.isRunning = NO;

	return result;
}

- (void)fillAudioBuffer:(Float64*)buffer:(UInt32)numFrames {
}

@end