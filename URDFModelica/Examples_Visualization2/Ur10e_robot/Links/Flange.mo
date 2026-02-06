within URDFModelica.Examples_Visualization2.Ur10e_robot.Links;
model Flange
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialOneFrame_a;
  parameter FlangeParams linkParams annotation (Placement(transformation(extent = {{-100, 80}, {-80, 100}})));
  parameter Boolean enableCollision = true;
  parameter Boolean enableInertial = true;
  parameter Boolean overwriteColor = true "Visualization2 overwrite color of meshes with color from URDF source";
  Modelica.Mechanics.MultiBody.Parts.FixedRotation trafoInertial(
    r = linkParams.inertial.origin.xyz,
    rotationType = Modelica.Mechanics.MultiBody.Types.RotationTypes.PlanarRotationSequence,
    sequence = {3, 2, 1},
    angles = Modelica.Units.Conversions.to_deg({linkParams.inertial.origin.rpy[3], linkParams.inertial.origin.rpy[2], linkParams.inertial.origin.rpy[1]}), animation = false) annotation (
    Placement(transformation(extent = {{-70, -10}, {-50, 10}})));
  Modelica.Mechanics.MultiBody.Parts.Body body(
    r_CM = {0.0, 0.0, 0.0},
    m = linkParams.inertial.mass,
    I_11 = linkParams.inertial.inertia.ixx,
    I_22 = linkParams.inertial.inertia.iyy,
    I_33 = linkParams.inertial.inertia.izz,
    I_21 = linkParams.inertial.inertia.ixy,
    I_31 = linkParams.inertial.inertia.ixz,
    I_32 = linkParams.inertial.inertia.iyz, animation = false) if enableInertial annotation (
    Placement(transformation(origin = {-10, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(frame_a, trafoInertial.frame_a) annotation (
    Line(points = {{-100, 0}, {-70, 0}}));
  connect(trafoInertial.frame_b, body.frame_a) annotation (
    Line(points = {{-50, 0}, {-20, 0}}, color = {95, 95, 95}));
  annotation (Icon(coordinateSystem(
        preserveAspectRatio = true,
        extent = {{-100, -100}, {100, 100}}), graphics = {
        Rectangle(
          extent = {{-100, 30}, {-3, -30}},
          lineColor = {0, 24, 48},
          fillPattern = FillPattern.HorizontalCylinder,
          fillColor = {39, 139, 0},
          radius = 10),
        Text(
          extent = {{150, -100}, {-150, -70}},
          textString = "m=%linkParams.inertial.mass"),
        Text(
          extent = {{-150, 110}, {150, 70}},
          textString = "%name",
          textColor = {0, 0, 255}),
        Ellipse(
          extent = {{-20, 60}, {100, -60}},
          lineColor = {0, 24, 48},
          fillPattern = FillPattern.Sphere,
          fillColor = {39, 139, 0})}), preferredView = "diagram");
end Flange;
