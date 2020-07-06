extends Camera2D


func _process(delta):
	if Input.is_action_pressed("control"):
		var direction_x :=  Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		var direction_y :=  Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		self.position += Vector2(direction_x, direction_y) * delta * 1000
		if Input.is_action_pressed("ui_page_up"):
			self.zoom += Vector2(1,1) * 10 * delta
		if Input.is_action_pressed("ui_page_down"):
			self.zoom -= Vector2(1,1) * 10 * delta
	
