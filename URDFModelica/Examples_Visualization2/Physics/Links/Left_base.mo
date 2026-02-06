within URDFModelica.Examples_Visualization2.Physics.Links;
model Left_base
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialOneFrame_a;
  parameter Left_baseParams linkParams annotation (Placement(transformation(extent = {{-100, 80}, {-80, 100}})));
  parameter Boolean enableCollision = true;
  parameter Boolean enableInertial = true;
  parameter Boolean overwriteColor = true "Visualization2 overwrite color of meshes with color from URDF source";
  Modelica.Mechanics.MultiBody.Parts.FixedRotation trafoInertial(
    r = linkParams.inertial.origin.xyz,
    rotationType = Modelica.Mechanics.MultiBody.Types.RotationTypes.PlanarRotationSequence,
    sequence = {3, 2, 1},
    angles = Modelica.Units.Conversions.to_deg({linkParams.inertial.origin.rpy[3], linkParams.inertial.origin.rpy[2], linkParams.inertial.origin.rpy[1]}), animation = false) annotation (
    Placement(transformation(extent = {{-70, -10}, {-50, 10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedRotation trafoVisual(
    r = linkParams.visual.origin.xyz,
    rotationType = Modelica.Mechanics.MultiBody.Types.RotationTypes.PlanarRotationSequence,
    sequence = {3, 2, 1},
    angles = Modelica.Units.Conversions.to_deg({linkParams.visual.origin.rpy[3], linkParams.visual.origin.rpy[2], linkParams.visual.origin.rpy[1]}), animation = false) if linkParams.hasVisual annotation (
    Placement(transformation(extent = {{-70, 20}, {-50, 40}})));
  Modelica.Mechanics.MultiBody.Parts.FixedRotation trafoCollision(
    r = linkParams.collision.origin.xyz,
    rotationType = Modelica.Mechanics.MultiBody.Types.RotationTypes.PlanarRotationSequence,
    sequence = {3, 2, 1},
    angles = Modelica.Units.Conversions.to_deg({linkParams.collision.origin.rpy[3], linkParams.collision.origin.rpy[2], linkParams.collision.origin.rpy[1]}), animation = false) if linkParams.hasCollision and enableCollision annotation (
    Placement(transformation(extent = {{-70, -40}, {-50, -20}})));
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
  Visualization2.Shapes.Primitives.Cube visualBox(height = linkParams.visual.geometry.size[3], length = linkParams.visual.geometry.size[1], width = linkParams.visual.geometry.size[2], color = integer(linkParams.visual.material.rgba[1:3]*255), transparency = 1 - linkParams.visual.material.rgba[4]) if linkParams.hasVisual and linkParams.visual.geometry.geometryType == URDFModelica.Types.GeometryType.box annotation (
    Placement(transformation(origin = {-30, 30}, extent = {{-10, -10}, {10, 10}})));
  Visualization2.Shapes.Primitives.Cube collisionBox(height = linkParams.collision.geometry.size[3], length = linkParams.collision.geometry.size[1], width = linkParams.collision.geometry.size[2], color = {255, 0, 255}, transparency = 0.5) if linkParams.hasCollision and linkParams.collision.geometry.geometryType == URDFModelica.Types.GeometryType.box and enableCollision annotation (
    Placement(transformation(origin = {-30, -30}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(frame_a, trafoVisual.frame_a) annotation (
    Line(points = {{-100, 0}, {-80, 0}, {-80, 30}, {-70, 30}}));
  connect(frame_a, trafoInertial.frame_a) annotation (
    Line(points = {{-100, 0}, {-70, 0}}));
  connect(frame_a, trafoCollision.frame_a) annotation (
    Line(points = {{-100, 0}, {-80, 0}, {-80, -30}, {-70, -30}}));
  connect(trafoInertial.frame_b, body.frame_a) annotation (
    Line(points = {{-50, 0}, {-20, 0}}, color = {95, 95, 95}));
  connect(trafoVisual.frame_b, visualBox.frame_a) annotation (
    Line(points = {{-50, 30}, {-40, 30}}, color = {95, 95, 95}));
  connect(trafoCollision.frame_b, collisionBox.frame_a) annotation (
    Line(points = {{-50, -30}, { -40, -30}}, color = {95, 95, 95}));
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
end Left_base;
