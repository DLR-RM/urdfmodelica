within URDFModelica_Tutorial.Links;
model Link_Visualization2
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialOneFrame_a;
  replaceable parameter URDFModelica_Tutorial.Records.Link linkParams
     constrainedby URDFModelica_Tutorial.Records.Link  annotation (Placement(transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}})));
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
  Visualization2.Shapes.Primitives.Cube visualBox(height = linkParams.visual.geometry.size[3], length = linkParams.visual.geometry.size[1], width = linkParams.visual.geometry.size[2], color = integer(linkParams.visual.material.rgba[1:3]*255), transparency = 1 - linkParams.visual.material.rgba[4]) if linkParams.hasVisual and linkParams.visual.geometry.geometryType == URDFModelica_Tutorial.Types.GeometryType.box annotation (
    Placement(transformation(origin = {-30, 30}, extent = {{-10, -10}, {10, 10}})));
  Visualization2.Shapes.Primitives.Cylinder visualCylinder(n(displayUnit = "1") = {0, 1, 0}, angle = 90, length = linkParams.visual.geometry.length, radius=  linkParams.visual.geometry.radius, color = integer(linkParams.visual.material.rgba[1:3]*255), transparency = 1 - linkParams.visual.material.rgba[4]) if linkParams.hasVisual and linkParams.visual.geometry.geometryType == URDFModelica_Tutorial.Types.GeometryType.cylinder annotation (
    Placement(transformation(origin = {0, 30}, extent = {{-10, -10}, {10, 10}})));
  Visualization2.Shapes.Primitives.Sphere visualSphere(radius = linkParams.visual.geometry.radius, color = integer(linkParams.visual.material.rgba[1:3]*255), transparency = 1 - linkParams.visual.material.rgba[4]) if linkParams.hasVisual and linkParams.visual.geometry.geometryType == URDFModelica_Tutorial.Types.GeometryType.sphere annotation (
    Placement(transformation(origin = {30, 30}, extent = {{-10, -10}, {10, 10}})));
  Visualization2.Shapes.Files.CADFile visualMesh(filename = Modelica.Utilities.Files.loadResource(linkParams.visual.geometry.filename), scale = linkParams.visual.geometry.scale, transparency = 1 - linkParams.visual.material.rgba[4], overwriteColor = true, color = integer(linkParams.visual.material.rgba[1:3]*255)) if linkParams.hasVisual and linkParams.visual.geometry.geometryType == URDFModelica_Tutorial.Types.GeometryType.mesh annotation (
    Placement(transformation(origin = {60, 30}, extent = {{-10, -10}, {10, 10}})));
  Visualization2.Shapes.Primitives.Cube collisionBox(height = linkParams.collision.geometry.size[3], length = linkParams.collision.geometry.size[1], width = linkParams.collision.geometry.size[2], color = {255, 0, 255}, transparency = 0.5) if linkParams.hasCollision and linkParams.collision.geometry.geometryType == URDFModelica_Tutorial.Types.GeometryType.box and enableCollision annotation (
    Placement(transformation(origin = {-30, -30}, extent = {{-10, -10}, {10, 10}})));
  Visualization2.Shapes.Primitives.Cylinder collisionCylinder(n(displayUnit = "1") = {0, 1, 0}, angle = 90, length = linkParams.collision.geometry.length, radius = linkParams.collision.geometry.radius, color = {255, 0, 255}, transparency = 0.5) if linkParams.hasCollision and linkParams.collision.geometry.geometryType == URDFModelica_Tutorial.Types.GeometryType.cylinder and enableCollision annotation (
    Placement(transformation(origin = {0, -30}, extent = {{-10, -10}, {10, 10}})));
  Visualization2.Shapes.Primitives.Sphere collisionSphere(radius = linkParams.collision.geometry.radius, color = {255, 0, 255}, transparency = 0.5) if linkParams.hasCollision and linkParams.collision.geometry.geometryType == URDFModelica_Tutorial.Types.GeometryType.sphere and enableCollision annotation (
    Placement(transformation(origin = {30, -30}, extent = {{-10, -10}, {10, 10}})));
  Visualization2.Shapes.Files.CADFile collisionMesh(filename = Modelica.Utilities.Files.loadResource(linkParams.collision.geometry.filename), scale = linkParams.collision.geometry.scale, transparency = 0.5, overwriteColor = true, color = {255, 0, 255}) if linkParams.hasCollision and linkParams.collision.geometry.geometryType == URDFModelica_Tutorial.Types.GeometryType.mesh and enableCollision annotation (
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
end Link_Visualization2;
