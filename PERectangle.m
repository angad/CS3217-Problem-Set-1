//
//  PERectangle.m
//  
//  CS3217 || Assignment 1
//  Name: Angad Singh
//

#import "PERectangle.h"

@implementation PERectangle
// OVERVIEW: This class implements a rectangle and the associated
//             operations.

@synthesize width, height, corners, origin, center, rotation;

- (CGPoint)center {
  // EFFECTS: returns the coordinates of the centre of mass for this
  // rectangle.
	struct CGPoint c, topRight, bottomLeft;
	topRight.x = self.origin.x + (self.size.width)*cos(rotation);
	topRight.y = self.origin.y + (self.size.width)*sin(rotation);
	bottomLeft.y = self.origin.y + (self.size.height)*cos(rotation);
	bottomLeft.x = self.origin.x + (self.size.height)*sin(rotation);
	c.x = (topRight.x - bottomLeft.x)/2;
	c.y = (topRight.y - bottomLeft.y)/2;
	return c;
}

- (CGPoint)cornerFrom:(CornerType)corner {
  // REQUIRES: corner is a enum constant defined in PEShape.h as follows:
  //           kTopLeftCorner, kTopRightCorner, kBottomLeftCorner,
  //		   kBottomRightCorner 
  // EFFECTS: returns the coordinates of the specified rotated rectangle corner after rotating
	struct CGPoint topRight, bottomLeft, bottomRight;
	topRight.x = self.origin.x + (self.size.width)*cos(rotation);
	topRight.y = self.origin.y + (self.size.width)*sin(rotation);
	bottomLeft.y = self.origin.y + (self.size.height)*cos(rotation);
	bottomLeft.x = self.origin.x + (self.size.height)*sin(rotation);
	bottomRight.x = topRight.x + (self.size.height)*sin(rotation);
	bottomRight.y = topRight.y + (self.size.height)*cos(rotation);
	corner[0] = origin;
	corner[1] = topRight;
	corner[2] = bottomRight;
	corner[3] = bottomLeft;3
	return corner;
}

- (CGPoint*)corners {
  // EFFECTS:  return an array with all the rectangle corners

  CGPoint *corners = (CGPoint*) malloc(4*sizeof(CGPoint));
  corners[0] = [self cornerFrom: kTopLeftCorner];
  corners[1] = [self cornerFrom: kTopRightCorner];
  corners[2] = [self cornerFrom: kBottomRightCorner];
  corners[3] = [self cornerFrom: kBottomLeftCorner];
  return corners;
}

- (id)initWithOrigin:(CGPoint)o width:(CGFloat)w height:(CGFloat)h rotation:(CGFloat)r{
  // MODIFIES: self
  // EFFECTS: initializes the state of this rectangle with origin, width,
  //          height, and rotation angle in degrees
	self.origin = o;
	self.size.width = w;
	self.size.height = h;
	self.rotation = r;
}

- (id)initWithRect:(CGRect)rect {
  // MODIFIES: self
  // EFFECTS: initializes the state of this rectangle using a CGRect
	self = rect;
}

- (void)rotate:(CGFloat)angle {
  // MODIFIES: self
  // EFFECTS: rotates this shape anti-clockwise by the specified angle
  // around the center of mass
	rotation += angle;
}

- (void)translateX:(CGFloat)dx Y:(CGFloat)dy {
  // MODIFIES: self
  // EFFECTS: translates this shape by the specified dx (along the
  //            X-axis) and dy coordinates (along the Y-axis)
	self.origin.x += dx;
	self.origin.y += dy;
}

- (BOOL)overlapsWithShape:(id<PEShape>)shape {
  // EFFECTS: returns YES if this shape overlaps with specified shape.
  
  if ([shape class] == [PERectangle class]) {
    return [self overlapsWithRect:(PERectangle *)shape];
  }

  return NO;
}

- (BOOL)overlapsWithRect:(PERectangle*)rect {
  // EFFECTS: returns YES if this shape overlaps with specified shape.
  // <add missing code here>
	

}

- (CGRect)boundingBox {	
  // EFFECTS: returns the bounding box of this shape.

  // optional implementation (not graded)
  return CGRectMake(INFINITY, INFINITY, INFINITY, INFINITY);
}

@end

