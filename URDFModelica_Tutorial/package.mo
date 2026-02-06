package URDFModelica_Tutorial
  extends Modelica.Icons.Package;

  annotation (
    preferredView = "info",
    version = "0.3.4",
    versionDate = "2026-03-06",
    uses(Modelica(version = "4.0.0"), Visualization2(version="1.1")),
    Documentation(info = "<html>
    <H1>URDF Modelica</H1> 
<p>Package <strong>URDFModelica</strong> is a package to convert
robot designs into multibody simulation models based on the
<strong>U</strong>nified <strong>R</strong>obot
<strong>D</strong>escription <strong>F</strong>ormat <strong>URDF</strong>.</p>
<h4>Copyright</h4>
<p>
<strong>Licensed by <img src=\"modelica://URDFModelica/Resources/DLR-Signet_black_small.png\"/> under the 3-Clause BSD License</strong><br>
</p>
<p>
<em>
This Modelica package is <u>free</u> software and
the use is completely at <u>your own risk</u>;
it can be redistributed and/or modified under the terms of the
3-Clause BSD license, see the license conditions (including the
disclaimer of warranty) in the
<a href=\"modelica://URDFModelica.Documentation.License\">License documentation</a>.
</em>
</p>
<p>
<strong>Modelica&reg;</strong> is a registered trademark of the Modelica Association.
</p>
</html>"),
  Icon(graphics = {Text(origin = {0, 50}, extent = {{-100, 50}, {100, -50}}, textString = "URDF"), Text(origin = {0, -50}, extent = {{-100, 50}, {100, -50}}, textString = "XML")}));
end URDFModelica_Tutorial;
