within URDFModelica_Tutorial.Documentation;
class Links
  extends Modelica.Icons.Information;

  annotation (DocumentationClass = true, preferredView = "info", Documentation(info = "<html>
<p>
Package <strong>URDFModelica/Links</strong> contains
the prototypes for robot links as specified by the
<strong>U</strong>nified <strong>R</strong>obot
<strong>D</strong>escription <strong>F</strong>ormat <strong>URDF</strong>
<a href=\"https://wiki.ros.org/urdf/XML/link\">ROS Wiki</a>. 
Models for simple collision simulation are in here too.
</p>
<p>
The <strong>Link</strong> model can be any rigid robot part. 
A link always has an <tt>Inertial</tt> component, that is a 
Modelica.Mechanics.MultiBody.Parts.Body with parameters from
the corresponding record, which can be zero. Optional 
components are <tt>Collision</tt> and <tt>Visual</tt>. 
Collision is not simulated, only visualized. There are two 
ways to visualize visual and collision models. The main 
way has visualizers from the Standard Library, the 
other way uses the DLR Visualization 2 library. The user 
decides which to use when calling the Python script. 
When a new robot package is created, copies of 
<strong>Link</strong> are put in the new 
<strong>Links</strong> subpackage for each link together 
with a parameter record for each link. Thus, the link 
models can be adapted independently of the parameter 
definitions, parameters which can be updated at any time
without modifying the link models.
</p>
<p>
In the main link version, visual and collision models 
use the visualizers from the 
Modelica.Mechanics.MultiBody.Visualizers package. 
The correct visualization component (box, cylinder, sphere, 
CAD file) is selected from all components contained in 
the <strong>Link</strong> prototype model.
</p>
<p>
In the visualization2 link version, visual and collision 
models are simulated externally. 
The correct visualization component (box, cylinder, sphere, 
CAD file) is selected from all components contained in 
the <strong>Link_Visualization2</strong> prototype model. 
By default colors from URDF are always used, colors from 
meshes can be used instead by setting the parameter
<tt>overwriteColor</tt> to <tt>false</tt>. 
The visualization2 version requires the 
<a href=\"https://www.sr-scil.de/simulationsbibliotheken/kommerziell-verfuegbar/visualization/\">
DLR Visualization 2 library</a>, the free community 
edition suffices to run the examples. It is activated if 
the user adds `-v` to the Python translation script.
</p>
<p>
<strong>Collision</strong> of links is not simulated 
but only visualized. The same visualizers from 
Standard Library or DLR Visualization 2 than
for visual simulation are included equally 
in each link that has collision information. Color is 
set to <tt>{255, 0, 255}</tt> (i.e. pink) for easier 
distinction, transparency is turned on if 
possible. Collision can be globally turned 
off with the <tt>enableCollision</tt> parameter 
that is propagated through the whole robot.
</p>
<p>
Proper collision simulation of links against other 
links or environment is not implemented in this
library but left to the user to choose its preferred 
way. But URDFModelica/Links package contains models 
that show one simple possibility for collision 
simulation against planes. It is based on the 
<tt>Modelica.Mechanics.Translational.Components.ElastoGap</tt> 
(normal) and dry Coulomb friction (tangential) with 
<tt>tanh</tt> to make it continuously differentiable. 
<strong>CollisionPoint</strong> contains one ElastoGap 
and tangential dry friction element, the rotational 
degrees of freedom are unconstrained. 
<strong>CollisionBox</strong> has eight CollisionPoints, 
one for each corner of a box. <strong>CollisionCylinder
</strong> has 16 CollisionPoints, effectively creating 
an octagonal prism. <strong>CollisionSphere</strong> has 
twelve CollisionPoints, one for each corner of an 
icosahedron. There is no dedicated model for collision 
of meshes or their convex envelope.
</p>
<p>
In order to get somewhat realistic examples, one 
CollisionPoint for each leaf is connected to the 
vector of <tt>frame_b</tt> from <tt>BaseURDF</tt> 
in <tt>RunURDF</tt> such that mobile robots don't 
fall beneath the collision counterpart, that is the 
(x, y) plane at <tt>z=0</tt>. This is not done for 
stationary robots (with <tt>-s</tt> option) that 
are rigidly connected to the world origin.
</p>
<p>
The <strong>Link</strong> model stands as is and does 
not need to be processed by the Python script to 
work. One can add a link to any multibody model of 
Modelica because all parameters have default values 
and optional components are conditionally included. 
The advantage of the URDF link compared to a Standard 
Library body is the attached parameter record with 
which it is easy to have very different rigid bodies 
with optional visual and collision models.
</p>
</html>"));
end Links;
