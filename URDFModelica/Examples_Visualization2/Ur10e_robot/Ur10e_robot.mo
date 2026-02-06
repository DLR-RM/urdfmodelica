within URDFModelica.Examples_Visualization2.Ur10e_robot;
model Ur10e_robot
  extends URDFModelica.Icons.StationaryRobotIcon;
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialOneFrame_a;

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

  Modelica.Mechanics.Rotational.Interfaces.Flange_b rotational_flange_b[numRotationalJoints] if numRotationalJoints > 0
    annotation (Placement(transformation(extent = {{-100, 90}, {-80, 110}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a rotational_flange_a[numRotationalJoints] if numRotationalJoints > 0
    annotation (Placement(transformation(extent = {{-50, 90}, {-30, 110}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b translational_flange_b[numTranslationalJoints] if numTranslationalJoints > 0
    annotation (Placement(transformation(extent = {{30, 90}, {50, 110}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_a translational_flange_a[numTranslationalJoints] if numTranslationalJoints > 0
    annotation (Placement(transformation(extent = {{80, 90}, {100, 110}})));

  Links.Base_link base_link(enableCollision = enableCollision, overwriteColor = overwriteColor)
    annotation (Placement(transformation(origin = {-80, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Links.Base_link_inertia base_link_inertia(enableCollision = enableCollision, overwriteColor = overwriteColor)
    annotation (Placement(transformation(origin = {-30, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Links.Shoulder_link shoulder_link(enableCollision = enableCollision, overwriteColor = overwriteColor)
    annotation (Placement(transformation(origin = {20, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Links.Upper_arm_link upper_arm_link(enableCollision = enableCollision, overwriteColor = overwriteColor)
    annotation (Placement(transformation(origin = {70, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Links.Forearm_link forearm_link(enableCollision = enableCollision, overwriteColor = overwriteColor)
    annotation (Placement(transformation(origin = {120, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Links.Wrist_1_link wrist_1_link(enableCollision = enableCollision, overwriteColor = overwriteColor)
    annotation (Placement(transformation(origin = {170, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Links.Wrist_2_link wrist_2_link(enableCollision = enableCollision, overwriteColor = overwriteColor)
    annotation (Placement(transformation(origin = {220, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Links.Wrist_3_link wrist_3_link(enableCollision = enableCollision, overwriteColor = overwriteColor)
    annotation (Placement(transformation(origin = {270, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Links.Base base(enableCollision = enableCollision, overwriteColor = overwriteColor)
    annotation (Placement(transformation(origin = {-30, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Links.Flange flange(enableCollision = enableCollision, overwriteColor = overwriteColor)
    annotation (Placement(transformation(origin = {320, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Links.Tool0 tool0(enableCollision = enableCollision, overwriteColor = overwriteColor)
    annotation (Placement(transformation(origin = {370, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Joints.Base_link_base_link_inertia base_link_base_link_inertia
    annotation (Placement(transformation(origin = {-55, 40}, extent = {{-10, -10}, {10, 10}})));
  Joints.Shoulder_pan_joint shoulder_pan_joint(flangeIndex = 1)
    annotation (Placement(transformation(origin = {-5, 40}, extent = {{-10, -10}, {10, 10}})));
  Joints.Shoulder_lift_joint shoulder_lift_joint(flangeIndex = 2)
    annotation (Placement(transformation(origin = {45, 40}, extent = {{-10, -10}, {10, 10}})));
  Joints.Elbow_joint elbow_joint(flangeIndex = 3)
    annotation (Placement(transformation(origin = {95, 40}, extent = {{-10, -10}, {10, 10}})));
  Joints.Wrist_1_joint wrist_1_joint(flangeIndex = 4)
    annotation (Placement(transformation(origin = {145, 40}, extent = {{-10, -10}, {10, 10}})));
  Joints.Wrist_2_joint wrist_2_joint(flangeIndex = 5)
    annotation (Placement(transformation(origin = {195, 40}, extent = {{-10, -10}, {10, 10}})));
  Joints.Wrist_3_joint wrist_3_joint(flangeIndex = 6)
    annotation (Placement(transformation(origin = {245, 40}, extent = {{-10, -10}, {10, 10}})));
  Joints.Base_link_base_fixed_joint base_link_base_fixed_joint
    annotation (Placement(transformation(origin = {-55, 70}, extent = {{-10, -10}, {10, 10}})));
  Joints.Wrist_3_flange wrist_3_flange
    annotation (Placement(transformation(origin = {295, 40}, extent = {{-10, -10}, {10, 10}})));
  Joints.Flange_tool0 flange_tool0
    annotation (Placement(transformation(origin = {345, 40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_b[2] "Coordinate system b fixed to the component with one cut-force and cut-torque" annotation (Placement(transformation(extent = {{384, -16}, {416, 16}}), iconTransformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}})));

equation
  connect(frame_a, base_link.frame_a)
    annotation (Line(points = {{-100, 0}, {-100, 70}, {-80, 70}}));
  connect(base.frame_a, frame_b[1])
    annotation (Line(points = {{-30, 70}, {400, 70}, {400, 0}}, color = {95, 95, 95}));
  connect(tool0.frame_a, frame_b[2])
    annotation (Line(points = {{370, 40}, {400, 40}, {400, 0}}, color = {95, 95, 95}));
  connect(base_link.frame_a, base_link_base_link_inertia.frame_a)
    annotation (Line(points = {{-80, 70}, {-65, 40}}, color = {95, 95, 95}));
  connect(base_link_base_link_inertia.frame_b, base_link_inertia.frame_a)
    annotation (Line(points = {{-45, 40}, {-30, 40}}, color = {95, 95, 95}));
  connect(base_link_inertia.frame_a, shoulder_pan_joint.frame_a)
    annotation (Line(points = {{-30, 40}, {-15, 40}}, color = {95, 95, 95}));
  connect(shoulder_pan_joint.frame_b, shoulder_link.frame_a)
    annotation (Line(points = {{5, 40}, {20, 40}}, color = {95, 95, 95}));
  connect(shoulder_pan_joint.flange_a, rotational_flange_a[1]);
  connect(shoulder_pan_joint.flange_b, rotational_flange_b[1]);
  connect(shoulder_link.frame_a, shoulder_lift_joint.frame_a)
    annotation (Line(points = {{20, 40}, {35, 40}}, color = {95, 95, 95}));
  connect(shoulder_lift_joint.frame_b, upper_arm_link.frame_a)
    annotation (Line(points = {{55, 40}, {70, 40}}, color = {95, 95, 95}));
  connect(shoulder_lift_joint.flange_a, rotational_flange_a[2]);
  connect(shoulder_lift_joint.flange_b, rotational_flange_b[2]);
  connect(upper_arm_link.frame_a, elbow_joint.frame_a)
    annotation (Line(points = {{70, 40}, {85, 40}}, color = {95, 95, 95}));
  connect(elbow_joint.frame_b, forearm_link.frame_a)
    annotation (Line(points = {{105, 40}, {120, 40}}, color = {95, 95, 95}));
  connect(elbow_joint.flange_a, rotational_flange_a[3]);
  connect(elbow_joint.flange_b, rotational_flange_b[3]);
  connect(forearm_link.frame_a, wrist_1_joint.frame_a)
    annotation (Line(points = {{120, 40}, {135, 40}}, color = {95, 95, 95}));
  connect(wrist_1_joint.frame_b, wrist_1_link.frame_a)
    annotation (Line(points = {{155, 40}, {170, 40}}, color = {95, 95, 95}));
  connect(wrist_1_joint.flange_a, rotational_flange_a[4]);
  connect(wrist_1_joint.flange_b, rotational_flange_b[4]);
  connect(wrist_1_link.frame_a, wrist_2_joint.frame_a)
    annotation (Line(points = {{170, 40}, {185, 40}}, color = {95, 95, 95}));
  connect(wrist_2_joint.frame_b, wrist_2_link.frame_a)
    annotation (Line(points = {{205, 40}, {220, 40}}, color = {95, 95, 95}));
  connect(wrist_2_joint.flange_a, rotational_flange_a[5]);
  connect(wrist_2_joint.flange_b, rotational_flange_b[5]);
  connect(wrist_2_link.frame_a, wrist_3_joint.frame_a)
    annotation (Line(points = {{220, 40}, {235, 40}}, color = {95, 95, 95}));
  connect(wrist_3_joint.frame_b, wrist_3_link.frame_a)
    annotation (Line(points = {{255, 40}, {270, 40}}, color = {95, 95, 95}));
  connect(wrist_3_joint.flange_a, rotational_flange_a[6]);
  connect(wrist_3_joint.flange_b, rotational_flange_b[6]);
  connect(base_link.frame_a, base_link_base_fixed_joint.frame_a)
    annotation (Line(points = {{-80, 70}, {-65, 70}}, color = {95, 95, 95}));
  connect(base_link_base_fixed_joint.frame_b, base.frame_a)
    annotation (Line(points = {{-45, 70}, {-30, 70}}, color = {95, 95, 95}));
  connect(wrist_3_link.frame_a, wrist_3_flange.frame_a)
    annotation (Line(points = {{270, 40}, {285, 40}}, color = {95, 95, 95}));
  connect(wrist_3_flange.frame_b, flange.frame_a)
    annotation (Line(points = {{305, 40}, {320, 40}}, color = {95, 95, 95}));
  connect(flange.frame_a, flange_tool0.frame_a)
    annotation (Line(points = {{320, 40}, {335, 40}}, color = {95, 95, 95}));
  connect(flange_tool0.frame_b, tool0.frame_a)
    annotation (Line(points = {{355, 40}, {370, 40}}, color = {95, 95, 95}));
  annotation (preferredView = "diagram",
    Diagram(coordinateSystem(extent = {{-100, -120}, {400, 100}})));
end Ur10e_robot;
