within URDFModelica.Examples.Physics_Wheels.Joints;
model Right_back_wheel_joint
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
  parameter Right_back_wheel_jointParams jointParams annotation (Placement(transformation(extent = {{-100, 80}, {-80, 100}})));
  parameter Integer flangeIndex = 0;
  Modelica.Mechanics.MultiBody.Parts.FixedRotation fixedRotation(angles = Modelica.Units.Conversions.to_deg({jointParams.origin.rpy[3], jointParams.origin.rpy[2], jointParams.origin.rpy[1]}), r = jointParams.origin.xyz, rotationType = Modelica.Mechanics.MultiBody.Types.RotationTypes.PlanarRotationSequence, sequence = {3, 2, 1}, animation = false) annotation (
    Placement(transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute(useAxisFlange = true, n = jointParams.axis.xyz, animation = false) annotation (
    Placement(transformation(origin = {10, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b annotation (
    Placement(transformation(origin = {-50, 100}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-50, 100}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a annotation (
    Placement(transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(frame_a, fixedRotation.frame_a) annotation (
    Line(points = {{-100, 0}, {-80, 0}}));
  connect(revolute.frame_b, frame_b) annotation (
    Line(points = {{20, 0}, {100, 0}}, color = {95, 95, 95}));
  connect(fixedRotation.frame_b, revolute.frame_a) annotation (
    Line(points = {{-60, 0}, {0, 0}}, color = {95, 95, 95}));
  connect(revolute.support, flange_b) annotation (
    Line(points = {{4, 10}, {-50, 10}, {-50, 100}}));
  connect(revolute.axis, flange_a) annotation (
    Line(points = {{10, 10}, {10, 100}, {0, 100}}));
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
          extent = {{30, -60},{ 100, 60}},
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
          extent = {{-150, -135}, {150, -95}},
          textString = "%name",
          textColor = {0, 0, 255}),
        Text(
          extent = {{-150, -100}, {150, -70}},
          textString = "n = %jointParams.axis.xyz"),
        Text(
          origin = {0, -10},
          textColor = {95, 95, 95},
          extent = {{-100, 100}, {100, 40}},
          textString = "%flangeIndex",
          visible = flangeIndex > 0)}), preferredView = "diagram");
end Right_back_wheel_joint;
