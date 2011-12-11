//
//  LayersViewController.m
//  Layers
//
//  Created by test on 3/29/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "LayersViewController.h"
#import "Trackball.h"

@implementation LayersViewController



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


//- (void)loadView {
//	transformView = [[AITransformView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
//	self.view = transformView;
//}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
    
    scroller.contentSize = CGSizeMake(self.view.frame.size.height*2, self.view.frame.size.width*2);
//    scroller.contentOffset = CGPointMake(1000000.0/2, 1000000.0/2);
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

/*
//Trackball Version by Bill Dudney
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	CGPoint location = [[touches anyObject] locationInView:self];
	if(nil == self.trackball) {
		self.trackball = [Trackball trackBallWithLocation:location inRect:self.bounds];
	} else {
		[self.trackball setStartPointFromLocation:location];
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	CGPoint location = [[touches anyObject] locationInView:self];
	CATransform3D transform = [trackball rotationTransformForLocation:location];
	rootLayer.sublayerTransform = transform;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	CGPoint location = [[touches anyObject] locationInView:self];
	[self.trackball finalizeTrackBallForLocation:location];
}
*/

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
	if(nil == transformView.trackball) {
		transformView.trackball = [Trackball trackBallWithLocation:scrollView.contentOffset inRect:transformView.bounds];
	} else {
		[transformView.trackball setStartPointFromLocation:scrollView.contentOffset];
	}
    tracking = YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (! decelerate) [self scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    tracking = NO;
	[transformView.trackball finalizeTrackBallForLocation:scrollView.contentOffset];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (! tracking) return;
    
	CATransform3D transform = [transformView.trackball rotationTransformForLocation:scrollView.contentOffset];
	transformView.rootLayer.sublayerTransform = transform;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
