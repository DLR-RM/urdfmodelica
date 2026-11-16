within URDFModelica_Tutorial.Joints;
model JointLimitCheck "Checks the joint limits and throws warnings or errors."

  extends Modelica.Blocks.Icons.Block;

  parameter AssertionLevel assertionLevel=AssertionLevel.warning "Assertion level (warning or error)";

  parameter Real lower "Lower joint angle limit";
  parameter Real upper "Upper joint angle limit";
  parameter Real velocity "Joint velocity limit";
  parameter Real effort "Joint torque limit";

  Modelica.Blocks.Interfaces.RealInput jointAngle
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput jointVelocity
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput jointTorque
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
equation
  assert(jointAngle >= lower, "Joint position over high limit", assertionLevel);
  assert(jointAngle <= upper, "Joint position over low limit", assertionLevel);
  assert(abs(jointVelocity) <= velocity, "Joint speed over limit", assertionLevel);
  assert(abs(jointTorque) <= effort, "Joint torque over limit", assertionLevel);

  annotation (preferredView = "text",
    Icon(coordinateSystem(preserveAspectRatio = false), graphics = {
      Text(
        extent = {{-80, 80}, {80, -80}},
        textColor = {0, 0, 0},
        textString = "ang>=low?
ang<=upp?
vel<=vlim?
tq<=effort?")}),
    Diagram(coordinateSystem(preserveAspectRatio = false)));
end JointLimitCheck;
