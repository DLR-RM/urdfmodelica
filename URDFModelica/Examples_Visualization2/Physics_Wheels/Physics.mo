within URDFModelica.Examples_Visualization2.Physics_Wheels;
model Physics
  extends URDFModelica.Icons.MobileRobotIcon;
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialOneFrame_a;

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
  Links.Right_leg right_leg(enableCollision = enableCollision, overwriteColor = overwriteColor)
    annotation (Placement(transformation(origin = {-30, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Links.Right_base right_base(enableCollision = enableCollision, overwriteColor = overwriteColor)
    annotation (Placement(transformation(origin = {20, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Links.Right_front_wheel right_front_wheel(enableCollision = enableCollision, overwriteColor = overwriteColor)
    annotation (Placement(transformation(origin = {70, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Links.Right_back_wheel right_back_wheel(enableCollision = enableCollision, overwriteColor = overwriteColor)
    annotation (Placement(transformation(origin = {70, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Links.Left_leg left_leg(enableCollision = enableCollision, overwriteColor = overwriteColor)
    annotation (Placement(transformation(origin = {-30, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Links.Left_base left_base(enableCollision = enableCollision, overwriteColor = overwriteColor)
    annotation (Placement(transformation(origin = {20, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Links.Left_front_wheel left_front_wheel(enableCollision = enableCollision, overwriteColor = overwriteColor)
    annotation (Placement(transformation(origin = {70, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Links.Left_back_wheel left_back_wheel(enableCollision = enableCollision, overwriteColor = overwriteColor)
    annotation (Placement(transformation(origin = {70, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Links.Gripper_pole gripper_pole(enableCollision = enableCollision, overwriteColor = overwriteColor)
    annotation (Placement(transformation(origin = {-30, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Links.Left_gripper left_gripper(enableCollision = enableCollision, overwriteColor = overwriteColor)
    annotation (Placement(transformation(origin = {20, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Links.Left_tip left_tip(enableCollision = enableCollision, overwriteColor = overwriteColor)
    annotation (Placement(transformation(origin = {70, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Links.Right_gripper right_gripper(enableCollision = enableCollision, overwriteColor = overwriteColor)
    annotation (Placement(transformation(origin = {20, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Links.Right_tip right_tip(enableCollision = enableCollision, overwriteColor = overwriteColor)
    annotation (Placement(transformation(origin = {70, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Links.Head head(enableCollision = enableCollision, overwriteColor = overwriteColor)
    annotation (Placement(transformation(origin = {-30, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Links.Box box(enableCollision = enableCollision, overwriteColor = overwriteColor)
    annotation (Placement(transformation(origin = {20, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Joints.Base_to_right_leg base_to_right_leg
    annotation (Placement(transformation(origin = {-55, 70}, extent = {{-10, -10}, {10, 10}})));
  Joints.Right_base_joint right_base_joint
    annotation (Placement(transformation(origin = {-5, 70}, extent = {{-10, -10}, {10, 10}})));
  Joints.Right_front_wheel_joint right_front_wheel_joint(flangeIndex = 1)
    annotation (Placement(transformation(origin = {45, 70}, extent = {{-10, -10}, {10, 10}})));
  Joints.Right_back_wheel_joint right_back_wheel_joint(flangeIndex = 2)
    annotation (Placement(transformation(origin = {45, 40}, extent = {{-10, -10}, {10, 10}})));
  Joints.Base_to_left_leg base_to_left_leg
    annotation (Placement(transformation(origin = {-55, 10}, extent = {{-10, -10}, {10, 10}})));
  Joints.Left_base_joint left_base_joint
    annotation (Placement(transformation(origin = {-5, 10}, extent = {{-10, -10}, {10, 10}})));
  Joints.Left_front_wheel_joint left_front_wheel_joint(flangeIndex = 3)
    annotation (Placement(transformation(origin = {45, 10}, extent = {{-10, -10}, {10, 10}})));
  Joints.Left_back_wheel_joint left_back_wheel_joint(flangeIndex = 4)
    annotation (Placement(transformation(origin = {45, -20}, extent = {{-10, -10}, {10, 10}})));
  Joints.Gripper_extension gripper_extension(flangeIndex = 1)
    annotation (Placement(transformation(origin = {-55, -50}, extent = {{-10, -10}, {10, 10}})));
  Joints.Left_gripper_joint left_gripper_joint(flangeIndex = 5)
    annotation (Placement(transformation(origin = {-5, -50}, extent = {{-10, -10}, {10, 10}})));
  Joints.Left_tip_joint left_tip_joint
    annotation (Placement(transformation(origin = {45, -50}, extent = {{-10, -10}, {10, 10}})));
  Joints.Right_gripper_joint right_gripper_joint(flangeIndex = 6)
    annotation (Placement(transformation(origin = {-5, -80}, extent = {{-10, -10}, {10, 10}})));
  Joints.Right_tip_joint right_tip_joint
    annotation (Placement(transformation(origin = {45, -80}, extent = {{-10, -10}, {10, 10}})));
  Joints.Head_swivel head_swivel(flangeIndex = 7)
    annotation (Placement(transformation(origin = {-55, -110}, extent = {{-10, -10}, {10, 10}})));
  Joints.Tobox tobox
    annotation (Placement(transformation(origin = {-5, -110}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_b[7] "Coordinate system b fixed to the component with one cut-force and cut-torque" annotation (Placement(transformation(extent = {{84, -16}, {116, 16}}), iconTransformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}})));

equation
  connect(frame_a, base_link.frame_a)
    annotation (Line(points = {{-100, 0}, {-100, 70}, {-80, 70}}));
  connect(right_front_wheel.frame_a, frame_b[1])
    annotation (Line(points = {{70, 70}, {100, 70}, {100, 0}}, color = {95, 95, 95}));
  connect(right_back_wheel.frame_a, frame_b[2])
    annotation (Line(points = {{70, 40}, {100, 40}, {100, 0}}, color = {95, 95, 95}));
  connect(left_front_wheel.frame_a, frame_b[3])
    annotation (Line(points = {{70, 10}, {100, 10}, {100, 0}}, color = {95, 95, 95}));
  connect(left_back_wheel.frame_a, frame_b[4])
    annotation (Line(points = {{70, -20}, {100, -20}, {100, 0}}, color = {95, 95, 95}));
  connect(left_tip.frame_a, frame_b[5])
    annotation (Line(points = {{70, -50}, {100, -50}, {100, 0}}, color = {95, 95, 95}));
  connect(right_tip.frame_a, frame_b[6])
    annotation (Line(points = {{70, -80}, {100, -80}, {100, 0}}, color = {95, 95, 95}));
  connect(box.frame_a, frame_b[7])
    annotation (Line(points = {{20, -110}, {100, -110}, {100, 0}}, color = {95, 95, 95}));
  connect(base_link.frame_a, base_to_right_leg.frame_a)
    annotation (Line(points = {{-80, 70}, {-65, 70}}, color = {95, 95, 95}));
  connect(base_to_right_leg.frame_b, right_leg.frame_a)
    annotation (Line(points = {{-45, 70}, {-30, 70}}, color = {95, 95, 95}));
  connect(right_leg.frame_a, right_base_joint.frame_a)
    annotation (Line(points = {{-30, 70}, {-15, 70}}, color = {95, 95, 95}));
  connect(right_base_joint.frame_b, right_base.frame_a)
    annotation (Line(points = {{5, 70}, {20, 70}}, color = {95, 95, 95}));
  connect(right_base.frame_a, right_front_wheel_joint.frame_a)
    annotation (Line(points = {{20, 70}, {35, 70}}, color = {95, 95, 95}));
  connect(right_front_wheel_joint.frame_b, right_front_wheel.frame_a)
    annotation (Line(points = {{55, 70}, {70, 70}}, color = {95, 95, 95}));
  connect(right_front_wheel_joint.flange_a, rotational_flange_a[1]);
  connect(right_front_wheel_joint.flange_b, rotational_flange_b[1]);
  connect(right_base.frame_a, right_back_wheel_joint.frame_a)
    annotation (Line(points = {{20, 70}, {35, 40}}, color = {95, 95, 95}));
  connect(right_back_wheel_joint.frame_b, right_back_wheel.frame_a)
    annotation (Line(points = {{55, 40}, {70, 40}}, color = {95, 95, 95}));
  connect(right_back_wheel_joint.flange_a, rotational_flange_a[2]);
  connect(right_back_wheel_joint.flange_b, rotational_flange_b[2]);
  connect(base_link.frame_a, base_to_left_leg.frame_a)
    annotation (Line(points = {{-80, 70}, {-65, 10}}, color = {95, 95, 95}));
  connect(base_to_left_leg.frame_b, left_leg.frame_a)
    annotation (Line(points = {{-45, 10}, {-30, 10}}, color = {95, 95, 95}));
  connect(left_leg.frame_a, left_base_joint.frame_a)
    annotation (Line(points = {{-30, 10}, {-15, 10}}, color = {95, 95, 95}));
  connect(left_base_joint.frame_b, left_base.frame_a)
    annotation (Line(points = {{5, 10}, {20, 10}}, color = {95, 95, 95}));
  connect(left_base.frame_a, left_front_wheel_joint.frame_a)
    annotation (Line(points = {{20, 10}, {35, 10}}, color = {95, 95, 95}));
  connect(left_front_wheel_joint.frame_b, left_front_wheel.frame_a)
    annotation (Line(points = {{55, 10}, {70, 10}}, color = {95, 95, 95}));
  connect(left_front_wheel_joint.flange_a, rotational_flange_a[3]);
  connect(left_front_wheel_joint.flange_b, rotational_flange_b[3]);
  connect(left_base.frame_a, left_back_wheel_joint.frame_a)
    annotation (Line(points = {{20, 10}, {35, -20}}, color = {95, 95, 95}));
  connect(left_back_wheel_joint.frame_b, left_back_wheel.frame_a)
    annotation (Line(points = {{55, -20}, {70, -20}}, color = {95, 95, 95}));
  connect(left_back_wheel_joint.flange_a, rotational_flange_a[4]);
  connect(left_back_wheel_joint.flange_b, rotational_flange_b[4]);
  connect(base_link.frame_a, gripper_extension.frame_a)
    annotation (Line(points = {{-80, 70}, {-65, -50}}, color = {95, 95, 95}));
  connect(gripper_extension.frame_b, gripper_pole.frame_a)
    annotation (Line(points = {{-45, -50}, {-30, -50}}, color = {95, 95, 95}));
  connect(gripper_extension.flange_a, translational_flange_a[1]);
  connect(gripper_extension.flange_b, translational_flange_b[1]);
  connect(gripper_pole.frame_a, left_gripper_joint.frame_a)
    annotation (Line(points = {{-30, -50}, {-15, -50}}, color = {95, 95, 95}));
  connect(left_gripper_joint.frame_b, left_gripper.frame_a)
    annotation (Line(points = {{5, -50}, {20, -50}}, color = {95, 95, 95}));
  connect(left_gripper_joint.flange_a, rotational_flange_a[5]);
  connect(left_gripper_joint.flange_b, rotational_flange_b[5]);
  connect(left_gripper.frame_a, left_tip_joint.frame_a)
    annotation (Line(points = {{20, -50}, {35, -50}}, color = {95, 95, 95}));
  connect(left_tip_joint.frame_b, left_tip.frame_a)
    annotation (Line(points = {{55, -50}, {70, -50}}, color = {95, 95, 95}));
  connect(gripper_pole.frame_a, right_gripper_joint.frame_a)
    annotation (Line(points = {{-30, -50}, {-15, -80}}, color = {95, 95, 95}));
  connect(right_gripper_joint.frame_b, right_gripper.frame_a)
    annotation (Line(points = {{5, -80}, {20, -80}}, color = {95, 95, 95}));
  connect(right_gripper_joint.flange_a, rotational_flange_a[6]);
  connect(right_gripper_joint.flange_b, rotational_flange_b[6]);
  connect(right_gripper.frame_a, right_tip_joint.frame_a)
    annotation (Line(points = {{20, -80}, {35, -80}}, color = {95, 95, 95}));
  connect(right_tip_joint.frame_b, right_tip.frame_a)
    annotation (Line(points = {{55, -80}, {70, -80}}, color = {95, 95, 95}));
  connect(base_link.frame_a, head_swivel.frame_a)
    annotation (Line(points = {{-80, 70}, {-65, -110}}, color = {95, 95, 95}));
  connect(head_swivel.frame_b, head.frame_a)
    annotation (Line(points = {{-45, -110}, {-30, -110}}, color = {95, 95, 95}));
  connect(head_swivel.flange_a, rotational_flange_a[7]);
  connect(head_swivel.flange_b, rotational_flange_b[7]);
  connect(head.frame_a, tobox.frame_a)
    annotation (Line(points = {{-30, -110}, {-15, -110}}, color = {95, 95, 95}));
  connect(tobox.frame_b, box.frame_a)
    annotation (Line(points = {{5, -110}, {20, -110}}, color = {95, 95, 95}));
  annotation (preferredView = "diagram",
    Diagram(coordinateSystem(extent = {{-100, -130}, {100, 100}})));
end Physics;
