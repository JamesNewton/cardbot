# cardbot
A parametric cardboard robot. Main page:

http://www.thingiverse.com/thing:2055990

Parametric base, sides, and wheels for a robot made from cardboard. Simple, but easy and super cheap to make and... to remake if it gets destroyed in a robot battle! Open in customizer to experiment with different widths, lengths, heights, wheel sizes and the position of the wheels front to back. Switch the view to dxf to make a laser cutter outline. The extra cardboard can be used to make cross braces to strengthen the body.

<img src="http://thingiverse-production-new.s3.amazonaws.com/renders/f8/e2/0e/89/c3/a95a52449ef0216404d1fa6cfe23724f_preview_featured.jpg">

https://youtu.be/257xCgosHWQ

The main motivation for writing this as a script was to make it easy to play with different sizes and still have a very accurate alignment so it can use regular DC motors, with the motor shaft rubbing against the edge of the wheel to turn it. Stretch a fat rubber band over the wheel (size the wheels for the rubber band) and the motor shaft will make solid contact. The small "washers" have different sized holes in them. The larger hole washer is glued to the wheel before slipping over the axle during assembly. It spaces the wheel away from the body, and helps keep it on the shaft.. The smaller hole washer is glued to the axle with hot glue after assembly to hold the wheel in place.

If you use RC servos, or gearmotors, just ignore the upper motor holes or set the motor sizes to 0. Honestly, you probably don't need this script then.

A good motor / controller / firmware package for a robot like this can be found here:

https://github.com/jmalins/BattleBot-Control

TODO: Cut one and see how it works, adjust, iterate. Especially the crease parameter to see if it can be turned into a score rather than a cut.

TODO: Add a pattern of slots or holes to the wheel to support detection of wheel movement for feedback to the controller, allowing precise movement... a low resolution servo encoder.

