/*==============================================================================
Copyright (c) 2010-2011 QUALCOMM Austria Research Center GmbH.
All Rights Reserved.
Qualcomm Confidential and Proprietary
==============================================================================*/


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "EAGLView.h"
#import "OverlayViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "Monster.h"




@interface ImageTargetsAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow* window;
    OverlayViewController* overlayViewController;
    EAGLView* view;
    AVAudioPlayer *Sound;

    Monster *mon;
}

@property (nonatomic,retain) AVAudioPlayer *Sound;


@property (nonatomic, retain) Monster *mon;

@property(nonatomic, retain) OverlayViewController* overlayViewController;

-(void)pauseLayer:(CALayer*)layer;
-(void)resumeLayer:(CALayer*)layer;
-(void)changeUrl:(NSString *)name;
-(void)changeSoundAndPlay:(NSString *)name;

@end
