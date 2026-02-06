within URDFModelica.Examples.Ur10e_robot.Joints;
model Shoulder_lift_joint
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
  parameter Shoulder_lift_jointParams jointParams annotation (Placement(transformation(extent = {{-100, 80}, {-80, 100}})));
  parameter Integer flangeIndex = 0;
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
  Modelica.Blocks.Logical.GreaterThreshold posLimitHigh(threshold = jointParams.limit.upper) annotation (
    Placement(transformation(origin = {70, 80}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Logical.LessThreshold posLimitLow(threshold = jointParams.limit.lower) annotation (
    Placement(transformation(origin = {70, 60}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Logical.GreaterThreshold speedLimitHigh(threshold = jointParams.limit.velocity) annotation (
    Placement(transformation(origin = {70, 40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Logical.LessThreshold speedLimitLow(threshold = -jointParams.limit.velocity) annotation (
    Placement(transformation(origin = {70, 20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Logical.GreaterThreshold torqueLimitHigh(threshold = jointParams.limit.effort) annotation (
    Placement(transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Logical.LessThreshold torqueLimitLow(threshold = -jointParams.limit.effort) annotation (
    Placement(transformation(origin = {70, -20}, extent = {{-10, -10}, {10, 10}})));
equation
  assert(not posLimitHigh.y, "Joint position over high limit", AssertionLevel.warning);
  assert(not posLimitLow.y, "Joint position over low limit", AssertionLevel.warning);
  assert(not speedLimitHigh.y, "Joint speed over high limit", AssertionLevel.warning);
  assert(not speedLimitLow.y, "Joint speed over low limit", AssertionLevel.warning);
  assert(not torqueLimitHigh.y, "Joint torque over high limit", AssertionLevel.warning);
  assert(not torqueLimitLow.y, "Joint torque over low limit", AssertionLevel.warning);
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
  connect(angleSensor.phi, posLimitHigh.u) annotation (
    Line(points = {{41, 50}, {50, 50}, {50, 80}, {58, 80}}, color = {0, 0, 127}));
  connect(angleSensor.phi, posLimitLow.u) annotation (
    Line(points = {{41, 50}, {50, 50}, {50, 60}, {58, 60}}, color = {0, 0, 127}));
  connect(speedSensor.w, speedLimitHigh.u) annotation (
    Line(points = {{41, 30}, {50, 30}, {50, 40}, {58, 40}}, color = {0, 0, 127}));
  connect(speedSensor.w, speedLimitLow.u) annotation (
    Line(points = {{41, 30}, {50, 30}, {50, 20}, {58, 20}}, color = {0, 0, 127}));
  connect(torqueSensor.tau, torqueLimitHigh.u) annotation (
    Line(points = {{21, 0}, {58, 0}}, color = {0, 0, 127}));
  connect(torqueSensor.tau, torqueLimitLow.u) annotation (
    Line(points = {{21, 0}, {20, 0}, {20, -20}, {58, -20}}, color = {0, 0, 127}));
  connect(revolute.frame_b, frame_b) annotation (
    Line(points = {{20, -40}, {100, -40}, {100, 0}}, color = {95, 95, 95}));
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
end Shoulder_lift_joint;
