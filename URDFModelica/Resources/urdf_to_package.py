#!/usr/bin/env python

import sys
import getopt
import os
import warnings
import math

# Comment out if you want to inhibit usage of package versions installed on system
##for entry in sys.path:
##    if 'site-packages' in entry:
##        sys.path.remove(entry)
        
from urdf_parser_py.urdf import URDF, Link, Joint


link_counter = 0
joint_counter = 0

numJoints = 0
numLinks = 0
numAxes = 0

data_base = 'URDFModelica.Records'

moveableJoints = []
connectionMatrix = []
materials = {}


def save_packageorder(packageorder, rootpath, packagepath, packagename):
    with open(rootpath + '/' + packagepath + '/' + packagename + '/package.order', 'w') as f:
        for elem in packageorder:
            f.write(elem + '\n')

def save_package(packagename, robotname, rootpath, packagepath, modelicapackagepath):
    with open(rootpath + '/' + packagepath + '/' + robotname + '/' + packagename + '/package.mo', 'w') as f:
        f.write('within ' + modelicapackagepath + '.' + robotname + ';\n')
        f.write('package ' + packagename + '\n')
        f.write('  extends URDFModelica.Icons.' + packagename + 'PackageIcon;\n')
        f.write('end ' + packagename + ';\n')

def save_elemparams(text, elemname, elemtype, robotname, rootpath, packagepath, modelicapackagepath):
    with open(rootpath + '/' + packagepath + '/' + robotname + '/' + elemtype + 's/' + elemname + 'Params.mo', 'w') as f:
        f.write('within ' + modelicapackagepath + '.' + robotname + '.' + elemtype + 's;\n')
        f.write('record ' + elemname + 'Params\n')
        f.write('  extends ')
        f.write(text)
        f.write(';\n  annotation (preferredView = "text");\n')
        f.write('end ' + elemname + 'Params;\n')

def save_elem(elem, elemname, elemtype, elemtypetype, robotname, rootpath, packagepath, modelicapackagepath):
    with open(rootpath + '/' + packagepath + '/' + robotname + '/' + elemtype + 's/' + elemname + '.mo', 'w') as f:
        f.write('within ' + modelicapackagepath + '.' + robotname + '.' + elemtype + 's;\n')
        f.write('model ' + elemname + '\n')

        # find path to elem prototype, easiest relative to this python file
        readpath = os.path.dirname(os.path.realpath(__file__))
        index = readpath.find('Resources\\')
        if index == -1:
            index = readpath.find('Resources/')
        if index == -1:
            index = readpath.find('Resources')
        readpath = readpath[:index] + elemtype + 's/'

        with open(readpath + elemtypetype + '.mo') as readf:
            for line in readf:
                if not line.startswith('within') and not line.startswith('model') and not line.startswith('end'):
                    if 'replaceable parameter URDFModelica.Records.'+elemtype in line: # special case params
                        f.write('  parameter ' + elemname + 'Params ' + elemtype.lower() + 'Params annotation (Placement(transformation(extent = {{-100, 80}, {-80, 100}})));\n')
                        line = next(readf)
                    elif 'trafoVisual' in line: # copy lines with trafoVisual (declaration and connects) only if elem has visual
                        if not elem.visual:
                            while ';' not in line:
                                line = next(readf)
                        elif not hasattr(elem.visual.geometry, 'filename') and 'visualMesh' in line:
                            while ';' not in line:
                                line = next(readf)
                        elif not hasattr(elem.visual.geometry, 'size') and 'visualBox' in line:
                            while ';' not in line:
                                line = next(readf)
                        elif not hasattr(elem.visual.geometry, 'length') and 'visualCylinder' in line:
                            while ';' not in line:
                                line = next(readf)
                        elif hasattr(elem.visual.geometry, 'length') and 'visualSphere' in line:
                            while ';' not in line:
                                line = next(readf)
                        elif not hasattr(elem.visual.geometry, 'radius') and 'visualSphere' in line:
                            while ';' not in line:
                                line = next(readf)
                        else:
                            f.write(line)
                    elif 'Visualization2.Shapes.Files.CADFile visualMesh' in line: # copy lines that declare visualMesh only if elem has visual and is mesh, visualization2 version
                        if not elem.visual:
                            while ';' not in line:
                                line = next(readf)
                        elif not hasattr(elem.visual.geometry, 'filename'):
                            while ';' not in line:
                                line = next(readf)
                        else:
                            f.write(line)
                    elif 'Visualization2.Shapes.Primitives.Cube visualBox' in line: # copy lines that declare visualBox only if elem has visual and is box, visualization2 version
                        if not elem.visual:
                            while ';' not in line:
                                line = next(readf)
                        elif not hasattr(elem.visual.geometry, 'size'):
                            while ';' not in line:
                                line = next(readf)
                        else:
                            f.write(line)
                    elif 'Visualization2.Shapes.Primitives.Cylinder visualCylinder' in line: # copy lines that declare visualCylinder only if elem has visual and is cylinder, visualization2 version
                        if not elem.visual:
                            while ';' not in line:
                                line = next(readf)
                        elif not hasattr(elem.visual.geometry, 'length'):
                            while ';' not in line:
                                line = next(readf)
                        else:
                            f.write(line)
                    elif 'Visualization2.Shapes.Primitives.Sphere visualSphere' in line: # copy lines that declare visualSphere only if elem has visual and is sphere, visualization2 version
                        if not elem.visual:
                            while ';' not in line:
                                line = next(readf)
                        elif hasattr(elem.visual.geometry, 'length'):
                            while ';' not in line:
                                line = next(readf)
                        elif not hasattr(elem.visual.geometry, 'radius'):
                            while ';' not in line:
                                line = next(readf)
                        else:
                            f.write(line)
                    elif 'Modelica.Mechanics.MultiBody.Visualizers.FixedShape visualMesh' in line: # copy lines that declare visualMesh only if elem has visual and is mesh, standard library version
                        if not elem.visual:
                            while ';' not in line:
                                line = next(readf)
                        elif not hasattr(elem.visual.geometry, 'filename'):
                            while ';' not in line:
                                line = next(readf)
                        else:
                            f.write(line)
                    elif 'Modelica.Mechanics.MultiBody.Visualizers.FixedShape visualBox' in line: # copy lines that declare visualBox only if elem has visual and is box, standard library version
                        if not elem.visual:
                            while ';' not in line:
                                line = next(readf)
                        elif not hasattr(elem.visual.geometry, 'size'):
                            while ';' not in line:
                                line = next(readf)
                        else:
                            f.write(line)
                    elif 'Modelica.Mechanics.MultiBody.Visualizers.FixedShape visualCylinder' in line: # copy lines that declare visualCylinder only if elem has visual and is cylinder, standard library version
                        if not elem.visual:
                            while ';' not in line:
                                line = next(readf)
                        elif not hasattr(elem.visual.geometry, 'length'):
                            while ';' not in line:
                                line = next(readf)
                        else:
                            f.write(line)
                    elif 'Modelica.Mechanics.MultiBody.Visualizers.FixedShape visualSphere' in line: # copy lines that declare visualSphere only if elem has visual and is sphere, standard library version
                        if not elem.visual:
                            while ';' not in line:
                                line = next(readf)
                        elif hasattr(elem.visual.geometry, 'length'):
                            while ';' not in line:
                                line = next(readf)
                        elif not hasattr(elem.visual.geometry, 'radius'):
                            while ';' not in line:
                                line = next(readf)
                        else:
                            f.write(line)
                    elif 'trafoCollision' in line: # copy lines with trafoCollision (declaration and connects) only if elem has collision
                        if not elem.collision:
                            while ';' not in line:
                                line = next(readf)
                        elif not hasattr(elem.collision.geometry, 'filename') and 'collisionMesh' in line:
                            while ';' not in line:
                                line = next(readf)
                        elif not hasattr(elem.collision.geometry, 'size') and 'collisionBox' in line:
                            while ';' not in line:
                                line = next(readf)
                        elif not hasattr(elem.collision.geometry, 'length') and 'collisionCylinder' in line:
                            while ';' not in line:
                                line = next(readf)
                        elif hasattr(elem.collision.geometry, 'length') and 'collisionSphere' in line:
                            while ';' not in line:
                                line = next(readf)
                        elif not hasattr(elem.collision.geometry, 'radius') and 'collisionSphere' in line:
                            while ';' not in line:
                                line = next(readf)
                        else:
                            f.write(line)
                    elif 'collisionMesh' in line: # copy lines that declare and connect collisionPoint only if elem has collision and is mesh
                        if not elem.collision:
                            while ';' not in line:
                                line = next(readf)
                        elif not hasattr(elem.collision.geometry, 'filename'):
                            while ';' not in line:
                                line = next(readf)
                        else:
                            f.write(line)
                    elif 'collisionBox' in line: # copy lines that declare and connect collisionBox only if elem has collision and is box
                        if not elem.collision:
                            while ';' not in line:
                                line = next(readf)
                        elif not hasattr(elem.collision.geometry, 'size'):
                            while ';' not in line:
                                line = next(readf)
                        else:
                            f.write(line)
                    elif 'collisionCylinder' in line: # copy lines that declare and connect collisionCylinder only if elem has collision and is cylinder
                        if not elem.collision:
                            while ';' not in line:
                                line = next(readf)
                        elif not hasattr(elem.collision.geometry, 'length'):
                            while ';' not in line:
                                line = next(readf)
                        else:
                            f.write(line)
                    elif 'collisionSphere' in line: # copy lines that declare and connect collisionSphere only if elem has collision and is sphere
                        if not elem.collision:
                            while ';' not in line:
                                line = next(readf)
                        elif hasattr(elem.collision.geometry, 'length'):
                            while ';' not in line:
                                line = next(readf)
                        elif not hasattr(elem.collision.geometry, 'radius'):
                            while ';' not in line:
                                line = next(readf)
                        else:
                            f.write(line)
                    else:
                        f.write(line)
                        
        f.write('end ' + elemname + ';\n')

def save_link(link, robotname, rootpath, packagepath, modelicapackagepath, visualization2, update):
    lt = make_Link_Text(link)
    linkClassName = to_class_name(link.name)

    save_elemparams(lt, linkClassName, 'Link', robotname, rootpath, packagepath, modelicapackagepath)
    if not update:
        if visualization2:
            save_elem(link, linkClassName, 'Link', 'Link_Visualization2', robotname, rootpath, packagepath, modelicapackagepath)
        else:
            save_elem(link, linkClassName, 'Link', 'Link', robotname, rootpath, packagepath, modelicapackagepath)
        
def save_joint(joint, robotname, rootpath, packagepath, modelicapackagepath, update):
    jt = make_Joint_Text(joint)
    jointClassName = to_class_name(joint.name)

    save_elemparams(jt, jointClassName, 'Joint', robotname, rootpath, packagepath, modelicapackagepath)
    if not update:
        save_elem(joint, jointClassName, 'Joint', joint.type.capitalize(), robotname, rootpath, packagepath, modelicapackagepath)

def save_robot(robot, robotname, modelname, visualization2, stationary, numCollisionLinks, numNonCollisionLinks, numRotationalJoints, numTranslationalJoints, numOtherJoints, rootpath, packagepath, modelicapackagepath, ordered_elements_positions, leafs):
    with open(rootpath + '/' + packagepath + '/' + robotname + '/' + modelname + '.mo', 'w') as f:
        f.write('within ' + modelicapackagepath + '.' + robotname + ';\n')
        f.write('model ' + modelname + '\n')
        if stationary:
            f.write('  extends URDFModelica.Icons.StationaryRobotIcon;\n')
        else:
            f.write('  extends URDFModelica.Icons.MobileRobotIcon;\n')
        
        # find path to elem prototype, easiest relative to this python file
        readpath = os.path.dirname(os.path.realpath(__file__))
        index = readpath.find('Resources\\')
        if index == -1:
            index = readpath.find('Resources/')
        if index == -1:
            index = readpath.find('Resources')
        readpath = readpath[:index] + 'Robot/'

        # copy first half and change parameters
        with open(readpath + 'BaseURDF.mo') as readf:
            for line in readf:
                if 'annotation (preferredView = "diagram"' in line:
                    break # first half finished
                elif 'Integer numCollisionLinks' in line:
                    f.write('  parameter Integer numCollisionLinks = ' + str(int(numCollisionLinks)) + ';\n')
                elif 'Integer numNonCollisionLinks' in line:
                    f.write('  parameter Integer numNonCollisionLinks = ' + str(int(numNonCollisionLinks)) + ';\n')
                elif 'Integer numLeafLinks' in line:
                    f.write('  parameter Integer numLeafLinks = ' + str(len(leafs)) + ';\n')
                elif 'Integer numRotationalJoints' in line:
                    f.write('  parameter Integer numRotationalJoints = ' + str(int(numRotationalJoints)) + ';\n')
                elif 'Integer numTranslationalJoints' in line:
                    f.write('  parameter Integer numTranslationalJoints = ' + str(int(numTranslationalJoints)) + ';\n')
                elif 'Integer numOtherJoints' in line:
                    f.write('  parameter Integer numOtherJoints = ' + str(int(numOtherJoints)) + ';\n')
                elif 'Boolean overwriteColor' in line and not visualization2:
                    pass
                elif not line.startswith('within') and not line.startswith('model') and not line.startswith('partial'):
                    f.write(line)

        # add links, joints
        for link in robot.links:
            linkClassName = to_class_name(link.name)
            for index in range(len(ordered_elements_positions)):
                if ordered_elements_positions[index][0] == linkClassName.lower():
                    if visualization2:
                        f.write('  Links.' + linkClassName + ' ' + linkClassName.lower() + '(enableCollision = enableCollision, overwriteColor = overwriteColor)\n')
                    else:
                        f.write('  Links.' + linkClassName + ' ' + linkClassName.lower() + '(enableCollision = enableCollision)\n')
                    f.write('    annotation (Placement(transformation(origin = {' + str(ordered_elements_positions[index][1]) + ', ' + str(ordered_elements_positions[index][2]+10) + '}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));\n')
                    
        rotationalCounter = 0
        translationalCounter = 0
        for joint in robot.joints:
            jointClassName = to_class_name(joint.name)
            for index in range(len(ordered_elements_positions)):
                if ordered_elements_positions[index][0] == jointClassName.lower():
                    if joint.type == 'revolute' or joint.type == 'continuous':
                        rotationalCounter += 1
                        f.write('  Joints.' + jointClassName + ' ' + jointClassName.lower() + '(flangeIndex = ' + str(int(rotationalCounter)) + ')\n')
                    elif joint.type == 'prismatic':
                        translationalCounter += 1
                        f.write('  Joints.' + jointClassName + ' ' + jointClassName.lower() + '(flangeIndex = ' + str(int(translationalCounter)) + ')\n')
                    else:
                        f.write('  Joints.' + jointClassName + ' ' + jointClassName.lower() + '\n')
                    f.write('    annotation (Placement(transformation(origin = {' + str(ordered_elements_positions[index][1]) + ', ' + str(ordered_elements_positions[index][2]) + '}, extent = {{-10, -10}, {10, 10}})));\n')
                    
        max_X = max([column[1] for column in ordered_elements_positions])
        min_Y = min(min([column[2] for column in ordered_elements_positions]), -100)
        frame_X = max(max_X + 30, 100)
        frame_Y = 0

        # add frame_b vector for leafs of kinematic chains
        f.write('  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_b[' + str(int(len(leafs))) + '] "Coordinate system b fixed to the component with one cut-force and cut-torque" annotation (Placement(transformation(extent = {{'+str(frame_X-16) +', -16}, {'+str(frame_X+16) +', 16}}), iconTransformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}})));\n')

        f.write('\nequation\n')

        # connect the first link to frame_a
        f.write('  connect(frame_a, ' + ordered_elements_positions[0][0] + '.frame_a)\n')
        f.write('    annotation (Line(points = {{-100, 0}, {-100, ' + str(ordered_elements_positions[0][2]) + '}, {' + str(ordered_elements_positions[0][1]) + ', ' + str(ordered_elements_positions[0][2]) + '}}));\n')
        # connect leafs of kinematic chains to frame_b vector
        for link in robot.links:
            linkClassName = to_class_name(link.name)
            for index in range(len(ordered_elements_positions)):
                if ordered_elements_positions[index][0] == linkClassName.lower():
                    for leafindex in range(len(leafs)):
                        if leafs[leafindex].replace('-','_').lower() == linkClassName.lower():
                            f.write('  connect(' + linkClassName.lower() + '.frame_a, frame_b[' + str(int(leafindex+1)) + '])\n')
                            f.write('    annotation (Line(points = {{' + str(ordered_elements_positions[index][1]) + ', ' + str(ordered_elements_positions[index][2]) + '}, {' + str(frame_X) + ', ' + str(ordered_elements_positions[index][2]) + '}, {' + str(frame_X) + ', ' + str(frame_Y) + '}}, color = {95, 95, 95}));\n')

        # connect joints to links (parent and child) and output flanges (rot or trans)
        rotationalCounter = 0
        translationalCounter = 0
        for joint in robot.joints:
            jointClassName = to_class_name(joint.name)

            for index in range(len(ordered_elements_positions)):
                if ordered_elements_positions[index][0] == jointClassName.lower():
                    break
            for pindex in range(len(ordered_elements_positions)):
                if ordered_elements_positions[pindex][0] == to_class_name(joint.parent).lower():
                    break
            for cindex in range(len(ordered_elements_positions)):
                if ordered_elements_positions[cindex][0] == to_class_name(joint.child).lower():
                    break
            f.write('  connect(' + to_class_name(joint.parent).lower() + '.frame_a, ' + jointClassName.lower() + '.frame_a)\n')
            f.write('    annotation (Line(points = {{' + str(int(ordered_elements_positions[pindex][1])) + ', ' + str(ordered_elements_positions[pindex][2]) + '}, {' + str(int(ordered_elements_positions[index][1]-10)) + ', ' + str(ordered_elements_positions[index][2]) + '}}, color = {95, 95, 95}));\n')
            f.write('  connect(' + jointClassName.lower() + '.frame_b, ' + to_class_name(joint.child).lower() + '.frame_a)\n')
            f.write('    annotation (Line(points = {{' + str(int(ordered_elements_positions[index][1]+10)) + ', ' + str(ordered_elements_positions[index][2]) + '}, {' + str(int(ordered_elements_positions[cindex][1])) + ', ' + str(ordered_elements_positions[cindex][2]) + '}}, color = {95, 95, 95}));\n')
                
            if joint.type == 'revolute' or joint.type == 'continuous':
                rotationalCounter += 1
                f.write('  connect(' + jointClassName.lower() + '.flange_a, rotational_flange_a[' + str(int(rotationalCounter)) + '])')
                f.write(';\n') # semicolon only if not annotation in the next line
                # f.write('    annotation (Line(points = {{' + str(ordered_elements_positions[index][1]) + ', ' + str(int(ordered_elements_positions[index][2]+10)) + '}, {-40, 100}}, color = {0, 0, 0}));\n') # comment out to make diagram readable
                f.write('  connect(' + jointClassName.lower() + '.flange_b, rotational_flange_b[' + str(int(rotationalCounter)) + '])')
                f.write(';\n') # semicolon only if not annotation in the next line
                # f.write('    annotation (Line(points = {{' + str(int(ordered_elements_positions[index][1]-5)) + ', ' + str(int(ordered_elements_positions[index][2]+10)) + '}, {-90, 100}}, color = {0, 0, 0}));\n') # comment out to make diagram readable
            elif joint.type == 'prismatic':
                translationalCounter += 1
                f.write('  connect(' + jointClassName.lower() + '.flange_a, translational_flange_a[' + str(int(translationalCounter)) + '])')
                f.write(';\n') # semicolon only if not annotation in the next line
                # f.write('    annotation (Line(points = {{' + str(ordered_elements_positions[index][1]) + ', ' + str(int(ordered_elements_positions[index][2]+10)) + '}, {90, 100}}, color = {0, 127, 0}));\n') # comment out to make diagram readable
                f.write('  connect(' + jointClassName.lower() + '.flange_b, translational_flange_b[' + str(int(translationalCounter)) + '])')
                f.write(';\n') # semicolon only if not annotation in the next line
                # f.write('    annotation (Line(points = {{' + str(int(ordered_elements_positions[index][1]-5)) + ', ' + str(int(ordered_elements_positions[cindex][2]+10)) + '}, {40, 100}}, color = {0, 127, 0}));\n') # comment out to make diagram readable

        # copy second half
        with open(readpath + 'BaseURDF.mo') as readf:
            secondhalf = False
            for line in readf:
                if 'annotation (preferredView = "diagram"' in line:
                    secondhalf = True # second half begins
                    f.write(line)
                    f.write('    Diagram(coordinateSystem(extent = {{-100, '+ str(min_Y-20) +'}, {'+ str(frame_X) +', 100}})));\n')
                    line = next(readf)
                elif secondhalf and not line.startswith('end'):
                    f.write(line)

        f.write('end ' + modelname + ';\n')

def save_robot_run(robot, robotname, modelname, visualization2, stationary, numCollisionLinks, numNonCollisionLinks, numRotationalJoints, numTranslationalJoints, numOtherJoints, rootpath, packagepath, modelicapackagepath, ordered_elements_positions, leafs):
    robotClassName = to_class_name(robot.name)
    with open(rootpath + '/' + packagepath + '/' + robotname + '/' + modelname + '.mo', 'w') as f:
        f.write('within ' + modelicapackagepath + '.' + robotname + ';\n')
        f.write('model ' + modelname + '\n')
        
        # find path to elem prototype, easiest relative to this python file
        readpath = os.path.dirname(os.path.realpath(__file__))
        index = readpath.find('Resources\\')
        if index == -1:
            index = readpath.find('Resources/')
        if index == -1:
            index = readpath.find('Resources')
        readpath = readpath[:index] + 'Robot/'

        # copy first half and change parameters
        if visualization2:
            readfile = readpath + 'RunURDF_Visualization2.mo'
        else:
            readfile = readpath + 'RunURDF.mo'
        with open(readfile) as readf:
            for line in readf:
                if line.startswith('equation'):
                    break # first half finished
                elif 'Integer numCollisionLinks' in line:
                    f.write('  parameter Integer numCollisionLinks = ' + str(int(numCollisionLinks)) + ';\n')
                elif 'Integer numNonCollisionLinks' in line:
                    f.write('  parameter Integer numNonCollisionLinks = ' + str(int(numNonCollisionLinks)) + ';\n')
                elif 'Integer numLeafLinks' in line:
                    f.write('  parameter Integer numLeafLinks = ' + str(len(leafs)) + ';\n')
                elif 'Integer numRotationalJoints' in line:
                    f.write('  parameter Integer numRotationalJoints = ' + str(int(numRotationalJoints)) + ';\n')
                elif 'Integer numTranslationalJoints' in line:
                    f.write('  parameter Integer numTranslationalJoints = ' + str(int(numTranslationalJoints)) + ';\n')
                elif 'Integer numOtherJoints' in line:
                    f.write('  parameter Integer numOtherJoints = ' + str(int(numOtherJoints)) + ';\n')
                elif 'Boolean overwriteColor' in line and not visualization2:
                    pass
                elif 'URDFModelica.Links.CollisionPoint' in line and stationary: # leafs collision points only if not stationary
                    while ';' not in line:
                        line = next(readf)
                elif 'Modelica.Mechanics.MultiBody.Parts.Fixed[numLeafLinks]' in line and stationary: # leafs collision points counterparts only if not stationary
                    while ';' not in line:
                        line = next(readf)
                elif not line.startswith('within') and not line.startswith('model') and not line.startswith('partial'):
                    f.write(line)

        # add robot
        if visualization2:
            f.write('  ' + robotClassName + ' ' + robotClassName.lower() + '(enableCollision = enableCollision, overwriteColor = overwriteColor) annotation (Placement(transformation(extent = {{-20, -60}, {20, -20}})));\n')
        else:
            f.write('  ' + robotClassName + ' ' + robotClassName.lower() + '(enableCollision = enableCollision) annotation (Placement(transformation(extent = {{-20, -60}, {20, -20}})));\n')
        # add free motion with initial values for mobile robots
        if not stationary:
            f.write('  Modelica.Mechanics.MultiBody.Joints.FreeMotion freeMotion(r_rel_a(start = {0.0, 0.0, 1.0}), angles_start = {0.0, 0.0, 0.0}) annotation (Placement(transformation(extent = {{-60, 80}, {-40, 100}})));\n')

        f.write('\nequation\n')

        # connect robot to world or free motion
        if stationary:
            f.write('  connect(' + robotClassName.lower() + '.frame_a, world.frame_b) annotation (Line(points = {{-20, -40}, {-30, -40}, {-30, 90}, {-80, 90}}, color = {95, 95, 95}));\n')
        else:
            f.write('  connect(' + robotClassName.lower() + '.frame_a, freeMotion.frame_b) annotation (Line(points = {{-20, -40}, {-30, -40}, {-30, 90}, {-40, 90}}, color = {95, 95, 95}));\n')
            f.write('  connect(world.frame_b, freeMotion.frame_a) annotation (Line(points = {{-80, 90}, {-60, 90}}, color = {95, 95, 95}));\n')
            # connect leafs to collision points if mobile
            f.write('  connect(' + robotClassName.lower() + '.frame_b, collisionPoint.frame_a) annotation (Line(points = {{20, -40}, {40, -40}}, color = {95, 95, 95}));\n')

        # connect output flanges (rot or trans) to sources
        rotationalCounter = 0
        translationalCounter = 0
        for joint in robot.joints:
            if joint.type == 'revolute' or joint.type == 'continuous':
                rotationalCounter += 1
                f.write('  connect(rotationalPosition[' + str(int(rotationalCounter)) + '].flange, ' + robotClassName.lower() + '.rotational_flange_a[' + str(int(rotationalCounter)) + ']) annotation (Line(points = {{-60, 10}, {-8, 10}, {-8, -20}}, color = {0, 0, 0}));\n')
                f.write('  connect(rotationalPosition[' + str(int(rotationalCounter)) + '].support, ' + robotClassName.lower() + '.rotational_flange_b[' + str(int(rotationalCounter)) + ']) annotation (Line(points = {{-70, 0}, {-18, 0}, {-18, -20}}, color = {0, 0, 0}));\n')
            elif joint.type == 'prismatic':
                translationalCounter += 1
                f.write('  connect(translationalPosition[' + str(int(translationalCounter)) + '].flange, ' + robotClassName.lower() + '.translational_flange_a[' + str(int(translationalCounter)) + ']) annotation (Line(points = {{-60, 50}, {18, 50}, {18, -20}}, color = {0, 127, 0}));\n')
                f.write('  connect(translationalPosition[' + str(int(translationalCounter)) + '].support, ' + robotClassName.lower() + '.translational_flange_b[' + str(int(translationalCounter)) + ']) annotation (Line(points = {{-70, 40}, {8, 40}, {8, -20}}, color = {0, 127, 0}));\n')

        # copy second half
        with open(readpath + 'RunURDF.mo') as readf:
            secondhalf = False
            for line in readf:
                if line.startswith('equation'):
                    secondhalf = True # second half begins
                elif secondhalf and not line.startswith('end'):
                    if 'collisionPoint' in line and stationary:
                        while ';' not in line:
                            line = next(readf)
                    else:
                        f.write(line)
                    
        f.write('end ' + modelname + ';\n')

def save_robot_test(robot, robotname, modelname, visualization2, stationary, numCollisionLinks, numNonCollisionLinks, numRotationalJoints, numTranslationalJoints, numOtherJoints, rootpath, packagepath, modelicapackagepath, ordered_elements_positions, leafs):
    robotClassName = to_class_name(robot.name)
    with open(rootpath + '/' + packagepath + '/' + robotname + '/' + modelname + '.mo', 'w') as f:
        f.write('within ' + modelicapackagepath + '.' + robotname + ';\n')
        f.write('model ' + modelname + '\n')
        
        # find path to elem prototype, easiest relative to this python file
        readpath = os.path.dirname(os.path.realpath(__file__))
        index = readpath.find('Resources\\')
        if index == -1:
            index = readpath.find('Resources/')
        if index == -1:
            index = readpath.find('Resources')
        readpath = readpath[:index] + 'Robot/'

        # copy first half and change parameters
        with open(readpath + 'TestURDF.mo') as readf:
            for line in readf:
                if line.startswith('equation'):
                    break # first half finished
                elif 'Integer numCollisionLinks' in line:
                    f.write('  parameter Integer numCollisionLinks = ' + str(int(numCollisionLinks)) + ';\n')
                elif 'Integer numNonCollisionLinks' in line:
                    f.write('  parameter Integer numNonCollisionLinks = ' + str(int(numNonCollisionLinks)) + ';\n')
                elif 'Integer numLeafLinks' in line:
                    f.write('  parameter Integer numLeafLinks = ' + str(len(leafs)) + ';\n')
                elif 'Integer numRotationalJoints' in line:
                    f.write('  parameter Integer numRotationalJoints = ' + str(int(numRotationalJoints)) + ';\n')
                elif 'Integer numTranslationalJoints' in line:
                    f.write('  parameter Integer numTranslationalJoints = ' + str(int(numTranslationalJoints)) + ';\n')
                elif 'Integer numOtherJoints' in line:
                    f.write('  parameter Integer numOtherJoints = ' + str(int(numOtherJoints)) + ';\n')
                elif 'Boolean overwriteColor' in line and not visualization2:
                    pass
                elif not line.startswith('within') and not line.startswith('model') and not line.startswith('partial'):
                    f.write(line)

        # add robot run
        if visualization2:
            f.write('  ' + robotClassName + 'Run ' + robotClassName.lower() + 'Run(enableCollision = enableCollision, overwriteColor = overwriteColor) annotation (Placement(transformation(extent = {{-10, -10}, {10, 10}})));\n')
        else:
            f.write('  ' + robotClassName + 'Run ' + robotClassName.lower() + 'Run(enableCollision = enableCollision) annotation (Placement(transformation(extent = {{-10, -10}, {10, 10}})));\n')

        f.write('\nequation\n')

        # connect output flanges (rot or trans) to sources
        f.write('  connect(rotationalPTP.q, ' + robotClassName.lower() + 'Run.rotationalPositionInput) annotation (Line(points = {{-39, -12}, {-20, -12}, {-20, 2}, {-12, 2}}, color = {0, 0, 127}));\n')
        f.write('  connect(translationalPTP.q, ' + robotClassName.lower() + 'Run.translationalPositionInput) annotation (Line(points = {{-39, 48}, {-20, 48}, {-20, 6}, {-12, 6}}, color = {0, 0, 127}));\n')

        # copy second half
        with open(readpath + 'TestURDF.mo') as readf:
            secondhalf = False
            for line in readf:
                if line.startswith('equation'):
                    secondhalf = True # second half begins
                elif secondhalf and not line.startswith('end'):
                    f.write(line)
                    
        f.write('end ' + modelname + ';\n')


def to_class_name(name):
    # convert string to legal Modelica class name (incomplete)

    # keywords from Modelica Language Spec version 3.7-dev
    keywords = ['algorithm',
                'discrete',
                'false',
                'loop',
                'pure',
                'and',
                'each',
                'final',
                'model',
                'record',
                'annotation',
                'else',
                'flow',
                'not',
                'redeclare',
                'elseif',
                'for',
                'operator',
                'replaceable',
                'block',
                'elsewhen',
                'function',
                'or',
                'return',
                'break',
                'encapsulated',
                'if',
                'outer',
                'stream',
                'class',
                'end',
                'import',
                'output',
                'then',
                'connect',
                'enumeration',
                'impure',
                'package',
                'true',
                'connector',
                'equation',
                'in',
                'parameter',
                'type',
                'constant',
                'expandable',
                'initial',
                'partial',
                'when',
                'constrainedby',
                'extends',
                'inner',
                'protected',
                'while',
                'der',
                'external',
                'input',
                'public',
                'within']

    illegal_names = ['world']
    if name in illegal_names or name in keywords:
        # Modify illegal identifier
        name = name + '0'

    return name.replace('-','_').capitalize()

def to_modelica_package(robot, rootpath, packagepath, visualization2, stationary, update):

    robotClassName = to_class_name(robot.name)

    # graph information for annotations
    (jointsnum, numjoints) = joint_name_to_num(robot)
    (linksnum, numlinks) = link_name_to_num(robot)
    (chains, roots, leafs) = kinematic_chains(robot, jointsnum, linksnum)
    ordered_elements_positions = links_and_joints_order(chains)
    
    # create new dir and package, overwrite existing otherwise
    if not os.path.isdir(rootpath + '/' + packagepath + '/' + robotClassName):
        if update:
            warnings.warn(rootpath + '/' + packagepath + '/' + robotClassName + ' not found, no update is possible')
            return
        os.mkdir(rootpath + '/' + packagepath + '/' + robotClassName)
        with open(rootpath + '/' + packagepath + '/package.order', 'a') as f:
            f.write(robotClassName + '\n')

    # Modelica paths inside library
    modelicapackagepath = packagepath.replace('/','.')
    modelicapackagepath = modelicapackagepath.replace('\\','.')
    packageorder = []

    # count elems for output sizes
    collisionLinks = []
    nonCollisionLinks = []
    rotationalJoints = []
    translationalJoints = []
    otherJoints = []

    # create or overwrite links and their params
    if len(robot.links) > 0:
        if not os.path.isdir(rootpath + '/' + packagepath + '/' + robotClassName + '/Links'):
            if update:
                warnings.warn(rootpath + '/' + packagepath + '/' + robotClassName + '/Links' + ' not found, no update is possible')
                return
            os.mkdir(rootpath + '/' + packagepath + '/' + robotClassName + '/Links')
        packageorder.append('Links');
        packageorderlinks = []
        
        for link in robot.links:
            linkClassName = to_class_name(link.name)
            packageorderlinks.append(linkClassName)
            packageorderlinks.append(linkClassName+'Params')
            if link.collision:
                collisionLinks.append(linkClassName)
            else:
                nonCollisionLinks.append(linkClassName)
            save_link(link, robotClassName, rootpath, packagepath, modelicapackagepath, visualization2, update)

        if not update:
            save_packageorder(packageorderlinks, rootpath, packagepath, robotClassName + '/Links')
            save_package('Links', robotClassName, rootpath, packagepath, modelicapackagepath)

    # create or overwrite joints and their params
    if len(robot.joints) > 0:
        if not os.path.isdir(rootpath + '/' + packagepath + '/' + robotClassName + '/Joints'):
            if update:
                warnings.warn(rootpath + '/' + packagepath + '/' + robotClassName + '/Joints' + ' not found, no update is possible')
                return
            os.mkdir(rootpath + '/' + packagepath + '/' + robotClassName + '/Joints')
        packageorder.append('Joints');
        packageorderjoints = []
        
        for joint in robot.joints:
            jointClassName = to_class_name(joint.name)
            packageorderjoints.append(jointClassName)
            packageorderjoints.append(jointClassName+'Params')
            if joint.type == 'revolute' or joint.type == 'continuous':
                rotationalJoints.append(jointClassName)
            elif joint.type == 'prismatic':
                translationalJoints.append(jointClassName)
            else:
                otherJoints.append(jointClassName)
            save_joint(joint, robotClassName, rootpath, packagepath, modelicapackagepath, update)

        if not update:
            save_packageorder(packageorderjoints, rootpath, packagepath, robotClassName+'/Joints')
            save_package('Joints', robotClassName, rootpath, packagepath, modelicapackagepath)

    if not update:
        # create or overwrite robot, run and test models
        packageorder.append(robotClassName)
        save_robot(robot, robotClassName, robotClassName, visualization2, stationary,
                   len(collisionLinks), len(nonCollisionLinks), len(rotationalJoints), len(translationalJoints), len(otherJoints),
                   rootpath, packagepath, modelicapackagepath,
                   ordered_elements_positions, leafs)

        packageorder.append(robotClassName + 'Run')
        save_robot_run(robot, robotClassName, robotClassName + 'Run', visualization2, stationary,
                       len(collisionLinks), len(nonCollisionLinks), len(rotationalJoints), len(translationalJoints), len(otherJoints),
                       rootpath, packagepath, modelicapackagepath,
                       ordered_elements_positions, leafs)

        packageorder.append(robotClassName + 'Test')
        save_robot_test(robot, robotClassName, robotClassName + 'Test', visualization2, stationary,
                        len(collisionLinks), len(nonCollisionLinks), len(rotationalJoints), len(translationalJoints), len(otherJoints),
                        rootpath, packagepath, modelicapackagepath,
                        ordered_elements_positions, leafs)

        # finally save package and packageorder files
        save_packageorder(packageorder, rootpath, packagepath, robotClassName)
        with open(rootpath + '/' + packagepath + '/' + robotClassName + '/package.mo', 'w') as f:
            f.write('within ' + modelicapackagepath + ';\n')
            f.write('package ' + robotClassName + '\n')
            f.write('  extends Modelica.Icons.Package;\n')
            f.write('  annotation (preferredView = "info", Icon(graphics = {Text(\n')
            f.write('    extent = {{-100, 100}, {100, 0}},\n')
            f.write('    textColor = {0, 0, 0},\n')
            f.write('    textString = "URDF"), Text(\n')
            f.write('    extent = {{-100, 0}, {100, -100}},\n')
            f.write('    textColor = {0, 0, 0},\n')
            f.write('    textString = "' + robotClassName + '")}));\n')
            f.write('end ' + robotClassName + ';\n')

        print('Successfully created package ' + rootpath + '/' + packagepath + '/' + robotClassName)
    else:
        print('Successfully updated package ' + rootpath + '/' + packagepath + '/' + robotClassName)

def joint_name_to_num(robot):
    # return two dicts where the name leads to the number in the list and vice versa
    num = 0
    jointsnum = {}
    numjoints = {}
    for joint in robot.joints:
        jointsnum.update({joint.name: num})
        numjoints.update({num: joint.name})
        num = num + 1
    return (jointsnum, numjoints)

def link_name_to_num(robot):
    # return two dicts where the name leads to the number in the list and vice versa
    num = 0
    linksnum = {}
    numlinks = {}
    for link in robot.links:
        linksnum.update({link.name: num})
        numlinks.update({num: link.name})
        num = num + 1
    return (linksnum, numlinks)

def find_roots_and_leafs(robot):
    # find all roots (links that never are child) and leafs (links that never are parent)
    leafs = [link.name for link in robot.links]
    roots = [link.name for link in robot.links]
    for joint in robot.joints:
        if joint.parent in leafs:
            leafs.remove(joint.parent)
        if joint.child in roots:
            roots.remove(joint.child)
    return (roots, leafs)

def floyd_warshall(robot, jointsnum, linksnum):
    # calc all links shortest paths    
    dist = [[10*len(list(jointsnum)) for link in robot.links] for link in robot.links]
    prev = [[None for link in robot.links] for link in robot.links]
    for joint in robot.joints:
        dist[linksnum[joint.parent]][linksnum[joint.child]] = 1
        prev[linksnum[joint.parent]][linksnum[joint.child]] = linksnum[joint.parent]
    for link in robot.links:
        dist[linksnum[link.name]][linksnum[link.name]] = 0
        prev[linksnum[link.name]][linksnum[link.name]] = linksnum[link.name]
    for k in range(len(list(linksnum))):
        for i in range(len(list(linksnum))):
            for j in range(len(list(linksnum))):
                if dist[i][j] > dist[i][k] + dist[k][j]:
                    dist[i][j] = dist[i][k] + dist[k][j]
                    prev[i][j] = prev[k][j]
    return (dist, prev)

def path(u, v, dist, prev):
    # return shortest path (link numbers) from u (link number) to v (link number) with dist and prev from floyd_warshall
    if not prev[u][v]:
        return []
    p = []
    p.append(v)
    while not u == v:
        v = prev[u][v]
        p.insert(0, v)
    return p

def kinematic_chains(robot, jointsnum, linksnum):
    # return all kinematic chains, paths from root links to leaf links
    (roots, leafs) = find_roots_and_leafs(robot)
    (dist, prev) = floyd_warshall(robot, jointsnum, linksnum)
    chains = []
    for r in roots:
        for l in leafs:
            chains.append(robot.get_chain(r, l))
    return (chains, roots, leafs)

def links_and_joints_order(chains):
    ordered_elements = [] # order in which the elements shall be added
    ordered_elements_positions = [] # order in which the elements shall be added, together with placement annotation
    chains_done = [] # remember which chains have been processed
    # layout parameters
    x_start = -80
    y_start = 70
    x_step = 25
    y_step = 30
    # special case first chain
    for eindex in range(len(chains[0])):
        ename = to_class_name(chains[0][eindex]).lower()
        if eindex == 0: # special case first element of first chain (tree root)
            ordered_elements.append(ename)
            ordered_elements_positions.append([ename,int(x_start),int(y_start)])
        else:
            ordered_elements.append(ename)
            ordered_elements_positions.append([ename,int(x_start + eindex*x_step),int(y_start)])
    chains_done.append(0)
    
    while len(chains_done) < len(chains):
        # step backwards through elements and find next logical (hopefully) to process
        for index in range(len(ordered_elements)-1,-1,-1):
            found = False
            for cindex in range(len(chains)):
                if cindex in chains_done:
                    continue
                for eindex in range(len(chains[cindex])):
                    if to_class_name(chains[cindex][eindex]).lower() == ordered_elements[index]:
                        found = True
                        break
                if found:
                    break
            if found:
                break
        if not found:
            continue
        # process the chain
        for index in range(eindex+1, len(chains[cindex])):
            ename = to_class_name(chains[cindex][index]).lower()
            ordered_elements.append(ename)
            ordered_elements_positions.append([ename,int(x_start + index*x_step),int(y_start - y_step * len(chains_done))])
        chains_done.append(cindex)
    return ordered_elements_positions


def record_top(robot,lt,jt):
    global numJoints
    global numLinks
    global numAxes
    global connectionMatrix
    global moveableJoints
    
    rt = 'record ' + robot.name + ' "URDF ' + robot.name +'"\n'
    rt += 'extends ' + data_base + '.Robot('
    
    rt += 'name = "' + robot.name + '",\n'
    
    rt += 'link = {' + lt  
    rt += '},'
    
    rt += 'joint = {' + jt
    rt += '},\n' 
    
    rt += 'numJoints = ' + str(numJoints) + ',\n'
    rt += 'numLinks = ' + str(numLinks) + ',\n'
    rt += 'numAxes = ' + str(numAxes) + ',\n'

    if numJoints > 0:    
        rt += 'connectionMatrix = ' + str(connectionMatrix).replace('],','];') + ',\n'
    if numAxes > 0:
        rt += 'moveableJoints = ' + str(moveableJoints).replace('],','];') + ',\n'

    rt = rt[:-2]
    rt += ');\n'
       
    return rt

def record_bottom(robot):
    bt = 'annotation (preferredView = "text");\nend ' + robot.name + ';'
    return bt
    
def to_modelica_record(robot):
    global numJoints
    global numLinks
    global numAxes
    global connectionMatrix
    global materials
    
    numJoints=len(robot.joints)
    numLinks=len(robot.links)

    # It is allowed to specify a material element outside of the 'link' object, in the top level 'robot' element.
    # From within a link element you can then reference the material by name.
    for material in robot.materials:
        if material.color:
            rgba = str(material.color.rgba).replace('[','{').replace(']','}')
        else:
            rgba = None  
        if material.texture:
            texture = material.texture
        else:
            texture = None
        materials.update({material.name: [rgba,texture]})
    
    jt = ''
    for joint in robot.joints:
        jt += make_Joint_Text(joint) + ',\n'
    jt = jt[:-2]
    
    lt = ''    
    for link in robot.links:
        lt += make_Link_Text(link) + ',\n'
    lt = lt[:-2]
    
    rt = record_top(robot,lt,jt)
    bt = record_bottom(robot)
    
    mr = rt + '\n' + bt
    
    return mr

def get_connectionMatrix(robot):
    numLinks = len(robot.links)
    linkNumber_map = {}
    for iLink in range(1,numLinks+1):
        linkNumber_map[robot.links[iLink-1].name] = iLink
        
    M = []
    for joint in robot.joints:
        M.append([linkNumber_map[joint.parent],linkNumber_map[joint.child]])
    
    return M

def make_Origin_Text(origin):
    ot = data_base + '.Origin(xyz = '  + str(origin.xyz).replace('[','{').replace(']','}') +',rpy = '  + str(origin.rpy).replace('[','{').replace(']','}') + ')'
    return ot

def make_Origin_Text_Default():
    ot = data_base + '.Origin(xyz = {0.0, 0.0, 0.0}, rpy = {0.0, 0.0, 0.0})'
    return ot
    
def make_Inertial_Text(inertial):
    it = data_base + '.Inertial('
    if inertial.origin:
        it += 'origin = '  + make_Origin_Text(inertial.origin) + ',\n'
    else:
        it += 'origin = ' + make_Origin_Text_Default() + ',\n'
    
    it += 'mass = ' + str(inertial.mass) + ',\n'
    it += 'inertia = ' + data_base + '.Inertia(ixx = ' + str(inertial.inertia.ixx) + ',\n'
    it += 'ixy = ' + str(inertial.inertia.ixy) + ',\n'
    it += 'ixz = ' + str(inertial.inertia.ixz) + ',\n'
    it += 'iyy = ' + str(inertial.inertia.iyy) + ',\n'
    it += 'iyz = ' + str(inertial.inertia.iyz) + ',\n'
    it += 'izz = ' + str(inertial.inertia.izz) + '))'
    return it
    
def make_Inertial_Text_Default():
    it = data_base + '.Inertial('
    it += 'origin = ' + make_Origin_Text_Default() + ',\n'
    
    it += 'mass = 0.0,\n'
    it += 'inertia = ' + data_base + '.Inertia(ixx = 0.0,\n'
    it += 'ixy = 0.0,\n'
    it += 'ixz = 0.0,\n'
    it += 'iyy = 0.0,\n'
    it += 'iyz = 0.0,\n'
    it += 'izz = 0.0))'
    return it

def make_Geometry_Text(geometry):
    gt = data_base + '.Geometry('
    if hasattr(geometry, 'filename'):
        gt += 'geometryType = URDFModelica.Types.GeometryType.mesh,\n'
        gt += 'size = {1.0, 1.0, 1.0},\n'
        gt += 'length = 1.0,\n'
        gt += 'radius = 1.0,\n'
        gt += 'filename = "' + geometry.filename + '",\n'
        if geometry.scale:
            gt += 'scale = '  + str(geometry.scale).replace('[','{').replace(']','}') + ')'
        else:
            gt += 'scale = {1.0, 1.0, 1.0}' + ')'
    elif hasattr(geometry, 'size'):
        gt += 'geometryType = URDFModelica.Types.GeometryType.box,\n'
        gt += 'size = '  + str(geometry.size).replace('[','{').replace(']','}') + ',\n'
        gt += 'length = 1.0,\n'
        gt += 'radius = 1.0,\n'
        gt += 'filename = "defaultMeshPath",\n'
        gt += 'scale = {1.0, 1.0, 1.0}' + ')'
    elif hasattr(geometry, 'length'):
        gt += 'geometryType = URDFModelica.Types.GeometryType.cylinder,\n'
        gt += 'size = {1.0, 1.0, 1.0},\n'
        gt += 'length = '  + str(geometry.length) + ',\n'
        gt += 'radius = '  + str(geometry.radius) + ',\n'
        gt += 'filename = "defaultMeshPath",\n'
        gt += 'scale = {1.0, 1.0, 1.0}' + ')'
    elif hasattr(geometry, 'radius'):
        gt += 'geometryType = URDFModelica.Types.GeometryType.sphere,\n'
        gt += 'size = {1.0, 1.0, 1.0},\n'
        gt += 'length = 1.0,\n'
        gt += 'radius = '  + str(geometry.radius) + ',\n'
        gt += 'filename = "defaultMeshPath",\n'
        gt += 'scale = {1.0, 1.0, 1.0}' + ')'
    else:
        gt = ''
    
    return gt

def make_Geometry_Text_Default():
    gt = data_base + '.Geometry('
    gt += 'geometryType = URDFModelica.Types.GeometryType.sphere,\n'
    gt += 'size = {1.0, 1.0, 1.0},\n'
    gt += 'length = 1.0,\n'
    gt += 'radius = 1.0,\n'
    gt += 'filename = "defaultMeshPath",\n'
    gt += 'scale = {1.0, 1.0, 1.0}' + ')'
    return gt

def make_Material_Text(material):
    # It is allowed to specify a material element outside of the 'link' object, in the top level 'robot' element.
    # From within a link element you can then reference the material by name.
    global materials
    
    mt = data_base + '.Material('
    mt += 'name = "' + material.name + '",\n'
    
    if material.color:
        mt += 'rgba = ' + str(material.color.rgba).replace('[','{').replace(']','}') + ',\n'
    elif material.name in materials:
        if materials[material.name][0]:
            mt += 'rgba = ' + materials[material.name][0] + ',\n'
        else:
            mt += 'rgba = {0.5, 0.5, 0.5, 1.0},\n'
    else:
        mt += 'rgba = {0.5, 0.5, 0.5, 1.0},\n'
        
    if material.texture:
        mt += 'texture = "' + material.texture + '")'
    elif material.name in materials:
        if materials[material.name][1]:
            mt += 'texture = "' + materials[material.name][1] + '")'
        else:
            mt += 'texture = "defaultTextureFilename")'
    else:
        mt += 'texture = "defaultTextureFilename")'
        
    return mt

def make_Material_Text_Default():
    mt = data_base + '.Material('
    mt += 'name = "defaultMaterialName",\n'
    mt += 'rgba = {0.5, 0.5, 0.5, 1.0},\n'
    mt += 'texture = "defaultTextureFilename")'
    return mt
    
def make_Collision_Text(collision):
    ct = data_base + '.Collision('
    
    if collision.origin:
        ct += 'origin = ' + make_Origin_Text(collision.origin) + ',\n'
    else:
        ct += 'origin = ' + make_Origin_Text_Default() + ',\n'
        
    ct += 'geometry = ' + make_Geometry_Text(collision.geometry) + ''
    
    ct += ')'    
    
    return ct
    
def make_Collision_Text_Default():
    ct = data_base + '.Collision('
    ct += 'origin = ' + make_Origin_Text_Default() + ',\n'
    ct += 'geometry = ' + make_Geometry_Text_Default() + ')'    
    return ct
    
def make_Visual_Text(visual):
    vt = data_base + '.Visual('
    
    if visual.origin:
        vt += 'origin = ' + make_Origin_Text(visual.origin) + ',\n'
    else:
        vt += 'origin = ' + make_Origin_Text_Default() + ',\n'
        
    vt += 'geometry = ' + make_Geometry_Text(visual.geometry) + ',\n'
    
    if visual.material:
        vt += 'material = ' + make_Material_Text(visual.material) + ')'
    else:
        vt += 'material = ' + make_Material_Text_Default() + ')'    
    
    return vt
    
def make_Visual_Text_Default():
    vt = data_base + '.Visual('
    vt += 'origin = ' + make_Origin_Text_Default() + ',\n'
    vt += 'geometry = ' + make_Geometry_Text_Default() + ',\n'
    vt += 'material = ' + make_Material_Text_Default() + ')'    
    return vt
    
def make_Link_Text(link):
    global link_counter
    link_counter += 1
    
    lt = data_base + '.Link(\n'
    
    if link.visual:
        hasVisual = True
    else:
        hasVisual = False
        
    if link.collision:
        hasCollision = True
    else:
        hasCollision = False 

    
    lt += 'name = "' + link.name + '",\n'
    lt += 'hasVisual = '  + str(hasVisual).lower() + ',\n'
    lt += 'hasCollision = '  + str(hasCollision).lower()
    
    if link.inertial:
        lt += ',\n' + 'inertial = ' + make_Inertial_Text(link.inertial)
    else:
        lt += ',\n' + 'inertial = ' + make_Inertial_Text_Default()
    
    if hasVisual:
        lt += ',\n' + 'visual = ' + make_Visual_Text(link.visual)
    else:
        lt += ',\n' + 'visual = ' + make_Visual_Text_Default()
        
    if hasCollision:
        lt += ',\n' + 'collision = ' + make_Collision_Text(link.collision)
    else:
        lt += ',\n' + 'collision = ' + make_Collision_Text_Default()
    
    lt += ')'
    
    return lt

def make_Joint_Text(joint):
    global numAxes
    global joint_counter
    joint_counter += 1
    
    jt = data_base + '.Joint(\n'
    
    if joint.calibration:
        hasCalibration = True
    else:
        hasCalibration = False
        
    if joint.dynamics:
        hasDynamics = True
    else:
        hasDynamics = False
        
    if joint.limit:
        hasLimit = True
    else:
        hasLimit = False
        
    if joint.mimic:
        hasMimic = True
    else:
        hasMimic = False
        
    if joint.safety_controller:
        hasSafety_controller = True
    else:
        hasSafety_controller = False
        
    jt += 'name = "' + joint.name + '",\n'
    jt += 'hasCalibration = ' + str(hasCalibration).lower() + ',\n'
    jt += 'hasDynamics = ' + str(hasDynamics).lower() + ',\n'
    jt += 'hasLimit = ' + str(hasLimit).lower() + ',\n'
    jt += 'hasMimic = ' + str(hasMimic).lower() + ',\n'
    jt += 'hasSafety_controller = ' + str(hasSafety_controller).lower() + ',\n'
    
    if joint.type == 'revolute':
        numAxes += 1
        moveableJoints.append([joint_counter, 1])
        jt += 'jointType = URDFModelica.Types.JointType.revolute,\n'
    elif joint.type == 'prismatic':
        numAxes += 1
        moveableJoints.append([joint_counter, 1])
        jt += 'jointType = URDFModelica.Types.JointType.prismatic,\n'
    elif joint.type == 'continuous':
        numAxes += 1
        moveableJoints.append([joint_counter, 1])
        jt += 'jointType = URDFModelica.Types.JointType.continuous,\n'
    elif joint.type == 'floating':
        jt += 'jointType = URDFModelica.Types.JointType.floating,\n'
    elif joint.type == 'planar':
        jt += 'jointType = URDFModelica.Types.JointType.planar,\n'
    else: # elif joint.type == 'fixed':
        jt += 'jointType = URDFModelica.Types.JointType.fixedJoint,\n'
    
    if joint.origin:
        jt += 'origin = ' + make_Origin_Text(joint.origin) + ',\n'
    else:
        jt += 'origin = ' + make_Origin_Text_Default() + ',\n'

    jt += 'parent = ' + data_base + '.Parent(link = "' + joint.parent + '"),\n'
    jt += 'child = ' + data_base + '.Child(link = "' + joint.child + '")'
    
    if joint.axis:
        jt += ',\naxis = ' + data_base + '.Axis(xyz = ' + str(joint.axis).replace('[','{').replace(']','}') + ')'
    else:
        jt += ',\naxis = ' + data_base + '.Axis(xyz = {1.0, 0.0, 0.0})'
    
    jt += ',\ncalibration = ' + data_base + '.Calibration('
    if hasCalibration:
        if joint.calibration.rising:
            jt += 'rising = ' + str(joint.calibration.rising)
            if joint.calibration.falling:
                jt += ',falling = ' + str(joint.calibration.falling) + ')'
            else:
                jt += ',falling = 0.0)'
        else:
            jt += 'rising = 0.0, falling = ' + str(joint.calibration.falling) + ')'
    else:
        jt += 'rising = 0.0, falling = 0.0)'
            
    jt += ',\ndynamics = '  + data_base + '.Dynamics('
    if hasDynamics:
        if joint.dynamics.damping:
            jt += 'damping = ' + str(joint.dynamics.damping)
            if joint.dynamics.friction:
                jt += ',friction = ' + str(joint.dynamics.friction) + ')'
            else:
                jt += ',friction = 0.0)'
        else:
            jt += 'damping = 0.0, friction = ' + str(joint.dynamics.friction) + ')'
    else:
        jt += 'damping = 0.0, friction = 0.0)'
            
    jt += ',\nlimit = ' + data_base + '.Limit('
    if hasLimit:        
        if joint.limit.lower:
            jt += 'lower = ' + str(joint.limit.lower) + ',\n'
        else:
            jt += 'lower = 0.0,\n'
        if joint.limit.upper:
            jt += 'upper = ' + str(joint.limit.upper) + ',\n'
        else:
            jt += 'upper = 0.0,\n'
        jt += 'effort = ' + str(joint.limit.effort) + ',\n'
        jt += 'velocity = ' + str(joint.limit.velocity) + ')'
    else:
        jt += 'lower = 0.0,\n'
        jt += 'upper = 0.0,\n'
        jt += 'effort = 0.0,\n'
        jt += 'velocity = 0.0)'
        
    jt += ',\nmimic = ' + data_base + '.Mimic('
    if hasMimic:
        jt += 'joint = "' + joint.mimic.joint + '"'
        if joint.mimic.multiplier:
            jt += ',\n' + 'multiplier = ' + str(joint.mimic.multiplier)
        else:
            jt += ',\n' + 'multiplier = 1.0'
        if joint.mimic.offset:
            jt += ',\n' + 'offset = ' + (joint.mimic.offset)
        else:
            jt += ',\n' + 'offset = 0.0'
        jt += ')'
    else:
        jt += 'joint = "defaultJointName"'
        jt += ',\n' + 'multiplier = 1.0'
        jt += ',\n' + 'offset = 0.0)'
        
    jt += ',\nsafety_controller = ' + data_base + '.Safety_controller('
    if hasSafety_controller:
        if joint.safety_controller.soft_lower_limit:
            jt += 'soft_lower_limit = ' + str(joint.safety_controller.soft_lower_limit) + ',\n'
        else:
            jt += 'soft_lower_limit = 0.0,\n'
        if joint.safety_controller.soft_upper_limit:
            jt += 'soft_upper_limit = ' + str(joint.safety_controller.soft_upper_limit) + ',\n'
        else:
            jt += 'soft_upper_limit = 0.0,\n'
        if joint.safety_controller.k_position:
            jt += 'k_position = ' + str(joint.safety_controller.k_position) + ',\n'
        else:
            jt += 'k_position = 0.0,\n'
        jt += 'k_velocity = ' + str(joint.safety_controller.k_velocity) + ')'
    else:
        jt += 'soft_lower_limit = 0.0,\n'
        jt += 'soft_upper_limit = 0.0,\n'
        jt += 'k_position = 0.0,\n'
        jt += 'k_velocity = 0.0)'
         
               
    jt += ')'
    
    return jt


def main(argv):
    global connectionMatrix
    
    inputfile = 'physics.urdf' # URDF input file
    outputfile = 'noOutput' # Robots Modelica record file to create or overwrite
    rootpath = 'H:/URDF_tutorial/urdfmodelica_github' # this is the path to the root directory where the Modelica packages are
    packagepath = 'URDFModelica/Examples' # this is the path from root where the robot pacakge will be created or overwritten
    visualization2 = False # if False then standard library visualizers, if True then Visualization2 visualizers
    stationary = False # if False then robotRun has freeMotion and collision to z=0 plane, if True then robotRun is fixed to origin
    update = False # if True only parameters are updated and models are not overwritten, if False overwrite everything
    genericonly = False # if True only create the single Modelica record translation from URDF and skip the package creation (-r, -p, -v, -s are ignored), if False do package creation or update
    try:
        opts, args = getopt.getopt(argv,'hi:o:r:p:vsug',['ifile=','ofile=','rootpath=','packagepath='])
    except getopt.GetoptError:
        print('urdf_to_package.py -i <inputfile.urdf> -o <outputfile_modelicarecord.mo> -r <path/to/root/directory> -p <Modelica/package/without/robot/name> -s -v -u -g')
        print('urdf_to_package.py --ifile <inputfile.urdf> --ofile <outputfile_modelicarecord.mo> --rootpath <path/to/root/directory> --packagepath <Modelica/package/without/robot/name> --stationary --visualization2 --update --genericonly')
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print('urdf_to_package.py -i <inputfile.urdf> -o <outputfile_modelicarecord.mo> -r <path/to/root/directory> -p <Modelica/package/without/robot/name> -s -v -u -g')
            print('urdf_to_package.py --ifile <inputfile.urdf> --ofile <outputfile_modelicarecord.mo> --rootpath <path/to/root/directory> --packagepath <Modelica/package/without/robot/name> --stationary --visualization2 --update --genericonly')
            sys.exit()
        elif opt in ('-i', '--ifile'):
            inputfile = arg
        elif opt in ('-o', '--ofile'):
            outputfile = arg
        elif opt in ('-r', '--rootpath'):
            rootpath = arg
        elif opt in ('-p', '--packagepath'):
            packagepath = arg
        elif opt in ('-v', '--visualization2'):
            visualization2 = True
        elif opt in ('-s', '--stationary'):
            stationary = True
        elif opt in ('-u', '--update'):
            update = True
        elif opt in ('-g', '--genericonly'):
            genericonly = True
    
    f = open(inputfile, 'r')

    t = f.read()
    f.close()

    robot = URDF.from_xml_string(t) # parse URDF with additions for sensors and collision coefficients
    
    connectionMatrix = get_connectionMatrix(robot)
    
    mr = to_modelica_record(robot)
    
    if outputfile == 'noOutput' or outputfile == '' or outputfile == None:
        outputfile = robot.name + '.mo'
    
    of = open(outputfile, 'w')
    of.write(mr)
    of.close()

    if not genericonly:
        to_modelica_package(robot, rootpath.replace('-','_'), packagepath.replace('-','_'), visualization2, stationary, update)

if __name__ == '__main__':
   main(sys.argv[1:])
