function bamboo_rope(_start_x,_start_y,_end_x,_end_y,_segment_num = 2, _substeps = 10) constructor {
	segment_num = _segment_num;
	substeps = _substeps;
	points = array_create(segment_num+1);
	segments = array_create(segment_num);
	
	
	//creates verlet points
	for (var i = 0; i <= segment_num; ++i) {
		var val_ = i / segment_num;
		var x_ = lerp(_start_x,_end_x,val_);
		var y_ = lerp(_start_y,_end_y,val_);
	    points[i] = new bamboo_point(x_,y_);
	}
	
	//creates rope segments
	for (var i = 0; i < segment_num; ++i) {
		var p1_ = points[i];
		var p2_ = points[i+1];
		segments[i] = new bamboo_line(p1_,p2_);
	}
	
	//methods	
	static update = function(_drag = 0.01){
		for (var i = 0; i <= segment_num; ++i) {
			points[i].update(_drag);
		}
		
		for (var i = 0; i < segment_num; ++i) {
			segments[i].constrain_length(substeps);
		}
	}
	
	static attach_start = function(_verlet){
		points[0] = _verlet;
		segments[0].p1 = _verlet;
	}
	
	static gravity_force = function(_dir = -90, _force = 0.09807){
		for (var i = 0; i <= segment_num; ++i) {
			if(!points[i].fixed) points[i].gravity_force(_dir,_force);
		}	
	}
	
	static get_first_point = function(){
		return points[0];
	}
	
	static get_last_point = function(){
		return points[segment_num];
	}
	
	static set_position = function(_start_x,_start_y,_end_x,_end_y){
		for (var i = 0; i <= segment_num; ++i) {
			var p = points[i];
			var v = i / segment_num
			p.x = lerp(_start_x,_end_x,v);
			p.y = lerp(_start_y,_end_y,v);
		}
	}
	
	static draw = function(){
		for (var i = 0; i < segment_num; ++i) {
			segments[i].draw();
		}	
	}
	
	static draw_points = function(){
		for (var i = 0; i <= segment_num; ++i) {
			points[i].draw(2);
		}	
	}
	
	static draw_velocity = function(_multiply = 1){
		for (var i = 0; i <= segment_num; ++i) {
			points[i].draw_velocity(_multiply);
		}	
	}
}
