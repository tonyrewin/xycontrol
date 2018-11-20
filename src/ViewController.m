//
//  ViewController.m
//  xycontrol
//
//  Created by To on 19/11/2018.
//  Copyright © 2018 LampHeads. All rights reserved.
//

#import "ViewController.h"
#import "XYView.h"

@interface ViewController () <XYViewDelegate>
@property (atomic) BOOL lastx;
@property (nonatomic) XYView *xyView;
- (void)sendMIDI:(uint)midiChannel value:(uint)midiValue;
@end


@implementation ViewController

-(void) sendMIDI:(uint)midiChannel value:(uint)midiValue
{
    // http://www.onicos.com/staff/iz/formats/midi-event.html
    //const uint midiChannel = 0xB0;
    const uint midiFunction = 0x10; // change CC#1
    const UInt8 data[]  = { midiChannel, midiFunction, midiValue };
    ByteCount size = sizeof(data);
    
    Byte packetBuffer[sizeof(MIDIPacketList)];
    MIDIPacketList *packetList = (MIDIPacketList *)packetBuffer;
    
    MIDIPacketListAdd(packetList,
                      sizeof(packetBuffer),
                      MIDIPacketListInit(packetList),
                      0,
                      size,
                      data);
    
    for (ItemCount index = 0; index < MIDIGetNumberOfDestinations(); index++) {
        MIDIEndpointRef outputEndpoint = MIDIGetDestination(index);
        if (outputEndpoint)
            MIDISend(outputPort, outputEndpoint, packetList);
    }
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // XY View
    self.xyView = [[XYView alloc] initWithFrame:self.view.bounds];
    self.xyView.delegate = self;
    [self.xyView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.xyView];
    
    // MIDI
    [[MIDINetworkSession defaultSession] setEnabled:YES];
    MIDIClientCreate((CFStringRef)@"XYControl MIDI", NULL, NULL, &client);
    MIDIOutputPortCreate(client, (CFStringRef)@"XYControl Port", &outputPort);
    
    self.lastx = NO;
}

- (CGFloat)getXYHeight:(CGFloat)height
{
    return (height - 20.0 - 60.0) / 3.0;
}

- (void)controlValueChanged:(CGPoint)point
{
    if(self.lastx == YES) {
        [self sendMIDI:0xB1 value:point.y];
        //NSLog(@"yx");
        [self sendMIDI:0xB0 value:point.x];
        self.lastx = NO;
    } else {
        [self sendMIDI:0xB0 value:point.x];
        //NSLog(@"xy");
        [self sendMIDI:0xB1 value:point.y];
        self.lastx = YES;
    }
}

@end
