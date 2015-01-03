//
//  ViewController.m
//  NotDeadYet
//
//  Created by Taylor Wright-Sanson on 1/2/15.
//  Copyright (c) 2015 Taylor Wright-Sanson. All rights reserved.
//

#import "ViewController.h"
@import AVFoundation;

@interface ViewController () <AVAudioPlayerDelegate>

@property (assign) SystemSoundID bringOutYourDeadSound;
@property (assign) SystemSoundID soundSound;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)onBringOutYourDeadButtonPressed:(id)sender
{
    NSString *bringOutYourDeadPath = [[NSBundle mainBundle] pathForResource:@"dead" ofType:@"wav"];
    NSURL *bringOutYourDeadURL = [NSURL fileURLWithPath:bringOutYourDeadPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)bringOutYourDeadURL, &_bringOutYourDeadSound);
    AudioServicesPlaySystemSound(self.bringOutYourDeadSound);
}

- (IBAction)onNotDeadYetButtonPressed:(id)sender
{
    NSArray *soundsArray = @[@"notDead", @"happy"];
    NSString *randomName = soundsArray[arc4random_uniform(0)+1];
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:randomName ofType:@"wav"];

    NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &_soundSound);
    AudioServicesPlaySystemSound(self.soundSound);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
