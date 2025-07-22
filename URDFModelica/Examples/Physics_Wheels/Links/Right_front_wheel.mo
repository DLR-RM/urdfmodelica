within URDFModelica.Examples.Physics_Wheels.Links;
model Right_front_wheel
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialOneFrame_a;
  parameter Right_front_wheelParams linkParams annotation (Placement(transformation(extent = {{-100, 80}, {-80, 100}})));
  parameter Boolean enableCollision = true;
  parameter Boolean enableInertial = true;
  Modelica.Mechanics.MultiBody.Parts.FixedRotation trafoInertial(
    r = linkParams.inertial.origin.xyz,
    rotationType = Modelica.Mechanics.MultiBody.Types.RotationTypes.PlanarRotationSequence,
    sequence = {3, 2, 1},
    angles = Modelica.Units.Conversions.to_deg({linkParams.inertial.origin.rpy[3], linkParams.inertial.origin.rpy[2], linkParams.inertial.origin.rpy[1]}), animation = false)                   annotation (
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
  Modelica.Mechanics.MultiBody.Visualizers.FixedShape visualCylinder(shapeType = "cylinder", length = linkParams.visual.geometry.length, width = 2*linkParams.visual.geometry.radius, height = 2*linkParams.visual.geometry.radius, lengthDirection = {0, 0, -1}, r_shape = {0, 0, linkParams.visual.geometry.length/2}, color = integer(linkParams.visual.material.rgba[1:3]*255)) if linkParams.hasVisual and linkParams.visual.geometry.geometryType == URDFModelica.Types.GeometryType.cylinder annotation (
    Placement(transformation(origin = {0, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Visualizers.FixedShape collisionCylinder(shapeType = "cylinder", length = linkParams.collision.geometry.length, width = 2*linkParams.collision.geometry.radius, height = 2*linkParams.collision.geometry.radius, lengthDirection = {0, 0, -1}, r_shape = {0, 0, linkParams.collision.geometry.length/2}, color = {255, 0, 255}) if linkParams.hasCollision and linkParams.collision.geometry.geometryType == URDFModelica.Types.GeometryType.cylinder and enableCollision annotation (
    Placement(transformation(origin = {0, -30}, extent = {{-10, -10}, {10, 10}})));
  URDFModelica.Links.CollisionCylinder collisionCylinder1(radius = linkParams.collision.geometry.radius, height = linkParams.collision.geometry.length) annotation (Placement(transformation(extent = {{-10, -60}, {10, -40}})));
  Modelica.Mechanics.MultiBody.Parts.Fixed fixed annotation (Placement(transformation(extent = {{60, -60}, {40, -40}})));
equation
  connect(frame_a, trafoVisual.frame_a) annotation (
    Line(points = {{-100, 0}, {-80, 0}, {-80, 30}, {-70, 30}}));
  connect(frame_a, trafoInertial.frame_a) annotation (
    Line(points = {{-100, 0}, {-70, 0}}));
  connect(frame_a, trafoCollision.frame_a) annotation (
    Line(points = {{-100, 0}, {-80, 0}, {-80, -30}, {-70, -30}}));
  connect(trafoInertial.frame_b, body.frame_a) annotation (
    Line(points = {{-50, 0}, {-20, 0}}, color = {95, 95, 95}));
  connect(trafoVisual.frame_b, visualCylinder.frame_a) annotation (
    Line(points = {{-50, 30}, {-10, 30}}, color = {95, 95, 95}));
  connect(trafoCollision.frame_b, collisionCylinder.frame_a) annotation (
    Line(points = {{-50, -30}, {-10, -30}},  color = {95, 95, 95}));
  connect(collisionCylinder.frame_a, collisionCylinder1.frame_a) annotation (
    Line(points = {{-10, -30}, {-10, -50}}, color = {95, 95, 95}));
  connect(collisionCylinder1.frame_b, fixed.frame_b) annotation (
    Line(points = {{10, -50}, {40, -50}}, color = {95, 95, 95}));
  annotation (Icon(coordinateSystem(
        preserveAspectRatio = true,
        extent = {{-100, -100}, {100, 100}}), graphics={
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
end Right_front_wheel;
