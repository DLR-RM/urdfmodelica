within URDFModelica.Links;
model Link
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialOneFrame_a;
  replaceable parameter URDFModelica.Records.Link linkParams
     constrainedby URDFModelica.Records.Link  annotation (Placement(transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}})));
  parameter Boolean enableCollision = true;
  parameter Boolean enableInertial = true;
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
  Modelica.Mechanics.MultiBody.Visualizers.FixedShape visualBox(height = linkParams.visual.geometry.size[3], length = linkParams.visual.geometry.size[1], r_shape = {-linkParams.visual.geometry.size[1]/2, 0, 0}, shapeType = "box", width = linkParams.visual.geometry.size[2], color = integer(linkParams.visual.material.rgba[1:3]*255)) if linkParams.hasVisual and linkParams.visual.geometry.geometryType == URDFModelica.Types.GeometryType.box annotation (
    Placement(transformation(origin = {-30, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Visualizers.FixedShape visualCylinder(shapeType = "cylinder", length = linkParams.visual.geometry.length, width = 2*linkParams.visual.geometry.radius, height = 2*linkParams.visual.geometry.radius, lengthDirection = {0, 0, -1}, r_shape = {0, 0, linkParams.visual.geometry.length/2}, color = integer(linkParams.visual.material.rgba[1:3]*255)) if linkParams.hasVisual and linkParams.visual.geometry.geometryType == URDFModelica.Types.GeometryType.cylinder annotation (
    Placement(transformation(origin = {0, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Visualizers.FixedShape visualSphere(height = 2*linkParams.visual.geometry.radius, length = 2*linkParams.visual.geometry.radius, shapeType = "sphere", width = 2*linkParams.visual.geometry.radius, r_shape = {-linkParams.visual.geometry.radius, 0, 0}, color = integer(linkParams.visual.material.rgba[1:3]*255)) if linkParams.hasVisual and linkParams.visual.geometry.geometryType == URDFModelica.Types.GeometryType.sphere annotation (
    Placement(transformation(origin = {30, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Visualizers.FixedShape visualMesh(color = integer(linkParams.visual.material.rgba[1:3]*255), height = 0, shapeType = linkParams.visual.geometry.filename, width = 0, length = 0) if linkParams.hasVisual and linkParams.visual.geometry.geometryType == URDFModelica.Types.GeometryType.mesh annotation (
    Placement(transformation(origin = {60, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Visualizers.FixedShape collisionBox(height = linkParams.collision.geometry.size[3], length = linkParams.collision.geometry.size[1], r_shape = {-linkParams.collision.geometry.size[1]/2, 0, 0}, shapeType = "box", width = linkParams.collision.geometry.size[2], color = {255, 0, 255}) if linkParams.hasCollision and linkParams.collision.geometry.geometryType == URDFModelica.Types.GeometryType.box and enableCollision annotation (
    Placement(transformation(origin = {-30, -30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Visualizers.FixedShape collisionCylinder(shapeType = "cylinder", length = linkParams.collision.geometry.length, width = 2*linkParams.collision.geometry.radius, height = 2*linkParams.collision.geometry.radius, lengthDirection = {0, 0, -1}, r_shape = {0, 0, linkParams.collision.geometry.length/2}, color = {255, 0, 255}) if linkParams.hasCollision and linkParams.collision.geometry.geometryType == URDFModelica.Types.GeometryType.cylinder and enableCollision annotation (
    Placement(transformation(origin = {0, -30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Visualizers.FixedShape collisionSphere(height = 2*linkParams.collision.geometry.radius, length = 2*linkParams.collision.geometry.radius, shapeType = "sphere", width = 2*linkParams.collision.geometry.radius, r_shape = {-linkParams.collision.geometry.radius, 0, 0}, color = {255, 0, 255}) if linkParams.hasCollision and linkParams.collision.geometry.geometryType == URDFModelica.Types.GeometryType.sphere and enableCollision annotation (
    Placement(transformation(origin = {30, -30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Visualizers.FixedShape collisionMesh(color = {255, 0, 255}, height = 0, shapeType = linkParams.collision.geometry.filename, width = 0, length = 0) if linkParams.hasCollision and linkParams.collision.geometry.geometryType == URDFModelica.Types.GeometryType.mesh and enableCollision annotation (
    Placement(transformation(origin = {60, -30}, extent = {{-10, -10}, {10, 10}})));
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
  connect(trafoVisual.frame_b, visualCylinder.frame_a) annotation (
    Line(points = {{-50, 30}, {-10, 30}}, color = {95, 95, 95}));
  connect(trafoVisual.frame_b, visualSphere.frame_a) annotation (
    Line(points = {{-50, 30}, {20, 30}}, color = {95, 95, 95}));
  connect(trafoVisual.frame_b, visualMesh.frame_a) annotation (
    Line(points = {{-50, 30}, {50, 30}}, color = {95, 95, 95}));
  connect(trafoCollision.frame_b, collisionBox.frame_a) annotation (
    Line(points = {{-50, -30}, { -40, -30}}, color = {95, 95, 95}));
  connect(trafoCollision.frame_b, collisionCylinder.frame_a) annotation (
    Line(points = {{-50, -30}, {-10, -30}},  color = {95, 95, 95}));
  connect(trafoCollision.frame_b, collisionSphere.frame_a) annotation (
    Line(points = {{-50, -30}, {20, -30}}, color = {95, 95, 95}));
  connect(trafoCollision.frame_b, collisionMesh.frame_a) annotation (
    Line(points = {{-50, -30}, {50, -30}}, color = {95, 95, 95}));
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
end Link;
