    //
//  Monster.m
//  Monsters
//
//  Created by Александр Турьев on 20.01.11.
//  Copyright 2011 СевКавГТУ. All rights reserved.
//

#import "Monster.h"
#import <QuartzCore/QuartzCore.h>

#import <AVFoundation/AVAudioPlayer.h>


@implementation Monster


@synthesize animationURLs, animationFrameDuration, animationNumFrames, animationRepeatCount,
imageView, animationData, animationTimer, animationStep, animationDuration, animationOrientation;
@synthesize animationAudioURL, avAudioPlayer;
@synthesize currentLoop;
@synthesize player;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (void)dealloc {
	// This object can't be deallocated while animating, this could
	// only happen if user code incorrectly dropped the last ref.
	
	NSAssert([self isAnimating] == FALSE, @"dealloc while still animating");
	
	self.animationURLs = nil;
	self.imageView = nil;
	self.animationData = nil;
	self.animationTimer = nil;
    self.player = nil;
	
	[super dealloc];
}

+ (Monster*) monster
{
	return [[[Monster alloc] init] autorelease];
}

- (id) init{
    self = [super init];
    if(self){
        NSURL* movUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"PUMA_k1_sneaker" ofType:@"mp4"]];
        self.player = [[MPMoviePlayerController alloc] initWithContentURL: movUrl];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoDidStopNotification) name:MPMoviePlayerPlaybackDidFinishNotification object:player];
    }
    
    return self;
}

- (void)videoDidStopNotification{
    self.player.view.hidden = YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return YES;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.

- (void)loadView {
    //UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0,0,544,444)];
    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0,0,playerWidth,playerHeight)];
	[myView autorelease];
	self.view = myView;
	
//	// Foreground animation images
//	UIImageView *myImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
//	[myImageView autorelease];
//	self.imageView = myImageView;
//    [self.view addSubview:imageView];
    
	
	//[self reload];
}

//-(void)reload
//{
//    // Animation data should have already been loaded into memory as a result of
//	// setting the animationURLs property
//	
//	NSAssert(animationURLs, @"animationURLs was not defined");
//	NSAssert([animationURLs count] > 1, @"animationURLs must include at least 2 urls");
//	NSAssert(animationFrameDuration, @"animationFrameDuration was not defined");
//	
//	// Load animationData by reading from animationURLs
//	
//	NSMutableDictionary *dataDict = [NSMutableDictionary dictionaryWithCapacity:[animationURLs count]];
//	
//	NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:[animationURLs count]];
//	for ( NSURL* aURL in animationURLs ) {
//		NSString *urlKey = aURL.path;
//		NSData *dataForKey = [dataDict objectForKey:urlKey];
//		
//		if (dataForKey == nil) {
//			dataForKey = [NSData dataWithContentsOfURL:aURL];
//			NSAssert(dataForKey, @"dataForKey");
//			
//			[dataDict setObject:dataForKey forKey:urlKey];
//		}
//		
//		[muArray addObject:dataForKey];
//	}
//	self.animationData = [NSArray arrayWithArray:muArray];
//	
//	int numFrames = [animationURLs count];
//	float duration = animationFrameDuration * numFrames;
//	
//	self->animationNumFrames = numFrames;
//	self.animationDuration = duration;
//	
//
//	
//	// Display first frame of image animation
//	
//	self.animationStep = 0;
//	
//	[self animationShowFrame: animationStep];
//	
//	self.animationStep = animationStep + 1;
//	
//	if (animationAudioURL != nil) {
//		AVAudioPlayer *avPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:animationAudioURL
//																		 error:nil];
//		[avPlayer autorelease];
//		NSAssert(avPlayer, @"AVAudioPlayer could not be allocated");
//		self.avAudioPlayer = avPlayer;
//		
//		[avAudioPlayer prepareToPlay];		
//	}
//    
//}
//
//// Create an array of file/resource names with the given filename prefix,
//// the file names will have an integer appended in the range indicated
//// by the rangeStart and rangeEnd arguments. The suffixFormat argument
//// is a format string like "%02i.png", it must format an integer value
//// into a string that is appended to the file/resource string.
////
//// For example: [createNumberedNames:@"Image" rangeStart:1 rangeEnd:3 rangeFormat:@"%02i.png"]
////
//// returns: {"Image01.png", "Image02.png", "Image03.png"}
//
//+ (NSArray*) arrayWithNumberedNames:(NSString*)filenamePrefix
//						 rangeStart:(NSInteger)rangeStart
//						   rangeEnd:(NSInteger)rangeEnd
//					   suffixFormat:(NSString*)suffixFormat
//{
//	NSMutableArray *numberedNames = [[NSMutableArray alloc] initWithCapacity:40];
//	
//	for (int i = rangeStart; i <= rangeEnd; i++) {
//		NSString *suffix = [NSString stringWithFormat:suffixFormat, i];
//		NSString *filename = [NSString stringWithFormat:@"%@%@", filenamePrefix, suffix];
//		
//		[numberedNames addObject:filename];
//	}
//	
//	NSArray *newArray = [NSArray arrayWithArray:numberedNames];
//	[numberedNames release];
//	return newArray;
//}
//
//// Given an array of resource names (as returned by arrayWithNumberedNames)
//// create a new array that contains these resource names prefixed as
//// resource paths and wrapped in a NSURL object.
//
//+ (NSArray*) arrayWithResourcePrefixedURLs:(NSArray*)inNumberedNames
//{
//	NSMutableArray *URLs = [[NSMutableArray alloc] initWithCapacity:[inNumberedNames count]];
//	NSBundle* appBundle = [NSBundle mainBundle];
//	
//	for ( NSString* path in inNumberedNames ) {
//		NSString* resPath = [appBundle pathForResource:path ofType:nil];	
//		NSURL* aURL = [NSURL fileURLWithPath:resPath];
//		
//		[URLs addObject:aURL];
//	}
//	
//	NSArray *newArray = [NSArray arrayWithArray:URLs];
//	[URLs release];
//	return newArray;
//}

// Invoke this method to start the animation

- (void) startAnimating
{
    
    // add movie player
    if(player.view.superview == nil){
        self.player.controlStyle = MPMovieControlStyleNone;
        self.player.backgroundView.backgroundColor = [UIColor clearColor];
        self.player.view.backgroundColor = [UIColor clearColor];
        [self.view addSubview: self.player.view];
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        player.view.hidden = NO;
        [player play];
    } completion:^(BOOL finished) {

    }];
    

   
    
//	if (self.currentLoop == 1) {
//		[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(animate:) userInfo:nil repeats:NO];
//	}
//	else {
//		[self animate:nil];
//	}	
	// Send notification to object(s) that regestered interest in a start action
	
	/*	*/
}

//-(void)animate:(NSTimer *)timer {
//	self.animationTimer = [NSTimer timerWithTimeInterval: animationFrameDuration
//												  target: self
//												selector: @selector(animationTimerCallback:)
//												userInfo: NULL
//												 repeats: TRUE];
//	
//    [[NSRunLoop currentRunLoop] addTimer: animationTimer forMode: NSDefaultRunLoopMode];
//	
//	animationStep = 0;
//	
//	if (avAudioPlayer != nil)
//		[avAudioPlayer play];
//	/**/
//	[[NSNotificationCenter defaultCenter]
//	 postNotificationName:ImageAnimatorDidStartNotification
//	 object:self];
//}

// Invoke this method to stop the animation, note that this method must not
// invoke other methods and it must cancel any pending callbacks since
// it could be invoked in a low-memory situation or when the object
// is being deallocated. Invoking this method will not generate a
// animation stopped notification, that callback is only invoked when
// the animation reaches the end normally.

- (void) stopAnimating
{
//	if (![self isAnimating])
//		return;
//	
//	[animationTimer invalidate];
//	self.animationTimer = nil;
//	
//	animationStep = animationNumFrames - 1;
//	[self animationShowFrame: animationStep];
//	
//	if (avAudioPlayer != nil) {
//		[avAudioPlayer stop];
//		avAudioPlayer.currentTime = 0.0;
//		self->lastReportedTime = 0.0;
//	}
//	
//	// Send notification to object(s) that regestered interest in a stop action
//	
//	[[NSNotificationCenter defaultCenter]
//	 postNotificationName:ImageAnimatorDidStopNotification
//	 object:self];	
}

- (BOOL) isAnimating
{
	return !player.view.hidden;
}

//// Invoked at framerate interval to implement the animation
//
//- (void) animationTimerCallback: (NSTimer *)timer {
//	if (![self isAnimating])
//		return;
//	
//	NSTimeInterval currentTime;
//	NSUInteger frameNow;
//	
//	if (avAudioPlayer == nil) {
//		self.animationStep += 1;
//		
//		//		currentTime = animationStep * animationFrameDuration;
//		frameNow = animationStep;
//	} else {
//		currentTime = avAudioPlayer.currentTime;
//		frameNow = (NSInteger) (currentTime / animationFrameDuration);
//	}
//	
//	// Limit the range of frameNow to [0, SIZE-1]
//	if (frameNow < 0) {
//		frameNow = 0;
//	} else if (frameNow >= animationNumFrames) {
//		frameNow = animationNumFrames - 1;
//	}
//	
//	[self animationShowFrame: frameNow];
//	//	animationStep = frameNow + 1;
//	
//	if (animationStep >= animationNumFrames) {
//		[self stopAnimating];
//		
//		// Continue to loop animation until loop counter reaches 0
//		
//		if (animationRepeatCount > 0) {
//			self.animationRepeatCount = animationRepeatCount - 1;
//			[self startAnimating];
//		}
//	}
//}
//
//// Display the given animation frame, in the range [1 to N]
//// where N is the largest frame number.
//
//- (void) animationShowFrame: (NSInteger) frame {
//	if ((frame >= animationNumFrames) || (frame < 0))
//		return;
//	
//	NSData *data = [animationData objectAtIndex:frame];
//	UIImage *img = [UIImage imageWithData:data];
//	imageView.image = img;
//}




@end
