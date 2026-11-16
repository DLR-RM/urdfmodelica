within URDFModelica.Examples.Physics_Wheels.Joints;
model Right_gripper_joint
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
  parameter Right_gripper_jointParams jointParams annotation (Placement(transformation(extent = {{-100, 80}, {-80, 100}})));
  parameter Integer flangeIndex = 0;
  parameter Boolean checkJointLimits = jointParams.hasLimit "If true, the joint limits are checked";
  parameter AssertionLevel assertionLevel = AssertionLevel.warning "Assertion level (warning or error)";

  Modelica.Mechanics.MultiBody.Parts.FixedRotation fixedRotation(angles = Modelica.Units.Conversions.to_deg({jointParams.origin.rpy[3], jointParams.origin.rpy[2], jointParams.origin.rpy[1]}), r = jointParams.origin.xyz, rotationType = Modelica.Mechanics.MultiBody.Types.RotationTypes.PlanarRotationSequence, sequence = {3, 2, 1}, animation = false) annotation (
    Placement(transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute(useAxisFlange = true, n = jointParams.axis.xyz, animation = false) annotation (
    Placement(transformation(origin = {10, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b annotation (
    Placement(transformation(origin = {-50, 100}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-50, 100}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a annotation (
    Placement(transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sensors.TorqueSensor torqueSensor annotation (
    Placement(transformation(origin = {10, -8}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  URDFModelica.Joints.RotationalFriction dynamic(Rh = jointParams.dynamics.friction, Rv = jointParams.dynamics.damping) if jointParams.hasDynamics annotation (
    Placement(transformation(origin = {10, 80}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor annotation (
    Placement(transformation(origin = {30, 50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (
    Placement(transformation(origin = {30, 30}, extent = {{-10, -10}, {10, 10}})));
  URDFModelica.Joints.JointLimitCheck jointLimitCheck(assertionLevel = assertionLevel, lower = jointParams.limit.lower, upper = jointParams.limit.upper, velocity = jointParams.limit.velocity, effort = jointParams.limit.effort) if checkJointLimits annotation (
    Placement(transformation(extent = {{60, 20}, {80, 40}})));
equation
  connect(frame_a, fixedRotation.frame_a) annotation (
    Line(points = {{-100, 0}, {-80, 0}}));
  connect(fixedRotation.frame_b, revolute.frame_a) annotation (
    Line(points = {{-60, 0}, {-60, -40}, {0, -40}}, color = {95, 95, 95}));
  connect(revolute.support, flange_b) annotation (
    Line(points = {{4, -30}, {-50, -30}, {-50, 100}}));
  connect(revolute.axis, torqueSensor.flange_b) annotation (
    Line(points = {{10, -30}, {10, -18}}));
  if jointParams.hasDynamics then
    connect(flange_a, dynamic.flange_a) annotation (
      Line(points = {{0, 100}, {10, 100}, {10, 90}}, color = {0, 0, 0}));
    connect(dynamic.flange_b, torqueSensor.flange_a) annotation (
      Line(points = {{10, 70}, {10, 2}}, color = {0, 0, 0}));
  else
    connect(flange_a, torqueSensor.flange_a) annotation (
      Line(points = {{0, 100}, {10, 100}, {10, 2}}, color = {0, 0, 0}));
  end if;
  connect(torqueSensor.flange_a, angleSensor.flange) annotation (
    Line(points = {{10, 2}, {10, 50}, {20, 50}}));
  connect(torqueSensor.flange_a, speedSensor.flange) annotation (
    Line(points = {{10, 2}, {10, 30}, {20, 30}}));
  connect(revolute.frame_b, frame_b) annotation (
    Line(points = {{20, -40}, {100, -40}, {100, 0}}, color = {95, 95, 95}));
  connect(angleSensor.phi, jointLimitCheck.jointAngle) annotation (
    Line(points = {{41, 50}, {50, 50}, {50, 34}, {58, 34}}, color={0, 0, 127}));
  connect(speedSensor.w, jointLimitCheck.jointVelocity) annotation (
    Line(points = {{41, 30}, {58, 30}}, color = {0, 0, 127}));
  connect(torqueSensor.tau, jointLimitCheck.jointTorque) annotation (
    Line(points = {{21, 0}, {50, 0}, {50, 26}, {58, 26}}, color = {0, 0, 127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {
        Rectangle(
          lineColor = {64, 64, 64},
          fillColor = {39, 150, 249},
          fillPattern = FillPattern.HorizontalCylinder,
          extent = {{-100, -60}, {-30, 60}},
          radius = 10),
        Rectangle(
          lineColor = {64, 64, 64},
          fillColor = {39, 150, 249},
          fillPattern = FillPattern.HorizontalCylinder,
          extent = {{30, -60}, {100, 60}},
          radius = 10),
        Rectangle(
          lineColor = {64, 64, 64},
          extent = {{-100, 60}, {-30, -60}},
          radius = 10),
        Rectangle(
          lineColor = {64, 64, 64},
          extent = {{30, 60}, {100, -60}},
          radius = 10),
        Rectangle(
          lineColor = {64, 64, 64},
          fillColor = {39, 150, 249},
          fillPattern = FillPattern.Solid,
          extent = {{-30, 11}, {30, -10}}),
        Text(
          extent = {{-150, -155}, {150, -115}},
          textString = "%name",
          textColor = {0, 0, 255}),
        Text(
          extent = {{-150, -100}, {150, -70}},
          textString = "n=%jointParams.axis.xyz"),
        Text(
          origin = {0, -10},
          textColor = {135, 135, 135},
          extent = {{-60, 100},{ 60, 40}},
          textString = "%flangeIndex",
          visible = flangeIndex > 0)}), preferredView = "diagram");
end Right_gripper_joint;
