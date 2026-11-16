within URDFModelica_Tutorial.Joints;
model Planar
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
  replaceable parameter URDFModelica_Tutorial.Records.Joint jointParams
    constrainedby URDFModelica_Tutorial.Records.Joint annotation (Placement(transformation(extent = {{-100, 80}, {-80, 100}})), choicesAllMatching = true);
  Modelica.Mechanics.MultiBody.Parts.FixedRotation fixedRotation(r = jointParams.origin.xyz, rotationType = Modelica.Mechanics.MultiBody.Types.RotationTypes.PlanarRotationSequence, sequence = {3, 2, 1}, angles = Modelica.Units.Conversions.to_deg({jointParams.origin.rpy[3], jointParams.origin.rpy[2], jointParams.origin.rpy[1]}), animation = false) annotation (
    Placement(transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Joints.Planar planar(n = jointParams.axis.xyz, n_x = n_to_nx(jointParams.axis.xyz), animation = false) annotation (
    Placement(transformation(origin = {10, 0}, extent = {{-10, -10}, {10, 10}})));

protected
  function n_to_nx
    input Real n[3] = {0.0, 0.0, 1.0} "Planar joint axis orthogonal vector";
    output Real nx[3] "Planar joint x axis in plane vector";
  algorithm
    nx := zeros(3);
    if n[1] > 0.001 then
      nx[2] := n[1];
      nx[1] := -n[2];
    elseif n[2] > 0.001 then
      nx[3] := n[2];
      nx[2] := -n[3];
    else
      nx[1] := n[3];
      nx[3] := -n[1];
    end if;
  end n_to_nx;

equation
  connect(frame_a, fixedRotation.frame_a) annotation (
    Line(points = {{-100, 0}, {-80, 0}}));
  connect(planar.frame_b, frame_b) annotation (
    Line(points = {{20, 0}, {100, 0}}, color = {95, 95, 95}));
  connect(fixedRotation.frame_b, planar.frame_a) annotation (
    Line(points = {{-60, 0}, {0, 0}}, color = {95, 95, 95}));
  annotation (Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100}, {100, 100}}), graphics = {
        Rectangle(
          fillColor = {39, 150, 249},
          pattern = LinePattern.None,
          fillPattern = FillPattern.Solid,
          extent = {{-30, -60}, {-10, 60}}),
        Rectangle(
          fillColor = {39, 150, 249},
          pattern = LinePattern.None,
          fillPattern = FillPattern.Solid,
          extent = {{10, -60}, {30, 60}}),
        Rectangle(
          fillColor = {39, 150, 249},
          pattern = LinePattern.None,
          fillPattern = FillPattern.Solid,
          extent = {{-100, -10}, {-30, 10}}),
        Rectangle(
          fillColor = {39, 150, 249},
          pattern = LinePattern.None,
          fillPattern = FillPattern.Solid,
          extent = {{100, -10}, {30, 10}}),
        Text(
          extent = {{-150, 70}, {150, 110}},
          textString = "%name",
          textColor = {0, 0, 255}),
        Text(
          extent = {{-150, -100}, {150, -70}},
          textString = "n=%jointParams.axis.xyz")}),
      preferredView = "diagram");
end Planar;
