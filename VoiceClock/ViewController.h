//
//  ViewController.h
//  VoiceClock
//
//  Created by Tom Owen on 7/21/12.
//  Copyright (c) 2012 Owen & Owen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>

@interface ViewController : UIViewController
- (IBAction)PlayClick:(id)sender;
- (IBAction)beginAllTimers:(UIButton *)sender;
- (IBAction)cancelAllTimers:(UIButton *)sender;

@property (nonatomic, retain) AVAudioPlayer *soundPlayer;


@end
