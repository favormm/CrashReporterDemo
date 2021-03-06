/*
 * Author: Andreas Linde <mail@andreaslinde.de>
 *         Kent Sutherland
 *
 * Copyright (c) 2009 Andreas Linde & Kent Sutherland. All rights reserved.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */

#import <CrashReportSender/crashReportSender.h>
#import "CrashReporterDemoAppDelegate.h"

#define CRASH_REPORTER_URL [NSURL URLWithString:@"http://macdevcrashreports.com/submitcrash/1/y1w7sIYcbXxpO5U"]

@implementation CrashReporterDemoAppDelegate


// if the main nibs window is set to hidden on startup, this will show it
// this delegate method is required to be implemented!
- (void) showMainApplicationWindow
{
	[window makeFirstResponder: nil];
	[window makeKeyAndOrderFront:nil];
}


- (void)applicationDidFinishLaunching:(NSNotification *)note
{
	// Launch the crash reporter task
    [[CrashReportSender sharedCrashReportSender] sendCrashReportToURL:CRASH_REPORTER_URL
                                                             delegate:self 
                                                          companyName:@"CrashReporterDemo"];
}


- (void)bam
{
	signal(SIGBUS, SIG_DFL);
	
	*(long*)0 = 0xDEADBEEF;
}


- (IBAction)doCrash:(id)sender
{
	[self bam];
}

@end
