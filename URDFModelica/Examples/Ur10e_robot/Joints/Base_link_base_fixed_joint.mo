within URDFModelica.Examples.Ur10e_robot.Joints;
model Base_link_base_fixed_joint
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
  parameter Base_link_base_fixed_jointParams jointParams annotation (Placement(transformation(extent = {{-100, 80}, {-80, 100}})));
  Modelica.Mechanics.MultiBody.Parts.FixedRotation fixedRotation(r = jointParams.origin.xyz, rotationType = Modelica.Mechanics.MultiBody.Types.RotationTypes.PlanarRotationSequence, sequence = {3, 2, 1}, angles = Modelica.Units.Conversions.to_deg({jointParams.origin.rpy[3], jointParams.origin.rpy[2], jointParams.origin.rpy[1]}), animation = false) annotation (
    Placement(transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(frame_a, fixedRotation.frame_a) annotation (
    Line(points = {{-100, 0}, {-80, 0}}));
  connect(fixedRotation.frame_b, frame_b) annotation (
    Line(points = {{-60, 0}, {100, 0}}, color = {95, 95, 95}));
  annotation (Icon(coordinateSystem(
        preserveAspectRatio = true,
        extent = {{-100, -100}, {100, 100}}), graphics = {
        Rectangle(
          extent = {{-100, 10}, {100, -10}},
          fillPattern = FillPattern.Solid,
          lineColor = {0, 0, 0},
          fillColor = {39, 150, 249}),
        Line(points = {{80, 20}, {129, 50}}),
        Line(points = {{80, 20}, {57, 59}}),
        Polygon(
          points = {{144, 60}, {117, 59}, {132, 37}, {144, 60}},
          fillPattern = FillPattern.Solid),
        Polygon(
          points = {{43, 80}, {46, 50}, {68, 65}, {43, 80}},
          fillPattern = FillPattern.Solid),
        Text(
          extent = {{-150, 80}, {150, 120}},
          textString = "%name",
          textColor = {0, 0, 255})}), preferredView = "diagram");
end Base_link_base_fixed_joint;
