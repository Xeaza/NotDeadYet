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

@property (weak, nonatomic) IBOutlet UIButton *deadButton;
@property (weak, nonatomic) IBOutlet UIButton *notDeadButton;
@property NSInteger counter;
@property NSInteger shakeCounter;

@end

@implementation ViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.counter = 0;
    UIImage *selectedButtonBackgroundImage = [UIImage imageNamed:@"buttonPressed"];

    [self.deadButton setBackgroundImage:selectedButtonBackgroundImage forState: UIControlStateHighlighted];
    [self.notDeadButton setBackgroundImage:selectedButtonBackgroundImage forState: UIControlStateHighlighted];
}

- (IBAction)onBringOutYourDeadButtonPressed:(UIButton *)button
{
    SystemSoundID bringOutYourDeadSound;
    [self playSounds:@[@"dead"] counter:0 sound:bringOutYourDeadSound];
}

- (IBAction)onNotDeadYetButtonPressed:(UIButton *)button
{
    SystemSoundID notDeadSound;
    NSArray *soundsArray = @[@"notdead", @"happy"];
    NSString *randomName;
    randomName = soundsArray[self.counter];

    if (self.counter == 0) {
        self.counter = 1;
    }
    else {
        self.counter = 0;
    }

    [self playSounds:soundsArray counter:self.counter sound:notDeadSound];
}

#pragma mark - Shake

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        SystemSoundID shrubSound;
        NSArray *soundsArray = @[@"shrub", @"shrub2"];

        if (self.shakeCounter == 0) {
            self.shakeCounter = 1;
        }
        else {
            self.shakeCounter = 0;
        }

        [self playSounds:soundsArray counter:self.shakeCounter sound:shrubSound];
    }
}

- (void)playSounds:(NSArray *)soundsArray counter:(NSInteger)counter sound:(SystemSoundID)sound
{
    NSString *randomName;
    randomName = soundsArray[counter];

    NSString *soundPath = [[NSBundle mainBundle] pathForResource:randomName ofType:@"wav"];

    NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &sound);
    AudioServicesPlaySystemSound(sound);
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
