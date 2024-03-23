/// @function bamboo_point(x, y, [mass=1], [fixed=false])

show_debug_message("Bamboo: Welcome to Bamboo by STANN.co!");

function bamboo_point(_x,_y, _mass = 1, _fixed = false) constructor {
	//Written by STANN.co
	//credit appreciated
	
	x = _x;
	y = _y;
	x_prev = x;
	y_prev = y;
	fixed = _fixed;
	mass = _mass;
	
	///@description should be ran in step before any other forces
	///@param drag 0 - 1 dampens movement over time
	static update = function(_drag = 0.01){
		
		var x_vel = (x - x_prev);
		var y_vel = (y - y_prev);
		
		x_prev = x;
		y_prev = y;
		
		x_vel -= x_vel * _drag;
		y_vel -= y_vel * _drag;
		
		//applies force
		x+= x_vel;
		y+= y_vel;
	}
	
	///@description adds a force
	static force = function(_force_x, _force_y){
		if(!fixed){
			x+= _force_x / mass;
			y+= _force_y / mass;
		}
	}
	
	///@description add gravity in a specific direction
	static gravity_force = function(_dir = -90, _force = 0.09807){
		if(!fixed){
			x += lengthdir_x(_force,_dir);
			y += lengthdir_y(_force,_dir);
		}
	}
	
	static set_pos = function(_target_x,_target_y){
		x = _target_x;
		y = _target_y;
	}
	
	///@desription a spring implementation aiming for a target, with a stiffness
	///@param target_x
	///@param target_y
	///@param stiffness 0 - 1
	///@param mass
	static spring = function(_target_x,_target_y,_stiffness){
		
		if(!fixed){
			var dist = point_distance(x,y,_target_x,_target_y);
			var dir = point_direction(x,y,_target_x,_target_y);
			
			x += (lengthdir_x(dist,dir) * _stiffness) / mass;
			y += (lengthdir_y(dist,dir) * _stiffness) / mass;
		}
	}
	
	static draw = function(_radius = 1){
		draw_circle(x,y,_radius,0);
	}
	
	static draw_velocity = function(_multiply = 1){
		
		var dist_ = point_distance(x,y,x_prev,y_prev);
		var dir_ = point_direction(x,y,x_prev,y_prev);
		
		var x_ = x + lengthdir_x(-dist_*_multiply,dir_);
		var y_ = y + lengthdir_y(-dist_*_multiply,dir_);
		
		var val_ = min(1,dist_ / 10) * 255;
		
		var color_ = make_color_rgb(val_,255-val_,0);
		var color_prev_ = draw_get_color();
		draw_set_color(color_);
		draw_line(x,y,x_,y_);	
		draw_set_color(color_prev_);
	}
}