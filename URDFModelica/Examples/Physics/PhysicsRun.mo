within URDFModelica.Examples.Physics;
model PhysicsRun
  extends Modelica.Icons.Example;

  parameter Integer numCollisionLinks = 16;
  parameter Integer numNonCollisionLinks = 0;
  final parameter Integer numLinks = numCollisionLinks + numNonCollisionLinks;
  parameter Integer numLeafLinks = 7;
  parameter Integer numRotationalJoints = 7;
  parameter Integer numTranslationalJoints = 1;
  parameter Integer numOtherJoints = 7;
  final parameter Integer numJoints = numRotationalJoints + numTranslationalJoints + numOtherJoints;
  parameter Boolean enableCollision = true;

  inner Modelica.Mechanics.MultiBody.World world(enableAnimation = true, label2 = "z", n = {0, 0, -1}, animateWorld = false, animateGravity = false)
    annotation (Placement(transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sources.Position rotationalPosition[numRotationalJoints](each useSupport = true) if numRotationalJoints > 0
    annotation (Placement(transformation(origin = {-70, 10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Sources.Position[numTranslationalJoints] translationalPosition(each useSupport = true) if numTranslationalJoints > 0
    annotation (Placement(transformation(origin = {-70, 50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.RealInput rotationalPositionInput[numRotationalJoints] if numRotationalJoints > 0
    annotation (Placement(transformation(origin = {-120, 10}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 20}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Blocks.Interfaces.RealInput translationalPositionInput[numTranslationalJoints] if numTranslationalJoints > 0
    annotation (Placement(transformation(origin = {-120, 50}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Mechanics.MultiBody.Visualizers.Rectangle plane(length_u = 100, length_v = 100)  annotation(
    Placement(transformation(origin = {-10, 90}, extent = {{-10, -10}, {10, 10}})));
  URDFModelica.Links.CollisionPoint collisionPoint[numLeafLinks] annotation(
    Placement(transformation(origin = {50, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Parts.Fixed[numLeafLinks] fixed annotation(
    Placement(transformation(origin = {90, -40}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Physics physics(enableCollision = enableCollision) annotation (Placement(transformation(extent = {{-20, -60}, {20, -20}})));
  Modelica.Mechanics.MultiBody.Joints.FreeMotion freeMotion(r_rel_a(start = {0.0, 0.0, 1.0}), angles_start = {0.0, 0.0, 0.0}) annotation (Placement(transformation(extent = {{-60, 80}, {-40, 100}})));

equation
  connect(physics.frame_a, freeMotion.frame_b) annotation (Line(points = {{-20, -40}, {-30, -40}, {-30, 90}, {-40, 90}}, color = {95, 95, 95}));
  connect(world.frame_b, freeMotion.frame_a) annotation (Line(points = {{-80, 90}, {-60, 90}}, color = {95, 95, 95}));
  connect(physics.frame_b, collisionPoint.frame_a) annotation (Line(points = {{20, -40}, {40, -40}}, color = {95, 95, 95}));
  connect(rotationalPosition[1].flange, physics.rotational_flange_a[1]) annotation (Line(points = {{-60, 10}, {-8, 10}, {-8, -20}}, color = {0, 0, 0}));
  connect(rotationalPosition[1].support, physics.rotational_flange_b[1]) annotation (Line(points = {{-70, 0}, {-18, 0}, {-18, -20}}, color = {0, 0, 0}));
  connect(rotationalPosition[2].flange, physics.rotational_flange_a[2]) annotation (Line(points = {{-60, 10}, {-8, 10}, {-8, -20}}, color = {0, 0, 0}));
  connect(rotationalPosition[2].support, physics.rotational_flange_b[2]) annotation (Line(points = {{-70, 0}, {-18, 0}, {-18, -20}}, color = {0, 0, 0}));
  connect(rotationalPosition[3].flange, physics.rotational_flange_a[3]) annotation (Line(points = {{-60, 10}, {-8, 10}, {-8, -20}}, color = {0, 0, 0}));
  connect(rotationalPosition[3].support, physics.rotational_flange_b[3]) annotation (Line(points = {{-70, 0}, {-18, 0}, {-18, -20}}, color = {0, 0, 0}));
  connect(rotationalPosition[4].flange, physics.rotational_flange_a[4]) annotation (Line(points = {{-60, 10}, {-8, 10}, {-8, -20}}, color = {0, 0, 0}));
  connect(rotationalPosition[4].support, physics.rotational_flange_b[4]) annotation (Line(points = {{-70, 0}, {-18, 0}, {-18, -20}}, color = {0, 0, 0}));
  connect(translationalPosition[1].flange, physics.translational_flange_a[1]) annotation (Line(points = {{-60, 50}, {18, 50}, {18, -20}}, color = {0, 127, 0}));
  connect(translationalPosition[1].support, physics.translational_flange_b[1]) annotation (Line(points = {{-70, 40}, {8, 40}, {8, -20}}, color = {0, 127, 0}));
  connect(rotationalPosition[5].flange, physics.rotational_flange_a[5]) annotation (Line(points = {{-60, 10}, {-8, 10}, {-8, -20}}, color = {0, 0, 0}));
  connect(rotationalPosition[5].support, physics.rotational_flange_b[5]) annotation (Line(points = {{-70, 0}, {-18, 0}, {-18, -20}}, color = {0, 0, 0}));
  connect(rotationalPosition[6].flange, physics.rotational_flange_a[6]) annotation (Line(points = {{-60, 10}, {-8, 10}, {-8, -20}}, color = {0, 0, 0}));
  connect(rotationalPosition[6].support, physics.rotational_flange_b[6]) annotation (Line(points = {{-70, 0}, {-18, 0}, {-18, -20}}, color = {0, 0, 0}));
  connect(rotationalPosition[7].flange, physics.rotational_flange_a[7]) annotation (Line(points = {{-60, 10}, {-8, 10}, {-8, -20}}, color = {0, 0, 0}));
  connect(rotationalPosition[7].support, physics.rotational_flange_b[7]) annotation (Line(points = {{-70, 0}, {-18, 0}, {-18, -20}}, color = {0, 0, 0}));
  connect(translationalPositionInput, translationalPosition.s_ref) annotation (
    Line(points = {{-120, 50}, {-82, 50}}, color = {0, 0, 127}));
  connect(rotationalPositionInput, rotationalPosition.phi_ref) annotation (
    Line(points = {{-120, 10}, {-82, 10}}, color = {0, 0, 127}));
  connect(world.frame_b, plane.frame_a) annotation (
    Line(points = {{-80, 90}, {-20, 90}}, color = {95, 95, 95}));
  connect(collisionPoint.frame_b, fixed.frame_b) annotation(
    Line(points = {{60, -40}, {80, -40}}, color = {95, 95, 95}));
  annotation (preferredView = "diagram");
end PhysicsRun;
