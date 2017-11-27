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
#interpIncrement = 0.1
interp = 0
interpIncrement = .2
prevTarget = (0,0)
t_up = 0

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

    for i in range(len(q)):
        tP = -kP[i]*(q[i] - qdes[i])
        tD = -kD[i]*(dq[i]-dqdes[i])
        tI = (q[i] - qdes[i])*dt
        pid_integrators[i] = pid_integrators[i] + tI
        torques[i] = tP + tD + -kI[i]*pid_integrators[i]

    # limit the torque to a maximum
    if (torques[0] < -0.5) :
        torques[0] = -0.5
    if (torques[0] > 0.5) :
        torques[0] = 0.5
    if (torques[1] > 1) :
        torques[1] = 1
    if (torques[1] < -1) :
        torques[1] = -1
    if (torques[2] > 1) :
        torques[2] = 1
    if (torques[2] < -1) :
        torques[2] = -1

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
    global robot,status,current_stroke,current_stroke_progress,stroke_list, pid_integrators, interp, prevTarget, interpIncrement, t_up
    qdes = [0,0,0,0]
    dqdes = [0,0,0,0]
    link = robot.link(3)

    if (status == "pen up") :
        penHeight = 0.005
    elif (status == "pen up moving") :
        penHeight = 0.005
    elif (status == "pen down") :
        penHeight = -0.002
    elif (status == "done") :
        penHeight = 0.005
    else :
        penHeight = -0.002

    if (current_stroke == len(stroke_list)):
        status == "done"
        penHeight = 0.2
        target = prevTarget
    else :
        target = stroke_list[current_stroke][current_stroke_progress]

    if (status == "move") :
        if interp > 0.9:
            delta = 0.08
            interp  = 1 + delta
        r1 = prevTarget[0] + interp * (target[0] - prevTarget[0])
        r2 = prevTarget[1] + interp * (target[1] - prevTarget[1])
        target = (r1,r2)

    wc = []
    wc2 = []
    wc.extend(target)
    wc.extend([penHeight])
    wc2.extend(target)
    wc2.extend([penHeight+1])

    # IK Solver
    obj = ik.objective(link,local= [[0,0,0],[0,0,-1]], world=[wc, wc2])
    res = ik.solve(obj)
    qdes = robot.getConfig()

    kP = [20,8,1,20]
    kI = [0.05,0.01,0,0]
    kD = [8,1.5,0.1,5]

    allWithin = True
    for i in range(len(q)):
        acceptableRange = 0.002
        if (status == "move" and interp <0.75) :
            acceptableRange = 0.01
        if (status == "move" and interp >0.75) :
            acceptableRange = 0.001
        if (math.fabs(q[i] - qdes[i]) > acceptableRange):
            allWithin = False
    if allWithin:
        if (status == "done") :
            status = "done"
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
            current_stroke_progress = current_stroke_progress + 1
        elif (status == "move"):
            if interp < (1 -.05):
                interp = interp + interpIncrement
            else:
                pid_integrators = [0,0,0,0]
                if (current_stroke_progress == len(stroke_list[current_stroke]) -1):
                    t_up = t
                    status = "pen up"
                    if (current_stroke == len(stroke_list)-1) :
                        status = "done"
                else :
                    interp = interpIncrement
                    prevTarget = target
                    current_stroke_progress = current_stroke_progress+1
    return getPIDTorqueAndAdvance(q,dq,qdes,dqdes,kP,kI,kD,pid_integrators,dt)

def curves():
    #K = [[(0.2,0.05),(0.2,-0.05)],[(0.25,0.05),(0.2,0.0),(0.25,-0.05)]]
    #H = [[(0.28,0.05),(0.28,-0.05)],[(0.33,0.05),(0.33,-0.05)],[(0.28,0),(0.33,0)]]
    #return K+H
    R1 = [[(0.2,0.03),(0.2,-0.03)],[(0.2,0.03),(0.23,0.03)],[(0.23,0.03),(0.23,0.00)]]
    R2 = [[(0.23,0.0),(0.2,0.0),(.23,-0.03)]]
    S1 = [[(0.24,0.03),(0.24,0.0)], [(0.24,0.03),(0.27,0.03)], [(0.24,0.0),(0.27,0.0)]]
    S2 = [[(0.24,-0.03),(0.27,-0.03)], [(0.27,0.0),(0.27,-0.03)]]
    P1 = [[(0.28,0.03),(0.28,-0.03)],[(0.28, 0.03),(0.30,0.03)]]
    P2 = [[(0.28,0.0),(0.30,0.0)],[(0.30, 0.03),(0.30,0.0)]]
    return R1 + R2 + S1 + S2 + P1 + P2

#####################################################################
# Place your written answers here
#
# NOTE: It sometimes takes my robot a second to calibrate before it drops the
# pen for each curve. This is due to the fact that the allowed error before dropping
# the pen is quite tight.
#
# 1A. Constant Tuning  (127-130)
#
# I tuned my parameters mostly through trial error. However, I had a good idea of what
# values might work well. I knew I wanted to restrict the speed of the robot quite significantly
# because the bound on the veloctiy is so tight. For this reason I made dqdes = [0,0,0,0] and
# the kD values high. This helped oppose any large deviations from the desired low veloctiy.
#
# I made the Kp values larger than the others. I made Kp largest for the first join and pen.
# This was determined through trial and error.
#
# I made the Ki values non-zero, but small. Large Ki values can cause large overshoots and oscillations
# around the desired point - which I wanted to prevent at all cost. However, I did not chose zero Ki terms
# for two reasons 1. I wanted to prove my Ki term worked in the PID controller
# 2. I wanted to compensate for any external force - which does not exist in this example, but could
# be introduced.
#
# 1B. Gravity Compensation (69)
#
# If no torque/force is applied to pen it falls, due to the constant external
# gravitation force on it. In order to combat this I add a constant -1.47 force
# in the postive y direction on the pen at all times (all timesteps). This -1.47
# force is addition to any other force I apply to get the pen to the desired position -
# which comes from the PID controller.
# To determine this value of -1.47 I ran a trial in which I applied no torques. In other
# words I ran a trial in which I I did not move the robot. I then applied a force to the
# pen solely and tuned this value until the pen was still (when the force I applied opposed
# the gravitational force exactly. This allows the force applied to the pen to work as expected.
#
# 2A. Trajectory Control Design
#
# General Approach
#
# My general approach was to write an IK solver that solves for the desired configuration for the
# robot to get to a specfic point. Then I send this configuration to the PID controller to apply torques
# until the robot gets within a specified bound of the desired configuration. From here I modify the state
# and chose the next desired point for the IK solver to solve.
#
# IK Solver (122-125)
#
# In order to get the pen vertical I send two points to the IK solver. These two points allow
# for the definition of a directon. Therefore, with these two points I am able to contrain the z-axis
# negative of the robot's local z-axis (straight down) to align with the global z-axis (straight-up).
# This keeps the pen vertical.
#
# State (130-169)
#
# My robot consists of 5 states: 1. done 2. pen down 3. pen up 4. pen up move 5 move
#
# Done - The state is quite self-explanatory. When the robot is in this state it has drawn
# all potential curves. At this point the robot moves the pen to the up (0.005) position.
#
# Pen down - Once the robot has located the start of the curve (in the pen up move) state, the
# robot transitions to the pen down state. In this state the robot does not translate in the xy plane,
# but rather, simply lowers the pen to the appropriate height (0.002). Once this is complete the robot
# transitions to the move state.
#
# Pen up - The robot is in this state when it has finished a curve segment and needs to put the pen up
# to move to another. Like the pen down state the robot only moves the pen height in this state and does not
# translate in the xy direction. Once the pen reaches the appropriate height the robot transitions to the pen up move
# state.
#
# Pen up move - In this state the robot moves to the start of a curve with the pen up. Once the robot reaches said point
# it transitions to pen down mode
#
# Move - In this state the robot pen is down. The robot continues to move to interpolation milestones on the curve. If the
# robot reaches the end of a curve segment it grabs the next curve segment and continues to move, if this next curve
# segment exists. If not the robot needs to go to the next curve. If this next curve exists the robot transitions to pen up.
# If the robot has drawn the final curve it transitions to the done state.
#
# Interpolation (107-113)
#
# In order to get smoother curves I break each curve into 5 and linearly interpolate over the curve.
# In other words I have an interpolation value that goes from 0 to 1 and increments by 0.2 for each
# curve. Without this the robot draws curved lines, not straight lines, from the start to the end of the curve.
# The accuracy of my robot, at the expense of speed, is increased by decreasing this interpolation increment.
#
# Velocity and joint limitations (55-67)
#
# I limit the magnitude of the torques on joints 1,2, and 3 to ensure the torques on the joins
# stay within their limits. However, my torque limits are actually tighter than those defined by the
# problem. My reasoning for this is to make the robot more more slowly, to stay within the velocity
# limits.
