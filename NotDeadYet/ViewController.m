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
@property (weak, nonatomic) IBOutlet UIButton *deadButton;
@property (weak, nonatomic) IBOutlet UIButton *notDeadButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *selectedButtonBackgroundImage = [UIImage imageNamed:@"buttonPressed"];

    [self.deadButton setBackgroundImage:selectedButtonBackgroundImage forState: UIControlStateHighlighted];
    [self.notDeadButton setBackgroundImage:selectedButtonBackgroundImage forState: UIControlStateHighlighted];
}

- (IBAction)onBringOutYourDeadButtonPressed:(UIButton *)button
{
    NSString *bringOutYourDeadPath = [[NSBundle mainBundle] pathForResource:@"dead" ofType:@"wav"];
    NSURL *bringOutYourDeadURL = [NSURL fileURLWithPath:bringOutYourDeadPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)bringOutYourDeadURL, &_bringOutYourDeadSound);
    AudioServicesPlaySystemSound(self.bringOutYourDeadSound);
}

- (IBAction)onNotDeadYetButtonPressed:(UIButton *)button
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
