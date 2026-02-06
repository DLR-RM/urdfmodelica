within URDFModelica.Examples_Visualization2.Ur10e_robot;
model Ur10e_robotRun
  extends Modelica.Icons.Example;

  parameter Integer numCollisionLinks = 7;
  parameter Integer numNonCollisionLinks = 4;
  final parameter Integer numLinks = numCollisionLinks + numNonCollisionLinks;
  parameter Integer numLeafLinks = 2;
  parameter Integer numRotationalJoints = 6;
  parameter Integer numTranslationalJoints = 0;
  parameter Integer numOtherJoints = 4;
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
  Ur10e_robot ur10e_robot(enableCollision = enableCollision, overwriteColor = overwriteColor) annotation (Placement(transformation(extent = {{-20, -60}, {20, -20}})));

equation
  connect(ur10e_robot.frame_a, world.frame_b) annotation (Line(points = {{-20, -40}, {-30, -40}, {-30, 90}, {-80, 90}}, color = {95, 95, 95}));
  connect(rotationalPosition[1].flange, ur10e_robot.rotational_flange_a[1]) annotation (Line(points = {{-60, 10}, {-8, 10}, {-8, -20}}, color = {0, 0, 0}));
  connect(rotationalPosition[1].support, ur10e_robot.rotational_flange_b[1]) annotation (Line(points = {{-70, 0}, {-18, 0}, {-18, -20}}, color = {0, 0, 0}));
  connect(rotationalPosition[2].flange, ur10e_robot.rotational_flange_a[2]) annotation (Line(points = {{-60, 10}, {-8, 10}, {-8, -20}}, color = {0, 0, 0}));
  connect(rotationalPosition[2].support, ur10e_robot.rotational_flange_b[2]) annotation (Line(points = {{-70, 0}, {-18, 0}, {-18, -20}}, color = {0, 0, 0}));
  connect(rotationalPosition[3].flange, ur10e_robot.rotational_flange_a[3]) annotation (Line(points = {{-60, 10}, {-8, 10}, {-8, -20}}, color = {0, 0, 0}));
  connect(rotationalPosition[3].support, ur10e_robot.rotational_flange_b[3]) annotation (Line(points = {{-70, 0}, {-18, 0}, {-18, -20}}, color = {0, 0, 0}));
  connect(rotationalPosition[4].flange, ur10e_robot.rotational_flange_a[4]) annotation (Line(points = {{-60, 10}, {-8, 10}, {-8, -20}}, color = {0, 0, 0}));
  connect(rotationalPosition[4].support, ur10e_robot.rotational_flange_b[4]) annotation (Line(points = {{-70, 0}, {-18, 0}, {-18, -20}}, color = {0, 0, 0}));
  connect(rotationalPosition[5].flange, ur10e_robot.rotational_flange_a[5]) annotation (Line(points = {{-60, 10}, {-8, 10}, {-8, -20}}, color = {0, 0, 0}));
  connect(rotationalPosition[5].support, ur10e_robot.rotational_flange_b[5]) annotation (Line(points = {{-70, 0}, {-18, 0}, {-18, -20}}, color = {0, 0, 0}));
  connect(rotationalPosition[6].flange, ur10e_robot.rotational_flange_a[6]) annotation (Line(points = {{-60, 10}, {-8, 10}, {-8, -20}}, color = {0, 0, 0}));
  connect(rotationalPosition[6].support, ur10e_robot.rotational_flange_b[6]) annotation (Line(points = {{-70, 0}, {-18, 0}, {-18, -20}}, color = {0, 0, 0}));
  connect(translationalPositionInput, translationalPosition.s_ref) annotation (
    Line(points = {{-120, 50}, {-82, 50}}, color = {0, 0, 127}));
  connect(rotationalPositionInput, rotationalPosition.phi_ref) annotation (
    Line(points = {{-120, 10}, {-82, 10}}, color = {0, 0, 127}));
  connect(world.frame_b, plane.frame_a) annotation (
    Line(points = {{-80, 90}, {-20, 90}}, color = {95, 95, 95}));
  annotation (preferredView = "diagram");
end Ur10e_robotRun;
