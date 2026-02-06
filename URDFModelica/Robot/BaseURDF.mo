within URDFModelica.Robot;
model BaseURDF
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialOneFrame_a;

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

  Modelica.Mechanics.Rotational.Interfaces.Flange_b rotational_flange_b[numRotationalJoints] if numRotationalJoints > 0
    annotation (Placement(transformation(extent = {{-100, 90}, {-80, 110}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a rotational_flange_a[numRotationalJoints] if numRotationalJoints > 0
    annotation (Placement(transformation(extent = {{-50, 90}, {-30, 110}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b translational_flange_b[numTranslationalJoints] if numTranslationalJoints > 0
    annotation (Placement(transformation(extent = {{30, 90}, {50, 110}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_a translational_flange_a[numTranslationalJoints] if numTranslationalJoints > 0
    annotation (Placement(transformation(extent = {{80, 90}, {100, 110}})));

  annotation (preferredView = "diagram",
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})));
end BaseURDF;
