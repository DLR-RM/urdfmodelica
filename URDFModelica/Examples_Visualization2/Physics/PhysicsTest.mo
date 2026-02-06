within URDFModelica.Examples_Visualization2.Physics;
model PhysicsTest
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
  parameter Boolean overwriteColor = true "Visualization2 overwrite color of meshes with color from URDF source";

  Modelica.Blocks.Sources.KinematicPTP2 rotationalPTP(q_begin = zeros(numRotationalJoints), q_end = ones(numRotationalJoints), qd_max = 0.1*ones(numRotationalJoints), qdd_max = 0.01*ones(numRotationalJoints), startTime = 1.0) if numRotationalJoints > 0
    annotation (Placement(transformation(origin = {-50, -20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.KinematicPTP2 translationalPTP(q_begin = zeros(numTranslationalJoints), q_end = ones(numTranslationalJoints), qd_max = 0.1*ones(numTranslationalJoints), qdd_max = 0.01*ones(numTranslationalJoints), startTime = 1.0) if numTranslationalJoints > 0
    annotation (Placement(transformation(origin = {-50, 40}, extent = {{-10, -10}, {10, 10}})));
  PhysicsRun physicsRun(enableCollision = enableCollision, overwriteColor = overwriteColor) annotation (Placement(transformation(extent = {{-10, -10}, {10, 10}})));

equation
  connect(rotationalPTP.q, physicsRun.rotationalPositionInput) annotation (Line(points = {{-39, -12}, {-20, -12}, {-20, 2}, {-12, 2}}, color = {0, 0, 127}));
  connect(translationalPTP.q, physicsRun.translationalPositionInput) annotation (Line(points = {{-39, 48}, {-20, 48}, {-20, 6}, {-12, 6}}, color = {0, 0, 127}));

  annotation (
    experiment(StartTime = 0.0, StopTime = 25.0, Tolerance = 1e-06, Interval = 0.05), preferredView = "diagram");
end PhysicsTest;
