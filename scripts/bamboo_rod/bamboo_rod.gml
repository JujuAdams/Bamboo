function bamboo_rod(_start_x,_start_y,_end_x,_end_y,_segment_num = 2, _substeps = 10) : bamboo_rope(_start_x,_start_y,_end_x,_end_y,_segment_num, _substeps) constructor {
	segment_num = _segment_num;
	substeps = _substeps;
	dir = point_direction(_start_x,_start_y,_end_x,_end_y);
	
	//methods	
	static update = function(_drag = 0.01, _stiffness = 0.9){
		
		for (var i = 0; i <= segment_num; ++i) {
			points[i].update((_drag));
		}
		
		for (var i = segment_num-1; i >= 0; --i) {
			segments[i].constrain_length(substeps);
		}
		
		repeat(substeps){
			
			//for each segment sets it's direction to be halfway between next and previous segment's rotation
			//first segment is set to dir
			
			for (var i = 0; i < segment_num; ++i) {
				var segment = segments[i];
				var dir_ = segment.get_direction();
				var dir_prev_ = dir_;
				var dir_next_ = dir_;
				var dir_target_ = dir_;
				
				if(i == 0){
					segment.set_direction(dir)
					
				} else {
					if(i > 0){
						dir_prev_ = segments[i-1].get_direction();
					}
					
					if(i < segment_num-1){
						dir_next_ = segments[i+1].get_direction();
					}
					
					dir_target_ -= ((angle_difference(dir_,dir_prev_) / 2) * _stiffness) / 1;
					dir_target_ -= ((angle_difference(dir_,dir_next_) / 2) * _stiffness) / 1;
					segment.set_direction(dir_target_);
				}
			}
		}
	}
}