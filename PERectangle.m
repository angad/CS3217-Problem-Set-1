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
	return CGPointMake(origin.x + 0.5*width, origin.y + 0.5*height);
}

- (CGPoint)rotatePoint:(CGPoint)point {
	
	CGPoint relative, rotated;
	CGFloat dist, angle;
	angle = self.rotation * M_PI/180.0;

	relative.x = point.x - self.center.x;
	relative.y = point.y - self.center.y;
	
	rotated.x = relative.x*cos(angle) + relative.y*sin(angle) + self.center.x;
	rotated.y = -relative.x*sin(angle) + relative.y*cos(angle) + self.center.y;
	
	return rotated;
}

- (CGPoint)cornerFrom:(CornerType)corner {
  // REQUIRES: corner is a enum constant defined in PEShape.h as follows:
  //           kTopLeftCorner, kTopRightCorner, kBottomLeftCorner,
  //		   kBottomRightCorner 
  // EFFECTS: returns the coordinates of the specified rotated rectangle corner after rotating
	struct CGPoint a;
	if(corner == kTopLeftCorner)
	{
		return [self rotatePoint :origin];
	}
	if(corner == kTopRightCorner)
	{
		a.x = origin.x + width;
		a.y = origin.y;
		return [self rotatePoint: a];
	}
	if(corner == kBottomLeftCorner)
	{
		a.y = origin.y + height;
		a.x = origin.x;
		return [self rotatePoint:a];
	}
	if(corner == kBottomRightCorner)
	{
		a.x = origin.x + width;
		a.y = origin.y + height;
		return [self rotatePoint:a];
	}
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
	if(self = [super init])
	{
	origin = o;
	width = w;
	height = h;
	rotation = r;
	}
	return self;
}

- (id)initWithRect:(CGRect)rect {
  // MODIFIES: self
  // EFFECTS: initializes the state of this rectangle using a CGRect
	if(self = [super init])
	{
		[self initWithOrigin:rect.origin width: rect.size.width height: rect.size.height rotation: 0];
	}
	return self;
}

- (void)rotate:(CGFloat)angle {
  // MODIFIES: self
  // EFFECTS: rotates this shape anti-clockwise by the specified angle
  // around the center of mass
	rotation = angle;
}

- (void)translateX:(CGFloat)dx Y:(CGFloat)dy {
  // MODIFIES: self
  // EFFECTS: translates this shape by the specified dx (along the
  //            X-axis) and dy coordinates (along the Y-axis)
	origin.x += dx;
	origin.y += dy;
}

- (BOOL)overlapsWithShape:(id<PEShape>)shape {
  // EFFECTS: returns YES if this shape overlaps with specified shape.
  
  if ([shape class] == [PERectangle class]) {
    return [self overlapsWithRect:(PERectangle *)shape];
  }

  return NO;
}


- (BOOL)liesWithin:(CGPoint)p{
	
	if(p.x > self.origin.x && p.x < (self.origin.x + self.width) && p.y > self.origin.y && p.y < (self.origin.y + self.height))
		return YES;
	else return NO;
}


- (BOOL)overlapsWithRect:(PERectangle*)rect {
  // EFFECTS: returns YES if this shape overlaps with specified shape.
  // <add missing code here>
	CGPoint* c1 = self.corners;
	CGPoint* c2 = rect.corners;
	
	//printf("Corners for rectangle 1 <%f,%f>, <%f,%f>, <%f,%f>, <%f,%f>", c1[0].x, c1[0].y, c1[1].x, c1[1].y, c1[2].x, c1[2].y, c1[3].x, c1[3].y);
	
	CGPoint intersection;
	
	CGFloat x11, y11, x12, y12, x21, y21, x22, y22;
	CGFloat d, u;
	int i,j,k,l;
	
	for(i=0; i<4; i++)
	{
		if(i==3) k=0; else k=i+1;
		x11 = c1[i].x;
		y11 = c1[i].y; //rectangle1 corner1
		x12 = c1[k].x;
		y12 = c1[k].x; //rectangle1 corner2
		
		for(j=0; j<4; j++)
		{
			if(j==3) l=0; else l=j+1;
			x21 = c2[j].x;
			y21 = c2[j].y;//rectangle2 corner1
			x22 = c2[l].x;
			y22 = c2[l].y;//rectangle2 corner2
			
			d = (y22-y21)*(x12-x11) - (x22-x21)*(y12-y11);
			u = (x22-x21)*(y11-y21) - (y22-y21)*(x11-x21);
			
			
			if(d!=0) // if d=0 lines are parallel
			{
				intersection.x = x11 + u*(x12-x11);
				intersection.y = y11 + u*(y12-y11);
				if([self liesWithin: intersection] || [rect liesWithin: intersection])
					return YES;
			}
			
			if(d==0 && u==0) //coincident lines
			{
				return YES;
			}
		}
	}	
	return NO;
}

- (CGRect)boundingBox {	
  // EFFECTS: returns the bounding box of this shape.

  // optional implementation (not graded)
  return CGRectMake(INFINITY, INFINITY, INFINITY, INFINITY);
}

@end

