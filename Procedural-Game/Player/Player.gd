extends KinematicBody2D

var move_speed := 400
var jump_force := 800
var gravity := 1200
var max_jump_times := 2
var jump_times := 0
var grounded := false
var velocity := Vector2.ZERO

var jump_timer = 0.5

func _physics_process(delta):
	var direction_x :=  Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = direction_x * move_speed
	
	if Input.is_action_just_pressed("reload"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("attack"):
		spawn_bomb()
	if Input.is_action_just_pressed("jump") and jump_times > 0:
		velocity.y = -jump_force
		jump_times -= 1
	
	if not grounded and jump_times == max_jump_times:
		jump_timer += delta
	
	if jump_timer >= 0.5:
		jump_times -= 1
		jump_timer = 0
		
	velocity.y += gravity * delta
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	grounded = is_on_floor()
	if grounded:
		velocity = Vector2.ZERO
		jump_times = max_jump_times

func spawn_bomb():
	var bomb := Global.BOMB.instance()
	bomb.global_position = self.global_position
	get_parent().add_child(bomb)
