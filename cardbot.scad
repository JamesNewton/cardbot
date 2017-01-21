$fs=0.5;

bot_body_width = 40;
bot_body_height = 20;
bot_body_length = 70;
bot_skin_thick = 1;
motor_body_height = 7;
motor_shaft_diameter = 2;
crease = .1;
bot_wheel_setback = 10;
bot_wheel_clearance = bot_skin_thick+1;
bot_wheel_shaft_r = 2;
bot_wheel_r = bot_body_height/2+1;

bot_wheel_c = bot_wheel_r+motor_body_height/2+motor_shaft_diameter/2;

folded = $t;

//platform
translate([bot_wheel_setback,-bot_body_width/2+bot_skin_thick,0]) 
  dc_motor_small();
translate([bot_wheel_setback,bot_body_width/2-bot_skin_thick,0]) rotate([180,0,0]) 
  dc_motor_small();
translate([0,0,motor_body_height/2]) //raise body off motors
  cube([bot_body_length, bot_body_width, bot_skin_thick],center=true);


//left wheel
translate([bot_wheel_setback,
			-(bot_body_width/2+crease+bot_wheel_clearance)
			-(bot_wheel_r+bot_body_height)*(1-folded),
			motor_body_height/2])
rotate([90*folded,0,0]) 
  translate([0,-bot_wheel_c*folded,0])
    difference() {
      cylinder(r=bot_wheel_r, h=bot_skin_thick,center=true);
      cylinder(r=bot_wheel_shaft_r, h=bot_skin_thick+crease,center=true);
      }

//left side
translate([0,-(bot_body_width/2)-crease,motor_body_height/2])
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
translate([0,(bot_body_width/2)+crease,motor_body_height/2])
rotate([180-90*folded,0,0]) 
  translate([0,-bot_body_height/2,0])
	cube([bot_body_length, bot_body_height, bot_skin_thick],center=true);

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

