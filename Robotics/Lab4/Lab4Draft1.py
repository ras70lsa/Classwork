import math
from klampt.model import ik

robot = None
dt = 0.01

#for I terms
pid_integrators = [0,0,0,0]

#higher level controller status... you don't need to use these if you wish
status = "pen up moving"
current_stroke = 0
current_stroke_progress = 0
stroke_list = []
interpIncrement = 0.1
interp = interpIncrement
prevTarget = (0,0)

def init(world):
    global robot,stroke_list
    robot = world.robot(0)
    stroke_list = curves()

def getPIDTorqueAndAdvance(q,dq,
                        qdes,dqdes,
                        kP,kI,kD,
                        pid_integrators,dt):
    """ TODO: implement me
    Returns the torques resulting from a set of PID controllers, given:
    - q: current configuration (list of floats)
    - dq: current joint velocities
    - qdes: desired configuration
    - dqdes: desired joint velocities
    - kP: list of P constants, one per joint
    - kI: list of I constants, one per joint
    - kD: list of D constants, one per joint
    - pid_integrators: list of error integrators, one per joint
    - dt: time step since the last call of this function

    The pid_integrators list should also be updated according to the time step.
    """
    global current_stroke
    torques = [0]*len(q)
    print pid_integrators
    for i in range(len(q)):
        #only the P term is computed here...
        tP = -kP[i]*(q[i] - qdes[i])
        tD = -kD[i]*(dq[i]-dqdes[i])
        tI = -kI[i]*(q[i] - qdes[i])
        pid_integrators[i] = pid_integrators[i] + tI
        torques[i] = tP + tD + pid_integrators[i]

    ## Apply opposing gravitational force
    torques[3] = torques[3] + -1.47

    return torques

def getTorque(t,q,dq):
    """ TODO: implement me
    Returns a 4-element torque vector given the current time t, the configuration q, and the joint velocities dq to drive
    the robot so that it traces out the desired curves.

    Recommended order of operations:
    1. Monitor and update the current status and stroke
    2. Update the stroke_progress, making sure to perform smooth interpolating trajectories
    3. Determine a desired configuration given current state using IK
    4. Send qdes, dqdes to PID controller
    """
    global robot,status,current_stroke,current_stroke_progress,stroke_list, pid_integrators, interp, prevTarget, interpIncrement
    qdes = [0,0,0,0]
    dqdes = [0,0,0,0]
    link = robot.link(3)

    if (status == "pen up") :
        print "PEN UP"
        penHeight = 0.05
    elif (status == "pen up moving") :
        print "PEN UP MOVING"
        penHeight = 0.05
    elif (status == "pen down") :
        print "PEN DOWN"
        penHeight = -0.002
    else :
        print status
        penHeight = -0.002

    if (current_stroke == len(stroke_list)):
        status == "done"
        penHeight = 0.2
        target = (0, 0)
    else :
        target = stroke_list[current_stroke][current_stroke_progress]

    if (status == "move") :
        print "want to interp: ", interp
        r1 = prevTarget[0] + interp * (target[0] - prevTarget[0])
        r2 = prevTarget[1] + interp * (target[1] - prevTarget[1])
        target = (r1,r2)
        print target
    wc = []
    wc2 = []
    wc.extend(target)
    wc.extend([penHeight])
    wc2.extend(target)
    wc2.extend([penHeight+1])


    obj = ik.objective(link,local= [[0,0,0],[0,0,-1]], world=[wc, wc2])
    res = ik.solve(obj)
    qdes = robot.getConfig()

    kP = [10,5,2,50]
    kI = [0,0,0,0]
    kD = [8,1.5,0.1,5]
    allWithin = True
    for i in range(len(q)):
        acceptableRange = 0.01
        if (status == "moving" and interp <0.8) :
            acceptableRange = 0.05
        if (status == "moving" and interp >0.8) :
            acceptableRange = 0.001
        if (math.fabs(q[i] - qdes[i]) > acceptableRange):
            allWithin = False
    if allWithin:
        print "ALL WITHIN"
        if (status == "done") :
            print "do nothing"
        elif (status == "pen up") :
            interp = 0
            status = "pen up moving"
            current_stroke_progress = 0;
            current_stroke = current_stroke + 1
        elif (status == "pen up moving") :
            status = "pen down"
        elif (status == "pen down") :
            interp = interpIncrement
            status = "move"
            prevTarget = target
            print "prevTarget: ", prevTarget
            current_stroke_progress = current_stroke_progress + 1
        elif (status == "move"):
            if interp < 1 - interpIncrement + interpIncrement/2:
                interp = interp + interpIncrement
            else:
                pid_integrators = [0,0,0,0]
                if (current_stroke_progress == len(stroke_list[current_stroke]) -1):
                    print "END OF LIST"
                    print current_stroke_progress
                    status = "pen up"
                else :
                    print "KEEP GOING"
                    interp = interpIncrement
                    prevTarget = target
                    print "prevTarget: ", prevTarget
                    print current_stroke_progress
                    current_stroke_progress = current_stroke_progress+1
    return getPIDTorqueAndAdvance(q,dq,qdes,dqdes,kP,kI,kD,pid_integrators,dt)
    #return [0,1,0,0]

def curves():
    K = [[(0.2,0.05),(0.2,-0.05)],[(0.25,0.05),(0.2,0.0),(0.25,-0.05)]]
    H = [[(0.28,0.05),(0.28,-0.05)],[(0.33,0.05),(0.33,-0.05)],[(0.28,0),(0.33,0)]]
    return K+H

#####################################################################
# Place your written answers here
#
#
#
#
#
#
#
#
#
