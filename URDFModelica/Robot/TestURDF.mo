within URDFModelica.Robot;
model TestURDF
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

  Modelica.Blocks.Sources.KinematicPTP2 rotationalPTP(q_begin = zeros(numRotationalJoints), q_end = ones(numRotationalJoints), qd_max = 0.1*ones(numRotationalJoints), qdd_max = 0.01*ones(numRotationalJoints), startTime = 1.0) if numRotationalJoints > 0
    annotation (Placement(transformation(origin = {-50, -20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.KinematicPTP2 translationalPTP(q_begin = zeros(numTranslationalJoints), q_end = ones(numTranslationalJoints), qd_max = 0.1*ones(numTranslationalJoints), qdd_max = 0.01*ones(numTranslationalJoints), startTime = 1.0) if numTranslationalJoints > 0
    annotation (Placement(transformation(origin = {-50, 40}, extent = {{-10, -10}, {10, 10}})));
equation

  annotation (
    experiment(StartTime = 0.0, StopTime = 25.0, Tolerance = 1e-06, Interval = 0.05), preferredView = "diagram");
end TestURDF;
