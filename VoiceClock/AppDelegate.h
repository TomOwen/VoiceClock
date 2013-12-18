//
//  AppDelegate.h
//  VoiceClock
//
//  Created by Tom Owen on 7/21/12.
//  Copyright (c) 2012 Owen & Owen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVAudioSession.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) AVAudioPlayer *soundPlayer;

@end
