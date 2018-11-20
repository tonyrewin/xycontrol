//
//  ViewController.h
//  xycontrol
//
//  Created by To on 19/11/2018.
//  Copyright © 2018 LampHeads. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMIDI/CoreMIDI.h>

@interface ViewController : UIViewController {
    MIDIClientRef client;
    MIDIPortRef outputPort;
}
@end
