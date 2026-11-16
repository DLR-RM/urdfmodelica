within URDFModelica.Joints;
model Joint
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
  replaceable parameter Records.Joint jointParams constrainedby Records.Joint
    annotation (Placement(transformation(extent = {{-100, 80}, {-80, 100}})), choicesAllMatching = true);
  parameter Boolean checkJointLimits = true "If true, the joint limits are checked";
  parameter AssertionLevel assertionLevel = AssertionLevel.warning "Assertion level (warning or error)";

  Fixed fixed(jointParams = jointParams) if jointParams.jointType == Types.JointType.fixedJoint
    annotation (Placement(transformation(extent = {{-10, 60}, {10, 80}})));
  Continuous continuous(jointParams = jointParams) if jointParams.jointType == Types.JointType.continuous
    annotation (Placement(transformation(extent = {{-10, 30}, {10, 50}})));
  Revolute revolute(jointParams = jointParams, checkJointLimits = checkJointLimits, assertionLevel = assertionLevel) if jointParams.jointType == Types.JointType.revolute
    annotation (Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  Prismatic prismatic(jointParams = jointParams, checkJointLimits = checkJointLimits, assertionLevel = assertionLevel) if jointParams.jointType == Types.JointType.prismatic
    annotation (Placement(transformation(extent = {{-10, -50}, {10, -30}})));
  Planar planar(jointParams = jointParams) if jointParams.jointType == Types.JointType.planar
    annotation (Placement(transformation(extent = {{-10, -80}, {10, -60}})));
  Floating floating(jointParams = jointParams) if jointParams.jointType == Types.JointType.floating
    annotation (Placement(transformation(extent = {{-10, -110}, {10, -90}})));

  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a if jointParams.jointType == Types.JointType.revolute or jointParams.jointType == Types.JointType.continuous or jointParams.jointType == Types.JointType.prismatic annotation (
      Placement(transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Components.IdealGearR2T idealGearR2T(
    useSupportR = false,
    useSupportT = false,
    ratio = 1) if jointParams.jointType == Types.JointType.prismatic
    annotation (Placement(transformation(extent = {{-60, -40}, {-40, -20}})));
equation
  connect(frame_a, fixed.frame_a)
    annotation (Line(points = {{-100, 0}, {-20, 0}, {-20, 70}, {-10, 70}}));
  connect(frame_a, continuous.frame_a)
    annotation (Line(points = {{-100, 0}, {-20, 0}, {-20, 40}, {-10, 40}}));
  connect(frame_a, revolute.frame_a)
    annotation (Line(points = {{-100, 0}, {-10, 0}}));
  connect(frame_a, prismatic.frame_a)
    annotation (Line(points = {{-100, 0}, {-20, 0}, {-20, -40}, {-10, -40}}));
  connect(frame_a, planar.frame_a)
    annotation (Line(points = {{-100, 0}, {-20, 0}, {-20, -70}, {-10, -70}}));
  connect(frame_a, floating.frame_a)
    annotation (Line(points = {{-100, 0}, {-20, 0}, {-20, -100}, {-10, -100}}));
  connect(fixed.frame_b, frame_b)
    annotation (Line(points = {{10, 70}, {20, 70}, {20, 0}, {100, 0}}));
  connect(continuous.frame_b, frame_b)
    annotation (Line(points = {{10, 40}, {20, 40}, {20, 0}, {100, 0}}));
  connect(revolute.frame_b, frame_b) annotation (Line(points = {{10, 0}, {100, 0}}));
  connect(prismatic.frame_b, frame_b)
    annotation (Line(points = {{10, -40}, {20, -40}, {20, 0}, {100, 0}}));
  connect(planar.frame_b, frame_b)
    annotation (Line(points = {{10, -70}, {20, -70}, {20, 0}, {100, 0}}));
  connect(floating.frame_b, frame_b)
    annotation (Line(points = {{10, -100}, {20, -100}, {20, 0}, {100, 0}}));
  connect(flange_a, continuous.flange_a)
    annotation (Line(points = {{0, 100}, {0, 84}, {14, 84}, {14, 54}, {0, 54}, {0, 50}}, color = {0, 0, 0}));
  connect(flange_a, revolute.flange_a)
    annotation (Line(points = {{0, 100}, {0, 84}, {14, 84}, {14, 14}, {0, 14}, {0, 10}}, color = {0, 0, 0}));
  connect(flange_a, idealGearR2T.flangeR)
    annotation (Line(points = {{0, 100}, {0, 84}, {14, 84}, {14, -14}, {-66, -14}, {-66, -30}, {-60, -30}}, color = {0, 0, 0}));
  connect(idealGearR2T.flangeT, prismatic.flange_a)
    annotation (Line(points = {{-40, -30}, {-40, -20}, {0, -20}, {0, -30}}, color = {0, 127, 0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio = false), graphics = {
        Rectangle(
          extent = {{-100, 12}, {102, -12}},
          lineColor = {0, 0, 0},
          fillColor = {39, 150, 249},
          fillPattern = FillPattern.Solid),
        Ellipse(
          extent = {{-40, -40}, {40, 40}},
          lineColor = {0, 0, 0},
          fillColor = {39, 150, 249},
          fillPattern = FillPattern.Solid),
        Ellipse(
          extent = {{-20, -20}, {20, 20}},
          lineColor = {0, 0, 0},
          fillColor = {255, 255, 255},
          fillPattern = FillPattern.Solid),
        Text(
          extent = {{-150, -135}, {150, -95}},
          textString = "%name",
          textColor = {0, 0, 255}),
        Line(points = {{0, 90}, {0, 40}}, color = {0, 0, 0})}),           Diagram(coordinateSystem(preserveAspectRatio = false)));
end Joint;
