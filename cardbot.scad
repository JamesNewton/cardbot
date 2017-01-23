$fs=.1;
bot_skin_thick = 1; //the thickness of the material being used
crease = .1; //gap to make the creases to bend the body
slip = .2; //increase in radius to let wheel and support spin

view = "all"; //[all: show the bot, dxf: make a file to cut]

//twice the distance from the motor mount to the center of the motor shaft
motor_body_height = 7; 
//diameter of the motor shaft.
motor_shaft_diameter = 2; 

//width of the robots body
bot_body_width = 40; 
//height of the robots body (width of the sides)
bot_body_height = 20; 
//length of the robots body
bot_body_length = 70; 

//increases the wheel size beyond the height of the side.
bot_wheel_size = 2;
//diameter of the axle where the wheels mount
bot_wheel_axel_diameter = 4; 
//how far to move the wheel back from center.
bot_wheel_setback = 10; 
//distance from side of the body to the wheel hub
bot_wheel_clearance = 1.2; 

bot_wheel_shaft_r = bot_wheel_axel_diameter/2; 
bot_wheel_clear = bot_skin_thick + bot_wheel_clearance;
bot_wheel_r = bot_body_height/2+bot_wheel_size;
bot_wheel_hub_r = bot_wheel_shaft_r*1.8 + bot_wheel_r*0.2;
bot_wheel_c = bot_wheel_r+motor_body_height/2+motor_shaft_diameter/2;

/* [Hidden] */


folded = lookup($t, [
	[0,0],
	[.3,1],
	[.6,1],
	[.8,0]
	]);


if (view == "dxf") {
	//projection() 
		cardbot(0);
	} 
else { cardbot(folded); }


module cardbot(folded) {

if (folded > 0.7) {
  translate([bot_wheel_setback,
   -bot_body_width/2+bot_skin_thick,
   -motor_body_height/2]) 
      dc_motor_small();
  translate([bot_wheel_setback,bot_body_width/2-bot_skin_thick,-motor_body_height/2]) 
    rotate([180,0,0]) 
      dc_motor_small();
  rotate([90,0,0]) //rotate to fold
    translate([bot_wheel_setback,-bot_wheel_c,0]) //shift down when folded
      color("grey") 
      cylinder(r=bot_wheel_shaft_r, 
        h=bot_body_width+bot_wheel_clear*4 , 
        center=true);
  }

//platform
cube([bot_body_length, bot_body_width, bot_skin_thick],center=true);


//left wheel
translate([(bot_body_length/2-bot_wheel_r)*(1-folded) + bot_wheel_setback*folded,
			-(bot_body_width/2+crease+bot_wheel_clear) //move just outside body
			-(bot_wheel_r+bot_body_height)*(1-folded), //and farther when not folded
			0]) 
rotate([90*folded,0,0]) //rotate to fold
  translate([0,-bot_wheel_c*folded,0]) //shift down when folded
    difference() { //wheel, then punch out hole for axil
      cylinder(r=bot_wheel_r, h=bot_skin_thick,center=true);
      cylinder(r=bot_wheel_shaft_r+slip, h=bot_skin_thick+crease,center=true);
      }

//left wheel spacer
translate([0*(1-folded) + bot_wheel_setback*folded,
			-(bot_body_width/2+crease+bot_wheel_clear-bot_skin_thick)
			-(bot_wheel_r+bot_body_height)*(1-folded), //and farther when not folded
			0])
rotate([90*folded,0,0]) //rotate to fold
  translate([0,-bot_wheel_c*folded,0]) //shift down when folded
    difference() { //wheel, then punch out hole for axle
      cylinder(r=bot_wheel_hub_r, h=bot_skin_thick,center=true);
      cylinder(r=bot_wheel_shaft_r+slip, h=bot_skin_thick+crease,center=true);
      }

//left wheel axel stop. Glued to axle
translate([(-bot_body_length/2+bot_wheel_r)*(1-folded) + bot_wheel_setback*folded,
			-(bot_body_width/2+crease+bot_wheel_clear+bot_skin_thick)
			-(bot_wheel_r+bot_body_height)*(1-folded), //and farther when not folded
			0])
rotate([90*folded,0,0]) //rotate to fold
  translate([0,-bot_wheel_c*folded,0]) //shift down when folded
    difference() { //wheel, then punch out hole for axle
      color("grey") cylinder(r=bot_wheel_hub_r, h=bot_skin_thick,center=true);
      cylinder(r=bot_wheel_shaft_r, h=bot_skin_thick+crease,center=true);
      }

//right wheel
translate([(bot_body_length/2-bot_wheel_r)*(1-folded) + bot_wheel_setback*folded,
			+(bot_body_width/2+crease+bot_wheel_clear)
			+(bot_wheel_r+bot_body_height)*(1-folded),
			0])
rotate([180-90*folded,0,0]) 
  translate([0,-bot_wheel_c*folded,0])
    difference() {
      cylinder(r=bot_wheel_r, h=bot_skin_thick,center=true);
      cylinder(r=bot_wheel_shaft_r+slip, h=bot_skin_thick+crease,center=true);
      }

//right wheel spacer glued to wheel
translate([0*(1-folded) + bot_wheel_setback*folded,
			+(bot_body_width/2+crease+bot_wheel_clear-bot_skin_thick)
			+(bot_wheel_r+bot_body_height)*(1-folded), //and farther when not folded
			0])
rotate([180-90*folded,0,0]) //rotate to fold
  translate([0,-bot_wheel_c*folded,0]) //shift down when folded
    difference() { //wheel, then punch out hole for axle
      cylinder(r=bot_wheel_hub_r, h=bot_skin_thick,center=true);
      cylinder(r=bot_wheel_shaft_r+slip, h=bot_skin_thick+crease,center=true);
      }

//right wheel axel stop. Glued to axle
translate([(-bot_body_length/2+bot_wheel_r)*(1-folded) + bot_wheel_setback*folded,
			+(bot_body_width/2+crease+bot_wheel_clear+bot_skin_thick)
			+(bot_wheel_r+bot_body_height)*(1-folded), //and farther when not folded
			0])
rotate([180-90*folded,0,0]) //rotate to fold
  translate([0,-bot_wheel_c*folded,0]) //shift down when folded
    difference() { //wheel, then punch out hole for axle
      color("grey") cylinder(r=bot_wheel_hub_r, h=bot_skin_thick,center=true);
      cylinder(r=bot_wheel_shaft_r, h=bot_skin_thick+crease,center=true);
      }

//left side
translate([0,-(bot_body_width/2)-crease,0])
rotate([90*folded,0,0]) 
  difference() {
    translate([0,-bot_body_height/2,0])
	  cube([bot_body_length, bot_body_height, bot_skin_thick],center=true);
	translate([bot_wheel_setback,-bot_wheel_c,0]) //punch out main axle
	  cylinder(r=bot_wheel_shaft_r+crease, h=bot_skin_thick+crease, center=true);
	translate([bot_wheel_setback,-motor_body_height/2,0]) //punch out for motor shaft
	  cylinder(r=motor_shaft_diameter/2+crease, h=bot_skin_thick+crease, center=true);
	}

//right side
translate([0,(bot_body_width/2)+crease,0])
rotate([180-90*folded,0,0]) 
  difference() {
    translate([0,-bot_body_height/2,0])
	  cube([bot_body_length, bot_body_height, bot_skin_thick],center=true);
	translate([bot_wheel_setback,-bot_wheel_c,0]) //punch out main axle
	  cylinder(r=bot_wheel_shaft_r+crease, h=bot_skin_thick+crease, center=true);
	translate([bot_wheel_setback,-motor_body_height/2,0]) //punch out for motor shaft
	  cylinder(r=motor_shaft_diameter/2+crease, h=bot_skin_thick+crease, center=true);
	}

}


module dc_motor_small(
	body_length = 15,
	body_diameter = 10,
	body_height = 7,
	shaft_length = 5,
	shaft_diameter = 2)
{
	union() {
		intersection() {
			color("gray") rotate([-90,0,0]) cylinder(body_length, r=body_diameter/2);
			color("gray") cube([body_diameter, body_length*2, body_height],center=true);
			}
		translate([0,-shaft_length,0]) rotate([-90,0,0]) 
			color("silver") cylinder(shaft_length, r=shaft_diameter/2);
		}
	}

