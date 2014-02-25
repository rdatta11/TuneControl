//
//  AppDelegate.m
//  TuneControl
//
//  Created by Rahul Datta on 2/21/14.
//  Copyright (c) 2014 Rahul Datta. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;

NSStatusItem *statusItem;
NSMenu *theMenu;

- (void)dealloc
{
    [super dealloc];
    
    [statusItem release];
    [theMenu release];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
	
    NSMenuItem *tItem = nil;
    
    theMenu = [[NSMenu alloc] initWithTitle:@""];
    [theMenu setAutoenablesItems:NO];
    
	
    [theMenu addItemWithTitle:@"Play/Pause" action:@selector(onHandlePlayPause:) keyEquivalent:@""];
    [theMenu addItemWithTitle:@"Previous" action:@selector(onHandlePrevious:) keyEquivalent:@""];
	[theMenu addItemWithTitle:@"Next" action:@selector(onHandleNext:) keyEquivalent:@""];
	
    [theMenu addItem:[NSMenuItem separatorItem]];
    
    tItem = [theMenu addItemWithTitle:@"Quit" action:@selector(terminate:) keyEquivalent:@"q"];
	
    [tItem setKeyEquivalentModifierMask:NSCommandKeyMask];
	
    NSStatusBar *statusBar = [NSStatusBar systemStatusBar];
    statusItem = [statusBar statusItemWithLength:NSVariableStatusItemLength];
    [statusItem retain];
    [statusItem setImage:[NSImage imageNamed:@"remoteControl.png"]];
    [statusItem setToolTip:@"TuneControl"];
    [statusItem setHighlightMode:YES];
    [statusItem setMenu:theMenu];
	
}
-(void)callScriptWithScriptName:(NSString*)withScriptName{
	NSString* path = [[NSBundle mainBundle] pathForResource:withScriptName ofType:@"scpt"];
	NSURL* url = [NSURL fileURLWithPath:path];
	NSDictionary* errors = [NSDictionary dictionary];
	NSAppleScript* appleScript = [[NSAppleScript alloc] initWithContentsOfURL:url error:&errors];
	[appleScript executeAndReturnError:nil];
	[appleScript release];
}

-(void)onHandleNext:(id) sender{
	NSLog(@"You selected Next");
	[self callScriptWithScriptName: @"PlayNextTrack"];
}

-(void)onHandlePrevious:(id) sender{
	NSLog((@"You selected Previous"));
	[self callScriptWithScriptName: @"PreviousTrack"];
}

-(void)onHandlePlayPause:(id) sender{
	NSLog((@"You selected Play/Pause"));
	[self callScriptWithScriptName: @"playpause"];
}


@end
