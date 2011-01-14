//
//  Overlaps.m
//  
//  CS3217 || Assignment 1
//  Name: Angad Singh
//

#import <Foundation/Foundation.h>
// Import PERectangle here

// define structure Rectangle
// <definition for struct Rectangle here>

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

	if(rect1.x < bottomRight2x && bottomRight1x > rect2.x && rect1.y < bottomRight2y && bottomRight1y > rect2.y)
	return 1;
	//if(rect1.x == rect2.x && rect1.y == rect2.y) || bottomRight1x == bottomRight2x || bottomRight1y == bottomRight2y)
	//return 1;

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
	if(overlaps(rect1, rect2)) printf("The two rectangles are overlapping!"); 
	else printf("The two rectangles are not overlapping!");

	/* Problem 2 code (Objective-C) */
	// declare rectangle 1 and rectangle 2 objects

	// input rotation for rectangle 1

	// input rotation for rectangle 2

	// rotate rectangle objects
	
	// check if rectangle objects overlap and write message

	// clean up

	// exit program
	return 0;
}

// This is where you should put your test cases to test that your implementation is correct. 
int test() {
  // EFFECTS: returns 1 if all test cases are successfully passed and 0 otherwise

}

/* 

Question 2(h)
========

<Your answer here>



Question 2(i): Reflection (Bonus Question)
==========================
(a) How many hours did you spend on each problem of this problem set?

<Your answer here>

(b) In retrospect, what could you have done better to reduce the time you spent solving this problem set?

<Your answer here>

(c) What could the CS3217 teaching staff have done better to improve your learning experience in this problem set?

<Your answer here>

*/
