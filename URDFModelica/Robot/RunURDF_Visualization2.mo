within URDFModelica.Robot;
model RunURDF_Visualization2
  extends Modelica.Icons.Example;

  parameter Integer numCollisionLinks = 0;
  parameter Integer numNonCollisionLinks = 0;
  final parameter Integer numLinks = numCollisionLinks + numNonCollisionLinks;
  parameter Integer numLeafLinks = 0;
  parameter Integer numRotationalJoints = 0;
  parameter Integer numTranslationalJoints = 0;
  parameter Integer numOtherJoints = 0;
  final parameter Integer numJoints = numRotationalJoints + numTranslationalJoints + numOtherJoints;
  parameter Boolean enableCollision = true;
  parameter Boolean overwriteColor = true "Visualization2 overwrite color of meshes with color from URDF source";

  inner Modelica.Mechanics.MultiBody.World world(enableAnimation = false, label2 = "z", n = {0, 0, -1}, animateWorld = false, animateGravity = false)
    annotation (Placement(transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sources.Position rotationalPosition[numRotationalJoints](each useSupport = true) if numRotationalJoints > 0
    annotation (Placement(transformation(origin = {-70, 10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Sources.Position[numTranslationalJoints] translationalPosition(each useSupport = true) if numTranslationalJoints > 0
    annotation (Placement(transformation(origin = {-70, 50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.RealInput rotationalPositionInput[numRotationalJoints] if numRotationalJoints > 0
    annotation (Placement(transformation(origin = {-120, 10}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 20}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Blocks.Interfaces.RealInput translationalPositionInput[numTranslationalJoints] if numTranslationalJoints > 0
    annotation (Placement(transformation(origin = {-120, 50}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}})));
  Visualization2.Shapes.Primitives.Plane plane(length = 100, width = 100, iconColor = {0, 128, 255})
    annotation (Placement(transformation(origin = {-10, 90}, extent = {{-10, -10}, {10, 10}})));
  inner Visualization2.VisualizationSetup visualizationSetup annotation (Placement(transformation(extent = {{80, 80}, {100, 100}})));
  URDFModelica.Links.CollisionPoint collisionPoint[numLeafLinks] annotation (
    Placement(transformation(origin = {50, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.Fixed[numLeafLinks] fixed annotation (
    Placement(transformation(origin = {90, -40}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
equation
  connect(translationalPositionInput, translationalPosition.s_ref) annotation (
    Line(points = {{-120, 50}, {-82, 50}}, color = {0, 0, 127}));
  connect(rotationalPositionInput, rotationalPosition.phi_ref) annotation (
    Line(points = {{-120, 10}, {-82, 10}}, color = {0, 0, 127}));
  connect(world.frame_b, plane.frame_a) annotation (
    Line(points = {{-80, 90}, {-20, 90}}, color = {95, 95, 95}));
  connect(collisionPoint.frame_b, fixed.frame_b) annotation (
    Line(points = {{60, -40}, {80, -40}}, color = {95, 95, 95}));
  annotation (preferredView = "diagram");
end RunURDF_Visualization2;
