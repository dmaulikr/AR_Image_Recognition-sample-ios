/*==============================================================================
Copyright (c) 2010-2011 QUALCOMM Austria Research Center GmbH.
All Rights Reserved.
Qualcomm Confidential and Proprietary
==============================================================================*/


#import <QuartzCore/QuartzCore.h>
#import "ImageTargetsAppDelegate.h"

@implementation ImageTargetsAppDelegate


@synthesize Sound = Sound;
@synthesize mon = mon;
@synthesize overlayViewController = overlayViewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    BOOL ret = YES;
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    window = [[UIWindow alloc] initWithFrame: screenBounds];
    self.overlayViewController = [[OverlayViewController alloc] init];
    UIView* parentV = [[UIView alloc] initWithFrame: screenBounds];
    
    screenBounds = CGRectMake(0, 0, parentV.frame.size.height, parentV.frame.size.width);
    view = [[EAGLView alloc] initWithFrame: screenBounds];
    [parentV addSubview:view];   

        
    /*NSMutableArray *myImages = [NSMutableArray arrayWithCapacity:426];
    for (int i=1; i<426; i++) 
    {
        
        //[myImages addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"clip1_%d",i] ofType:@"png" inDirectory:nil]]];
        [myImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"clip1_%d",i]]];
    }  
     
	self.myAnimatedView = [UIImageView alloc];
	[self.myAnimatedView initWithFrame:CGRectMake(160-543/2, 240-443/2, 543, 443)];   

	self.myAnimatedView.animationImages = myImages;
	self.myAnimatedView.animationDuration = 14;
	self.myAnimatedView.animationRepeatCount = 1;
    self.myAnimatedView.hidden = YES;
    [self.myAnimatedView startAnimating];
    [self pauseLayer:self.myAnimatedView.layer];
    
    //self.clip2 = [UIImage animatedImageNamed:@"clip2_" duration:14];
    

	[parentV addSubview:self.myAnimatedView];*/
    
    UIImageView *imgBar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar.png"]];   
    if( UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad ) {
        imgBar.frame = CGRectMake(0, 0, 480, 320);        
    }
    [parentV addSubview:imgBar];    
    [imgBar release];

   	
    
    //Start to animate	
   self.mon = [Monster monster];
    //426
    
//    [self changeUrl:@"clip1_"];
    self.mon.animationFrameDuration = ImageAnimator30FPS;
    mon.animationRepeatCount = 0;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationDidStartNotification:) name:ImageAnimatorDidStartNotification object:self.mon];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationDidStopNotification:) name:ImageAnimatorDidStopNotification object:self.mon];
    
    
    [parentV addSubview:mon.view];
    
    self.mon.view.hidden = YES;
    
    [overlayViewController setView: parentV];
    
    [window addSubview: self.overlayViewController.view];
    [window makeKeyAndVisible];    
    
    if (YES == ret) {
        [view onCreate];
    }
    
    return ret;
}

- (void)animationDidStartNotification:(NSNotification*)notification {
//	[[NSNotificationCenter defaultCenter] removeObserver:self name:ImageAnimatorDidStartNotification object:self.mon];	
    self.mon.view.hidden = NO;
}

- (void)animationDidStopNotification:(NSNotification*)notification {
	//[[NSNotificationCenter defaultCenter] removeObserver:self name:ImageAnimatorDidStopNotification object:self.mon];	
    self.mon.view.hidden = YES;
}

-(void)changeSoundAndPlay:(NSString *)name
{
//    self.Sound = nil;
//    NSError *error;
//    NSString* path = [[NSBundle mainBundle] pathForResource:name ofType:@"mp3"];
//    self.Sound = [[AVAudioPlayer alloc]
//                  initWithContentsOfURL:[NSURL fileURLWithPath:path] error:&error] ;
//    self.Sound.numberOfLoops = 0;
//    self.Sound.volume = 5;
//    [self.Sound prepareToPlay];
//    [self.Sound play]; 
}

-(void)changeUrl:(NSString *)name
{
//    int count = 0;
//    if([name isEqualToString:@"clip1_"])
//        count = 426;
//    else
//        count = 569;
//    self.mon.animationAudioURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:name ofType:@"mp3"]];
//
//    NSArray *names = [Monster arrayWithNumberedNames:name rangeStart:1 rangeEnd:count suffixFormat:@"%i.png"];	
//    NSArray *URLs = [Monster arrayWithResourcePrefixedURLs:names];	
//    self.mon.animationURLs = URLs;    
}

-(void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

-(void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // AR-specific actions
    [view onPause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // AR-specific actions
    [view onResume];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // AR-specific actions
    [view onDestroy];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Handle any background procedures not related to animation here.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Handle any foreground procedures not related to animation here.
}

- (void)dealloc
{
    [view release];
    [overlayViewController release];
    [window release];
    [Sound release];
    [mon release];
    
    [super dealloc];
}

@end
