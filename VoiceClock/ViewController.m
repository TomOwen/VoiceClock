//
//  ViewController.m
//  VoiceClock
//
//  Created by Tom Owen on 7/21/12.
//  Copyright (c) 2012 Owen & Owen. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()

@end

@implementation ViewController
@synthesize soundPlayer = _soundPlayer;

- (NSDate *)dateWithZeroSeconds:(NSDate *)date
{
    NSTimeInterval time = floor([date timeIntervalSinceReferenceDate] / 60.0) * 60.0;
    return  [NSDate dateWithTimeIntervalSinceReferenceDate:time];
}

-(NSDate *)getNextTimeToSpeak:(NSDate *)dateBegin {
    // if minutes 1-29 add (30 - minute)*60 to date, if minutes 30-59 add (60 - minute)*60 to date

    NSDate *now = [NSDate date];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSMinuteCalendarUnit | NSHourCalendarUnit) fromDate:dateBegin];
    int minutes = [components minute]; 
    int hour = [components hour];
    int seconds = 0;
    NSString *time0030 = @"30";
    if (minutes < 30) {
        seconds = (30 - minutes)*60;
    } else {
        seconds = (60 - minutes)*60;
        hour = hour + 1;
        time0030 = @"00";
    }
    if (hour > 12) hour = hour - 12;
    NSString *soundFileName = [[NSString alloc] initWithFormat:@"%i-%@.aiff",hour,time0030];
    //NSString *soundFileName = [[NSString alloc] initWithFormat:@"%i-%@.wav",hour,time0030];
    NSDate *newDate = [dateBegin dateByAddingTimeInterval:seconds];
    NSLog(@"current time %@",now);
    NSDate *zeroDate = [self dateWithZeroSeconds:newDate];
    NSLog(@"alarm time %@",zeroDate);
    NSLog(@"sound file is %@",soundFileName);
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = zeroDate;
    notification.soundName = soundFileName;
    NSString *message = [[NSString alloc] initWithFormat:@"Cat's Clock: It's now %d:%@",hour,time0030];
    notification.alertBody = message;
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    return newDate;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self beginAllTimers:nil];
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (IBAction)PlayClick:(id)sender {
        
        //NSURL *soundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"meough600"] ofType:@"aiff"]];
        NSURL *soundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"meough600"] ofType:@"aiff"]];
        
        self.soundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:nil];
        
        [self.soundPlayer prepareToPlay];
        [self.soundPlayer play];
  //
    
        
        
        NSLog(@"tmpFilename is %@", soundURL);
    

}

- (IBAction)beginAllTimers:(UIButton *)sender {
    NSDate *now = [NSDate date];
    for (int i=0;i<48;i++) {
    now = [self getNextTimeToSpeak:now];
    }
}

- (IBAction)cancelAllTimers:(UIButton *)sender {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}
@end
