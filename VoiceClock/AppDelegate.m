//
//  AppDelegate.m
//  VoiceClock
//
//  Created by Tom Owen on 7/21/12.
//  Copyright (c) 2012 Owen & Owen. All rights reserved.
//

#import "AppDelegate.h"



@implementation AppDelegate

@synthesize window = _window;
@synthesize soundPlayer = _soundPlayer;
-(NSString *)determineSoundFile {
    NSDate *now = [NSDate date];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSMinuteCalendarUnit | NSHourCalendarUnit) fromDate:now];
    int minutes = [components minute]; 
    int hour = [components hour];

    NSString *time0030 = @"30";
    if (minutes < 30) {
        time0030 = @"00";
    } else {
        time0030 = @"30";
    }
    if (hour > 12) hour = hour - 12;
    NSString *soundFileName = [[NSString alloc] initWithFormat:@"%i-%@",hour,time0030];
    return soundFileName;
}
- (void)application:(UIApplication *)application 
didReceiveLocalNotification:(UILocalNotification *)notification {
    // cancel all 
    //[[UIApplication sharedApplication] cancelAllLocalNotifications];
    //Handle the notificaton when the app is running
    NSLog(@"Recieved Notification %@",notification);
   // ViewController *getNext = [[ViewController alloc] init];
    //[getNext getNextTimeToSpeak];
    NSString *fileName = [self determineSoundFile];
    NSURL *soundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:fileName] ofType:@"aiff"]];
    
    
    self.soundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:nil];
    NSLog(@"Playing %@",fileName);
    [_soundPlayer prepareToPlay];
    [self.soundPlayer play];
    
   
    
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
     [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
