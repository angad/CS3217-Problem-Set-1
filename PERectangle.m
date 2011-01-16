//
//  PERectangle.m
//  
//  CS3217 || Assignment 1
//  Name: Angad Singh
//

#import "PERectangle.h"

//float comparison tolerance epsilon
#define EPSILON 0.00001

@implementation PERectangle
// OVERVIEW: This class implements a rectangle and the associated
//             operations.

@synthesize width, height, corners, origin, center, rotation;

- (CGPoint)center {
  // EFFECTS: returns the coordinates of the centre of mass for this
  // rectangle.
	return CGPointMake(origin.x + 0.5*width, origin.y + 0.5*height);
}

//self defined function
- (CGPoint)rotatePoint:(CGPoint)point {
	//REQUIRES : A point
	//EFFECTS : Returns the point rotated around the center by the angle of rotation
	CGPoint relative, rotated;
	CGFloat dist, angle;
	//converting to radians
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
	rotation += angle;
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


//self defined function
- (BOOL)liesWithin:(CGPoint)intersection : (CGPoint)start : (CGPoint)end{
	//REQUIRES : 3 points - start, end and intersection
	//EFFECTS :  returns YES if the point intersection lies between start and end
	
	CGFloat crossproduct, dotproduct, length;
	
	//checking if the points are aligned using cross product
	crossproduct = (intersection.y - start.y)*(end.x - start.x) - (intersection.x-start.x)*(end.y-start.y);
	if(fabs(crossproduct)>0.0001) return NO;
	
	//dotproduct should be positive
	dotproduct = (intersection.x - start.x)*(end.x -start.x)+(intersection.y-start.y)*(end.x-start.x);
	if(dotproduct < 0.0) return NO;
	
	//this is the squared length and it should be greater than the dotproduct
	length = (end.x-start.x)*(end.x-start.x) + (end.y-start.y)*(end.y-start.y);
	if(dotproduct > length) return NO;
	
	return YES;
}

- (BOOL)overlapsWithRect:(PERectangle*)rect {
  // EFFECTS: returns YES if this shape overlaps with specified shape.
	CGPoint* c1 = self.corners;
	CGPoint* c2 = rect.corners;
	
	CGPoint intersection;
	CGPoint p11, p12, p21, p22;
	CGFloat d, ua, ub;
	int i,j,k,l;
	
	for(i=0; i<4; i++)
	{
		if(i==3) k=0; else k=i+1;
		
		p11 = c1[i];
		p12 = c1[k]; //rectangle 1 corners
		
		for(j=0; j<4; j++)
		{
			if(j==3) l=0; else l=j+1;
			
			p21 = c2[j];
			p22 = c2[l];//rectangle2 corners
			
			ua = (p22.x-p21.x)*(p11.y-p21.y) - (p22.y-p21.y)*(p11.y-p21.x);
			ub = (p12.x-p11.x)*(p11.y-p21.y) - (p12.y-p11.y)*(p11.x-p21.x);
			d = (p22.y-p21.y)*(p12.x-p11.x) - (p22.x-p21.x)*(p12.y-p11.y);
			
			if(d!=0.0) // if d=0 lines are parallel
			{
				ua = ua/d;
				ub = ub/d;
				
				//the intersection point formed by the edges of the triangle
				intersection.x = p11.x + ua*(p12.x-p11.x);
				intersection.y = p11.y + ua*(p12.y-p11.y);
				
				//checking if the intersection point lies on the line segments formed by the corners
				if([self liesWithin: intersection : p11 : p12] && [self liesWithin: intersection : p21 : p22]) return YES;
			}
			
			if(d==0.0 && ua==0.0 && ub==0.0) //coincident lines
				if([self liesWithin: p11 : p21 : p22] || [self liesWithin: p12 : p21 : p22] || [self liesWithin: p21 : p11: p12] ||[self liesWithin: p22: p11 : p12])
					return YES;		
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