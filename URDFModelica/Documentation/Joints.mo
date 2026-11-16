within URDFModelica.Documentation;
class Joints
  extends Modelica.Icons.Information;

  annotation (DocumentationClass = true, preferredView = "info", Documentation(info = "<html>
<p>
Package <strong>URDFModelica/Joints</strong> contains
the prototypes for robot joints as specified by the
<strong>U</strong>nified <strong>R</strong>obot
<strong>D</strong>escription <strong>F</strong>ormat <strong>URDF</strong>
<a href=\"https://wiki.ros.org/urdf/XML/joint\">ROS Wiki</a>. 
Models for translational and rotational friction that are 
simpler than the Standard Library models, are in here too.
</p>
<p>
Joints connect links together. There are six types.
When a new robot package is created, copies of joints
of appropriate type are put in the new 
<strong>Joints</strong> subpackage for each joint 
together with a joint parameter record for each joint. 
Thus, the joint models can be adapted independent of 
the parameter definitions, parameters which can be 
updated at any time without modifying the joint models.
</p>
<p>
<strong>Fixed</strong> joints rigidly connect two links 
together without any degree of freedom.
</p>
<p>
<strong>Continuous</strong> joints connect two links 
together around a <tt>Modelica.Mechanics.MultiBody.Joints.Revolute</tt> 
leaving thus one rotational degree of freedom free. 
The joint flanges are also propagated to the outside 
such that the angle can be controlled. An integer 
parameter can optionally be set to mark the flange 
number for easier reference in a robot diagram.
</p>
<p>
<strong>Revolute</strong> is the same as 
Continuous with the difference that limits 
for angle (upper and lower limit), angle velocity
absolute value and effort (torque) absolute 
value by default are checked against at. This can be 
disabled with a Boolean parameter. A warning or error 
(depending on choice) is output if a limit is violated. 
An integer parameter can optionally be set to mark the 
flange number for easier reference in a robot diagram.
</p>
<p>
<strong>Prismatic</strong> is the same as
Revolute for translational connection between 
links using <tt>Modelica.Mechanics.MultiBody.Joints.Prismatic</tt>. 
The joint flanges are also propagated to the outside 
such that the position can be controlled. 
A warning or error (depending on user choice) is 
output by default if a limit (upper and lower 
position, velocity absolute value, effort 
(force) absolute value) is violated. This can be 
disabled with a Boolean parameter. An integer 
parameter can optionally be set to mark the flange 
number for easier reference in a robot diagram.
</p>
<p>
<strong>Planar</strong> joints connect two links 
together with three degrees of freedom around a 
<tt>Modelica.Mechanics.MultiBody.Joints.Planar</tt>. 
A protected function converts the URDF axis 
parameters to Modelica axis parameters.
</p>
<p>
<strong>Floating</strong> joints connect two links 
together with all six degrees of freedom around a 
<tt>Modelica.Mechanics.MultiBody.Joints.FreeMotion</tt>.
</p>
<p>
<strong>Joint</strong> has all joint types in one 
model conditionally by a type parameter. This is used 
in the generic robot model.
</p>
<p>
<strong>Friction</strong> models, optional in revolute 
and prismatic joints, are simpler than Standard Library 
<tt>Modelica.Mechanics.Translational.Components.SupportFriction</tt> 
and 
<tt>Modelica.Mechanics.Rotational.Components.BearingFriction</tt>. 
The friction force is calculated as follows
</p>
<blockquote><pre>
f_r = Rv * v + 2 * Rh / (1 + exp(-steep * v)) - Rh;
</pre></blockquote>
<p>
that is continuously differentiable. Parameters are
<ul>
<li><tt>Rv</tt> viscous friction coefficient 
(URDF dynamics damping)</li>
<li><tt>Rh</tt> stiction
(URDF dynamics friction)</li>
<li><tt>steep</tt> steepness of stiction 
approximation (default is 100)</li>
</ul>
Rotational friction is the same with torque and 
angle replacing force and position.
</p>
<p>
The <strong>URDFModelica/Joints</strong> models stand 
as is and do not need to be processed by the Python 
script to work. One can add a link to any multibody model 
of Modelica because all parameters have default values 
and optional components are conditionally included. 
The advantage of the URDF joints compared to Standard 
Library joints are the attached parameter record with 
which it is easy to have very different joints of 
different types with some optional components (friction, 
limits, mimic, safety controller).
</p>
</html>"));
end Joints;
