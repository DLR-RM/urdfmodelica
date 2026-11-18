within URDFModelica.Examples_Visualization2.Physics_Wheels.Joints;
model Gripper_extension
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
  parameter Gripper_extensionParams jointParams annotation (Placement(transformation(extent = {{-100, 80}, {-80, 100}})));
  parameter Integer flangeIndex = 0;
  parameter Boolean checkJointLimits = jointParams.hasLimit "If true, the joint limits are checked";
  parameter AssertionLevel assertionLevel = AssertionLevel.warning "Assertion level (warning or error)";

  Modelica.Mechanics.MultiBody.Parts.FixedRotation fixedRotation(angles = Modelica.Units.Conversions.to_deg({jointParams.origin.rpy[3], jointParams.origin.rpy[2], jointParams.origin.rpy[1]}), r = jointParams.origin.xyz, rotationType = Modelica.Mechanics.MultiBody.Types.RotationTypes.PlanarRotationSequence, sequence = {3, 2, 1}, animation = false) annotation (
    Placement(transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic prismatic(useAxisFlange = true, n = jointParams.axis.xyz, animation = false) annotation (
    Placement(transformation(origin = {10, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a annotation (
    Placement(transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b flange_b annotation (
    Placement(transformation(origin = {-50, 100}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-50, 100}, extent = {{-10, -10}, {10, 10}})));
  URDFModelica.Joints.TranslationalFriction dynamic(Rh = jointParams.dynamics.friction, Rv = jointParams.dynamics.damping) if jointParams.hasDynamics annotation (
    Placement(transformation(origin = {10, 80}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  Modelica.Mechanics.Translational.Sensors.ForceSensor forceSensor annotation (
    Placement(transformation(origin = {10, -8}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Mechanics.Translational.Sensors.PositionSensor positionSensor annotation (
    Placement(transformation(origin = {30, 50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Sensors.SpeedSensor speedSensor annotation (
    Placement(transformation(origin = {30, 30}, extent = {{-10, -10}, {10, 10}})));
  URDFModelica.Joints.JointLimitCheck jointLimitCheck(assertionLevel = assertionLevel, lower = jointParams.limit.lower, upper = jointParams.limit.upper, velocity = jointParams.limit.velocity, effort = jointParams.limit.effort) if checkJointLimits annotation (
    Placement(transformation(extent = {{60, 20}, {80, 40}})));
equation
  connect(frame_a, fixedRotation.frame_a) annotation (
    Line(points = {{-100, 0}, {-80, 0}}));
  connect(fixedRotation.frame_b, prismatic.frame_a) annotation (
    Line(points = {{-60, 0}, {-60, -40}, {0, -40}}, color = {95, 95, 95}));
  connect(prismatic.frame_b, frame_b) annotation (
    Line(points = {{20, -40}, {100, -40}, {100, 0}}, color = {95, 95, 95}));
  if jointParams.hasDynamics then
    connect(flange_a, dynamic.flange_a) annotation (
      Line(points = {{0, 100}, {10, 100}, {10, 90}}, color = {0, 127, 0}));
    connect(dynamic.flange_b, forceSensor.flange_a) annotation (
      Line(points = {{10, 70}, {10, 2}}, color = {0, 127, 0}));
  else
    connect(flange_a, forceSensor.flange_a) annotation (
      Line(points = {{0, 100}, {10, 100}, {10, 2}}, color = {0, 127, 0}));
  end if;
  connect(forceSensor.flange_b, prismatic.axis) annotation (
    Line(points = {{10, -18}, {10, -34}, {18, -34}}, color = {0, 127, 0}));
  connect(positionSensor.flange, forceSensor.flange_a) annotation (
    Line(points = {{20, 50}, {10, 50}, {10, 2}}, color = {0, 127, 0}));
  connect(speedSensor.flange, forceSensor.flange_a) annotation (
    Line(points = {{20, 30}, {10, 30}, {10, 2}}, color = {0, 127, 0}));
  connect(prismatic.support, flange_b) annotation (
    Line(points = {{6, -34}, {-50, -34}, {-50, 100}}, color = {0, 127, 0}));
  connect(positionSensor.s, jointLimitCheck.jointAngle) annotation (
    Line(points = {{41, 50}, {50, 50}, {50, 34}, {58, 34}}, color = {0, 0, 127}));
  connect(speedSensor.v, jointLimitCheck.jointVelocity) annotation (
    Line(points = {{41, 30}, {58, 30}}, color = {0, 0, 127}));
  connect(forceSensor.f, jointLimitCheck.jointTorque) annotation (
    Line(points = {{21, 0}, {50, 0}, {50, 26}, {58, 26}}, color = {0, 0, 127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {
        Rectangle(
          lineColor = {0, 0, 255},
          fillColor = {39, 150, 249},
          pattern = LinePattern.None,
          fillPattern = FillPattern.Solid,
          extent = {{-100, -50}, {-30, 41}}),
        Rectangle(
          lineColor = {0, 0, 255},
          pattern = LinePattern.None,
          fillPattern = FillPattern.Solid,
          extent = {{-100, 40}, {-30, 50}}),
        Rectangle(
          lineColor = {0, 0, 255},
          fillColor = {39, 150, 249},
          pattern = LinePattern.None,
          fillPattern = FillPattern.Solid,
          extent = {{-30, -30}, {100, 20}}),
        Rectangle(
          lineColor = {0, 0, 255},
          pattern = LinePattern.None,
          fillPattern = FillPattern.Solid,
          extent = {{-30, 20}, {100, 30}}),
        Line(points = {{-30, -50}, {-30, 50}}),
        Line(points = {{100, -30}, {100, 21}}),
        Text(
          extent = {{-150, -135}, {150, -95}},
          textString = "%name",
          textColor = {0, 0, 255}),
        Text(
          extent = {{-150, -100}, {150, -70}},
          textString = "n=%jointParams.axis.xyz"),
        Text(
          origin = {0, -10},
          textColor = {0, 127, 0},
          extent = {{-60, 100}, {60, 40}},
          textString = "%flangeIndex",
          visible = flangeIndex > 0)}), preferredView = "diagram");
end Gripper_extension;
