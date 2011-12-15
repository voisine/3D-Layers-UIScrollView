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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];

    scroller.scrollsToTop = NO;    
    scroller.contentSize = CGSizeMake(1000000.0, 1000000.0);
    scroller.contentOffset = CGPointMake(1000000.0/2, 1000000.0/2);
    transformView.rootLayer.speed = 100.0;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static CGFloat lastX = 0, lastY = 0;
    
    CATransform3D yRotate = CATransform3DMakeRotation((scrollView.contentOffset.y - lastY)/100, 1.0, 0.0, 0.0);
    CATransform3D xRotate = CATransform3DMakeRotation(-(scrollView.contentOffset.x - lastX)/100, 0.0, 1.0, 0.0);
    CATransform3D rotate = CATransform3DConcat(xRotate, yRotate);
    
    transformView.rootLayer.sublayerTransform = CATransform3DConcat(transformView.rootLayer.sublayerTransform, rotate);
    
    lastX = scrollView.contentOffset.x;
    lastY = scrollView.contentOffset.y;
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
