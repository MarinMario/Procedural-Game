extends KinematicBody2D

export var move_speed := 400
export var jump_force := 700
export var gravity := 1000
export var max_jump_times := 1
var jump_times := 0
var grounded := false
var velocity := Vector2.ZERO

var jump_timer = 0.5

export var shoot_wait_time := 0.1
var shoot_timer := 0.0
var press_attack_count := 0

func _physics_process(delta):
	var direction_x :=  Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = direction_x * move_speed
	
	$SpawnBombPosition.look_at(get_global_mouse_position())
	
	shoot_timer += delta
	if Input.is_action_just_pressed("attack"):
		if press_attack_count % 2 == 0:
			spawn_bomb(500)
		press_attack_count += 1
	if Input.is_action_just_pressed("jump") and jump_times > 0:
		velocity.y = -jump_force
		jump_times -= 1
	
	if not grounded and jump_times == max_jump_times:
		jump_timer += delta
	
	if jump_timer >= 0.1:
		jump_times -= 1
		jump_timer = 0
		
	velocity.y += gravity * delta
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	grounded = is_on_floor()
	if grounded:
		velocity = Vector2.ZERO
		jump_times = max_jump_times

func spawn_bomb(speed):
	var bomb: RigidBody2D = Global.BOMB.instance()
	var p = $SpawnBombPosition/Pos
	bomb.global_position = p.global_position
	bomb.speed = speed
	get_parent().add_child(bomb)

