//
//  Overlaps.m
//  
//  CS3217 || Assignment 1
//  Name: Angad Singh
//https://github.com/angad/CS3217-Problem-Set-1

#import <Foundation/Foundation.h>
// Import PERectangle here
#import "PERectangle.h"

//float comparison tolerance epsilon
#define EPSILON 0.00001

// define structure Rectangle
struct Rectangle
{
	int x, y; //origin
	int width, height; //dimensions
};

int overlaps(struct Rectangle rect1, struct Rectangle rect2) {
  // EFFECTS: returns 1 if rectangles overlap and 0 otherwise

	int bottomRight1x = rect1.x + rect1.width;
	int bottomRight1y = rect1.y + rect1.height;
	int bottomRight2x = rect2.x + rect2.width;
	int bottomRight2y = rect2.y + rect2.height;

	if(rect1.x <= bottomRight2x && bottomRight1x >= rect2.x && rect1.y <= bottomRight2y && bottomRight1y >= rect2.y)
	return 1;
	
	return 0;
}


int main (int argc, const char * argv[]) {
	
	/* Problem 1 code (C only!) */
	// declare rectangle 1 and rectangle 2

	struct Rectangle rect1;
	struct Rectangle rect2;

	// input origin for rectangle 1
	printf("Input <x y> coordinates for the origin of the first rectangle: ");

	scanf("%d%d", &rect1.x, &rect1.y);
	
	// input size (width and height) for rectangle 1
	printf("Input width and height of the first rectangle: ");

	scanf("%d%d", &rect1.width, &rect1.height);
	
	// input origin for rectangle 2
	printf("Input <x y> coordinates for the origin of the second rectangle: ");

	scanf("%d%d", &rect2.x, &rect2.y);
	
	// input size (width and height) for rectangle 2
	printf("Input width and height of the second rectangle: ");

	scanf("%d%d", &rect2.width, &rect2.height);

	// check if overlapping and write message
	if(overlaps(rect1, rect2)) printf("The two rectangles are overlapping!\n"); 
	else printf("The two rectangles are not overlapping!\n");

	/* Problem 2 code (Objective-C) */
	// declare rectangle 1 and rectangle 2 objects
	PERectangle *rectangle1 = [PERectangle alloc];
	PERectangle *rectangle2 = [PERectangle alloc];
	float rotate1, rotate2;
	

	// input rotation for rectangle 1
	printf("Input rotation angle for the first rectangle: ");
	scanf("%f", &rotate1);

	// input rotation for rectangle 2
	printf("Input rotation angle for the second rectangle: ");
	scanf("%f", &rotate2);
	
	// rotate rectangle objects
	rectangle1 = [rectangle1 initWithOrigin:CGPointMake((float)rect1.x, (float)rect1.y) width: (CGFloat)rect1.width height: (CGFloat)rect1.height rotation: (CGFloat)rotate1];
	rectangle2 = [rectangle2 initWithOrigin:CGPointMake((float)rect2.x, (float)rect2.y) width: (CGFloat)rect2.width height: (CGFloat)rect2.height rotation: (CGFloat)rotate2];

	// check if rectangle objects overlap and write message
	if([rectangle1 overlapsWithRect: rectangle2])
	{
		printf("The two rectangle objects are overlapping!\n");
	}
	else printf("The two rectangle objects do not overlap!\n");

	//clean up
	[rectangle1 release];
	[rectangle2 release];

	if(test()==1) printf("All tests successful\n");
	// exit program
	return 0;
}

// This is where you should put your test cases to test that your implementation is correct. 
int test() {
  // EFFECTS: returns 1 if all test cases are successfully passed and 0 otherwise

	PERectangle *rectangle1 = [PERectangle alloc];
	PERectangle *rectangle2 = [PERectangle alloc];
	
	
	//Rotated rectangle overlapping test1
	rectangle1 = [rectangle1 initWithOrigin:CGPointMake(0.0, 100.0) width: 100.0 height: 200.0 rotation: 90.0];
	rectangle2 = [rectangle2 initWithOrigin:CGPointMake(150.0, 100.0) width: 100.0 height: 100.0 rotation: 0.0];
	if(![rectangle1 overlapsWithRect: rectangle2])
	{
		printf("Test 1 failed\n");
	}
	//Rotated rectangle overlapping test2
	rectangle1 = [rectangle1 initWithOrigin:CGPointMake(5.0, 10.0) width: 5.0 height: 15.0 rotation: 90.0];
	rectangle2 = [rectangle2 initWithOrigin:CGPointMake(15.0, 15.0) width: 10.0 height: 5.0 rotation: 0.0];
	if(![rectangle1 overlapsWithRect: rectangle2])
	{
		printf("Test 2 failed\n");
	}
	
	//Rotated rectangle overlapping test3
	rectangle1 = [rectangle1 initWithOrigin:CGPointMake(5.0, 10.0) width: 10.0 height: 10.0 rotation: 45.0];
	rectangle2 = [rectangle2 initWithOrigin:CGPointMake(17.0, 10.0) width: 10.0 height: 10.0 rotation: 0.0];
	if(![rectangle1 overlapsWithRect: rectangle2])
	{
		printf("Test 3 failed\n");
	}
	
	//translate function test
	[rectangle1 translateX : 10.0  Y: 10.0];
	if(!((rectangle1.origin.x - 15.0) > EPSILON) && ((rectangle1.origin.x - 20.0) > EPSILON))
	{
		printf("Test 4 failed\n");
	}
	
	//center getter test
	if(!((rectangle1.center.x - 10.0) > EPSILON) && (rectangle1.center.y - 15.0) > EPSILON)
	{
		printf("Test 5 failed\n");
	}
	
	//Rotate and cornerFrom test (using corners getter)
	[rectangle2 rotate:90.0];
	CGPoint *corners = rectangle2.corners;
	if(!(corners[0].x - 17.0)>EPSILON && (corners[0].y - 20.0)>EPSILON 
	   && (corners[1].x - 17.0)>EPSILON && (corners[1].y - 10.0)>EPSILON
	   && (corners[2].x - 27.0)>EPSILON && (corners[2].y - 10.0)>EPSILON
	   && (corners[3].x - 27.0)>EPSILON && (corners[3].y - 20.0)>EPSILON)
    {
	   printf("Test 6 failed");
	   return 0;
    }
	
	return 1;
}

/* 

Question 2(h)
========

We could have had the representation of the rectangle with all its four corners. 
It would have been easy to rotate then - just pass the angle and the point in a function. 
But not much of a difference really in complexity.
 
The other representation could be with the center and height and width.
The corners could be easily calculated.
 
Question 2(i): Reflection (Bonus Question)
==========================
(a) How many hours did you spend on each problem of this problem set?

 Problem 1 - around an hour to get the basic thing running and another hour to optimize the thing. 
 Later found a good implementation online - http://silentmatt.com/rectangle-intersection/
 Based the conditions on that.
 Started 14th Jan 2pm and ended around 4pm 
 
 Problem 2 - around 2hrs on 14th Jan and 7hrs on 15th Jan and again 5hrs on 16th Jan

 The above hours include frequent visits to the loo and makan and distractions courtesy iPad (specifically Angry Birds)
 
(b) In retrospect, what could you have done better to reduce the time you spent solving this problem set?

 Should have paid attention in my Maths class.. Well I think this is the beginning and I am really working on a Mac for the first time.
 [First day in Mac lab - me: "How do I turn this thing on?" Jason: <strange look>"There is a button at the back"]
 Its pretty fun to work in a new environment and getting adjusted to it took a bit of time.

(c) What could the CS3217 teaching staff have done better to improve your learning experience in this problem set?

I was pretty confused with the "self" thing. But I think I figured it out.
 Rest was pretty good. Referred to the slides to get the hang of the syntax and basic stuff.
*/
