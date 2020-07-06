extends RigidBody2D

var tilemap: TileMap
var colliding_bomb: RigidBody2D
export var speed := 500
export var destroy_range := 3
export var impulse_force = 5000

func _ready():
	var impulse = (get_global_mouse_position() - global_position).normalized()
	apply_impulse(Vector2.ZERO, impulse * speed)
	$AnimationPlayer.play("count_down")

func explode_tilemap(body):
	var cell_position = body.world_to_map(global_position - body.global_position) 
	for column in range(-destroy_range, destroy_range):
		for row in range(-destroy_range, destroy_range):
			var cell := Vector2(cell_position.x + row, cell_position.y + column)
			body.set_cellv(cell, -1)

func explode_rigid_body(body):
	var impulse = (body.global_position - global_position).normalized()
	body.apply_impulse(Vector2.ZERO, impulse * impulse_force)

func spawn_explosion():
	var explosion = Global.EXPLOSION.instance()
	explosion.global_position = global_position
	get_parent().add_child(explosion)

func explode():
	var bodies = $DamageArea.get_overlapping_bodies()
	for body in bodies:
		if body is TileMap:
			explode_tilemap(body)
		elif body is RigidBody2D:
			explode_rigid_body(body)
	spawn_explosion()
	queue_free()

var explode_timer := 0.0
func _process(delta):
	explode_timer += delta
	if Input.is_action_just_pressed("attack") and explode_timer > 0.1:
		explode()

