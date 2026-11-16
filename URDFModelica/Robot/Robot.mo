within URDFModelica.Robot;
model Robot
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialOneFrame_a;
  extends URDFModelica.Icons.StationaryRobotIcon;

  parameter URDFModelica.Records.Robot robotParams
    annotation (choicesAllMatching = true, Placement(transformation(extent = {{-100, 80}, {-80, 100}})));

  parameter Boolean enableCollision = false;
  parameter Boolean enableInertial = true;
  parameter Boolean showLinkFrames = true;
  parameter Boolean checkJointLimits = true "If true, the joint limits are checked";
  parameter AssertionLevel assertionLevel = AssertionLevel.warning "Assertion level (warning or error)";

  parameter Integer numAxes = robotParams.numAxes;
  parameter Integer nL = size(robotParams.link, 1);
  parameter Integer nJ = size(robotParams.joint, 1);
  parameter Integer bL = Functions.getBaseLink(cM);
  parameter Integer tL = Functions.getToolLink(cM);

  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a[numAxes]
    annotation (Placement(transformation(extent = {{-10, 90}, {10, 110}})));

  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_b[nL] if showLinkFrames
    annotation (Placement(transformation(extent = {{84, -76}, {116, -44}}), iconTransformation(extent = {{84, -76}, {116, -44}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_tool
    annotation (Placement(transformation(extent = {{84, 16}, {116, 48}}), iconTransformation(extent = {{84, 16}, {116, 48}})));
protected
  parameter Integer cM[nJ, 2] = robotParams.connectionMatrix;

  replaceable Links.Link link[nL](linkParams = robotParams.link, each enableCollision = enableCollision, each enableInertial = enableInertial)
    annotation (Placement(transformation(extent = {{40, -10}, {60, 10}})));
  Joints.Joint joint[nJ](jointParams = robotParams.joint, each checkJointLimits = checkJointLimits, each assertionLevel = assertionLevel) annotation (Placement(transformation(extent = {{-20, -10}, {0, 10}})));

equation
  // Connect moveable joints to corresponding flanges
  for iAxis in 1:numAxes loop
    connect(flange_a[iAxis], joint[robotParams.moveableJoints[iAxis, 1]].flange_a) annotation (Line(points = {{0, 100}, {0, 14}, {-10, 14}, {-10, 10}}, color = {0, 0, 0}));
  end for;

  for iJoint in 1:robotParams.numJoints loop
    //Parent
    connect(link[cM[iJoint, 1]].frame_a, joint[iJoint].frame_a);
    //Child
    connect(joint[iJoint].frame_b, link[cM[iJoint, 2]].frame_a);
  end for;
  connect(frame_a, link[bL].frame_a) annotation (Line(
      points = {{-100, 0}, {-60, 0}, {-60, -20}, {20, -20}, {20, 0}, {40, 0}},
      color = {95, 95, 95},
      thickness = 0.5));
  connect(link.frame_a, frame_b) annotation (Line(
      points = {{40, 0}, {34, 0}, {34, -60}, {100, -60}},
      color = {95, 95, 95},
      thickness = 0.5));
  connect(link[tL].frame_a, frame_tool)
    annotation (Line(
      points = {{40, 0}, {34, 0}, {34, 32}, {100, 32}},
      color = {95, 95, 95},
      thickness = 0.5));
end Robot;
