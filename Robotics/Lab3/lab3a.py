from klampt import *
from klampt.math import vectorops

#attractive force constant
attractiveConstant = 100
#repulsive distance
repulsiveDistance = 0.1
# repulsive constant - alters the strength of the repulsive force
repulsiveConstant = .009;
#time step to limit the distance traveled
timeStep = 0.01

class Circle:
    def __init__(self,x=0,y=0,radius=1):
        self.center = (x,y)
        self.radius = radius

    def contains(self,point):
        return (vectorops.distance(point,self.center) <= self.radius)

    def distance(self,point):
        return (vectorops.distance(point,self.center) - self.radius)

def force(q,target,obstacles):
    """Returns the potential field force for a robot at configuration q,
    trying to reach the given target, with the specified obstacles.

    Input:
    - q: a 2D point giving the robot's configuration
    - robotRadius: the radius of the robot
    - target: a 2D point giving the robot's target
    - obstacles: a list of Circle's giving the obstacles
    """
    #basic target-tracking potential field implemented here

    # calculate the attractive force due to the goal
    f = vectorops.mul(vectorops.sub(target,q),attractiveConstant)

    for obstacle in obstacles:
        dist = obstacle.distance(q);

        # only add the repulsive force if the obstacle is "within" range
        if dist > repulsiveDistance:
            continue
        magnitude = (1.0/dist - 1/repulsiveDistance);

        # alter the magnitude to have a repulsiveConstant and to
        # divide by square of repulsiveDistance
        # Dividing by the square strengthens the repulsive force
        # The repuslvieConstant scales the strength of the repulsive force linearly
        magnitude = repulsiveConstant * magnitude / (dist**2);
        # set the direction of repulsive force away from the obstacle
        direction = vectorops.unit(vectorops.sub(q, obstacle.center));
        f = vectorops.madd(f, direction, magnitude);

    #limit the norm of f
    if vectorops.norm(f) > 1:
        f = vectorops.unit(f)
    return f

def start():
    # Below are the points I tried
    # They all succeeded
    # The bottom point is the original
    #return (.5,0)
    #return (.2,-.5)
    #return (-.3,-.5)
    #return (-0.5,0)
    #return (-.25,.25)
    #return (-.1,.5)
    #return (-.1,.8)
    #return (-.05,1.3)
    #return (-.05,.8)
    return (0.06,0.6)

def target():
    return (0.94,0.5)

def obstacles():
    # If I make the circles slightly larger it causes my field
    # approach to fail, as it discovers the local minima at the
    # crevasse of the circles
    # comment the two lines below and uncomment the oringinal obstacles
    # to get it to work again
    return [Circle(0.5,0.25,0.24),
        Circle(0.5,0.75,0.25)]
    #return [Circle(0.5,0.25,0.2),
    #    Circle(0.5,0.75,0.2)]
