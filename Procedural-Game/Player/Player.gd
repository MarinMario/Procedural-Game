extends KinematicBody2D

export var move_speed := 250
export var jump_force := 500
export var gravity := 900
export var max_jump_times := 1
var jump_times := 0
var grounded := false
var velocity := Vector2.ZERO

func _physics_process(delta):
	var direction_x :=  Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = direction_x * move_speed
	
	if not grounded and jump_times == max_jump_times:
		$LeaveFloorTimer.start()
	
	if Input.is_action_just_pressed("jump") and jump_times > 0:
		velocity.y = -jump_force
		jump_times -= 1
	
	if Input.is_action_just_pressed("reload"):
		get_tree().reload_current_scene()
		
	velocity.y += gravity * delta
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	grounded = is_on_floor()
	if grounded:
		velocity = Vector2.ZERO
		jump_times = max_jump_times

func _on_LeaveFloorTimer_timeout():
	jump_times -= 1
