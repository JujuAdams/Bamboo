///@param 1st point
///@param 2nd point
///@param dist by default dist between points
///@param dir by default dir between points
function bamboo_line(_p1,_p2,_dist = point_distance(_p1.x,_p1.y,_p2.x,_p2.y), _dir = point_direction(_p1.x,_p1.y,_p2.x,_p2.y) ) constructor {
	p1 = _p1;
	p2 = _p2;
	dist = _dist;
	
	static constrain_length = function(_substeps = 1){
		repeat(_substeps){
			//moves both points to maintain the targeted distance
			var _dist = max(0,point_distance(p1.x,p1.y,p2.x,p2.y) - dist) / 2;
			var _dir  = point_direction(p1.x,p1.y,p2.x,p2.y);		
			
			if(!p1.fixed){
				p1.x += lengthdir_x(_dist,_dir) / p1.mass;
				p1.y += lengthdir_y(_dist,_dir) / p1.mass;
			}
			
			if(!p2.fixed){
				p2.x -= lengthdir_x(_dist,_dir) / p2.mass;
				p2.y -= lengthdir_y(_dist,_dir) / p2.mass;
			}
		}
	}
	
	static get_direction = function(){
		return point_direction(p1.x,p1.y,p2.x,p2.y);
	}
	
	static set_direction = function(_dir_target){
		if(!p2.fixed){
			
			//var dist_ = point_distance(p1.x,p1.y,p2.x,p2.y);
			var dir_current_ = point_direction(p1.x,p1.y,p2.x,p2.y);
			
			var diff = angle_difference(dir_current_,_dir_target) / p2.mass;
			
			var force = dist * degtorad(diff);
			
			p2.x = p1.x + lengthdir_x(dist,dir_current_-diff);
			p2.y = p1.y + lengthdir_y(dist,dir_current_-diff);
			
			//p2.x_prev = p2.x + lengthdir_x(force,_dir_target+90);
			//p2.y_prev = p2.y + lengthdir_y(force,_dir_target+90);
		}
	}
	
	static set_pos = function(_target_x,_target_y){
		var x_ = lerp(p1.x,p2.x,0.5);
		var y_ = lerp(p1.y,p2.y,0.5);
		
		var offset_x_ = _target_x - x_;
		var offset_y_ = _target_y - y_;
		
		p1.x += offset_x_;
		p1.y += offset_y_;
		p2.x += offset_x_;
		p2.y += offset_y_;
	}
	
	static draw = function(){
		draw_line(p1.x,p1.y,p2.x,p2.y);	
	}
}