from sdxf import *
from math import sqrt, asin, acos, radians, degrees, sin, cos

# Lasercut Turing machine parts. Requires SDXF library.

# NOT Tested and several parts are known to be measured wrong.

# (C) Jim MacArthur, 2011

# SDXF is available from http://linux.softpedia.com/get/Multimedia/Graphics/SDXF-3248.shtml


#Blocks - predefined modules
b=Block('test')
b.append(Solid(points=[(0,0,0),(1,0,0),(1,1,0),(0,1,0)]))
b.append(Arc(center=(1,0,0)))

#Drawing
d=Drawing()

#various constants
thick = 3
gridSpacing = 7.58
gridHoleSize = 6
wheelRadius = 37.5/2 # Flight wheels
ballDiameter = 9.52
ballRadius = ballDiameter/2
gridWidth = gridSpacing - gridHoleSize
PI = 3.1415926534
camShaftSize = 4.76

raiser1l = (90-50)+gridSpacing*8-0.5*thick
pickupX = 90-raiser1l
# /|\ r
#/ | \
#-----
#  6

rideHeight = sqrt(wheelRadius*wheelRadius-(3*3))
print "rideHeight is "+str(rideHeight)
ballIngress = ballRadius-sqrt(ballRadius*ballRadius-(3*3))
lifterTravel = sqrt(((raiser1l-20)**2)*2)
bearingRadius = 8
mazeLength=12*gridSpacing

def raiserBar(x,y,l):
    d.append(Arc(center=(x,y),startAngle=-90,endAngle=90,radius=10))
    d.append(PolyLine(points=[(x,y+10),(x-l,y+10),(x-l,y),(x-l-thick,y),(x-l-thick,y-10),(x,y-10)],closed=0))
    d.append(Circle(center=(x,y),radius=2.5))

# Outer raiser bar
clearance = 1
topOfBall = ballDiameter-ballIngress
magbardepth = 25+rideHeight-topOfBall-2*thick-clearance

def MagBar(x,y):
    deep = magbardepth # Overall.
    wide = 14*gridSpacing+2*thick # Overall.
    p = [(x,y),(x,y-10),(x+thick,y-10),(x+thick,y-deep)]

    for i in range(-2,3):
        p+=[(x+wide/2+gridSpacing*2*i-1.5,y-deep)]
        p+=[(x+wide/2+gridSpacing*2*i-1.5,y-deep+3)]
        p+=[(x+wide/2+gridSpacing*2*i-2.5,y-deep+3)]
        p+=[(x+wide/2+gridSpacing*2*i-2.5,y-deep+5)]
        p+=[(x+wide/2+gridSpacing*2*i+2.5,y-deep+5)]
        p+=[(x+wide/2+gridSpacing*2*i+2.5,y-deep+3)]
        p+=[(x+wide/2+gridSpacing*2*i+1.5,y-deep+3)]
        p+=[(x+wide/2+gridSpacing*2*i+1.5,y-deep)]

    p += [(x+wide-thick,y-deep),(x+wide-thick,y-10),(x+wide,y-10),(x+wide,y)]
    
    d.append(PolyLine(points=p,closed=1))

#Magbar, side on, for illustration
def MagBar_S(x,y):
    d.append(PolyLine(points=[(x,y),(x+thick,y),(x+thick,y-magbardepth),(x,y-magbardepth)],closed=1))
    d.append(Line(points=[(x,y-10),(x+thick,y-10)]))

def ReleaseBar(x,y):
    deep = magbardepth # Not including tabs at base.
    wide = 14*gridSpacing+4*thick # Overall.
    p = [(x,y),(x,y-10),(x+thick,y-10),(x+thick,y-deep)]
    slotWidth = 7
    for i in range(-2,3):
        p+=[(x+wide/2+gridSpacing*2*i-slotWidth/2,y-deep)]
        p+=[(x+wide/2+gridSpacing*2*i-slotWidth/2,y-deep-thick)]
        p+=[(x+wide/2+gridSpacing*2*i+slotWidth/2,y-deep-thick)]
        p+=[(x+wide/2+gridSpacing*2*i+slotWidth/2,y-deep)]

    p += [(x+wide-thick,y-deep),(x+wide-thick,y-10),(x+wide,y-10),(x+wide,y)]
    
    d.append(PolyLine(points=p,closed=1))

def ReleaseBar_S(x,y):
    d.append(PolyLine(points=[(x,y),(x+thick,y),(x+thick,y-magbardepth-thick),(x,y-magbardepth-thick)],closed=1))
    d.append(Line(points=[(x,y-10),(x+thick,y-10)]))
    d.append(Line(points=[(x,y-magbardepth),(x+thick,y-magbardepth)]))

releasePlateDeep = 40

def ReleasePlate(x,y):
    wide = 80+thick*2
    deep = releasePlateDeep
    slotWidth = 7
    d.append(PolyLine(points=[(x,y),(x+wide,y),(x+wide,y+deep),(x,y+deep)],closed=1))
    for i in range(-2,3):
        centX = wide/2+i*gridSpacing*2
        offset = centX-slotWidth/2
        d.append(PolyLine(points=[(x+offset,y+10),(x+slotWidth+offset,y+10),(x+slotWidth+offset,y+thick+10),(x+offset,y+thick+10)],closed=1))
        d.append(Circle(center=(x+centX,y+30),radius=2.5))

def ReleasePlate_S(x,y):
    d.append(PolyLine(points=[(x,y),(x+releasePlateDeep,y),(x+releasePlateDeep,y-thick),(x,y-thick)],closed=1))

def Wheel(x,y):
    d.append(Circle(center=(x,y),radius=(wheelRadius)))
    d.append(Circle(center=(x,y),radius=1.5))

def ChassisBar(x,y,mazeHolderHeight):
    p = []
    p+= [(x,y)]
    tabStart =160
    for t in range(0,5):
        p+=[(x+tabStart+20*t,y)]
        p+=[(x+tabStart+20*t,y-thick)]
        p+=[(x+tabStart+20*t+10,y-thick)]
        p+=[(x+tabStart+20*t+10,y)]
    p+=[(x+300,y)]
    p+= [(x+300,y+50),(x+280,y+50),(x+270,y+100),(x+100,y+100),(x+50,y+30),(x,y+30)]
    d.append(PolyLine(points=p,closed=1))
    # Holes for axles
    d.append(Circle(center=(x+50,y+5),radius=1.5))
    d.append(Circle(center=(x+50+gridSpacing*30,y+5),radius=1.5))
    # Holes for raiser axle
    d.append(Circle(center=(x+90,y+20),radius=2.5))

    # Hole for mover axle
    d.append(Circle(center=(x+150,y+30),radius=2.5))
    # Hole for camshaft (in bearing?)
    d.append(Circle(center=(x+250,camShaftY),radius=8))

    # Lifter pulley shaft; doubles as mover spring point
    d.append(Circle(center=(x+120,y+80),radius=2.5))

    # Lifter follower axle
    d.append(Circle(center=(x+280,y+30),radius=2.5))

    # Holes to support maze holder
    d.append(Circle(center=(x+5,y+mazeHolderHeight+2.5),radius=2.5))
    d.append(Circle(center=(x+15+mazeLength,y+mazeHolderHeight+5),radius=2.5))

# The Fake Maze is a box 12*gridSpacing wide and 30mm tall.
def FakeMaze(x,y):
    w = 12*gridSpacing
    d.append(PolyLine(points=[(x,y),(x+w,y),(x+w,y+30),(x,y+30)],closed=1))
 
    # On top of this is the dir box
    d.append(PolyLine(points=[(x+4*gridSpacing-thick,y+30),(x+8*gridSpacing+thick,y+30),(x+8*gridSpacing+thick,y+40),(x+4*gridSpacing-thick,y+40)],closed=1))
    # On top of that is the state box
    d.append(PolyLine(points=[(x+4*gridSpacing-thick,y+40),(x+8*gridSpacing+thick,y+40),(x+8*gridSpacing+thick,y+65),(x+4*gridSpacing-thick,y+65)],closed=1))


def MazeBase(x,y):
    baseLength = mazeLength - 2*gridSpacing
    p = [(0,0),(mazeWidth,0)]
    for tab in range(0,3):
        p+=[(mazeWidth,15+tab*20)]
        p+=[(mazeWidth+thick,15+tab*20)]
        p+=[(mazeWidth+thick,15+tab*20+10)]
        p+=[(mazeWidth,15+tab*20+10)]

    p += [(mazeWidth,baseLength)]
    p += [(0,baseLength)]
    for tab in range(2 ,-1,-1):
        p+=[(0,15+tab*20+10)]
        p+=[(-thick,15+tab*20+10)]
        p+=[(-thick,15+tab*20)]
        p+=[(0,15+tab*20)]
    p = translate(p,x,y)
    for i in range(1,6):
        for j in range(0,5):
            d.append(Circle(center=(x+i*gridSpacing*2+gridSpacing,y+j*gridSpacing*2+gridSpacing),radius=5))
    d.append(PolyLine(points=p,closed=1))

liftFollowerLen = 100.0
liftFollowerCamPos = 60.0
def LifterFollower(x,y):
    halfWidth=8
    d.append(Arc(center=(x,y),startAngle=180,endAngle=0,radius=halfWidth))
    d.append(Arc(center=(x,y+liftFollowerLen),startAngle=0,endAngle=180,radius=halfWidth))
    d.append(Line(points=[(x-halfWidth,y),(x-halfWidth,y+liftFollowerLen)]))
    d.append(Line(points=[(x+halfWidth,y),(x+halfWidth,y+liftFollowerLen)]))   

    # Axle for the follower
    d.append(Circle(center=(x,y+liftFollowerCamPos),radius=2.5))
    # Bearing 
    #d.append(Circle(center=(x,y+liftFollowerCamPos),radius=8))

    # Place a hole to attach the rope to
    d.append(Circle(center=(x,y+100),radius=1.5))

liftFollowerRatio = liftFollowerLen/liftFollowerCamPos
print "Lift follower ratio="+str(liftFollowerRatio)
print "Required movement on lift cam (With doubler)="+str(lifterTravel/(liftFollowerRatio*2))

def moverCamFunction(x):
    if(x>0.5): return (x-0.5)*2
    else: return 0

def MoverCam(x,y,minR):
    travel = 21
    p = []
    for i in range(0,360):
        t = radians(i)
        r = minR + travel*moverCamFunction(i/360.0)
        p += [(x+r*cos(t),y+r*sin(t))]
    d.append(PolyLine(points=p,closed=1))
    #d.append(Circle(center=(x,y),radius=minR)) # Maximum
    #d.append(Circle(center=(x,y),radius=minR+travel)) # Minimum
    # Square hole shaft
    n = camShaftSize/2
    d.append(PolyLine(points=[(x+n,y+n),(x-n,y+n),(x-n,y-n),(x+n,y-n)],closed=1))

def lifterCamFunction(x):
    p1 = 0.33/4
    p2 = 0.5/4
    p3 = 1.33/4
    p4 = 0.5
    if(x<p1): return 0.5+(x/p1)*-0.5
    if(x<p2): return 0 # Dead zone due to non-zero follower size
    if(x<p3): return ((x-p2)/(p3-p2))*1.0
    if(x<p4): return 1+((x-p3)/(p4-p3))*-0.5
    else: return 0.5


def LifterCam(x,y,minR):
    travel = 34
    p=[]
    for i in range(0,360):
        t = radians(i)
        r = minR + travel*lifterCamFunction(i/360.0)
        p += [(x+r*cos(t),y+r*sin(t))]
    d.append(PolyLine(points=p,closed=1))
    #d.append(Circle(center=(x,y),radius=minR))
    #d.append(Circle(center=(x,y),radius=minR+travel))
    n = camShaftSize/2
    d.append(PolyLine(points=[(x+n,y+n),(x-n,y+n),(x-n,y-n),(x+n,y-n)],closed=1))

def Maze(x,y,drops):
    # Right, the tricky bit!
    p = [(x,y),(x,y+15)]
    drop = 2
    offset = gridSpacing
    for dr in drops:
        p += [(x+offset,y+20-dr*drop)]
        offset += gridSpacing*2
    offset -=gridSpacing
    p += [(x+offset,y+15)]
    p += [(x+offset,y)]
    d.append(PolyLine(points=p,closed=1))

def HMaze(x,y,drops):
    # Right, the tricky bit!
    p = [(x,y),(x,y+15)]
    drop = 2
    offset = gridSpacing
    for dr in drops:
        p += [(x+offset,y+20-dr*drop)]
        offset += gridSpacing*2
    offset -=gridSpacing
    p += [(x+offset,y+15)]
    p += [(x+offset,y)]
    d.append(PolyLine(points=p,closed=1))


d.blocks.append(b)                      #table blocks
d.styles.append(Style())                #table styles
d.views.append(View('Normal'))          #table view
d.views.append(ViewByWindow('Window',leftBottom=(1,0),rightTop=(2,1)))  #idem


raiserAxleX = 90

# Hole to tie rope to inner raiser
d.append(Circle(center=(90-raiser1l+20,25+200),radius=1.5))

print "lifter Travel="+str(lifterTravel)

# Draw lines where balls go
#for i in range(-10,10):
#    d.append(Line(points=[(50+i*gridSpacing*2,-10),(50+i*gridSpacing*2,10)]))

# Initial Maze pieces. The Maze is very complicated to make with 
# a laser cutter, and we may leave this for later.
doMaze = False
if(doMaze):
    Maze(0,50,[ 3,2,1,0,0,0 ])
    Maze(0,100,[ 4,4,0,0,1,0 ])
    Maze(0,150,[ 5,3,2,1,2,0 ])
    Maze(0,200,[ 6,1,0,0,8,7 ])
    Maze(0,250,[ 7,2,1,0,2,6 ])
    Maze(0,300,[ 0,3,0,0,1,5 ])
    Maze(0,350,[ 0,0,1,2,3,4 ])

# Note - this is just a transpose of the above values
    HMaze(100,50, [ 3,4,5,6,7,0,0 ])
    HMaze(150,100, [ 2,4,3,1,2,3,0 ])
    HMaze(200,150, [ 1,0,2,0,1,0,1 ])
    HMaze(250,200, [ 0,0,1,0,0,0,2 ])
    HMaze(300,250, [ 0,1,2,8,2,1,3 ])
    HMaze(350,300, [ 0,0,0,7,6,5,4 ])


moveLeverLen=100
puntPosition=50 # Distance ALONG THE MOVE LEVER. Not horizontal distance!
def MoveLever(x,y):
    halfWidth=7
    d.append(Arc(center=(x,y),startAngle=90,endAngle=270,radius=halfWidth))
    d.append(Arc(center=(x+moveLeverLen,y),startAngle=-90,endAngle=90,radius=halfWidth))
    d.append(Line(points=[(x,y-halfWidth),(x+100,y-halfWidth)]))
    d.append(Line(points=[(x,y+halfWidth),(x+100,y+halfWidth)]))

    # Holes for end axles
    d.append(Circle(center=(x,y),radius=2.5))
    d.append(Circle(center=(x+moveLeverLen,y),radius=2.5))
    # Holes for punt
    d.append(Circle(center=(x+puntPosition,y),radius=2.5))
    # Bearing at end, outer diameter 16
    #d.append(Circle(center=(x+moveLeverLen,y),radius=8))

puntLength = 40 # Axle centre to point
def Punt(x,y):
    halfWidth=7
    d.append(Arc(center=(x,y),startAngle=0,endAngle=180,radius=halfWidth))
    d.append(PolyLine(points=[(x+halfWidth,y),(x+halfWidth,y-puntLength+halfWidth),(x,y-puntLength),(x-halfWidth,y-puntLength+halfWidth),(x-halfWidth,y)],closed=0))
    d.append(Circle(center=(x,y),radius=2.5))
    d.append(Circle(center=(x,y-15),radius=2.5))

def Shifter(x,y):
    d.append(PolyLine(points=[(x,y),(x+5,y+5),(x+10,y+5),(x+10,y+10),(x+15,y+15),(x+20,y+10),(x+20,y+5),(x+25,y+5),(x+30,y)],closed=1))


# Move lever maths
moveLeverAxisY = 30
moveLeverAxisHeight = moveLeverAxisY-5+rideHeight
gridThick = 1 # Thickness of grid, i.e. how much we go below it to engage the punt
moverCamMaxRadius = 50
camShaftY = moveLeverAxisY+8+moverCamMaxRadius

# See trig diagram. X,Y,Z are not cartesian coordinates.

#moverX = gridWidth*0.5+gridHoleSize # Engage pos
#moverX = gridWidth*0.5+gridHoleSize+(gridSpacing*1) # Moved 1
moverX = gridWidth*0.5+gridHoleSize+(gridSpacing*2) # Moved 2

print "Mover variable X="+str(moverX)
moverY = moveLeverAxisHeight+gridThick
print "Mover variable Y="+str(moverY)
moverZ = sqrt((puntPosition-moverX)**2+moverY**2)
print "Mover variable Z="+str(moverZ)
moverE = asin((puntPosition-moverX)/moverZ)
print "Mover variable E="+str(degrees(moverE))
moverA = acos((puntPosition**2+moverZ**2-puntLength**2)/(2*moverZ*puntPosition))
print "Mover variable A="+str(degrees(moverA))
moverTheta = (3.14159/2) - moverA - moverE

print "Mover Theta: "+str(degrees(moverTheta))
vertDisplace = moveLeverLen*sin(moverTheta)
horizDisplace = moveLeverLen*cos(moverTheta)-moveLeverLen

print "End lever vertical displacement = "+str(vertDisplace)
print "End lever horizontal displacement = "+str(horizDisplace)
print "Total displacement = "+str(sqrt(vertDisplace**2+horizDisplace**2))

ground = 5-rideHeight;

d.append(Line(points=[(-500,ground),(500,ground)]))

print "Ground is at y="+str(ground)

# Base grid

# Note about spacing - 
# Wheels run in the grid, and the inside edge of one wheel is assumed to be aligned with the edge of the grid.
# There will be a washer of 1mm thickness between the wheel and the chassis, so the chassis starts 1mm in from one grid edge.

# Both the lifting arms will run INSIDE the chassis, not outside it as they did on older models.
# The extreme edges of the inner lifter, therefore, are 2*thickness+1 mm away from the grid edge.

# The total width of the inner lifter is (mazeWidth)+2*thickness mm. The central lift position, then, is at (mazewidth/2)+2*thickness+1 mm away from the grid edge.
# So the centre line for the punt needs to be that +/- 7.58mm.

# The internal spacing between chassis bars is mazeWidth+4*thickness.

# So define the baseplate:
mazeWidth = 14*gridSpacing
def BasePlate(x,y):
    x+=thick
    
    # Inner spacing: 0 to 
    p = [(x,y),(x+mazeWidth+4*thick,y)]
    for t in range(0,5):
        p += [(x+mazeWidth+4*thick,y+20*t)]
        p += [(x+mazeWidth+4*thick+thick,y+20*t)]
        p += [(x+mazeWidth+4*thick+thick,y+20*t+10)]
        p += [(x+mazeWidth+4*thick,y+20*t+10)]

    p+=[(x+mazeWidth+4*thick,y+100)]
    p+=[(x,y+100)]
    for t in range(4,-1,-1):
        p += [(x,y+20*t+10)]
        p += [(x-thick,y+20*t+10)]
        p += [(x-thick,y+20*t)]
        p += [(x,y+20*t)]

    d.append(PolyLine(points=p,closed=1))   

    gapWide = thick+1
    gapAlign = (mazeWidth/2)+2*thick+gridSpacing
    d.append(PolyLine(points=[(x+gapAlign-(gapWide/2),y+10),
                              (x+gapAlign-(gapWide/2),y+90),
                              (x+gapAlign+(gapWide/2),y+90),
                              (x+gapAlign+(gapWide/2),y+10)],closed=1))



def DropGuideS(x,y):
    d.append(PolyLine(points=[(x,y),(x+30,y),(x+30,y+thick),(x,y+thick)],closed=1))


def DropGuide(x,y):
    d.append(PolyLine(points=[(x,y),(x+mazeWidth+4*thick,y),(x+mazeWidth+4*thick,y+30),(x,y+30)],closed=1))
    offset = x+(mazeWidth/2)+2*thick
    d.append(Circle(center=(offset+gridSpacing*-4,y+20),radius=5))
    d.append(Circle(center=(offset+gridSpacing*-2,y+20),radius=5))
    d.append(Circle(center=(offset+gridSpacing*0,y+20),radius=5))
    d.append(Circle(center=(offset+gridSpacing*2,y+20),radius=5))
    d.append(Circle(center=(offset+gridSpacing*4,y+20),radius=5))

def rotate(p,deg):
    out = []
    for (x,y) in p:
        out += [( x*cos(radians(deg))-y*sin(radians(deg)),
                  y*cos(radians(deg))+x*sin(radians(deg)))]
    return out

def translate(p,x1,y1):
    out = []
    for (x,y) in p:
        out += [( x+x1, y+y1)]
    return out

slopeLen = 100
slopeSlope = 5
def SlopeS(x,y):
    p = [(0,0),(slopeLen,0),(slopeLen,thick),(0,thick)]
    p = rotate(p,slopeSlope)
    p = translate(p,x,y)
    d.append(PolyLine(points=p,closed=1))

# '1' here is a fudge due to the slope

slopeBase = ground+topOfBall+clearance+1
slopeTop = slopeLen * sin(radians(slopeSlope))+slopeBase+thick

# Maze holder. Holds the maze in place; 
def MazeHolder(x,y):
    overhang = 20
    length = overhang+mazeLength
    p = [(0,0),(length,0),(length,40),(15,40),(0,25)]
    p = translate(p,x,y)
    d.append(PolyLine(points=p,closed=1))

    p = [(0,0),(10,0),(10,thick),(0,thick)]
    p = translate(p,5,5-thick)
    p = translate(p,x,y)
    for tab in range(0,3):
        p = translate(p,20,0)
        d.append(PolyLine(points=p,closed=1))

    # Hole for the raiser axle
    d.append(Circle(center=(x+90,y-slopeTop-ballDiameter+5+20),radius=2.5))


    # Holes to support the holder itself
    d.append(Arc(center=(x+5,y+2.5),radius=2.5,startAngle=0,endAngle=180))

    d.append(Line(points=[(x+5-2.5,y),(x+5-2.5,y+2.5)]))
    d.append(Line(points=[(x+5+2.5,y),(x+5+2.5,y+2.5)]))
    d.append(Circle(center=(x+length-5,y+5),radius=2.5))

# Ball
#d.append(Circle(center=(50-gridSpacing*8,ground+ballRadius-ballIngress),radius=ballRadius))


# Circles to show path of certain raiser parts
#d.append(Circle(center=(90,20),radius=80,color=1)) # Limit of raiser hole pos
#d.append(Circle(center=(90,20),radius=94,color=1)) # Path of base of release plate

# All the top-level elements

raiserBar(raiserAxleX,20+200,raiser1l)
raiserBar(raiserAxleX,20+170,raiser1l+20)
ChassisBar(0,0,slopeTop+ballDiameter-5)

LifterFollower(500,30)

MoveLever(150,-100+moveLeverAxisY)
Punt(150+puntPosition,-150+moveLeverAxisY)
Shifter(puntPosition-15,-120)

MoverCam(120,camShaftY-250,moverCamMaxRadius)
LifterCam(250,camShaftY-250,30-bearingRadius)

#MagBar_S(-raiser1l+90-thick,30)
MagBar(-200+thick,0)
#ReleaseBar_S(-raiser1l+90-20-thick,30)

#ReleasePlate_S(-raiser1l+90-20-thick-10,30-magbardepth)

ReleaseBar(-200,70)
ReleasePlate(-300,0)

#Wheel(50,5)
#Wheel(50+gridSpacing*30,5)

for i in range(0,8):
    Wheel(-50+50*i,130)

BasePlate(-200-thick,100)
#DropGuideS(pickupX-20,ground+topOfBall+clearance)
DropGuide(-200,-100)
#SlopeS(pickupX+10+1,slopeBase)
#FakeMaze(10,slopeTop+ballDiameter)
MazeHolder(0,-100+slopeTop+ballDiameter-5)

MazeBase(-100,-150)
d.saveas('test.dxf')

