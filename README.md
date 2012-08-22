WaveTableSynth
==============

Light weight polyphonic additive wave table synthesizer that uses Audio Queues  

In your view controller just create an AQSound object

        _aqPlayer = [[AQSound alloc]init];

Currently there a couple of ways to play notes. The easiest would be to use:

    - (void)midiNoteOn:(int)noteNum atVoiceIndex:(int)voiceIndex;
    - (void)changeMidiNoteToNoteNum:(int)noteNum atVoiceIndex:(int)voiceIndex;
    - (void)midiNoteOff:(int)noteNum atVoiceIndex:(int)voiceIndex;

True polyphony is not yet fully supported but there groundwork is there. Of course folks
are welcome to submit pull requests.

Global volume can be controlled by the AQSynth's 

    @property UInt16 volume;

You can change the timbre by setting the AQSynth's

    @property SoundType soundType;

The AQSynth has an enum "SoundType" you can use or simply send an int of course.


Note that the volume limiter is scaled by the kNumberVoices macro.
Change this to 1 and edit the AQSynth's volume property to allow for 
some interesting (in my opinion) digital distortion effects.

Have fun!